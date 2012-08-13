package Minty.controller;

import Minty.model.UploadItem;
import Minty.services.ImageStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/uploadfile")
public class UploadFileController {
    private String uploadFolderPath;
    ServletConfig config;
    private ImageStore imageStore;
    private Errors error;

    @Autowired
    public UploadFileController(ImageStore imageStore){
        this.imageStore=imageStore;
    }

    public String getUploadFolderPath() {
        return uploadFolderPath;
    }

    public void setUploadFolderPath(String uploadFolderPath) {
        this.uploadFolderPath = uploadFolderPath;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String getUploadForm(Model model) {
        System.out.print("Blag");
        model.addAttribute(new UploadItem());
        return "uploadfile";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(UploadItem uploadItem,BindingResult result,
                         HttpServletRequest request, HttpServletResponse response,
                         HttpSession session) {
//        error=new Errors();
        if (result.hasErrors()) {
            for (ObjectError errors : result.getAllErrors()) {
//                error.addError("Upload","Error: " + errors.getCode() + " - "
//                        + errors.getDefaultMessage());
            }
            return "/uploadfile";
        }
        imageStore.addPic(request.getRealPath("/"),uploadItem.getFileData(),(String)session.getAttribute("userName"));
        //session.setAttribute("uploadFile", uploadItem.getFileData().getOriginalFilename());

        return "redirect:uploadfileindex";
    }

}
