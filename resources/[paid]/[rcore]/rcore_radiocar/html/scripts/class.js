var yPlayer = null;

function getNameFromURL(URL, cb){
    if(getYoutubeUrlId(URL) === "")
	{
        var audioPlayer = new Howl({
                src: [URL],
                loop: false,
                html5: true,
                autoplay: true,
                volume: 0.0,
                format: ['mp3'],
                onplay: function(){
                    cb(editString(URL), audioPlayer._duration);
                    audioPlayer.pause();
                    audioPlayer.stop();
                    audioPlayer.unload();
                },
        });
    }
    else
    {
		var test = new YT.Player("trash",
        {
            height: '0',
            width: '0',
            videoId: getYoutubeUrlId(URL),
            events:
            {
                'onReady': function(event){
                    cb(event.target.getVideoData().title, test.getDuration());
                    test.stopVideo();
                    test.destroy();
                },
            }
        });
    }
}

function updateName(url){
    if(getYoutubeUrlId(url) === "")
	{
        $(".nameSong").text(editString(url));
        currentSongName = editString(url);
    }else{
		yPlayer = new YT.Player("trash",
        {
            height: '0',
            width: '0',
            videoId: getYoutubeUrlId(url),
            events:
            {
                'onReady': function(event){
                    currentSongName = event.target.getVideoData().title;
                    getName(event.target.getVideoData().title);
                },
            }
        });
    }
}

function getYoutubeUrlId(url)
{
    var videoId = "";
    if( url.indexOf("youtube") !== -1 ){
        var urlParts = url.split("?v=");
        videoId = urlParts[1].substring(0,11);
    }

    if( url.indexOf("youtu.be") !== -1 ){
        var urlParts = url.replace("//", "").split("/");
        videoId = urlParts[1].substring(0,11);
    }
    return videoId;
}

function editString(string){
    var str = string;
    var res = str.split("/");
    var final = res[res.length - 1];
    final = final.replace(".mp3", " ");
    final = final.replace(".wav", " ");
    final = final.replace(".wma", " ");
    final = final.replace(".wmv", " ");

    final = final.replace(".aac", " ");
    final = final.replace(".ac3", " ");
    final = final.replace(".aif", " ");
    final = final.replace(".ogg", " ");
    final = final.replace("%20", " ");
    final = final.replace("-", " ");
    final = final.replace("_", " ");
    return final;
}

function getName(name){
    $(".nameSong").text(name);
    if (this.yPlayer) {
        if (typeof this.yPlayer.stopVideo === "function" && typeof this.yPlayer.destroy === "function") {
            yPlayer.stopVideo();
            yPlayer.destroy();
        }
    }
}