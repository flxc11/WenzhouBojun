//显示蒙灰层
function ShowMark(){
     var xp_mark=document.getElementById("xp_mark");
     if(xp_mark!=null) {
         //设置DIV
         xp_mark.style.left=0+"px";
         xp_mark.style.top=0+"px";
         xp_mark.style.position="absolute";
         xp_mark.style.backgroundColor="#000";
         xp_mark.style.zIndex="190";
         if(document.all) {
            xp_mark.style.filter="alpha(opacity=50)";
            var Ie_ver=navigator["appVersion"].substr(22,1);
           // if(Ie_ver==6||Ie_ver==5){hideSelectBoxes();}
         }
         else{xp_mark.style.opacity="0.5";}
         xp_mark.style.width="100%";
       var heights=XP_getPageSize().h;
       if(heights<600) {
         heights=620;
       }
       xp_mark.style.height=heights+"px";
         xp_mark.style.height=="100%";
         xp_mark.style.display="block";
     }
     else{
     //页面添加div explainDiv,注意必须是紧跟body 内的第一个元素.否则IE6不正常.
     $("body").prepend("<div id='xp_mark' style='display:none;'></div>");
     ShowMark();//继续回调自己
     }
}
//隐藏蒙灰层
function HideMark(){
    var xp_mark=document.getElementById("xp_mark");
    xp_mark.style.display="none";
    var Ie_ver=navigator["appVersion"].substr(22,1);
   // if(Ie_ver==6||Ie_ver==5){showSelectBoxes();}
}
//获取页面的高度与宽度
function XP_getPageSize(){
    var pt = {w:0,h:0}; 
    if (window.innerHeight && window.scrollMaxY){
      pt.w = document.body.scrollWidth;
      pt.h = window.innerHeight + window.scrollMaxY;
    }
    else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
      pt.w = document.body.scrollWidth;
      pt.h = document.body.scrollHeight;
    } 
    else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
      pt.w = document.body.offsetWidth;
      pt.h = document.body.offsetHeight;
    }
    return pt;
}
function showDiv(obj){//页面可以用obj == document.getElementById();
 $(obj).show().css({"z-index":"200","position":"absolute"});
 center(obj);
 $(window).scroll(function(){
  center(obj);
 });
 $(window).resize(function(){
  center(obj);
 }); 
}
function center(obj){//页面可以用obj == document.getElementById();
    var windowWidth = document.documentElement.clientWidth;   
   var windowHeight = document.documentElement.clientHeight;   
   
   var popupHeight =$(obj).height();   
   var popupWidth =$(obj).width();    
   
   $(obj).css({
    "top": (windowHeight-popupHeight-400)/2+$(document).scrollTop()+200,   
    "left": (windowWidth-popupWidth)/2   
   });  
}
 //让层居中隐藏
function closeDiv(obj){
    $(obj).hide();
    $(window).unbind();
}	