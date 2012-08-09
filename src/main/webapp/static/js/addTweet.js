


function addTweet(form) {
    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
        $('#numTweets').text(num_tweets);
    });

    newtweets++;
    num_tweets++;


}

function addTweetThenHide(form,id) {
    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
        $('#numTweets').text(num_tweets);
        hideReply(id);
    });


    newtweets++;
    num_tweets++;


}
