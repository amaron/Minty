var numb = '0123456789';
var lwr = 'abcdefghijklmnopqrstuvwxyz';
var upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var alnum=lwr+upr+numb;

function idFinder(tweet){
    var idList=new Array();
    var count =0;
    for(var i=0;i<tweet.length;i++){
        if(tweet[i]=='@' && alnum.indexOf(tweet[i-1])==-1){
            var id="";
            for(var j=i+1;alnum.indexOf(tweet[j])!=-1;j++){
                id+=tweet[j];
            }
            id='@'+id;
            idList[count++]=id;
            i=j;
        }
    }
    //alert(idList);
    return idList;
}


function htmlAdder(tweet,idList){

    for(var i=0;i<idList.length;i++){
        var link="@\<a href='/user/placeholder'>placeholder</a> ";
        var cleanID=idList[i].substring(1);
        var userlink=link.replace(/placeholder/g,cleanID);
        tweet=tweet.replace(idList[i],userlink);
    }
    return tweet;
}

function strip(html)
{
    var tmp = document.createElement("DIV");
    tmp.innerHTML = html;
    return tmp.textContent||tmp.innerText;
}

function displayNew(form){
    $.post('/user/getNewTweet.json', $(form).serialize(),function(result) {

        $('#updateBtn').hide();
        for(var i=0;i<result.val;i++){
            var data=result.List[i];
            //alert(JSON.stringify((temp)));
            //appendItem(temp);
            //alert("done");
            //var tweetItemLI = $(new EJS({url: '/static/ejs/tweet.ejs'}).render(temp)).data("tweetID", (temp).tweet_id);

            var list=idFinder(data.tweet);
            data.tweet= strip(data.tweet);
            data.tweet=htmlAdder(data.tweet,list);
            var month_names_short= ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var timeObject = getJsTimestamp( String(data.pushtime) );
            var stamp =  new Date(timeObject.year, Number(timeObject.month)-1, timeObject.day, timeObject.hour, timeObject.minute, timeObject.second);
            //alert(jQuery.timeago(stamp));
            var timeDiff= timeDifference((new Date()).getTime(),stamp.getTime());
            data["timeDiff"]=timeDiff;
            data.pushtime =month_names_short[Number(timeObject.month)-1]+" "+ timeObject.day +" " + timeObject.year + " at " + timeObject.hour+":"+timeObject.minute;

            var tweetItemLI = $(new EJS({url: '/static/ejs/tweet.ejs'}).render(data)).data("tweetID", data.tweet_id);

            $('#tweetList').prepend(tweetItemLI);
            //alert("reached");
            //$('#tweetItem'+data.tweet_id).fadeIn(3000);
            $('#tweetItem'+data.tweet_id).show();

        }
    });
}