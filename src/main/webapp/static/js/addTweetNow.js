
function addToMentions(list, tweet_id){

    if(list==null)return false;
    $.ajax({
        type: "POST",
        url: "/user/addToMentions.json",
        data:$.param({u_list:list, tweet_id:tweet_id}),
        success: function(result){

        }

    });
}

//function addToRetweets(tweet_id, isretweet_id){
//
//    $.ajax({
//        type: "POST",
//        url: "/user/addToRetweets.json",
//        data:$.param({retweet_id:isretweet_id, tweet_id:tweet_id}),
//        success: function(result){
//
//        }
//
//    });
//}

function addTweetNow(form) {


    $.post('/user/tweet/create.json', $(form).serialize(),function(data) {
        var u_list=idFinder(data.tweet);
        //alert(u_list);
        addToMentions(u_list,data.tweet_id);

        //if(isretweet_id!=null) addToRetweets(data.tweet_id,isretweet_id);

        var tweetItemLI= preComputeOnTweet(data);
        $('#tweetList').prepend(tweetItemLI);


    });
    newtweets++;
    num_tweets++;


}