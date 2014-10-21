myFocus.pattern.extend({//*********************kdui******************
    'mF_cnvp2014':function(settings,$){
        var $focus=$(settings);
        var $picList=$focus.find('.pic li');
        var $txtList=$focus.addListTxt().find('li');
        var $dotList=$focus.addList('dot').find('li');
        var $prevBtn=$focus.addHtml('<div class="prev"></div>');
        var $nextBtn=$focus.addHtml('<div class="next"></div>');
        var $images =$picList.find('img');
        //$focus.find(".pic").wrap("<div class='border'></div>");
        //PLAY
        var param={isRunning:false},body=document.body.offsetWidth,width=settings.width,img=[];
        $focus.find(".border").css({
            width:"100%",
            height:settings.height,
            position:"relative",
            overflow:"hidden"
        })
        $focus.css({
            width:width,
            height:settings.height+settings.txtHeight
        })
        $images.each(function(i){
            img[i] = $(this).css("width");
            if(!i) $picList.eq(i).fadeIn(0)
            else $picList.eq(i).fadeIn(0).css({display:'none'});
            if(img[i]>width) $(this).css({ marginLeft:-(img[i]-width)/2 });
        })
        if(settings.method=='scroll'){
            $focus.play(null,function(i,n,l){
                param.isRunning=true;
                if(i==l){
                    $picList.eq(i).css({display:'block',left:0});
                    param.isRunning=false
                }else{
                    $picList.eq(i).css({display:'block',left:width}).slide({left:0},770,"easeInOut",function(){param.isRunning=false});
                    $picList.eq(l).slide({left:-width},800,"easeInOut");
                }
                $dotList[l].className='';
                $dotList[i].className='current';
            });
        }else if(settings.method=="fadeIn"){
            $focus.play(function(i){
                param.isRunning=true;
                $dotList[i].className='';
                if(settings.timeBar) $bar.stop()[0].style.width=barW+'px';
                if(settings.timeBar&&!over) $bar.slide({width:0},t,'linear');
            },function(i){
                $picList.eq(i).css({zIndex:2}).fadeIn(600,'swing',function(){
                    $picList.each(function(){$(this).css({display:'none'})});
                    $(this).css({zIndex:1,display:'block'});
                    param.isRunning=false;
                });
                $dotList[i].className='current';
            });
        }
        //Control
        settings.delay=200;
        settings.wrap=false;
        $focus.bindControl($dotList,param);
        $prevBtn.bind('click',function(){if(!param.isRunning) $focus.run('-=1')});
        $nextBtn.bind('click',function(){if(!param.isRunning) $focus.run('+=1')});
        if($.isIE){
            $nextBtn.bind('selectstart',function(){return false});
            $prevBtn.bind('selectstart',function(){return false});
        }
        $focus.bind('mouseover',function(){$prevBtn.addClass('arr-hover'),$nextBtn.addClass('arr-hover')});
        $focus.bind('mouseout',function(){$prevBtn.removeClass('arr-hover'),$nextBtn.removeClass('arr-hover')});
        function onResize(){
            width = body = document.body.offsetWidth;
            $focus.css({width:width});
            $images.each(function(i){
                var left = $picList.eq(i).css("left");
                if(left!=0&&settings.method=="scroll") $picList.eq(i).css({left:-width});
                $(this).css({ marginLeft:-(img[i]-width)/2 });
            })
        };
        if(width>=body) $.addEvent(window,'resize',onResize);
    }
});
myFocus.config.extend({'mF_cnvp2014':{txtHeight:0,method:"scroll"}});//默认文字层高度