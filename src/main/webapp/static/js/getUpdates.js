

setInterval(function(){

    $.get("/user/updates.json", function(result) {
        if(result.value=="yes"){
            $('#updateBtn').attr("value", "you have new tweets!");
            $('#updateBtn').show();
           // $('#tweetList').easyNotification("New Tweets!");


        }
    });
}, 4000);

