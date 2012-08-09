document.getElementById('username').onkeydown = function(e){
    if (e.keyCode == 9) {

        if(this.value.length<1 || this.value.length>20){$('#username_error').text("username must be less than 20 characters");return false;}
        $.post("/user/register/usrchk/" + this.value + ".json", function (result) {
            $('#username_error').text(result.msg);
            if(result.msg=='success'){document.getElementById('email').focus();$('#email_error').text("Enter your email id!");}
        });


        return false;
    }
}