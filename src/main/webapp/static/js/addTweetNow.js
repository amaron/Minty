function addTweetNow(form) {
    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
        appendItem(data);
    });


}