<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("首页")%>
	<link rel="stylesheet" href="/js/txtscroller/scroll.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/jquery191min.js"></script>
	<script src="js/sea.js"></script>
	<script src="js/config.js"></script>
	<script src="js/jquery/easing/1.3.0/easing.js"></script>
    <script type="text/javascript">
        $(function(){
            var movetime = 1000;
            var page = 1;
            var li_width = 250;  //固定每个li的宽度
            var $parent = $("div.video_show");//根据当前点击元素获取到父元素
            var $v_show = $("div.video_content_list"); //寻找到“视频内容展示区域”
            var $v_content = $("div.video_content"); //寻找到“视频内容展示区域”外围的DIV元素
            var v_width = $v_content.width() ;
            var i = Math.floor(v_width / li_width); //图片宽度不变，根据外围宽度来决定个数
            var len = $v_show.find("li").length;
            var page_count = Math.ceil(len / 8) ;   //只要不是整数，就往大的方向取最小的整数
            var scrol_width = 1000;

            //把整个ul分成几个ul
            var limit = 8;
            if (len > limit) {
                var loop = Math.ceil(len / limit);
                for (var i = 1; i < loop; i++) {
                    $("<ul id='testUI" + i + "'></ul>").appendTo($(".video_content_list"));
                    for (var j = 0; j < limit; j++) {
                        $(".video_content_list ul li:nth-child(" + (limit + 1) + ")").appendTo($("#testUI" + i));
                    }
                }
            }
            var point_html = '<div class="prev" >上一页</div>';
            var _width = 50 + page_count*24;
            var $width = $(window).width();
            //$(".highlight_tip").css("left",($(window).width() - _width)/2);
            point_html += '<div class="next">下一页</div>';
            $(".highlight_tip").html(point_html);
            //向后 按钮
            $("div.next").click(function(){    //绑定click事件
                if( !$v_show.is(":animated") ){    //判断“视频内容展示区域”是否正在处于动画
                    if( page == page_count ){  //已经到最后一个版面了,如果再向后，必须跳转到第一个版面。
                        $v_show.animate({ left : '0px'}, {duration:movetime,easing:"easeInOutCirc"}); //通过改变left值，跳转到第一个版面
                        page = 1;
                    }else{
                        $v_show.animate({ left : '-='+scrol_width }, {duration:movetime,easing:"easeInOutCirc"});  //通过改变left值，达到每次换一个版面
                        page++;
                    }
                    $parent.find(".div1").eq((page-1)).addClass("current").siblings().removeClass("current");
                }
            });
            //往前 按钮
            $("div.prev").click(function(){
                if( !$v_show.is(":animated") ){    //判断“视频内容展示区域”是否正在处于动画
                    if( page == 1 ){  //已经到第一个版面了,如果再向前，必须跳转到最后一个版面。
                        $v_show.animate({ left : '-='+scrol_width*(page_count-1) }, {duration:movetime,easing:"easeInOutCirc"});
                        page = page_count;
                    }else{
                        $v_show.animate({ left : '+='+scrol_width }, {duration:movetime,easing:"easeInOutCirc"});
                        page--;
                    }
                    $parent.find(".div1").eq((page-1)).addClass("current").siblings().removeClass("current");
                }
            });
            $(".highlight_tip .div1").on("click",function() {
                if( !$v_show.is(":animated") ) {
                    var span_index = $(this).html();
                    if ( span_index > page ) {
                        $v_show.animate({ left : '-='+(span_index - page) * scrol_width }, {duration:movetime,easing:"easeInOutCirc"});
                        page = span_index;
                    }
                    if ( span_index < page ) {
                        $v_show.animate({ left : '+='+(page - span_index) * scrol_width }, {duration:movetime,easing:"easeInOutCirc"});
                        page = span_index;
                    }
                    $(this).addClass("current").siblings().removeClass("current");
                }
            })
        });
    </script>
</head>
<body>
	<!--#include file="top.asp" -->
	<div class="topnews">
		<div class="in-topnews">
			<div class="topnews-l"><img src="images/imgtopnews.jpg" alt=""></div>
			<div class="scrollbox">
					<div class="scroltit">
						<span id="but_up" style="cursor: pointer;"></span>
						<span id="but_down" style="cursor: pointer;"></span>
						<span id="but_num"></span>
					</div>
					<div id="scrollDiv">
				        <ul>
                            <%
                                Set Rs=Server.CreateObject("Adodb.RecordSet")
                                Sqla = "Select top 5 * From newsinfo Where ClassID=1 order by NewsOrder Desc"
                                Rs.Open Sqla,Conn,1,1
                                i=0
                                Do While Not Rs.Eof And i<5
                            %>
					        <li>
				        		<a href="shownews.asp?ID=<%=Rs("ID")%>" target="_blank" title="<%=Rs("NewsTitle")%>"><%=Rs("NewsTitle")%> </a><span><%=GetPostTime(Rs("ID"),"newsinfo")%></span>
				        	</li>
                            <%
                                i=i+1
                                Rs.MoveNext
                                loop
                                Rs.Close:Set Rs=Nothing
                            %>
			        	</ul>
				    </div>
				</div>
			<div class="topnews-r"><a href="news.asp">查看更多>></a></div>
		</div>
	</div>
	<div class="main-1">
		<div class="main-1-r">
			<h2 class="h-title"><img src="images/imgcontact.jpg" alt=""></h2>
			<span><i class="add"></i>公司地址： 温州市9号创意街区X懂X楼000室</span>
			<span><i class="user"></i>联 系 人：  陈某某经理</span>
			<span><i class="tel1"></i>联系电话： 0577-88888888</span>
			<span><i class="email"></i>电子邮箱： bojun@163.com</span>
			<h3 style="padding-top: 8px;"><img src="images/imgmap.jpg" alt=""></h3>
		</div>
		<div class="main-1-l">
			<h2 class="h-title"><img src="images/imgcompany.jpg" alt=""></h2>
			<dl>
				<dt><span>温州市博钧电子商务有限公司</span>，是一家专业经营跨境电子商务贸易和咨询服务的专业公司，主营业务包括两大块：（1）以化妆品为主的大众消费品的国内品牌建设和代理销售；（2）为国内外企业提供企业管理咨询及完善的电子商务解决方案。公司自2010年5月成立以来，以持续创新的科学理念推动互联网经济与传统行业相结合...<span style="display: inline-block;padding-top: 12px;"><a href="company.asp"><img src="images/imgmore.jpg" alt=""></a></span></dt>
				<dd><a href="company.asp"><img src="images/imgcompany1.jpg" alt=""></dd></a>
			</dl>
		</div>
	</div>
	<div class="main-2">
		<div class="pro-title">
			<img src="images/imgproduct.jpg" alt="">
		</div>
		<div class="video_show">
            <div class="video_content">
                <div  class="video_content_list">
                    <ul>
                        <%
                            Set Rs=Server.CreateObject("Adodb.RecordSet")
                            Sqla = "Select top 24 * From shopinfo Where ClassID In (2"&GetAllChild("shopClass",2)&") order by shopOrder Desc"
                            Rs.Open Sqla,Conn,1,1
                            i=0
                            Do While Not Rs.Eof And i<24
                        %>
                    	<li><a href='showproducts.asp?ID=<%=Rs("ID")%>&ClassID=<%=Rs("ClassID")%>' target='_blank' title='<%=Rs("shopname")%>'><img src='<%=Rs("shopspic")%>' /><span><%=GetShopTitle(Rs("ID"),20)%></span><span>价格：<%=Rs("ShopSPrice")%> 元</span></a></li>
                    	<%
                            i=i+1
                            Rs.MoveNext
                            loop
                            Rs.Close:Set Rs=Nothing
                        %>
                    </ul>
                </div>
            </div>
            <div class="v_caption">
                <div class="highlight_tip">

                </div>
            </div>
        </div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>