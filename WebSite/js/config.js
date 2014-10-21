seajs.config({
    alias:{
        "jquery": "jquery/jquery/1.8.3/jquery",
        "easing":"jquery/easing/1.3.0/easing",
        "mousewheel":"jquery/mousewheel/jquery.mousewheel",
        "color":"jquery/color/jquery.color",
        "modernizr":"modernizr/2.8.2/modernizr.js",
        "browser":"Public/browser",
        "lampMenu":"jquery.lamp.menu/sea/jquery.lamp.menu",
        "util":"Public/util",
        "myFocus":"myFocus/myFocus",
        "masonry":"masonry/2.1.8/jquery.masonry.min",
        "simplemodal":"simplemodal/jquery.simplemodal",
        "stickUp":"stickUp/stickUp.min",
        "nicescroll":"nicescroll/jquery.nicescroll.min",
        "roundabout":"fredhq/roundabout/jquery.roundabout.min",
        "roundaboutShapes":"fredhq/roundabout-shapes/jquery.roundabout-shapes.min",
        "lightbox":"lightbox/jquery.lightbox-0.5",
        "jCarousel": "jCarousel/3.0/jquery.jcarousel.min",
        "formValidator": "formValidator/2.6.2/jquery.validationEngine",
        "tab": "tab/tab.js",
        "txtscroller": "txtscroller/jqscroll.js",
        "print": "jquery/print/JqPrintArea",
        "dialog": "dialog/dialog"
    },
    preload:["easing","jCarousel"]
})
seajs.use("cnvp");
//多语言版本站点
var language = false;
//调试模式
var debug = true;
var TIME_STAMP = '?t=' + new Date().getTime();
seajs.on('fetch', function(data) {
  if (data.uri && debug) {
    data.requestUri = data.uri + TIME_STAMP
  }
});
seajs.on('define', function(data) {
  if(data.uri && debug) {
    data.uri = data.uri.replace(TIME_STAMP, '')
  }
});
