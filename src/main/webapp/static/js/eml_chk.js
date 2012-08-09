document.getElementById('email').onkeydown = function(e){
    if (e.keyCode == 9) {
        var re_mail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z])+$/;
        if(!re_mail.test(this.value)){$('#email_error').text("please enter valid email id");return false;}
        $.post("/user/register/emlchk/" + this.value + ".json", function (result) {
            $('#email_error').text(result.msg);
            if(result.msg=='success'){document.getElementById('password').focus(); $('#password_error').text("Enter your preferred password between 6 and 15 characters");}
        });


        return false;
    }
}