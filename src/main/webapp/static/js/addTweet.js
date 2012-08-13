


function addTweet(form) {

    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
        $('#numTweets').text(num_tweets);
        appendItem(data);
    });
    //alert("Hello");
    newtweets++;
    num_tweets++;


}

function addTweetThenHide(form,id) {
    addTweetNow(form);
    hideReply(id);
    hideRetweet(id);
    newtweets++;
    num_tweets++;


}
