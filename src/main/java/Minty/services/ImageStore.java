package Minty.services;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;


@Service
public class ImageStore {


    public boolean createUserDirectory(long id,String path) throws IOException{
        File newUserDir=new File(path+"\\static\\img\\"+id);
        boolean dirCreated=newUserDir.mkdir();
        if(dirCreated){
            File defaultPic=new File(path+"\\static\\images\\profilePic.jpg");
            String fileName = path + "\\static\\img\\"+id+"\\profilePic.jpg";
            fileWrite(new FileInputStream(defaultPic),fileName);
        }
        return dirCreated;

    }
    public boolean addPic(String path,MultipartFile file,String username){
        try {

            String fileName = null;
            InputStream inputStream = null;
            OutputStream outputStream = null;
            if (checkImgSize(path, file)) {
                inputStream = file.getInputStream();
                fileName = path + "/static/img/"+"Woo"+"/"+username+".jpg";
                fileWrite(inputStream, fileName);
                return true;
            }
            System.out.println("hellohere");
            return false;


        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    private boolean checkImgSize(String path, MultipartFile file) throws IOException {

        String fileName;OutputStream outputStream;
        if (file.getSize() > 0 || file.getSize() < 100000)
            return true;

        return false;

    }

    private void fileWrite(InputStream inputStream, String fileName) throws IOException {
        OutputStream outputStream;
        outputStream = new FileOutputStream(fileName);
        System.out.println("fileName:" + fileName);

        int readBytes = 0;
        byte[] buffer = new byte[100000];
        while ((readBytes = inputStream.read(buffer, 0, 100000)) != -1) {
            outputStream.write(buffer, 0, readBytes);
        }

        outputStream.close();
        inputStream.close();
    }


}
