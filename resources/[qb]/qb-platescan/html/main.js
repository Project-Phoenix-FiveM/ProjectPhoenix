$('document').ready(function() {
    alerts = {};
    
    window.addEventListener('message', function (event) {
        ShowNotif(event.data);
    });

    function ShowNotif(data) {
        var $notification = CreateNotification(data);
        var $height = $notification.height;
        $('.notif-container').empty()
        $('.notif-container').prepend($notification.animate({width: '300px', height: ''+ $height +'', 'line-height':'1.5em', fontSize: '12px', margin:'0 0 4px 0', opacity:'1'}));
        setTimeout(function() {
            $.when($notification.animate({width: '0', height:'0', fontSize: '0', margin:'5px 5px 5px 300px', opacity:'0'})).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    }
    
    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        $notification.addClass('notification').addClass(data.type);
        
        if (data.info.info !== undefined) {
            data.info.info = data.info.info.substring(0,102);

            if (!/^[A-Za-z0-9]/.test(data.info.info)) {
                var right = data.info.info.search("\\]");
                var reasons = data.info.flagReason

                data.info.info = '<span id="descbanner">' + data.info.info.substring(1, right) + '</span>'

                $.each(reasons, function(i, reason){
                    if (data.info.infoCode !== undefined) {
                        data.info.infoCode = data.info.infoCode + '<span id="code">' + reason + '</span>'
                    } else {
                        data.info.infoCode = '<span id="code">' + reason + '</span>'
                    }
                });

                if (data.type === "bad") {
                    $notification.html('\
                    <div class="content">\
                    <div id="alert-info">' + data.info.info + '<b>' + data.info.plateStatus + '</b>'
                    + '<br><i class="fas fa-user"></i><b>Owner:</b> ' + data.info.info2
                    + '<br><i class="fas fa-car"></i><b>Model: </b>' + data.info.info3
                    + '<br>' + data.info.infoCode + '</div></div>');
                } else {
                    $notification.html('\
                    <div class="content">\
                    <div id="alert-info">' + data.info.info + '<b>' + data.info.plateStatus + '</b>'
                    + '<br><i class="fas fa-user"></i><b>Owner:</b> ' + data.info.info2
                    + '<br><i class="fas fa-car"></i><b>Model: </b>' + data.info.info3 + '</div></div>');
                }
                $notification.height = '97px'
            }
        }

        $notification.fadeIn(10);

        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
       return $notification;
    }
});