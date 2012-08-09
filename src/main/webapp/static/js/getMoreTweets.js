function getMoreTweets(form){
    $.post('/user/getMoreTweets/' + newtweets +'.json',function(data) {
        //alert(data.List);
        if(data.val==0) $('#moreTweetsBtn').hide();
        for(k=0;k<data.val;k++){
            //alert(JSON.stringify(data.List[k]));
            appendItem(data.List[k]);
        }


    });
}