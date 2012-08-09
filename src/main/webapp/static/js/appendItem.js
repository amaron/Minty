var numb = '0123456789';
var lwr = 'abcdefghijklmnopqrstuvwxyz';
var upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var alnum=lwr+upr+numb;

function idFinder(tweet){
    var idList=new Array();
    var count =0;
    for(i=0;i<tweet.length;i++){
        if(tweet[i]=='@'){
            var id="";
            for(j=i+1;alnum.indexOf(tweet[j])!=-1;j++){
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

function strip(html)
{
    var tmp = document.createElement("DIV");
    tmp.innerHTML = html;
    return tmp.textContent||tmp.innerText;
}


function htmlAdder(tweet,idList){

    for(i=0;i<idList.length;i++){
        var link="@\<a href='/user/placeholder'>placeholder</a> ";
        var cleanID=idList[i].substring(1);
        var userlink=link.replace(/placeholder/g,cleanID);
        tweet=tweet.replace(idList[i],userlink);
    }
    return tweet;
}

function cleanTweet(tweet){

}
function appendItem(data) {
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
    $('#tweetList').append(tweetItemLI);
}