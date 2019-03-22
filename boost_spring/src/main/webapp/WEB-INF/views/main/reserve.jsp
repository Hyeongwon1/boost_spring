<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="description" content="네이버 예약, 네이버 예약이 연동된 곳 어디서나 바로 예약하고, 네이버 예약 홈(나의예약)에서 모두 관리할 수 있습니다.">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
    <title>네이버 예약</title>
    <link href="../resources/css/style.css" rel="stylesheet">
       <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.1.0/handlebars.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<style>

</style>
<script>
	var TTcount = 0;
	document.addEventListener("DOMContentLoaded", function() {
		var a = window.location.href
		var arr = []
			arr = a.split("=")
			dno = arr[1]
		Paramdata = {
		id 		: dno,
		flag	: "0"
		}
	  ajaxFn('POST','/main/detailprice',Paramdata);
		
		
		var chk_agree = document.querySelector("input[name=chk_agree]");
			chk_agree.addEventListener("change", function(evt) {
			chkagree(evt.target.checked)
		});
		var close = document.getElementsByClassName("btn_agreement")[0];
  		close.addEventListener("click", function (evt) {
  			openClose(evt.target.id,evt.target.innerText)
    	});
  		var close = document.getElementsByClassName("btn_agreement")[1];
  		close.addEventListener("click", function (evt) {
  			openClose(evt.target.id,evt.target.innerText)
    	});
  		
  		pmpm();
  		dayday(TTcount);
	});
	
	function ajaxFn(type,url,data){
    	console.log(data)
        xmlHttp = new XMLHttpRequest()
        xmlHttp.onreadystatechange = onready
//       	xmlHttp.open('POST','/todoo/TodoWrite',true) 
      	xmlHttp.open(type,url,true) 
//      formdata일시	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")  //POST요청
     	xmlHttp.setRequestHeader("Content-Type","application/json; charset=UTF-8")  //POST요청
    	if (data != null) {
	     	var Jdata = JSON.stringify(data)
	     	xmlHttp.send(Jdata);
		}
    }
    function onready(){
        if( xmlHttp.readyState==4){
            if( xmlHttp.status==200){
            	responseObject = JSON.parse(xmlHttp.responseText)
            	var DetailPrice = responseObject.DetailPrice
            	console.log(DetailPrice)
            	DetailPriceT(DetailPrice)
            }
        }
    }
	
	function DetailPriceT(data) {
		
		var templateC = document.querySelector("#detailPrice").innerText;
    	var bindTemplateC = Handlebars.compile(templateC); 
    	var Presult = "";
	    	data.forEach(function (item, index) {
	    		item.price =item.price.toLocaleString();
	    		Presult += bindTemplateC(item);
	    	});
	    var ticket_body = document.querySelector(".ticket_body")	
	    	
	    	ticket_body.innerHTML = Presult
	}
	
	 //접기 펼치기 
    function openClose(num,txt){
       	var agreement = document.getElementsByClassName("agreement")[1]
       	var agreementt = document.getElementsByClassName("agreement")[2]
       	var btn_text = document.getElementsByClassName("btn_text")[num];
       	if (num == 0) {
       		if (txt == '보기') {
	       		agreement.className = 'agreement open'
	       		btn_text.innerText ='접기'
			}else{
	       		agreement.className = 'agreement'
	       		btn_text.innerText ='보기'
			}
		}else if (num == 1) {
			if (txt == '보기') {
				agreementt.className = 'agreement open'
	       		btn_text.innerText ='접기'
			}else{
				agreementt.className = 'agreement'
	       		btn_text.innerText ='보기'
			}
		}     	
   }
	 
	function chkagree(data){
		var bk_btn_wrap = document.getElementsByClassName("bk_btn_wrap")[0];
		if (data == true) {
			bk_btn_wrap.className =	'bk_btn_wrap'
		}else{
			bk_btn_wrap.className = 'bk_btn_wrap disable'
		}
		
	}
	function Tab(tabElement) {
	        this.clearfix = tabElement;
	        this.registerEvents();
	    }
		
	Tab.prototype = {
            registerEvents : function() {
                this.clearfix.addEventListener("click", function (evt) {
                	var price = evt.target.parentNode.parentNode.nextSibling.nextSibling.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling.innerText 
                	 
                	 price = "" + price.replace(/,/gi,''); // 콤마 제거
                	 price = price.replace(/(^\s*)|(\s*$)/g, ""); // trim
                	if (evt.target.title == '더하기') {
                		var count = evt.target.previousSibling.previousSibling.value
                		console.log(evt.target.parentNode.nextSibling.nextSibling.firstChild.innerText)
                		console.log(evt.target.previousSibling.previousSibling.previousSibling.previousSibling)
                		evt.target.previousSibling.previousSibling.className ='count_control_input'
						evt.target.previousSibling.previousSibling.value =  Number(count) +1
						evt.target.parentNode.nextSibling.nextSibling.firstChild.innerText  = Number(price * evt.target.previousSibling.previousSibling.value)
					   
						if (evt.target.previousSibling.previousSibling.value > 0) {
							evt.target.parentNode.nextSibling.nextSibling.firstChild.className ='individual_price on_color'
								evt.target.previousSibling.previousSibling.previousSibling.previousSibling.className='btn_plus_minus spr_book2 ico_minus3'
									 TTcount++;
						}
						
					}else if(evt.target.title =='빼기'){
						var count = evt.target.nextSibling.nextSibling.value
						evt.target.nextSibling.nextSibling.value =  Number(count)-1
						evt.target.parentNode.nextSibling.nextSibling.firstChild.innerText  = Number(evt.target.parentNode.nextSibling.nextSibling.firstChild.innerText  - price)
                		if (evt.target.nextSibling.nextSibling.value == 0) {
                			--TTcount;
                			evt.target.className='btn_plus_minus spr_book2 ico_minus3 disabled'
                			evt.target.nextSibling.nextSibling.className ='count_control_input disabled'
                			evt.target.parentNode.nextSibling.nextSibling.firstChild.className ='individual_price'
						}else if(evt.target.nextSibling.nextSibling.value < 0){
							evt.target.nextSibling.nextSibling.value = 0
							evt.target.parentNode.nextSibling.nextSibling.firstChild.innerText = 0
							evt.target.parentNode.nextSibling.nextSibling.firstChild.className ='individual_price'
						}else{
							--TTcount;
						}
						
					}
                	dayday(TTcount)
                }.bind(this));
            }
        }
	
	
	function pmpm(){
		
		var clearfix = document.querySelector(".ticket_body");
	    var o = new Tab(clearfix);	
	}
	
	function dayday( count ){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();

		if(dd<10) {
		    dd='0'+dd
		} 

		if(mm<10) {
		    mm='0'+mm
		} 

		today = yyyy+'.'+mm+'.'+dd +','+'총'+'<span id="totalCount">'+count +'</span>매</p>'
		
		var ddate = document.querySelector(".inline_txt");
		console.log(ddate)
			ddate.innerHTML = today
	}
	
</script>
<body>
    <div id="container">
        <!-- [D] 예약하기로 들어오면 header에 fade 클래스 추가로 숨김 -->
        <div class="header fade">
            <header class="header_tit">
                <h1 class="logo">
                    <a href="/main/home" class="lnk_logo" title="네이버"> <span class="spr_bi ico_n_logo">네이버</span> </a>
                    <a href="/main/home" class="lnk_logo" title="예약"> <span class="spr_bi ico_bk_logo">예약</span> </a>
                </h1>
                <a href="#" class="btn_my"> <span title="예약확인">예약확인</span> </a>
            </header>
        </div>
        <div class="ct">
            <div class="ct_wrap">
                <div class="top_title">
                    <a href="/main/detail?id=${reserveDetail.id}" class="btn_back" title="이전 화면으로 이동"> <i class="fn fn-backward1"></i> </a>
                    <h2><span class="title">${reserveDetail.description}</span></h2>
                </div>
                <div class="group_visual">
                    <div class="container_visual" style="width: 414px;">
                        <ul class="visual_img">
                            <li class="item" style="width: 414px;"> <img alt=" " class="img_thumb" src="${reserveDetail.save_file_name}"> <span class="img_bg"></span>
                                <div class="preview_txt">
                                    <h2 class="preview_txt_tit"></h2> <em class="preview_txt_dsc">₩12,000 ~ </em><em class="preview_txt_dsc">2017.2.17.(금)~2017.4.18.(화), 잔여티켓 2769매</em> </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="section_store_details">
                    <div class="store_details">
                        <h3 class="in_tit"></h3>
                        <p class="dsc">
                                          장소 : ${reserveDetail.place_name} <br> 
                        </p>
                        <h3 class="in_tit">관람시간</h3>
                        <p class="dsc">
                         ${reserveDetail.opening_hours}<br> ‘문화가 있는 날’ 매월 마지막 주 수요일은 오후 8시까지 연장
                        </p>
                        <h3 class="in_tit">요금</h3>
                        <p class="dsc">
                           20인 이상 단체 20% 할인<br> 국가유공자, 장애인, 65세 이상 4,000원
                        </p>
                    </div>
                </div>
                <div class="section_booking_ticket">
                    <div class="ticket_body">
                       <!--  <div class="qty">
                            <div class="count_control">
                                [D] 수량이 최소 값이 일때 ico_minus3, count_control_input에 disabled 각각 추가, 수량이 최대 값일 때는 ico_plus3에 disabled 추가
                                <div class="clearfix">
                                    <a class="btn_plus_minus spr_book2 ico_minus3 disabled" title="빼기"> </a> 
                                    <input type="tel" class="count_control_input disabled" value="0" readonly title="수량">
                                    <a class="btn_plus_minus spr_book2 ico_plus3" title="더하기">
                                    </a>
                                </div>
                                [D] 금액이 0 이상이면 individual_price에 on_color 추가
                                <div class="individual_price"><span class="total_price">0</span><span class="price_type">원</span></div>
                            </div>
                            <div class="qty_info_icon"> 
                            	<strong class="product_amount"> <span>성인</span> </strong> 
                            	<strong class="product_price"> <span class="price">10,200</span> <span class="price_type">원</span> </strong> 
                            <em class="product_dsc">10,200원 (15% 할인가)</em> </div>
                        </div> -->
                    </div>
                </div>
                <div class="section_booking_form">
                    <div class="booking_form_wrap">
                        <div class="form_wrap">
                            <h3 class="out_tit">예매자 정보</h3>
                            <div class="agreement_nessasary help_txt"> <span class="spr_book ico_nessasary"></span> <span>필수입력</span> </div>
                            <form class="form_horizontal">
                                <div class="inline_form"> <label class="label" for="name"> <span class="spr_book ico_nessasary">필수</span> <span>예매자</span> </label>
                                    <div class="inline_control"> <input type="text" name="name" id="name" class="text" placeholder="네이버" maxlength="17"> </div>
                                </div>
                                <div class="inline_form"> <label class="label" for="tel"> <span class="spr_book ico_nessasary">필수</span> <span>연락처</span> </label>
                                    <div class="inline_control tel_wrap">
                                        <input type="tel" name="tel" id="tel" class="tel" value="" placeholder="휴대폰 입력 시 예매내역 문자발송">
                                        <div class="warning_msg">형식이 틀렸거나 너무 짧아요</div>
                                    </div>
                                </div>
                                <div class="inline_form"> <label class="label" for="email">  <span class="spr_book ico_nessasary">필수</span>  <span>이메일</span> </label>
                                    <div class="inline_control"> <input type="email" name="email" id="email" class="email" value="" placeholder="crong@codesquad.kr" maxlength="50"> </div>
                                </div>
                                <div class="inline_form last"> <label class="label" for="message">예매내용</label>
                                    <div class="inline_control">
                                        <p class="inline_txt selected">2017.2.17, 총 <span id="totalCount">16</span>매</p>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="section_booking_agreement">
                        <div class="agreement all"> 
                        	<input type="checkbox" id="chk3" class="chk_agree" name ="chk_agree">
                        	 	<label for="chk3" class="label chk_txt_label"> <span>이용자 약관 전체동의</span> </label>
                            <div class="agreement_nessasary">
                                <span>필수동의</span> </div>
                        </div>
                        <!-- [D] 약관 보기 클릭 시 agreement에 open 클래스 추가 -->
                        <div class="agreement"> 
                        	<span class="chk_txt_span"> 
                        	<i class="spr_book ico_arr_ipc2"></i> 
                        	<span>개인정보 수집 및 이용 동의</span> </span>
                            <a class="btn_agreement"  id="0"> 
                            	<span class="btn_text" id="0">보기</span>
                            	 <i class="fn fn-down2"></i> </a>
                            <div class="useragreement_details">&lt;개인정보 수집 및 이용 동의&gt;<br>
	                            <br> 1. 수집항목 : [필수] 이름, 연락처, [선택] 이메일주소<br>
	                            <br> 2. 수집 및 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존, 네이버 예약 이용 후 리뷰작성에 따른 네이버페이 포인트 지급 및 관련 안내<br>
	                            <br> 3. 보관기간 <br> - 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관<br> - 단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등 관련 법령에 의하여 일정 기간 보관이 필요한 경우에는 해당 기간 동안 보관함<br>
	                            <br> 4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.<br>
	                        </div>
                        </div>
                        <!-- [D] 약관 보기 클릭 시 agreement에 open 클래스 추가 -->
                        <div class="agreement"> 
                        <span class="chk_txt_span"> 
                        <i class="spr_book ico_arr_ipc2"></i> 
                        <span>개인정보 제3자 제공 동의</span> </span>
                            <a class="btn_agreement" id="1"> 
                            <span class="btn_text"  id="1">보기</span> 
                            <i class="fn fn-down2"></i> </a>
                            <div class="useragreement_details custom_details_wrap">
                                <div class="custom_details">&lt;개인정보 제3자 제공 동의&gt;<br>
	                                <br> 1. 개인정보를 제공받는 자 : 미디어앤아트<br>
	                                <br> 2. 제공하는 개인정보 항목 : [필수] 네이버 아이디, 이름, 연락처 [선택] 이메일 주소<br>
	                                <br> 3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 서비스 이용에 따른 설문조사 및 혜택 제공, 분쟁조정 해결을 위한 기록보존<br>
	                                <br> 4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시 까지 보관합니다.<br><br> 5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.<br>
	                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box_bk_btn">
                    <!-- [D] 약관 전체 동의가 되면 disable 제거 -->
                    <div class="bk_btn_wrap disable"> 
                    	<button type="button" class="bk_btn"> 
                    		<i class="spr_book ico_naver_s"></i> 
                    		<span>예약하기</span> 
                    	</button> 
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="gototop">
            <a href="#" class="lnk_top"> <span class="lnk_top_text">TOP</span> </a>
        </div>
        <div id="footer" class="footer">
            <p class="dsc_footer">네이버(주)는 통신판매의 당사자가 아니며, 상품의정보, 거래조건, 이용 및 환불 등과 관련한 의무와 책임은 각 회원에게 있습니다.</p>
            <span class="copyright">© NAVER Corp.</span>
        </div>
    </footer>

	<script type="myTemplate" id="detailPrice">
		<div class="qty">
            <div class="count_control">
                <div class="clearfix">
                    <a class="btn_plus_minus spr_book2 ico_minus3 disabled" title="빼기"> </a> 
					<input type="tel" class="count_control_input disabled" value="0" readonly title="수량">
                    <a class="btn_plus_minus spr_book2 ico_plus3" title="더하기">
                    </a>
                </div>
                <div class="individual_price"><span class="total_price">0</span><span class="price_type">원</span></div>
            </div>
            <div class="qty_info_icon"> 
			<strong class="product_amount"> 
				<span>{{price_type_name}}</span> 
			</strong> 
			<strong class="product_price"> 
			<span class="price">{{price}}</span> 
			<span class="price_type">원</span> 
			</strong> 
				<em class="product_dsc">
						{{price}}원 
						{{#if discount_rate }}
								({{discount_rate}}% 할인가)
						{{else}}
						{{/if}}
				</em> 
			</div>
        </div>
	</script>

</body>
</html>