var _c = _h = 0;
$(function(){
$('#play > a').click(function(){
var i = $(this).attr('alt') - 1;
clearInterval(_h);
_c = i;
play();
change(i);        
})
$("#pic img").hover(function(){clearInterval(_h)}, function(){play()});
play();
})
function play()
{
_h = setInterval("auto()", 3000);
}
function change(i)
{
$('#play > a').css('background-color','#E8FCEB').eq(i).css('background-color','#C6FF5E').blur();
$("#pic img").hide().eq(i).fadeIn('slow');
}