package Minty.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Timestamp;
import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 * User: karthik
 * Date: 13/8/12
 * Time: 1:07 AM
 * To change this template use File | Settings | File Templates.
 */
@Service
public class RESTHelper {
    private final ThreadLocal<Long> userID;
    public JdbcTemplate db;

    @Autowired
    public RESTHelper(@Qualifier("userID") ThreadLocal<Long> userID, JdbcTemplate template) {
        this.userID = userID;
        db = template;
    }

    public String encrypt(String plaintext){
        char[] p_text=plaintext.toCharArray();
        int i;
        for(i=0;i<p_text.length;i++){
            p_text[i]+=1;
        }
        return  plaintext.copyValueOf(p_text);

    }

    public String decrypt(String cyphertext){
        char[] c_text=cyphertext.toCharArray();
        int i;
        for(i=0;i<c_text.length;i++){
            c_text[i]-=1;
        }
        return  cyphertext.copyValueOf(c_text);

    }

    private String check3rdPartyRegistration(String remote_party){
        String result=null;
        try{
            db.queryForList("SELECT * FROM registered3rdparty WHERE pkey=?",remote_party);

        }catch(Exception e){
            return result;
        }
        return "yes";
    }

    private String checkRESTUserRegistration(String user_key, String username){
        String result=null;
        try{
            db.queryForList("SELECT * FROM restusers WHERE pkey=? AND username=?",user_key, username);

        }catch(Exception e){
            return result;
        }
        return "yes";
    }

    private boolean checkTimeOut(String request_time){
        Timestamp req_time = Timestamp.valueOf(request_time);
        if(((new java.util.Date()).getTime())- req_time.getTime()>5000)return false;
        else return true;

    }

    public String validate(String Secret, String username){

        String decoded_string=decrypt(Secret);
        String[] data=decoded_string.split(",");
        if(check3rdPartyRegistration(data[0])==null){
            return "Invalid 3rdParty Key. Contact Minty Admin for lost password or Register for 3rdParty access";
        }else{
            if(checkRESTUserRegistration(data[2],username)==null){
                return "Invalid User Key. User Must be logged on to make tweets.";
            }else{
                if(checkTimeOut(data[1])){
                    return "success";
                }else{
                    return "Request Timed out. Please Sync with Minty Server Time and send again";
                }
            }
        }

    }

    public String register3rdParty(String party_name){


        String uuid = UUID.randomUUID().toString();
        System.out.println("3rd party uuid = " + uuid);

        try{
        db.update("insert into registered3rdparty (pname,pkey) values(?,?)",party_name,uuid);
        }catch(Exception e){ return "Registration Failed, Try again!"; }
        return uuid;

    }

    public String registerRESTUser(String username){


        String uuid = UUID.randomUUID().toString();
        System.out.println("user uuid = " + uuid);

        try{
            db.update("insert into restusers (username,pkey) values(?,?)",username,uuid);
        }catch(Exception e){ return "Registration Failed, Try again!"; }
        return uuid;

    }


    public boolean sendKeyTo3rdParty(String cb_url, String key){

        String encrypted_key=encrypt(key);
        System.out.println("encrypted user key "+ encrypted_key);
        URL url = null;
        try {
            url = new URL(cb_url+"/key?="+encrypted_key);
        } catch (MalformedURLException e) {
            //e.printStackTrace();
            return false;
        }
        return true;

    }
}
