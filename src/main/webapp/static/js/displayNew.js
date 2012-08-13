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
    $.post('/user/getNewTweet.json', $(form).serialize(),function(data) {

        $('#updateBtn').hide();
        for(var i=0;i<data.val;i++){
            var temp=data.List[i];
            var tweetItemLI = $(new EJS({url: '/static/ejs/tweet.ejs'}).render(temp)).data("tweetID", (temp).tweet_id);
            var tweetItemLI =preComputeOnTweet(temp);
            $('#tweetList').prepend(tweetItemLI);

        }
    });
}