//tab选项卡
$(".cnvp-tab-nav>a").bind('mouseenter', function () {
    var tabs = $(this).parent().children("a");
    var selectedclass = getClass(tabs);
    var panels = $(this).parent().parent().children(".cnvp-tab-panle");
    var index = $.inArray(this, tabs);
    if (panels.eq(index)[0]) {
        $(tabs).removeClass(selectedclass)
            .eq(index).addClass(selectedclass);
        $(panels).addClass("cnvp-tabs-hide")
            .eq(index).removeClass("cnvp-tabs-hide");
    }
});
String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}
getClass = function (items) {
    currCls = null;
    items.each(function (i, item) {
        cls = $(item).attr('class');
        if (cls && !cls.trim() == '') {
            currCls = cls;
            return cls;
        }
    });
    return currCls;
};