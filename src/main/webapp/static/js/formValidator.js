function validateEmail(email, msg) {  
if (!email.value) {  
return true;  
    }  

        var re_mail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z])+$/;  
            if (!re_mail.test(email.value)) {  
            alert("invalid email"+msg);  
                email.focus();  
                    email.select();  
                        return false;  
                            }  



                    return true;  
                    }

function notEmptyValidator(field,msg){
    if(field!="" && field!=null){
        alert(msg+" can not be empty" );
        return false;
    }
    else return true;
}

function Validator(form){
    var result=notEmptyValidator(form.username);
    if(result==false){
        $('#username_error').text("username can not be empty");
    }
    var result=notEmptyValidator(form.user_password);
    if(result==false){
        $('#username_error').text("password can not be empty");
    }
}