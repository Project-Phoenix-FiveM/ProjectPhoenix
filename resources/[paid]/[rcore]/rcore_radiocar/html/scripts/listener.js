var currentIndex = null;
var soundList = [];
var closeToPlayer = [];
var currentSongName = "";

var playerPos = [-90000,-90000,-90000];

var vueJS = new Vue({
	el: '.radio_cont',
	data: 
	{
		songs: [],
		userSongs: [],
		customPlayList: [],
		framework: 0,

		visible: false,
		page: "custom",
		adding: false,
		locales: localesex,

		oldURL: "",
		oldLabel: "",

		index: null,

		maxTimeStamp: 0,
		timeSong: 0,
		volume: 30,
	},
	
	methods: {
	    playQueList: function(){
            $.post("https://rcore_radiocar/playque", JSON.stringify({}))
	    },

	    stopQueList: function(){
            $.post("https://rcore_radiocar/stopque", JSON.stringify({}))
	    },

	    removeFromPlayList: function(index, item){
            $.post("https://rcore_radiocar/removeMusicFromQue", JSON.stringify({
                index: item.index,
            }))
            vueJS.customPlayList[index].removed = true;
	    },

	    addToQue: function(){
	        var URL = $("#UrlForQue").val();
            getNameFromURL(URL, function(name, timestamp){
                $.post("https://rcore_radiocar/addToPlayListCache", JSON.stringify({
                    timeStamp: timestamp,
                    time: timestamp,
                    name: name,
                    url: URL,
                    active: false,
                }))

                vueJS.customPlayList.push({
                    label: name,
                    url: URL,
                    active: false,
                    removed: false,
                    index: vueJS.customPlayList.length + 1,
                });

                vueJS.page = "quemusic";
            });
	    },

	    slideInputChanged: function(){
            $.post("https://rcore_radiocar/timestamp", JSON.stringify({
                timeStamp: $("#timestamp_drag").val(),
            }))
	    },

	    changeVolume: function(minus){
	        if(minus){
                $.post('https://rcore_radiocar/volumedown', JSON.stringify({}));
	            }else{
	            $.post('https://rcore_radiocar/volumeup', JSON.stringify({}));
	        }
	    },

	    turnOffMusic: function(){
            $(".status").text(localesex.nothing);
            currentSongName = localesex.nameSong;
            $(".nameSong").text(localesex.nameSong);
            $(".timeSong").text("00:00:00")
            $.post('https://rcore_radiocar/stop', JSON.stringify({}));
	    },

	    pauseMusic: function(pg){
            $.post('https://rcore_radiocar/pausesong', JSON.stringify({}));
	    },

	    changePage: function(pg){
            $("#AddName").val("");
            $("#AddUrl").val("");
	        this.page = pg;
            this.$nextTick(function () {
                $(".nameSong").text(currentSongName);
            })
	    },

	    playCustomMusic: function(){
	        if ($("#url").val() !== "") {
                $(".status").text(localesex.playing);
                updateName($("#url").val());
	        }
            $.post('https://rcore_radiocar/play', JSON.stringify(
            {
                url: $("#url").val(),
            }));
	    },

        editMusic: function(url, label, adding, index){
            vueJS.index = index;
            vueJS.adding = adding;
            if(adding){
                this.page = "edit";
                this.$nextTick(function () {
                    $("#AddName").val("");
                    $("#AddUrl").val("");
                })
            }
            else
            {
                this.page = "edit";
                this.$nextTick(function () {
                    $("#AddName").val(label);
                    $("#AddUrl").val(url);
                })

                this.oldURL = url;
                this.oldLabel = label;
            }
        },

		showIndex: function (index) {
			currentIndex = index;
		},	
		
		playMusic: function (url) {
			updateName(url);
			$(".status").text(localesex.playing);
			$.post('https://rcore_radiocar/play', JSON.stringify({
				url: url,
			}));
		}
	}
}) 

function editSong(){
    if($("#AddName").val().length == 0 || $("#AddUrl").val().length == 0){
        return;
    }

	$.post('https://rcore_radiocar/editSong', JSON.stringify({
		index: currentIndex,
		label: $("#AddName").val(),
		url: $("#AddUrl").val(),
        oldURL: vueJS.oldURL,
        oldLabel: vueJS.oldLabel,
	}));

    if(vueJS.index != null){
        vueJS.userSongs[vueJS.index].label = $("#AddName").val();
        vueJS.userSongs[vueJS.index].url = $("#AddUrl").val();
    }

    vueJS.$nextTick(function () {
	    vueJS.changePage('playlist');
    })

    if(vueJS.adding != null){
        for(var i = 0; i < vueJS.userSongs.length; i ++){
            if(vueJS.userSongs[i].label === $("#AddName").val() || vueJS.userSongs[i].url === $("#AddUrl").val()){
                vueJS.userSongs[i].label = $("#AddName").val();
                vueJS.userSongs[i].url = $("#AddUrl").val();
                return;
            }
        }

        vueJS.userSongs.push({
            label: $("#AddName").val(),
            url: $("#AddUrl").val(),
            active: true,
        });
    }
}

function removeSong(){
	$.post('https://rcore_radiocar/removeSong', JSON.stringify({
        oldURL: vueJS.oldURL,
        oldLabel: vueJS.oldLabel,
	}));

    vueJS.$nextTick(function () {
	    vueJS.changePage('playlist');
        if(vueJS.index != null){
            vueJS.userSongs[vueJS.index].active = false;
        }
    })
}

$(document).ready(function(){
    $.post("https://rcore_radiocar/init", JSON.stringify({}))
});

$(function(){
	window.addEventListener('message', function(event) {
		var item = event.data;

        if(item.type === "volume"){
            $("#volume").text((item.volume * 100).toFixed(0) + "%")
        }

        switch(item.type)
        {
            case "position":
                playerPos = [item.x,item.y,item.z];
                break;

            case "volume":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setVolume(item.volume);
                    sound.setMaxVolume(item.volume);
                }
                break;

            case "timestamp":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setTimeStamp(item.timestamp);
                }
                break;

            case "max_volume":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setMaxVolume(item.volume);
                }
                break;

            case "url":
                var sound = soundList[item.name];

                if(sound != null)
                {
                    sound.destroyYoutubeApi();
                    sound.delete();
                    sound = null;
                }

                var sd = new SoundPlayer();
                sd.setName(item.name);
                sd.setSoundUrl(item.url);
                sd.setDynamic(item.dynamic);
                sd.setLocation(item.x,item.y,item.z);
                sd.setLoop(item.loop)
                sd.create();
                sd.setVolume(item.volume);
                sd.play();
                soundList[item.name] = sd;
                break;
            case "distance":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setDistance(item.distance);
                }
                break;

            case "play":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.delete();
                    sound.create();
                    sound.setVolume(item.volume);
                    sound.setDynamic(item.dynamic);
                    sound.setLocation(item.x,item.y,item.z);
                    sound.play();
                }
                break;

            case "soundPosition":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setLocation(item.x,item.y,item.z);
                }
                break;

            case "resume":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.resume();
                }
                break;

            case"pause":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.pause();
                }
                break;

            case "delete":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.destroyYoutubeApi();
                    sound.delete();
                    delete soundList[item.name];
                }
                break;
            case "repeat":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setTimeStamp(0);
                    sound.play();
                }
                break;
            case "changedynamic":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.unmute()
                    sound.setDynamic(item.bool);
                    sound.setVolume(sound.getMaxVolume());
                }
                break;
            case "changeurl":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.destroyYoutubeApi();
                    sound.delete();
                    sound.setSoundUrl(item.url);
                    sound.setLoaded(false);
                    sound.create();

                    sound.play();
                }
                break;
            case "loop":
                var sound = soundList[item.name];
                if(sound != null)
                {
                    sound.setLoop(item.loop);
                }
                break;
            case "unmuteAll":
                for (var soundName in soundList)
                {
                    sound = soundList[soundName];
                    if(sound.isDynamic()){
                        sound.unmuteSilent();
                    }
                }
                updateVolumeSounds();
                break;
            case "muteAll":
                for (var soundName in soundList)
                {
                    sound = soundList[soundName];
                    if(sound.isDynamic()){
                        sound.mute();
                    }
                }
                break;

            case "ui":
			    vueJS.visible = item.status
                break;
            case "resetUserSongs":
                vueJS.userSongs = [];
                break;
            case "FrameWork":
                vueJS.framework = item.frameWork;
                break;
            case "edit":
                vueJS.userSongs.push({
                    label: item.label,
                    url: item.url,
                    active: true,
                });
                break;

            case "clear":
                vueJS.songs = []
                break;
            case "resetQueMusic":
                vueJS.customPlayList = [];
                break;
            case "updateIndex":
                for(var i = 0; i < vueJS.customPlayList.length; i ++){
                    vueJS.customPlayList[i].active = false;
                }

                for(var i = 0; i < vueJS.customPlayList.length; i ++){
                    if (vueJS.customPlayList[i].index == item.index){
                        vueJS.customPlayList[i].active = true;
                    }
                }
                break;
            case "addQueMusic":
                vueJS.customPlayList.push({
                    label: item.name,
                    index: item.indexKey,
                    url: item.URL,
                    active: item.active,
                    removed: item.removed,
                });

                vueJS.customPlayList = vueJS.customPlayList.sort(function(a, b) {
                    return a.index - b.index
                });
                break;
            case "add":
                vueJS.songs.push({
                    label: item.label,
                    url: item.url,
                });
                break;

            case "timeSong":
                var leftTime = (item.timeSong + "").toHHMMSS();
                $(".timeSong").text(leftTime.format("00:00:00"))
                vueJS.maxTimeStamp = item.maxDuration;
                vueJS.timeSong = item.timeSong;
                break;

            case "update":
                $(".status").text(localesex.playing);
                updateName(item.url);
                break;

            case "reset":
                vueJS.locales.nothing = localesex.nothing;
                currentSongName = localesex.nameSong;
                vueJS.locales.nameSong = localesex.nameSong;
                vueJS.locales.timeSong = localesex.timeSong.format("00:00:00");
                break;

            case "timeWorld":
                $("#time").text(item.timeWorld)
                break;
		}
	})

});

$(document).keyup(function(e) {
	if (e.key === "Escape") {
		$.post('https://rcore_radiocar/exit', JSON.stringify({}));
    }
});

String.prototype.toHHMMSS = function () {
    var sec_num = parseInt(this, 10); // don't forget the second param
    var hours   = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = sec_num - (hours * 3600) - (minutes * 60);

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (seconds < 10) {seconds = "0"+seconds;}
    return hours+':'+minutes+':'+seconds;
}

if (!String.prototype.format) {
  String.prototype.format = function(...args) {
    return this.replace(/(\{\d+\})/g, function(a) {
      return args[+(a.substr(1, a.length - 2)) || 0];
    });
  };
}


function Between(loc1,loc2)
{
	var deltaX = loc1[0] - loc2[0];
	var deltaY = loc1[1] - loc2[1];
	var deltaZ = loc1[2] - loc2[2];

	var distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);
	return distance;
}

function addToCache()
{
    closeToPlayer = [];
    var sound = null;
	for (var soundName in soundList)
	{
		sound = soundList[soundName];
		if(sound.isDynamic())
		{
			var distance = Between(playerPos,sound.getLocation());
			var distance_max = sound.getDistance();
			if(distance < distance_max + 40)
			{
                closeToPlayer[soundName] = soundName;
			}
			else
			{
                if(sound.loaded()) {
                    sound.mute();
                }
			}
		}
	}
}

setInterval(addToCache, 1000);

function updateVolumeSounds()
{
    var sound = null;
    for (var name in closeToPlayer)
    {
        sound = soundList[name];
        if(sound != null){
            if(sound.isDynamic())
            {
                var distance = Between(playerPos,sound.getLocation());
                var distance_max = sound.getDistance();
                if(distance < distance_max)
                {
                    sound.updateVolume(distance,distance_max);
                    continue;
                }
                sound.mute();
            }
        }
    }
}

setInterval(updateVolumeSounds, refreshTime);