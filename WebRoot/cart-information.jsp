<%@page import="java.util.Iterator"%>
<%@page import="com.syc.cart.cartitem"%>
<%@page import="com.syc.cart.cart"%>
<%@page import="com.syc.shopping.user"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	user u=(user)session.getAttribute("user");
cart c=(cart)session.getAttribute("cart");
String doOrder="false";
if(u==null){
	response.sendRedirect("nologin.jsp");
	return;
}
if(c==null || c.productcount()<1){
	response.sendRedirect("cart.jsp");
	return;
}
String adress=request.getParameter("adress");
String name=request.getParameter("name");
String phone=request.getParameter("phone");
out.println("adress");
String phone1="";
String name1="";
String adress1="";
if(adress!=null && phone!=null && name!=null && !adress.trim().equals("") && !phone.trim().equals("") && !name.trim().equals("")){
byte[] adresses=URLEncoder.encode(adress,"ISO-8859-1").getBytes();
adress1=new String(adresses,"gbk");
adress=URLDecoder.decode(adress,"gbk");
byte[] names=URLEncoder.encode(name,"ISO-8859-1").getBytes();
name1=new String(names,"gbk");
name=URLDecoder.decode(name,"gbk");
byte[] phones=URLEncoder.encode(phone,"ISO-8859-1").getBytes();
phone1=new String(phones,"gbk");
phone=URLDecoder.decode(phone,"gbk");
doOrder="true";
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>ѧ����</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]> 
<link href="css/main.ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 7]> 
<link href="css/main.ie7.css" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="js/jquery-imgslideshow.js"></script>
<script type="text/javascript" src="js/ks-switch.js"></script>
<script type="text/javascript" src="js/lib.js"></script>
<script type="text/javascript">
	var timeout = 500;
	var closetimer = 0;
	var ddmenuitem = 0;

	$(document).ready(function() {
		$('.cat_item').mousemove(function() {
			$(this).addClass('cat_item_on');
		});
		$('.cat_item').mouseleave(function() {
			$(this).removeClass('cat_item_on');
		});
		$('#slideshow').imgSlideShow({
			itemclass : 'i'
		})
		$("#slide-qg").switchTab({
			titCell : "dt a",
			trigger : "mouseover",
			delayTime : 0
		});
		$("#s_cart_nums1").hover(function() {
			mcancelclosetime();
			if (ddmenuitem)
				ddmenuitem.hide();
			ddmenuitem = $(document).find("#s_cartbox");
			ddmenuitem.fadeIn();
		}, function() {
			mclosetime();
		});
		$("#s_cart_nums2").hover(function() {
			mcancelclosetime();
			if (ddmenuitem)
				ddmenuitem.hide();
			ddmenuitem = $(document).find("#s_cartbox");
			ddmenuitem.fadeIn();
		}, function() {
			mclosetime();
		});
		$("#s_cartbox").hover(function() {
			mcancelclosetime();
		}, function() {
			mclosetime();
		});
		var $cur = 1;
		var $i = 4;
		var $len = $('.hot_list>ul>li').length;
		var $pages = Math.ceil($len / $i);
		var $w = $('.hotp').width() - 66;

		var $showbox = $('.hot_list');

		var $pre = $('div.left_icon');
		var $next = $('div.rgt_icon');

		$pre.click(function() {
			if (!$showbox.is(':animated')) {
				if ($cur == 1) {
					$showbox.animate({
						left : '-=' + $w * ($pages - 1)
					}, 500);
					$cur = $pages;
				} else {
					$showbox.animate({
						left : '+=' + $w
					}, 500);
					$cur--;
				}

			}
		});

		$next.click(function() {
			if (!$showbox.is(':animated')) {
				if ($cur == $pages) {
					$showbox.animate({
						left : 0
					}, 500);
					$cur = 1;
				} else {
					$showbox.animate({
						left : '-=' + $w
					}, 500);
					$cur++;
				}

			}
		});

	});
	function mclose() {
		if (ddmenuitem)
			ddmenuitem.hide();
	}
	function mclosetime() {
		closetimer = window.setTimeout(mclose, timeout);
	}
	function mcancelclosetime() {
		if (closetimer) {
			window.clearTimeout(closetimer);
			closetimer = null;
		}
	}
</script>
</head>

<body>
	<div id="doc">
		<div id="s_hdw">

			<div id="s_tbar">
				<div class="s_hd">
					<div class="tbar_lft">
						<%
							if(u==null){
						%>
						<a href="login.jsp">�ף����¼</a> | <a href="register.jsp">���ע��</a>
						<%
							}else{
						%>
						HI,�û�<%=u.getUsername()%>
						<%
							}
						%>
					</div>
					<div class="tbar_rgt">
						<ul>
							<li class="first"><a href="my.jsp">�ҵĶ���</a></li>
							<li><a href="my,jsp">�ҵ�ѧ����</a></li>
							<li><a href="#">���ﳵ</a></li>
							<li><a href="#">�ղؼ�</a></li>
							<li><a href="/LOGO/admin/login.jsp">�����̨</a></li>
							<li class="s_tel_str">�������ߣ�</li>
							<li class="s_tel">10086-10010-10001</li>
						</ul>
					</div>
				</div>
			</div>
			<!--s_tbar end-->

			<div class="s_hd nav">
				<div id="s_logo">
					<a href="index.jsp"><img src="images/logo.jpg" border="0" /></a>
				</div>
				<div id="s_nav">
					<ul>
						<li class="first cur"><a href="index.jsp">��ҳ</a><span></span></li>
					</ul>
				</div>
			</div>
			<!--s_hd end-->

			<div class="mmenu">
				<div class="s_hd">
					<div id="s_search">
						<form action="" method="post">
							<input name="" type="text" class="search-input" /><input name=""
								type="image" src="images/btn_search.jpg" />
						</form>
					</div>

					<div id="s_keyword">
						<ul>
							<li><strong>���ţ�</strong></li>
							<li><a href="#">Java�鼮</a></li>
							<li><a href="#">�Ż�</a></li>
							<li><a href="#">��ʳ</a></li>
						</ul>
					</div>

					<div id="s_cart">
						<ul>
							<li class="nums"><a href="cart.jsp" id="s_cart_nums1">���ﳵ��
									<span><%=c.productcount()%></span> ��
							</a> <a href="cart.jsp" class="btn" id="s_cart_nums2"></a></li>
							<li class="checkout"><a href="cart.jsp">ȥ����>></a></li>
						</ul>
					</div>

					<div id="s_cartbox" class="s_cartbox">���Ĺ��ﳵ��������Ʒ���Ͽ�ѡ���İ�����Ʒ�ɣ�</div>

					<script type="text/javascript">
						$(document).ready(function() {
							$("#s_cats").hoverClass("current");
						});
					</script>

					<div id="s_cats">
						<div class="cat_hd">
							<h3>
								<a style="color:#FFFFFF" >������Ʒ����</a>
							</h3>
						</div>
						<div class="cat_bd">
							<ul>
								<li class="cat_item">
									<h4 class="cat_tit">
										<a href="#" class="cat_tit_link">ʳƷ�����ϡ���ˮ</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">����ʳƷ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">���ڱ��ɸ��</a></li>
														<li><a href="#">���ڳ���</a></li>
														<li><a href="#">����ţ��</a></li>
														<li><a href="#">������Ƭ</a></li>
														<li><a href="#">���ڿ�Ȫˮ</a></li>
														<li><a href="#">�������Ӳ�/�̲�</a></li>
														<li><a href="#">���ڻ�����</a></li>
														<li><a href="#">�������/���</a></li>
														<li><a href="#" class="more">����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">������ʳ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��Ƭ</a></li>
														<li><a href="#">���׻�</a></li>
														<li><a href="#">��ʳƷ</a></li>
														<li><a href="#">��Ѽ����</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">��̦</a></li>
														<li><a href="#">�۽�</a></li>
														<li><a href="#">����/ ����/���߸�</a></li>
														<li><a href="#">Сʳ</a></li>
														<li><a href="#">���</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">̼������</a></li>
														<li><a href="#">��֭</a></li>
														<li><a href="#">�˶�/��������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">ˮ</a></li>
														<li><a href="#">��Ʒ</a></li>
														<li><a href="#">��������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ơ��</a></li>
														<li><a href="#">���Ѿ�</a></li>
														<li><a href="#">�׾�</a></li>
														<li><a href="#">�ƾ�</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">�̲���</a></li>
														<li><a href="#">�ձ���</a></li>
														<li><a href="#">Ԥ����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">������/��ʳ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">��ʳƷ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��/���</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ʳ����</a></li>
														<li><a href="#">����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����</a></li>
														<li><a href="#">��ţ��</a></li>
														<li><a href="#">��ζ��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��ͯ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���ʵ�����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���ȳ���</a></li>
														<li><a href="#">���ȶ�/��</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">�������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�̷�</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��Ƭ</a></li>
														<li><a href="#">�̲�</a></li>
														<li><a href="#">����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ζ����</a></li>
														<li><a href="#">��ζ����</a></li>
														<li><a href="#">�մ����</a></li>
														<li><a href="#">���ı���</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">�������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>

										</div>

										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ӽ�� Everwines</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��ʦ��</a></li>
														<li><a href="#">��ţ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�ɿڿ���</a></li>
														<li><a href="#">ȸ��</a></li>
														<li><a href="#">ͳһ</a></li>
														<li><a href="#">������</a></li>
													</ul>
												</dd>
											</dl>

											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">����ѧ���Ե���</a></li>
														<li><a href="#">��ѧ������</a></li>
														<li><a href="#">�������Ƹ</a></li>
													</ul>
												</dd>
											</dl>
										</div>
									</div>
								</li>
								<li class="cat_item">
									<h4 class="cat_tit">
										<a href="#" class="cat_tit_link">���ݻ�ױ�����˻���</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">�沿����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����</a></li>
														<li><a href="#">���ˮ/ˬ��ˮ</a></li>
														<li><a href="#">��Һ</a></li>
														<li><a href="#">��˪</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��Ĥ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��ʪ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��ɹ</a></li>
														<li><a href="#">�</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">жױ</a></li>
														<li><a href="#">������װ</a></li>
														<li><a href="#">��˪</a></li>
														<li><a href="#">���ͷ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">��ʿ����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ʿ����</a></li>
														<li><a href="#">��ʿ����</a></li>
														<li><a href="#">����ϴҺ</a></li>
														<li><a href="#">ϴ������</a></li>
														<li><a href="#">��ԡ¶</a></li>
														<li><a href="#">���뵶��/Ƭ</a></li>
														<li><a href="#">���ˮ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">�۲�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�۲�����</a></li>
														<li><a href="#">��Ĥ</a></li>
														<li><a href="#">�۲����</a></li>
														<li><a href="#">��˪</a></li>
														<li><a href="#">�۲�жױҺ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">ϴ������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ȥм��ϴ��ˮ</a></li>
														<li><a href="#">��˳��ϴ��ˮ</a></li>
														<li><a href="#">�޸���ϴ��ˮ</a></li>
														<li><a href="#">����һϴ��ˮ</a></li>
														<li><a href="#">������ϴ��ˮ</a></li>
														<li><a href="#">����Ӫ��ϴ��ˮ</a></li>
														<li><a href="#">���ྻ��ϴ��ˮ</a></li>
														<li><a href="#">�h��ϴ��ˮ/��</a></li>
														<li><a href="#">����/��</a></li>
														<li><a href="#">ϴ����װ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#" class="more">����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">���廤��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">�㲿����</a></li>
														<li><a href="#">�ֲ�����</a></li>
														<li><a href="#">��������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">ϴԡ��Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ԡ¶</a></li>
														<li><a href="#">ԡ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ϴ��Һ</a></li>
														<li><a href="#">ԡ����ԡ����</a></li>
														<li><a href="#">ԡñ</a></li>
														<li><a href="#">��ԡ��װ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">Ů�Ի���</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����װ������</a></li>
														<li><a href="#">����������</a></li>
														<li><a href="#">ҹ��������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">Ů��ϴҺ</a></li>
														<li><a href="#">Ů��ʪ��</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">��ǻ����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����</a></li>
														<li><a href="#">��ˢ</a></li>
														<li><a href="#">����ˮ</a></li>
														<li><a href="#">����/��ǩ</a></li>
														<li><a href="#">�������¼�</a></li>
														<li><a href="#">������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>

										</div>

										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">ŷ����</a></li>
														<li><a href="#">���˱���</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����˿</a></li>
														<li><a href="#">ɳ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�����׶�</a></li>
														<li><a href="#">�ѽ�ʿ</a></li>
														<li><a href="#">��ʫ����</a></li>
														<li><a href="#">���汦</a></li>
														<li><a href="#">��ά��</a></li>
													</ul>
												</dd>
											</dl>

											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">������ʷ��ǰ������ר</a></li>
														<li><a href="#">�ѽ�ʿ��48Ԫ���ֿ۲�</a></li>
														<li><a href="#">��������Ʒ�����ϴ���</a></li>
														<li><a href="#">Ʈ��ȫ��������85��</a></li>
													</ul>
												</dd>
											</dl>

										</div>
									</div>
								</li>

								<li class="cat_item">
									<h4 class="cat_tit">
										<a href="#" class="cat_tit_link">ĸӤʳƷ��ĸӤ��Ʒ</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">�̷�ϵ��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�̷��ػ����</a></li>
														<li><a href="#">�����̷�</a></li>
														<li><a href="#">�̷���Ʒ</a></li>
														<li><a href="#">1���̷�</a></li>
														<li><a href="#">2���̷�</a></li>
														<li><a href="#">3���̷�</a></li>
														<li><a href="#">4���̷�</a></li>
														<li><a href="#">�����䷽�̷�</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">��ʳ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�׷�</a></li>
														<li><a href="#">Ӥ����֭</a></li>
														<li><a href="#">��/��/����</a></li>
														<li><a href="#">������ʳ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����/ĥ����</a></li>
														<li><a href="#">����/�˷�/���</a></li>
														<li><a href="#">Ӥ������</a></li>
														<li><a href="#">Ӫ����</a></li>
														<li><a href="#">Ӥ������</a></li>
														<li><a href="#">Ӥ�׶��ǹ�</a></li>
														<li><a href="#">Ӥ��ʳ����</a></li>
														<li><a href="#">��ʳ��Ʒ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">ĸӤӪ��Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�����</a></li>
														<li><a href="#">����Ӫ��Ʒ</a></li>
														<li><a href="#">ţ����</a></li>
														<li><a href="#">�ۺ�Ӫ����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">�׶�������</a></li>
														<li><a href="#">��θ��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">Ӫ��Ʒ��Ʒ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">������Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ֽ���</a></li>
														<li><a href="#">��/���</a></li>
														<li><a href="#">Ӥ��ʪ��</a></li>
														<li><a href="#">����ֽ���</a></li>
														<li><a href="#">ֽ�����Ʒ</a></li>
														<li><a href="#">Ӥ��ֽ��</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">������Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ƿ/����</a></li>
														<li><a href="#">�����þ�</a></li>
														<li><a href="#">��������/����</a></li>
														<li><a href="#">��ˢ/�̼�</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">Ӥ����Ʒ����</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">ϴ��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ϴ��/��ԡ</a></li>
														<li><a href="#">��˪/����</a></li>
														<li><a href="#">����/��Ѣ</a></li>
														<li><a href="#">ˬ��/����</a></li>
														<li><a href="#">��ɹ/����Һ</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">Ӥ��ϴ����װ</a></li>
														<li><a href="#">ϴ����Ʒ</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">������ȫ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ȫ����</a></li>
														<li><a href="#">����/�����þ�</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">ѧ����Ʒ</a></li>
														<li><a href="#">Ӥ��������</a></li>
														<li><a href="#">������ȫ��Ʒ</a></li>
														<li><a href="#">Ӥ����ˮ/��������</a></li>
													</ul>
												</dd>
											</dl>

											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>

										</div>

										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">�ﱦ��</a></li>
														<li><a href="#">���䱦��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���޳�</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�����ɰ�</a></li>
														<li><a href="#">��������</a></li>
													</ul>
												</dd>
											</dl>

											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">�������޳�����������</a></li>
														<li><a href="#">�ﱦ����100����15</a></li>
														<li><a href="#">�����ػ�85��</a></li>
														<li><a href="#">�����̷���2��1</a></li>
													</ul>
												</dd>
											</dl>

										</div>
									</div>
								</li>

								<li class="cat_item">
									<h4 class="cat_tit">
										<a href="#" class="cat_tit_link">������Ʒ�������Ʒ</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">����ˮ��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����</a></li>
														<li><a href="#">ˮ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�̹�</a></li>
														<li><a href="#">����/ƽ�׹�</a></li>
														<li><a href="#">��װ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ѹ����</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">ֽ��Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ֽ</a></li>
														<li><a href="#">��װ��ȡʽ��ֽ</a></li>
														<li><a href="#">���װ��ȡʽ��ֽ</a></li>
														<li><a href="#">������ֽ</a></li>
														<li><a href="#">ʪ��ֽ</a></li>
														<li><a href="#">����ֽ</a></li>
														<li><a href="#">������ֽ</a></li>
														<li><a href="#">ƽ��ֽ</a></li>
														<li><a href="#">������ֽ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�ֿ��ֿ�</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���ʺ�</a></li>
														<li><a href="#">������Ʒ</a></li>
														<li><a href="#">ʱ������</a></li>
														<li><a href="#">ˮ��/ˮ��</a></li>
														<li><a href="#">������װ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ϴ����</a></li>
														<li><a href="#">ϴ�·�</a></li>
														<li><a href="#">ϴ��Һ</a></li>
														<li><a href="#">���ﻤ��</a></li>
														<li><a href="#">����Һ</a></li>
														<li><a href="#">ϴ�ྫ</a></li>
														<li><a href="#">�Ҿ߻����</a></li>
														<li><a href="#">��޼�</a></li>
														<li><a href="#">Ь��/Ьˢ</a></li>
														<li><a href="#">��������/���</a></li>
														<li><a href="#">ˮ�����</a></li>
														<li><a href="#">����ȩ</a></li>
														<li><a href="#">Ƥ�ﻤ���</a></li>
														<li><a href="#">΢��¯����</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">���۾�</a></li>
														<li><a href="#">ԡ������</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">��ש����</a></li>
														<li><a href="#">�ذ�����</a></li>
														<li><a href="#">�յ�����</a></li>
														<li><a href="#">�ܵ�����</a></li>
														<li><a href="#">ϴ�»�����</a></li>
														<li><a href="#">�������Һ</a></li>
														<li><a href="#">��ʪ/����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">����þ�</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ٽ಼/Ĩ��/�����</a></li>
														<li><a href="#">�ϰѳ��Ƽ����</a></li>
														<li><a href="#">ɨ��/�λ�</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">����Ͱ</a></li>
														<li><a href="#">����������/��©</a></li>
														<li><a href="#">������๤��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ˮͰ</a></li>
														<li><a href="#">�������ˢ��</a></li>
														<li><a href="#">ֽ���</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">һ������Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">���ʴ�</a></li>
														<li><a href="#">һ���Բ;�</a></li>
														<li><a href="#">����/Χȹ</a></li>
														<li><a href="#">һ����Ь��/����</a></li>
														<li><a href="#">��ǩ/����</a></li>
														<li><a href="#">����Ĥ</a></li>
														<li><a href="#">ֽ��</a></li>
														<li><a href="#">�ܱ�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">����</a></li>
														<li><a href="#">�ֿ��ֿ�</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">ASD ���˴�</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��¶</a></li>
														<li><a href="#">�ɰ���</a></li>
														<li><a href="#">SIMELO</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">Supor �ղ���</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">����</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">��è��38Ԫ��Ưˮ</a></li>
														<li><a href="#">�������ȫ����</a></li>
														<li><a href="#">������Ʒ�����</a></li>
														<li><a href="#">һ������Ʒ���׼�</a></li>
												</dd>
											</dl>
										</div>
									</div>
								</li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">�ֻ�ͨѶ���������</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">�ֻ�ͨѶ </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ѡ������</a></li>
														<li><a href="#">�ֻ�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�ֻ���� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ֻ����</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">�ֻ������</a></li>
														<li><a href="#">�ֻ�������</a></li>
														<li><a href="#">�ֻ���Ĥ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">����Ӱ�� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������� </a></li>
														<li><a href="#">����/΢�����</a></li>
														<li><a href="#">������ͷ</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">��Я���</a></li>
														<li><a href="#">���������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">����Ӱ�� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">MP3/MP4</a></li>
														<li><a href="#">�����ܱ� </a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">¼���� </a></li>
														<li><a href="#">����/���� </a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">MID</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">���Ӵʵ�</a></li>
														<li><a href="#">���ӽ���</a></li>
														<li><a href="#">�ֳֵ���</a></li>
														<li><a href="#">��˷�</a></li>
														<li><a href="#">רҵ��Ƶ</a></li>
														<li><a href="#">MP3/MP4���</a></li>
														<li><a href="#">��¼��</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">������� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�洢��</a></li>
														<li><a href="#">���/����� </a></li>
														<li><a href="#">������ </a></li>
														<li><a href="#">�ƶ���Դ</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">��Ӱ���</a></li>
														<li><a href="#">�����/�ֱ�</a></li>
														<li><a href="#">���ż�/��̨</a></li>
														<li><a href="#">�����Ʒ</a></li>
														<li><a href="#">������Ĥ</a></li>
														<li><a href="#">�����������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">���ص��� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">GPS������</a></li>
														<li><a href="#">����������Ʒ</a></li>
														<li><a href="#">������Ʒ</a></li>
													</ul>
												</dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">ŵ����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�῵</a></li>
														<li><a href="#">HTC</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">Apple ƻ��</a></li>
														<li><a href="#">˶����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����ŷ</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">������</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">���ǡ�Ħ�������ֻ�ר</a></li>
														<li><a href="#">����ּۡ���ֽ����</a></li>
														<li><a href="#">������ͷ�����䣬���</a></li>
														<li><a href="#">�����������¥�����</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">��ҵ硢�������</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">��ҵ� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ƽ����� </a></li>
														<li><a href="#">�յ� </a></li>
														<li><a href="#">���� </a></li>
														<li><a href="#">ϴ�»� </a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">Ӱ������ </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">DVD���Ż�</a></li>
														<li><a href="#">���岥����</a></li>
														<li><a href="#">��ͥӰԺ </a></li>
														<li><a href="#">�������� </a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">΢��¯</a></li>
														<li><a href="#">��ѹ����</a></li>
														<li><a href="#">�緹��</a></li>
														<li><a href="#">��ˮ��/��ˮƿ</a></li>
														<li><a href="#">���¯</a></li>
														<li><a href="#">����;��</a></li>
														<li><a href="#">�����/�忾��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���̻�</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">���Ȼ�</a></li>
														<li><a href="#">�翾��</a></li>
														<li><a href="#">���߽ⶾ��</a></li>
														<li><a href="#">�����/ե֭��</a></li>
														<li><a href="#">������������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ȡů����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">���̻�</a></li>
														<li><a href="#">��ʪ��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">�绰��</a></li>
														<li><a href="#">��ˮ��</a></li>
														<li><a href="#">���ٶ�</a></li>
														<li><a href="#">��ˮ�豸</a></li>
														<li><a href="#">�����������</a></li>
														<li><a href="#">ԡ��/������</a></li>
														<li><a href="#">��ʪ��</a></li>
														<li><a href="#">�����/�յ���</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">���˻��� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���뵶 </a></li>
														<li><a href="#">��/��ë�� </a></li>
														<li><a href="#">��ǻ���� </a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">�� �� ��</a></li>
														<li><a href="#">�������˻��� </a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�������� </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">����</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">���ӹҼ�/����</a></li>
														<li><a href="#">�߲�/���� </a></li>
														<li><a href="#">����ң����</a></li>
														<li><a href="#">ǽ�濪��</a></li>
													</ul>
												</dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��ά</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">TCL</a></li>
														<li><a href="#">Midea����</a></li>
														<li><a href="#">Supor �ղ���</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">������ʿյ��������</a></li>
														<li><a href="#">��ϴֱ����������ϲ��</a></li>
														<li><a href="#">Һ��������ִ�żۣ�</a></li>
														<li><a href="#">С�ҵ��սʮ�£����</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">����,���,�칫��Ʒ</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">��������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ʼǱ�����</a></li>
														<li><a href="#">����������</a></li>
														<li><a href="#">ƽ�����</a></li>
														<li><a href="#">̨ʽ��</a></li>
														<li><a href="#">�ʼǱ����԰�</a></li>
														<li><a href="#">iPadƽ�帽��</a></li>
														<li><a href="#">�ܱ����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�洢��Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ƶ�Ӳ�� </a></li>
														<li><a href="#">U��</a></li>
														<li><a href="#">����洢NAS</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">Ӳ�̺�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ʾ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">���� </a></li>
														<li><a href="#">������װ</a></li>
														<li><a href="#">����ͷ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����/HUB</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">��Ϸ�豸</a></li>
														<li><a href="#">���Ӻ�</a></li>
														<li><a href="#">UPS��Դ</a></li>
														<li><a href="#">���Թ���</a></li>
														<li><a href="#">��д��</a></li>
														<li><a href="#">����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">·����</a></li>
														<li><a href="#">����AP</a></li>
														<li><a href="#">���ƽ����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">3G����</a></li>
														<li><a href="#">������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�豸���Ĳ�</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�㳮�� </a></li>
														<li><a href="#">װ����� </a></li>
														<li><a href="#">һ��� </a></li>
														<li><a href="#">����� </a></li>
														<li><a href="#">ɨ���� </a></li>
														<li><a href="#">��ӡ�� </a></li>
														<li><a href="#">װ���� </a></li>
														<li><a href="#">ͶӰ�� </a></li>
														<li><a href="#">���Ӱװ� </a></li>
														<li><a href="#">����� </a></li>
														<li><a href="#">���� </a></li>
														<li><a href="#">ī�� </a></li>
														<li><a href="#">ī�� </a></li>
														<li><a href="#">ɫ�� </a></li>
														<li><a href="#">��¼��Ƭ </a></li>
														<li><a href="#">��ӡ�� </a></li>
														<li><a href="#">ͶӰĻ </a></li>
														<li><a href="#">���ڻ�</a></li>
														<li><a href="#">����绰 </a></li>
														<li><a href="#">������ </a></li>
														<li><a href="#">��д�� </a></li>
														<li><a href="#">��ֽ��</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">ֽƷ������ </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ӡֽ </a></li>
														<li><a href="#">����ֽ </a></li>
														<li><a href="#">����������Ʒ </a></li>
														<li><a href="#">���Դ�ӡֽ </a></li>
														<li><a href="#">��Ƭ��ֽ</a></li>
														<li><a href="#">�ռǱ� </a></li>
														<li><a href="#">��ϰ�� </a></li>
														<li><a href="#">��ǩ�� </a></li>
														<li><a href="#">��ֽ�� </a></li>
														<li><a href="#">������±� </a></li>
														<li><a href="#">��Ȧ�� </a></li>
														<li><a href="#">Ӳ�汾 </a></li>
														<li><a href="#">������ </a></li>
														<li><a href="#">��ҳ�� </a></li>
														<li><a href="#">���汾 </a></li>
														<li><a href="#">��װ�� </a></li>
														<li><a href="#">���߱� </a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��д������ </a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">Բ��� </a></li>
														<li><a href="#">���Ա� </a></li>
														<li><a href="#">ǩ�ֱ� </a></li>
														<li><a href="#">Ǧ��/�Ǧ�� </a></li>
														<li><a href="#">�װ�/��˱� </a></li>
														<li><a href="#">�Ǻű� </a></li>
														<li><a href="#">��о </a></li>
														<li><a href="#">������Ʒ </a></li>
														<li><a href="#">������ </a></li>
														<li><a href="#">�ֱ� </a></li>
														<li><a href="#">īˮ </a></li>
														<li><a href="#">ӫ��� </a></li>
														<li><a href="#">����� </a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">ƻ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">SAMSUNG ����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ThinkPad</a></li>
														<li><a href="#">��˶</a></li>
														<li><a href="#">Ŧ��</a></li>
														<li><a href="#">��ʿ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�״�</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�Ǹ�</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">�Ҿ����Ρ�����˶�</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">������Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��Ʒ�׼�</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���ﱻ</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��Ʒ����</a></li>
														<li><a href="#">̺��/ë��̺</a></li>
														<li><a href="#">��ͷ/��о</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">��ϯ/����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">LOVO�����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">����̺/���ȵ�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�˶�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ԡ�輰���</a></li>
														<li><a href="#">��Ħ����</a></li>
														<li><a href="#">����/Ѫѹ��</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">���༰���</a></li>
														<li><a href="#">�߶���</a></li>
														<li><a href="#">����/���г�</a></li>
														<li><a href="#">�ܲ���/̤����</a></li>
														<li><a href="#">���Ь/���弰���</a></li>
														<li><a href="#">���༰���</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">ˮ���þ�</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">�տ���Ʒ</a></li>
														<li><a href="#">����ҰӪ��Ʒ</a></li>
														<li><a href="#">ƽ������ͨ��</a></li>
														<li><a href="#">������������</a></li>
														<li><a href="#">��������Ʒ</a></li>
														<li><a href="#">�˶���װ</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�����˶���Ʒ</a></li>
														<li><a href="#">�٤��Ʒ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�ҷ�����Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ë��</a></li>
														<li><a href="#">��Ь</a></li>
														<li><a href="#">ë�����</a></li>
														<li><a href="#">ԡ��</a></li>
														<li><a href="#">ԡ��</a></li>
														<li><a href="#">̨��</a></li>
														<li><a href="#">Χȹ/����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��������Ʒ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���/����</a></li>
														<li><a href="#">ճ�����ҹ�</a></li>
														<li><a href="#">��ˮ��</a></li>
														<li><a href="#">̿����</a></li>
														<li><a href="#">ǽ��װ��</a></li>
														<li><a href="#">���õ�/��</a></li>
														<li><a href="#">ů����</a></li>
														<li><a href="#">������������Ʒ</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�Ҿ�/�ƾ�</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ռ��ʦ�����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">Ь��/Ь��</a></li>
														<li><a href="#">�³�/�¹�</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��ͯ�Ҿ�</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">���/���</a></li>
														<li><a href="#">�����ƾ�</a></li>
														<li><a href="#">��̺/�ص�/��̺</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">ɳ��</a></li>
														<li><a href="#">��</a></li>
														<li><a href="#">��ϼҾ�</a></li>
														<li><a href="#">���´������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">С����</a></li>
														<li><a href="#">����ɡ</a></li>
														<li><a href="#">�ռ��ʦ</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">�⽻��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��ƥ��</a></li>
														<li><a href="#">��ʿ��������Wenger</a></li>
														<li><a href="#">�캣��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����ҷ�</a></li>
														<li><a href="#">�����鱦</a></li>
														<li><a href="#">������</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">��Ʒ�׼�99Ԫ��</a></li>
														<li><a href="#">����ҷ������ش�</a></li>
														<li><a href="#">�����鱦����ѧ����</a></li>
														<li><a href="#">���쿪ʼ��</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">��ߡ�ͼ������</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">ë�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ë����ż</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">ë����Ь</a></li>
														<li><a href="#">�յ���</a></li>
														<li><a href="#">�Ҽ�����</a></li>
														<li><a href="#">ë������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">Ӥ�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�������</a></li>
														<li><a href="#">�й�Э��</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">ҡ��/����</a></li>
														<li><a href="#">Ӥ��Ӿ��</a></li>
														<li><a href="#">��Ϸ��/��Ϸ̺</a></li>
														<li><a href="#">ѧ�����</a></li>
														<li><a href="#">ϴ�����</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">��ǧ/ҡ��</a></li>
														<li><a href="#">Ӥ������Ʒ</a></li>
														<li><a href="#">����/����</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">��ɫ����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">ͼ��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�׶�����</a></li>
														<li><a href="#">��ͯ��ѧ</a></li>
														<li><a href="#">�ֹ���Ϸ</a></li>
														<li><a href="#">����/�ٿ�</a></li>
														<li><a href="#">��ͯ�汾</a></li>
														<li><a href="#">��ͥ����</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">��ͳ�Ļ�</a></li>
														<li><a href="#">���տ���</a></li>
														<li><a href="#">��԰׼��</a></li>
														<li><a href="#">��ѧ����</a></li>
														<li><a href="#">����ͼ��</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">��ͨ����</a></li>
														<li><a href="#">�в�����</a></li>
														<li><a href="#">�Ľ�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">Ӣ��ѧϰ</a></li>
														<li><a href="#">�׶���ѧǰ����</a></li>
														<li><a href="#">��ͨ����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��ľ/ƴ�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ƴ���ľ</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">ƴͼ</a></li>
														<li><a href="#">�ѵ���ľ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�˶�����</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">��Ӿ��ɳ̲���</a></li>
														<li><a href="#">�������</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ű�����</a></li>
														<li><a href="#">��ʿ�ṫ��</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">������������</a></li>
														<li><a href="#">С����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">����</a></li>
														<li><a href="#">��ѩ</a></li>
														<li><a href="#">�ָ�</a></li>
														<li><a href="#">�ű�</a></li>
														<li><a href="#">��֮��</a></li>
														<li><a href="#">��ʫ�ȵ�</a></li>
														<li><a href="#">LALABABY</a></li>
														<li><a href="#">�������汾��</a></li>
														<li><a href="#">���</a></li>
														<li><a href="#">С���</a></li>
														<li><a href="#">����Ȥ</a></li>
														<li><a href="#">ëë��</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">300�����1������</a></li>
														<li><a href="#">����Ʒ��ң���������</a></li>
														<li><a href="#">�ָ߳��ͼ�</a></li>
														<li><a href="#">��ѩ �ָ� ����������</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">��װЬñ</a><span class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">Ůװ.</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ŮװT��</a></li>
														<li><a href="#">ŮװPolo��</a></li>
														<li><a href="#">Ůװ��֯��/ë��</a></li>
														<li><a href="#">Ůװ����</a></li>
														<li><a href="#">Ůװ�˶���װ</a></li>
														<li><a href="#">Ůװ����</a></li>
														<li><a href="#">Ůװȹ��</a></li>
														<li><a href="#">Ůװ����</a></li>
														<li><a href="#">Ůװ����</a></li>
														<li><a href="#">����װ</a></li>
														<li><a href="#">Ůװѩ����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��װ.</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��װT��</a></li>
														<li><a href="#">��װPolo��</a></li>
														<li><a href="#">��װ��֯��/ë��</a></li>
														<li><a href="#">��װ����</a></li>
														<li><a href="#">��װ�˶���װ</a></li>
														<li><a href="#">��װ�̿�</a></li>
														<li><a href="#">��װ���� </a></li>
														<li><a href="#">��װ����</a></li>
														<li><a href="#">��װ����</a></li>
														<li><a href="#">��װ����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">ͯװ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ͯ</a></li>
														<li><a href="#">Ůͯ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">Ьѥ</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">ͯЬ</a></li>
														<li><a href="#">��Ь</a></li>
														<li><a href="#">ŮЬ</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">Ь�����</a></li>
														<li><a href="#">Ůʽ���</a></li>
														<li><a href="#">��ͯ���</a></li>
														<li><a href="#">��ʽ���</a></li>
														<li><a href="#">�˶����</a></li>
													</ul>
												</dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">����</a></li>
														<li><a href="#">����ū</a></li>
														<li><a href="#">nike 360</a></li>
														<li><a href="#">CARTELO������</a></li>
														<li><a href="#">��;</a></li>
														<li><a href="#">��ʨ</a></li>
														<li><a href="#">PARGO���</a></li>
														<li><a href="#">OLOMOŷ��ŵ</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">Tomnrabbit</a></li>
														<li><a href="#">JAMESKING</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">����������͵ڶ���</a></li>
														<li><a href="#">��������� 2����</a></li>
														<li><a href="#">ţ�п����� 69Ԫ��</a></li>
														<li><a href="#">����ū�콢��</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
								<li class="cat_item"><h4 class="cat_tit">
										<a href="#" class="cat_tit_link">Ӫ��������������е</a><span
											class="s_arrow">></span>
									</h4>
									<div class="cat_cont">
										<div class="cat_cont_lft">
											<dl class="cf">
												<dt>
													<a href="#">��ǿ����/ ��ƣ��</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">���嵰���ʷ�</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">����ϩ</a></li>
														<li><a href="#">ţ����/�����ʷ�</a></li>
														<li><a href="#">�ĺ���</a></li>
														<li><a href="#">�����/�����</a></li>
														<li><a href="#">�ۺ�Ӫ����Y</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">��ǿ����</a></li>
														<li><a href="#">�����ʷ�</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">ά����/������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���ʼ�</a></li>
														<li><a href="#">B��ά����</a></li>
														<li><a href="#">ά����A/D</a></li>
														<li><a href="#">ά����E/C</a></li>
														<li><a href="#">Ҷ��Ƭ</a></li>
														<li><a href="#">�и�ά����</a></li>
														<li><a href="#">����ά����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">�ݱ���</a></li>
														<li><a href="#">�ݮ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">�����</a></li>
														<li><a href="#">��ԭ����</a></li>
														<li><a href="#">��Ѫ����</a></li>
														<li><a href="#">̥����</a></li>
														<li><a href="#">�ӻ�˥��</a></li>
														<li><a href="#">����������1</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">��������</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">���ʲ�</a></li>
														<li><a href="#">ƻ����/��</a></li>
														<li><a href="#">����ʳƷ</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">�ٻƹ�</a></li>
														<li><a href="#">ȼ֬��/����</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">������е</a>
												</dt>
												<dd>
													<ul>
														<li class="first"><a href="#">��ĦЬ��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">��������������</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">���¼�/�Ʋ���/֬�����������ƾ�������</a></li>
														<li><a href="#">����������е��</a></li>
														<li><a href="#">ǣ����</a></li>
														<li><a href="#">��ԡ��</a></li>
														<li><a href="#">Ѫ����/��ֽ</a></li>
														<li><a href="#">����������</a></li>
														<li><a href="#">�ι�����</a></li>
														<li><a href="#">���Ȱ�������</a></li>
														<li><a href="#">��Ħ��</a></li>
														<li><a href="#">�ι���/�����</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">��������</a></li>
														<li><a href="#">�������</a></li>
														<li><a href="#">���Ȱ�Y</a></li>
														<li><a href="#">��ͥ����</a></li>
														<li><a href="#">��/�ȷ�����</a></li>
														<li><a href="#">Ѫѹ��Y</a></li>
														<li><a href="#">��������Y</a></li>
													</ul>
												</dd>
											</dl>
											<dl class="cf">
												<dt>
													<a href="#">�����Ƶ��</a>
												</dt>
												<dd></dd>
											</dl>
										</div>
										<div class="cat_cont_rgt">
											<dl>
												<dt>����ϲ��</dt>
												<dd>
													<ul>
														<li><a href="#">��A</a></li>
														<li><a href="#">ϲ��</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">������˹</a></li>
														<li><a href="#">�ƴ�</a></li>
														<li><a href="#">����Դ</a></li>
														<li><a href="#">ŷķ��</a></li>
														<li><a href="#">����</a></li>
														<li><a href="#">������</a></li>
														<li><a href="#">lumi</a></li>
														<li><a href="#">��ͨ</a></li>
														<li><a href="#">������</a></li>
												</dd>
											</dl>
											<dl>
												<dt>����ר��</dt>
												<dd>
													<ul>
														<li><a href="#">����Ʒ0���������ڶ�</a></li>
														<li><a href="#">����Ʒ�̲���������</a></li>
														<li><a href="#">��Ȥ��Ʒϵ��</a></li>
														<li><a href="#">���˱�����3��1</a></li>
												</dd>
											</dl>
										</div>
									</div></li>
							</ul>
							<!--<div class="all_cats"><a href="#" class="more">ȫ����Ʒ����</a></div>-->
						</div>
					</div>
				</div>
			</div>
			<!--mmenu end-->

		</div>
		<!--s_hdw end-->

		<link type="text/css" href="css/info.css" rel="stylesheet" />

		<div id="s_bdw">
			<div id="s_bd">

				<div class="stepflow">
					<img src="images/cartinforstep.gif" width="980" height="32" alt="" />
				</div>

				<div class="infotable">
					<table width="100%">
						<tr>
							<td class="tit">�ջ���ַ</td>
							<td class="summary">
								<form action="cart-information.jsp" method="get">
									<table class="address" width="100%">
										<%
											if(doOrder.equals("false")){
										%>
										<tr>
											<td><span class="red">*</span>��ϸ��ַ��</td>
											<td><input type="text" name="adress" value="" id=""
												class="stext" style="width:280px;" /></td>
										</tr>
										<tr>
											<td><span class="red">*</span>�ջ��ˣ�</td>
											<td><input type="text" name="name" value="" id=""
												class="stext" /></td>
										</tr>
										<tr>
											<td><span class="red">*</span>�ֻ����룺</td>
											<td><input type="text" name="phone" value="��18888888888"
												id="" class="stext focutext00" /></td>
										</tr>
										<tr>
											<td colspan="2" height="10px"></td>
										</tr>
										<tr>
											<td colspan="2"><input type="submit" value="ȷ���ջ���Ϣ"
												class="btntext" /></td>
										</tr>
										<%
											}else{
										%>
										<tr>
											<td colspan="2"><span class="red">*</span>����ɹ�</td>
										</tr>
										<%
											}
										%>
									</table>
								</form>
							</td>
						</tr>
					</table>
				</div>
				<!--infotable end-->

				<script type="text/javascript">
			$(function(){
				$(".focutext00").focusText();
				$(".focutext01").focusText();
				$(".focutext02").focusText();
				$(".focutext03").focusText();
			});
			</script>

				<div class="infotable"></div>
				<!--infotable end-->

				<div class="infotable"></div>
				<!--infotable end-->

				<div class="infotable"></div>
				<!--infotable end-->

				<div class="catinfotable">
					<table width="100%">
						<tr>
							<td class="tit">�����嵥<br /> <a
								style="font-size:12px;font-weight:normal;" class="blue"
								href="cart.jsp">����</a></td>
							<td class="summary">
								<table class="catlist" width="100%">
									<tr bgcolor="#f3f3f3">
										<th>���ﳵ�е���Ʒ</th>
										<th>�۸�</th>
										<th>����</th>
										<th>��ѧ���Խ��</th>
										<th>��������</th>
										<th>����ʱ��</th>
									</tr>
									<%
										cartitem item=null;
												for(Iterator<cartitem> iterator=c.getCartitems().iterator();iterator.hasNext();){
													item=iterator.next();
									%>
									<tr>
										<td><a href="#"><%=item.getName()%></a><br />��Ʒ��ţ�<%=item.getProductid()%></td>
										<td class="red">��<%=item.getPrice()%></td>
										<td>��0.00</td>
										<td>0</td>
										<td><%=item.getCount()%></td>
										<td>�л����ɵ��ճ���</td>
									</tr>
									<%
										}
									%>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<!--catinfotable end-->

				<div class="catinfotable">
					<table width="100%">
						<tr>
							<td class="tit">��������</td>
							<td class="summary"><div class="f-r"
									style="width:170px;padding:0 15px;background:#f3f3f3;">
									<table class="totable" width="100%">
										<tr>
											<td>��Ʒ�ܼۣ�</td>
											<td align="right">��<%=c.gettotalprice()%></td>
										</tr>
										<tr>
											<td>�˷ѽ�</td>
											<td align="right">��0.00</td>
										</tr>
										<tr>
											<td>ѧ���Խ�ҵֿۣ�</td>
											<td align="right">��0.00</td>
										</tr>
										<tr>
											<td>�����Żݣ�</td>
											<td align="right">��0.00</td>
										</tr>
										<tr>
											<td>��&nbsp;&nbsp;��&nbsp;&nbsp;�ѣ�</td>
											<td align="right">��0.00</td>
										</tr>
										<tr>
											<td>��&nbsp;&nbsp;��&nbsp;&nbsp;ȯ��</td>
											<td align="right">��0.00</td>
										</tr>
										<tr>
											<td>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�</td>
											<td align="right"><strong
												style="font-size:18px;color:#dc0000;">��<%=c.gettotalprice()%></strong></td>
										</tr>
										<tr>
											<td align="right" colspan="2"><input type="button"
												value="" onclick="check()" class="btnimg" /></td>
										</tr>
										<tr>
											<td height="10px"></td>
										</tr>
									</table>
									<script type="text/javascript">
									function check(){
										if("<%=doOrder%>"=="true"){
											window.location.href="order-success.jsp?name=<%=name1%>&phone=<%=phone1%>&adress=<%=adress1%>";
											} else {
												alert("��������ȷ���ͻ���Ϣ");
											}
										}
									</script>
								</div></td>
						</tr>
					</table>
				</div>
				<!--catinfotable end-->

			</div>
			<!--s_bd end-->
		</div>
		<!--s_bdw end-->

		<div id="s_ftw">

			<div class="ft_quicklinks">
				<div class="ftql cf">
					<ul>

						<li class="ftql_s">
							<h3>����ѧ����</h3>
							<ul>
								<li><a href="">ѧ���Խ���</a></li>
								<li><a href="">�Ŷ�</a></li>
								<li><a href="">ý�屨��</a></li>
								<li><a href="">������ʿ</a></li>
								<li><a href="">����</a></li>
							</ul>
						</li>
						
					</ul>
				</div>
			</div>

			<div id="s_ft">
				<div class="ft_suggest pt100">
					<div class="ft_suggest pt100">�������ӣ�<a href="http://www.hnsoftedu.com/">�������ְҵ����ѧԺ</a></div>
				</div>
				<div class="copyright tac pbt10">��Ȩ���� Copyright&copy; ѧ���� All
					Rights Reserved ��Ȩ����</div>
				<div class="ft_banners2 tac">
					<ul>
						<li><a href="#"><img src="images/u255.png" border="0" /></a></li>
						<li><a href="#"><img src="images/u257.png" border="0" /></a></li>
						<li><a href="#"><img src="images/u259.png" border="0" /></a></li>
						<li><a href="#"><img src="images/u261.png" border="0" /></a></li>
					</ul>
				</div>
			</div>

		</div>
		<!--s_ftw end-->

	</div>
</body>
</html>
