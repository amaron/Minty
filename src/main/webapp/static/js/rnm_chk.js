document.getElementById('realname').onkeydown = function(e){
    if (e.keyCode == 9) {

        $('#username_error').text("Enter your unique username!");
        document.getElementById('username').focus();
        return false;
    }
}
