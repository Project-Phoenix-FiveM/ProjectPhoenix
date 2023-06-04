var UIVisible = false;

$(document).ready(function(){
    window.addEventListener('message', function(event){
        var Data = event.data;

        if (Data.action == "UpdateUI") {
            UpdateUI(Data)
        }
    });
});

function UpdateUI(data) {
    if (data.IsActive) {
        if (!UIVisible) {
            $(".container").fadeIn(300);
            $.each(data.Stock, function(i, stock){
                var Parent = $(".hotdogs-stocks").find('[data-stock="'+i+'"]');
                var Span = $(Parent).find('.stock-amount');
                $(Span).html(stock.Current + " / " + stock.Max[data.Level.lvl - 1]);
            });
            if (data.Level.rep !== undefined) {
                $("#my-level").html('LEVEL '+data.Level.lvl+' : '+data.Level.rep+'xp');
            } else {
                $("#my-level").html('LEVEL '+data.Level.lvl+' : 0xp');
            }
            UIVisible = true;
        } else {
            $.each(data.Stock, function(i, stock){
                var Parent = $(".hotdogs-stocks").find('[data-stock="'+i+'"]');
                var Span = $(Parent).find('.stock-amount');
                $(Span).html(stock.Current + " / " + stock.Max[data.Level.lvl - 1]);
            });
            if (data.Level.rep !== undefined) {
                $("#my-level").html('LEVEL '+data.Level.lvl+' : '+data.Level.rep+'xp');
            } else {
                $("#my-level").html('LEVEL '+data.Level.lvl+' : 0xp');
            }
        }
    } else {
        $(".container").fadeOut(300);
        UIVisible = false;
    }
}