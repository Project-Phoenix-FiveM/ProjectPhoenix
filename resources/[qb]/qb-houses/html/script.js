Decorations = {}

var houseCategorys = {};

var selectedObject = null;

var selectedObjectData = null;

$(".container").hide();

$('document').ready(function() {

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type == "toggle") {
            if (item.status == true) {
                $(".container").fadeIn(250);
            } else {
                $(".container").fadeOut(250);
            }
        }

        if (item.type == "setupContract") {
            $("#welcome-name").html(item.firstname + " " + item.lastname)
            $("#property-adress").html(item.street)
            $("#property-price").html("$ " + item.houseprice);
            $("#property-brokerfee").html("$ " + item.brokerfee);
            $("#property-bankfee").html("$ " + item.bankfee);
            $("#property-taxes").html("$ " + item.taxes);
            $("#property-totalprice").html("$ " + item.totalprice);
        }

        if (item.type == "openObjects") {
            Decorations.Open(item);
            houseCategorys = item.furniture;
        }

        if (item.type == "closeUI") {
            Decorations.Close();
        }

        if (item.type == "buyOption") {
            $(".decorate-confirm").css("display", "block");
            $(".decorate-confirm").find("p").html("Are you sure you want to purchase the item for $"+selectedObjectData.price+"?");
        }

        if (item.type == "objectLoaded") {
            $(".decorate-item").css({'pointer-events': 'auto'});
            $(".object-load-status").css("display", "none");
        }

        if (item.type == "frontcam") {
            if (item.toggle) {
                $("#house-cam").fadeIn(150);
                $("#cam-label").html(item.label);
            } else {
                $("#house-cam").fadeOut(150)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 116 ) {
            $.post('https://qb-houses/toggleCursor');
        }

        if (data.which == 13 ) {
            if (selectedObjectData != null && $(".decorate-confirm").css('display') != 'block') {
                $.post('https://qb-houses/editOwnedObject', JSON.stringify({
                    objectData: selectedObjectData
                }));
                selectedObjectData = null;
                $.post('https://qb-houses/setupMyObjects', JSON.stringify({}), function(myObjects){
                    $('.decorate-items').html("");
                    $.each(myObjects, function(i, object){
                        var elem = '<div class="decorate-item" id="myobject-'+i+'" data-type="myObject"><span id="decorate-item-name"><b>Object: </b>'+object.hashname+'</span><span id="decorate-item-category"><strong>Price: </strong><span id="item-price" style="color: green;">OWNED</span></span></div>';
                        $('.decorate-items').append(elem);
                        $('#myobject-'+i).removeData('myObjectData');
                        $('#myobject-'+i).data('myObjectData', object);
                    });
                    $(".decorate-items").fadeIn(150);
                });
            } else if (selectedObject !== null && $(".decorate-confirm").css('display') != 'block') {
                var objId = $(selectedObject).attr('id');
                var objData = $('#'+objId).data('objectData');
                selectedObjectData = objData
                if (objData != null) {
                    $.post("https://qb-houses/spawnobject", JSON.stringify({
                        object: objData.object,
                    }));
                    $(".decorate-items").fadeOut(150);
                }
                selectedObject = null;
            }
        }

        if (data.which == 27) {
            Decorations.Close();
        }
    };
})

Decorations.Open = function(data) {
    $("#decorate").fadeIn(250);
}

Decorations.SetupCategorys = function() {
    $(".decorate-footer-buttons").html("");
    $(".decorate-footer-buttons").hide();
    $.each(houseCategorys, function(key, category){
        var elem = '<div class="footer-btn" id="'+key+'"><p>'+category.label+'</p></div>';

        $(".decorate-footer-buttons").append(elem);
        $("#"+key).data('categoryData', category)
    });
    $(".decorate-footer-buttons").fadeIn(150);
}

var selectedHeaderButton = null;

$(document).on('click', '.header-btn', function(){

    if ($(this).attr('id') == "objects-list") {
        if ($(this).hasClass('header-btn-selected')) {
            $(selectedHeaderButton).removeClass('header-btn-selected');
            $(".decorate-footer-buttons").fadeOut(150);
        } else {
            $(selectedHeaderButton).removeClass('header-btn-selected');
            $(this).addClass('header-btn-selected');
            $('.decorate-items').fadeOut(150);
            Decorations.SetupCategorys();
        }
    }

    if ($(this).attr('id') == "close") {
        Decorations.Close();
    }

    if ($(this).attr('id') == "my-objects") {
        if ($(this).hasClass('header-btn-selected')) {
            $(selectedHeaderButton).removeClass('header-btn-selected');
            $('.decorate-items').fadeOut(150);
        } else {
            $(selectedHeaderButton).removeClass('header-btn-selected');
            $(this).addClass('header-btn-selected');
            $(".decorate-footer-buttons").fadeOut(150);
            $.post('https://qb-houses/setupMyObjects', JSON.stringify({}), function(myObjects){
                $('.decorate-items').html("");
                $.each(myObjects, function(i, object){
                    var elem = '<div class="decorate-item" id="myobject-'+i+'" data-type="myObject"><span id="decorate-item-name"><b>Object: </b>'+object.hashname+'</span><span id="decorate-item-category"><strong>Price: </strong><span id="item-price" style="color: green;">OWNED</span></span></div>';
                    $('.decorate-items').append(elem);
                    $('#myobject-'+i).data('myObjectData', object);
                });
                $(".decorate-items").fadeIn(150);
            });
        }
    }
    
    $.post('https://qb-houses/ResetSelectedProp');

    selectedHeaderButton = this;
})

$(document).on('click', '.footer-btn', function(){
    var selectedCategory = $(this).attr('id');
    if (selectedCategory != "remove-owned-obj") {
        $('.decorate-items').html("");
        $.each(houseCategorys[selectedCategory].items, function(i, item){
            var elem = '<div class="decorate-item" id="object-'+i+'" data-type="newObject"><span id="decorate-item-name"><b>Object: </b>'+(item.label).charAt(0).toUpperCase() +''+(item.label).substr(1).toLowerCase()+'</span><span id="decorate-item-category"><strong>Price: </strong><span id="item-price" style="color: green;">$'+item.price+'</span></span></div>';
            $('.decorate-items').append(elem);
            $('#object-'+i).data('objectData', item);
        });
        $(".decorate-items").fadeIn(150);
    } else {
        $(".decorate-items").html("");
        $(".decorate-footer-buttons").html("");
        $(selectedHeaderButton).removeClass('header-btn-selected');
        $.post('https://qb-houses/deleteSelectedObject');
        $(".decorate-footer-buttons").fadeOut(150);
        $(".decorate-items").fadeOut(150);
    }
});

$(document).on('click', '#buy-object', function(){
    $.post("https://qb-houses/buySelectedObject", JSON.stringify({
        price: selectedObjectData.price,
    }));
    selectedObjectData = null;
    $(".decorate-confirm").css("display", "none");
});

$(document).on('click', '#cancel-object', function(){
    $.post('https://qb-houses/cancelSelectedObject');
    selectedObjectData = null;
    $(".decorate-confirm").css("display", "none");
});

$(document).on('click', '.decorate-item', function(){
    var objId = $(this).attr('id');
    var objData = $('#'+objId).data('objectData');
    var myObjectData = $('#'+objId).data('myObjectData');
    if (selectedObject != null) {
        $(selectedObject).removeClass('selected-object');
    }

    if ($("#"+objId).data('type') == "newObject") {
        if (selectedObject == this) {
            $(this).removeClass('selected-object');
            selectedObject = null;
            $.post('https://qb-houses/removeObject');
        } else {
            $(this).addClass('selected-object');
            selectedObject = this;
            $.post("https://qb-houses/chooseobject", JSON.stringify({
                object: objData.object,
            }));
            $(".decorate-item").css({'pointer-events': 'none'});
            $(".object-load-status").css("display", "block");
        }
    } else if ($("#"+objId).data('type') == "myObject") {
        if (selectedObject == this) {
            $(this).removeClass('selected-object');
            $.post('https://qb-houses/deselectOwnedObject')
            selectedObject = null;
        } else {
            $(this).addClass('selected-object');
            selectedObject = this;
            selectedObjectData = myObjectData;
            $.post('https://qb-houses/selectOwnedObject', JSON.stringify({
                objectData: myObjectData
            }))
            $(".decorate-footer-buttons").html("");
            var elem = '<div class="footer-btn" id="remove-owned-obj"><p>Remove</p></div>';
            $(".decorate-footer-buttons").append(elem);
            $(".decorate-footer-buttons").fadeIn(150);
        }
    }
});

Decorations.Close = function() {
    $("#decorate").css("display", "none");
    $(".decorate-confirm").css("display", "none");
    $(".decorate-items").css("display", "none");
    $(".decorate-footer-buttons").css("display", "none");
    if (selectedHeaderButton != null) {
        $(selectedHeaderButton).removeClass('header-btn-selected');
    }
    selectedObjectData = null;
    $.post("https://qb-houses/closedecorations", JSON.stringify({}));
}

$(".property-accept").click(function(e){
    $.post('https://qb-houses/buy', JSON.stringify({}))
});

$(".property-cancel").click(function(e){
    $.post('https://qb-houses/exit', JSON.stringify({}));
});
