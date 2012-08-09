document.getElementById('password').onkeydown = function(e){
    if (e.keyCode == 9) {

        if(this.value.length<6 || this.value.length>15){$('#password_error').text("password must be between 6 and 15 characters");return false;}

        this.focus();
        return false;
    }
}