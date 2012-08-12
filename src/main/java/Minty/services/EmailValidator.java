package Minty.services;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 6/8/12
 * Time: 3:02 PM
 * To change this template use File | Settings | File Templates.
 */
public class EmailValidator{

    private Pattern pattern;
    private Matcher matcher;

    private static final String	EMAIL_PATTERN	= "^[!#-'\\*\\+\\-/0-9=\\?A-Z\\^_`a-z{-~]+(\\.[!#-'\\*\\+\\-/0-9=\\?A-Z\\^_`a-z{-~]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    public EmailValidator(){
        pattern = Pattern.compile(EMAIL_PATTERN);
    }


    public boolean validate(final String hex){

        matcher = pattern.matcher(hex);
        return matcher.matches();

    }
}