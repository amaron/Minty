function follow(handle) {
    $.post("/user/follow/"+handle+".json",function(data) {
        //alert("you "+ data.displayvalue +" " + data.name+ " now!");

        $('#tweetList').easyNotification("you "+ data.displayvalue +" " + data.name+ " now!");
        if(data.displayvalue=='follow')
            $('#num_followers').text(num_followers+1);
        if(data.displayvalue=='unfollow')
            $('#num_followers').text(num_followers-1);

        $('#followBtn').attr("value",data.value);
    });
}