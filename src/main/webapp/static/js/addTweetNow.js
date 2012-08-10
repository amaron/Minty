function addTweetNow(form) {
    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
      var tweetItemLI= preComputeOnTweet(data);
        $('#tweetList').prepend(tweetItemLI);
    });


}