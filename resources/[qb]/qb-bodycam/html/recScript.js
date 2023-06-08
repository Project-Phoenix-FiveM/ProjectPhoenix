const canvas = document.getElementById("videocall-canvas");
var recordsData = [];
var webhook;
var Name = "";
var date = "";
var stopVideoRecord;
var randomKey;
var nowDate;
var StopTime;
var Vue =  new Vue({
    el: "#table",
    data: {
    records: [],
    users:  [],
    boss:false
    },
    methods: {
        addList: function (RD) {
          this.users.push(RD);
        } ,
        addRecords: function (RD) {
          this.records.push(RD);
        } ,
        clearList: function () {
            this.users = [];
        } ,
        PlayVideo : function(url) {
            $( ".recordStream" ).append("<video id='videoStream' controls width='1280' height='720'></video>");
            $( "#videoStream" ).html('<source  src="'+ url +'" type="video/webm">');
            $(".page").css("opacity","0");
            setTimeout(() => {
            $(".tablet").css("background-color","black");
            $(".recordStream").css("display","block");
            $(".page").css("overflow","hidden");
            }, 1000);
        },
        selectUser : function(citizen) {
            this.records = [];
            $(".Users").css("display","none");
            $.post("http://qb-bodycam/GetUserRecords",JSON.stringify({citizen:citizen}),function(cb){
                addRecFunc(cb)
            })
            $(".records").css("display","block")
            $("#filter").css('display',"block")
            $(".fixedhd button").html('<i class="fas fa-chevron-circle-left"></i>')
            $(".fixedhd button").attr('onclick',"backUser()")
        },
        setRecords: function(rec){
            this.records = rec
        },
        bossChange: function(is){
            this.boss = is
            console.log(is)
        },
        deleteRecord: function(key,cid){
            $.post("http://qb-bodycam/deleteRecords",JSON.stringify({key:key,cid:cid}),function(o){
                Vue.setRecords(o.data)
            })
        }
    }
  })

  function ara(){
      var value = document.getElementById("filter").value
      console.log(value)
    result = recordsData.filter(record => {
        var date = new Date(record.filterdate)
        const day = date.getDate();
        const monthIndex = ("0" + (date.getMonth() + 1)).slice(-2);
        const year = date.getFullYear();
        const dateString = `${year}-${monthIndex}-${day}`;
        return dateString.includes(value);
    })
    Vue.setRecords(result)
}

  function backUser() {
    $(".records").css("display","none")
    $("#filter").css('display',"none")
    $(".Users").css("display","block");
    $(".fixedhd button").html('<i class="fas fa-sign-out-alt"></i>')
    $(".fixedhd button").attr('onclick',"CloseKayitlar()")
  }

  function addRecFunc(data) {
    recordsData = [];
    for ( var index in data ) {
        Vue.addRecords( data[index] );
        recordsData.push( data[index] );
    }
  }

  function closeVideo() {
    var video = document.getElementById("videoStream");
    video.remove();
    $(".tablet").css("background-color","white");
    $(".recordStream").css("display","none");
    $(".page").css("opacity","100");
    $(".page").css("overflow","auto");
    $(".page").css("overflow-x","hidden");
}

function generateKey(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * 
 charactersLength));
   }
   return result;
}

window.addEventListener("message",function (event) {
    if (event.data.type == "record") {
        if (event.data.rec == true) {
            webhook = event.data.webhook 
            $(".bodycam").css("display","block");
            stopVideoRecord = false;
            if (event.data.resolutions == "360p") {
                innerWidth = 640 // 360p
                innerHeight = 360
            }else if (event.data.resolutions == "480p") {
                innerWidth = 854 // 480p
                innerHeight = 480
            }else if (event.data.resolutions == "720p") {
                innerWidth = 1280 // 720p
                innerHeight = 720
            }else if (event.data.resolutions == "1080p") {
                innerWidth = 1920 // 1080p
                innerHeight = 1080
            }

            StopTime = event.data.time
    // ------------------------------
			
            Name = event.data.pName.toUpperCase();
            var grade = event.data.jobGrade.toUpperCase();
			var job = event.data.jobName;

            if (job == 'sheriff') {
                $(".logo").attr("src", "lssd.png");
                job = "Los Santos County Sheriff's Department";
            }
            else if (job == 'police') {
                $(".logo").attr("src", "lspd.png");
                job = "Los Santos Police Department";
            }
               document.getElementById("player").innerHTML =  event.data.pName.toUpperCase();
               document.getElementById("job").innerHTML = job,
               document.getElementById("grade").innerHTML =  grade;
            setInterval(function(){
                const months 	= ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                const  days     = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                var e = new Date,
                a = e.getHours(),
                n = e.getMinutes(),
                sec = e.getSeconds(),
                s = sec,
                o = n,
                month 	= e.getMonth(),
                day 	= e.getDay(),
                date 	= e.getDate(),
                d = date,
                year = e.getFullYear(),
                i = a;
                a < 10 && (i = "0" + i), n < 10 && (o = "0" + n) ,  sec < 10 && (s = "0" + sec) , date < 10 && (d = "0" + date);
                document.getElementById("day").innerHTML =  days[day];
                document.getElementById("month").innerHTML =  months[month];
                document.getElementById("year").innerHTML =  year;
                document.getElementById("hr").innerHTML =  i;
                document.getElementById("min").innerHTML =  o;
                document.getElementById("sec").innerHTML =  s;
                nowDate =  days[day] + ", " + d + " " + months[month]  + " " + year + " " + i+":"+o+":"+s
            },1000)

// ------------------------------
            MainRender.renderToTarget(canvas);
            recVideoFunction();
            randomKey = generateKey(8);
            setTimeout(() => {
                stopVideoRecord = false;
                recVideoStreem.state == 'recording' && recVideoStreem.stop()
            },StopTime+1000);
        }else{
            $(".bodycam").css("display","none");
            stopVideoRecord = true;
            recVideoStreem.stop()
            MainRender.stop();
        }
    }else if (event.data.type == "data") {
        Vue.clearList();
        for (const key in event.data.RecData) {
            console.log(typeof(event.data.RecData[key]))
            Vue.addList(event.data.RecData[key]);
        }
        $(".tablet").css("display","block");
        console.log(event.data.job_grade)
        if (event.data.job_grade == event.data.boss) {
            console.log(true)
            Vue.bossChange(true);
        }else{
            console.log(false)
            Vue.bossChange(false);
        }
    }
})



let recVideoStreem;
var science = canvas.captureStream(60)// argüman olarak kaç fps işleyeceğini değiştirebilirsiniz.
const recVideoFunction = async() => {
    try {
            let chunks = [];
            recVideoStreem = new MediaRecorder(science); 
            recVideoStreem.ondataavailable = e => {
                    chunks.push(e.data);
                    if (recVideoStreem.state == 'inactive') {
                        ctx = canvas.getContext("2d");
                        ctx.clearRect(0, 0, canvas.width, canvas.height);
                            let blob = new Blob(chunks, { type: 'video/webm;' });

                            if (!stopVideoRecord) {
                                recVideoFunction();
                                setTimeout(() => {
                                    recVideoStreem.state == 'recording' && recVideoStreem.stop()
                                },StopTime+1000);
                            }else{
                                $(".ntf1").css("display","block")
                            }

                            const formData = new FormData(); 
                            formData.append("files[]",blob,"video.webm"); // Oluşan video kaydını blob formatında aldıktan sonra dc'a göndermek üzere form datasına ekler.
                            formData.append("avatar_url","https://cdn.discordapp.com/attachments/1021993639708209152/1023108505089097728/OIP.png")
                            formData.append("username","Venture BodyCam System") // Discord botun ismini ayarlar.
                            formData.append("content",Name+ " "+" Recorded Bodycam"+" "+"Keynumber : "+randomKey) // Discord botun ismini ayarlar.
                        fetch(webhook, { // Oluşturulan video kaydını  dc weebhok ile dc kanalına gönderir ve oluşturulan dosya linkini geri döndererek kullanmaya yarar.
                            method: 'POST',
                            mode: 'cors',
                            body: formData
                        })
                        .then(response => response.text())
                        .then(text => {
                            var textparse = JSON.parse(text);
                            var RetunUrl = textparse.attachments[0].url
                            const d = new Date();   
                            $.post("http://qb-bodycam/SendNewRecord", JSON.stringify({ // Oluşturulan dc ses linkini alarak mesaj wp uygulamasına mesaj olarak ekler.
                                Name: Name,
                                Date: nowDate,
                                RecordUrl:RetunUrl,
                                key:randomKey,
                                filterdate:d // Filtreleme işlemi için Date formatında tarih.
                            }));
                            if (stopVideoRecord) {
                                randomKey = "";
                                setTimeout(() => {
                                    $(".ntf1").css("display","none") 
                                    $(".ntf2").css("display","block")
                                }, 1000);
                                setTimeout(() => {
                                    $(".ntf2").css("display","none")
                                }, 3000);
                            }
                        });
                    }
                }
            recVideoStreem.start()
    } catch (error) {
        if (error) console.log(error);
    }
}





function CloseKayitlar(){
    $(".tablet").css("display","none");
    $.post("http://qb-bodycam/NuiFalse");
}

