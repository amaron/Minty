

setInterval(function(){

    $.get("/user/updates.json", function(result) {
        if(result.value=="yes"){
            $('#updateBtn').attr("value", "you have "+ result.number + " new tweets!");
            $('#updateBtn').show();
           // $('#tweetList').easyNotification("New Tweets!");


        }
    });
}, 20000);

