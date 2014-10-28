define(function(require){
    var util = require("Public/util.js");
    require("jCarousel");
    require("txtscroller");
    $(function(){
        util.widget.setHome(".fav .sethome");
        util.widget.addFav(".fav .aff");
        $("#scrollDiv").Scroll({
            line:1,
            speed:500,
            timer:3000,
            up:"but_down",
            down:"but_up",
            Num: "but_num"
        });
        $(".mycarousel").JC({
            page: true
        });
    })
})