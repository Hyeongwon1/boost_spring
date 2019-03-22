<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="네이버 예약, 네이버 예약이 연동된 곳 어디서나 바로 예약하고, 네이버 예약 홈(나의예약)에서 모두 관리할 수 있습니다.">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
    <title>네이버 예약</title>
    <link href="../resources/css/style.css" rel="stylesheet">
<!--     <script type="text/javascript" src="../resources/js/handlebars-v4.1.0.js"></script> -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.1.0/handlebars.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        .container_visual {
            height: 414px;
        }
    </style>
	<script>
	var moreCount		= 0; //더보기
	var count = 0;
	var dno  = 0;
	document.addEventListener("DOMContentLoaded", function() {
			var a = window.location.href
			var arr = []
				arr = a.split("=")
				dno = arr[1]
			Paramdata = {
			id 		: dno,
			flag	: "0",
			limit	: 3,	
		   	start   : 0
			}
		  ajaxFn('POST','/main/detailEntry',Paramdata);
		
		//오시는길,상세영역 탭 구분	
		var tabui = document.querySelector(".section_info_tab");
	    	 tabui.addEventListener("click", function (evt) {
	   	  	 anchorChange(evt.target.id)
	    });			
		
	    //접기,펼치기 구분
	  	var close = document.querySelector(".section_store_details");
	  		close.addEventListener("click", function (evt) {
	  		console.log(evt.target)
	  		console.log(evt.target.id)
	  		openClose(evt.target.id)
	    });
	  		
	  	//etc image 다음버튼 
		var close = document.querySelector(".nxt_inn");
			close.addEventListener("click", function (evt) {
			imageChange()
		});	
			
// 		//etc image 다음버튼 
// 		var close = document.querySelector(".nxt_inn");
// 			close.addEventListener("click", function (evt) {
// 			console.log(evt.target)
// 			console.log(evt.target.id)
// 	//	 	openClose(evt.target.id)
// 			imageChange()
// 		});	
	  
	  	//더보기 클릭
	   document.querySelector(".btn_review_more").onclick = function()
	     {
	   	  //더보기 클릭시마다 limit start+3씩 증가
	   	  //플래그 1을 줌으로써 상세는 더이상 조회되지 않도록
	   	  Paramdata.flag = "1"
	   	  moreCount += 3;
	   	  Paramdata.start = moreCount
	   	  ajaxFn('POST','/main/detailEntry', Paramdata);
	     }	
	  		
			
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
            	var data = responseObject.data
            	var ComentList = responseObject.ComentList
            	var ComentCount = responseObject.ComentCount
            	var ComentScore = responseObject.ComentScore
            	var etcImage = responseObject.etcImage
            	console.log(ComentList)
            	console.log(etcImage)
            	if (data != null) {
	            	detailEntry(data,ComentCount,ComentScore,etcImage);
				}
            	
            	if (ComentList != null) {
            		ComentListT(ComentList,Paramdata.start,ComentCount);
				}
            	
            }
        }
    }	
	
	function ComentListT(data,moreCount,ComentCount){
    	//coment 영역
    	var templateC = document.querySelector("#detailComentList").innerText;
    	var bindTemplateC = Handlebars.compile(templateC); 
    	var comentresult = "";
	    	data.forEach(function (item, index) {
	    		comentresult += bindTemplateC(item);
	    	});
    	
    	var list_short_review = document.querySelector(".list_short_review")
    	
    	var btn_review_more = document.querySelector(".btn_review_more");
    	if ( moreCount+data.length  >= ComentCount) {
    		btn_review_more.style.display="none";
		}else{
			btn_review_more.style.display="block";
		}	   
    	
    		if (moreCount  == 0) {
    			list_short_review.innerHTML = comentresult
    		//더보기 시 추가
    	    }else{
    			list_short_review.innerHTML += comentresult
    		}	
    	
    }
    
    function detailEntry(data,ComentCount,ComentScore,etcImage){
    	console.log(ComentScore)
    	//메인이미지 영역
    	var template = document.querySelector("#detailE").innerText;
    	var bindTemplate = Handlebars.compile(template); 
    	var detailresult = bindTemplate(data);
    	var detail = document.querySelector(".visual_img")
    		detail.innerHTML = detailresult
    	
    		console.log("etcImage")
    		console.log(etcImage)
    	if (etcImage) {
    		var etcIresult = bindTemplate(etcImage);
    		detail.innerHTML += etcIresult
    		detail.innerHTML += detailresult
    		detail.innerHTML += etcIresult
		}	
    	
    	//펼쳐보기 영역
    	var store_details = document.querySelector(".dsc")
    		store_details.innerHTML = data.content
    		
    	//카운트영역
    	var green = document.querySelector(".green")
    		green.innerHTML = ComentCount+"건"
    	
    	//스코어 영역
    	var cscore = document.querySelector(".cscore")
    		cscore.innerHTML = ComentScore
    	
    	//별점 영역
        var graph_value = document.querySelector(".graph_value")
        	graph_value.style.width = (ComentScore*20) + "%"
    		
    	//상세 영역
    	var detail_info_lst = document.querySelector(".detail_info_lst .in_dsc ")
    		detail_info_lst.innerHTML = data.content
    	
    	//오시는길 영역
    	var template2 = document.querySelector("#detailStore").innerText;
    	var bindTemplate2 = Handlebars.compile(template2); 
    	var detailoresult = bindTemplate2(data);
    	var detailo = document.querySelector(".detail_location")
    		detailo.innerHTML = detailoresult
    	
    }
    
    function anchorChange(num){
    console.log(num)
    console.log(typeof(num))
    if (num != "") {
   		//오시는길,상세 하이드 앵커 표시 구분
	   	 var anchList = document.getElementsByClassName("anchor");
	//    	 console.log(anchList.length)
	   	 for (var i = 0; i < anchList.length; i++) {
				if (i == num) {
	   	 			var anchor = document.getElementsByClassName("anchor")[i];
	   		 		anchor.className ='anchor active';
				}else{
					var anchor = document.getElementsByClassName("anchor")[i];
		    		anchor.className ='anchor';
				}
	 	}
   	 
	   	//오시는길,상세 하이드 영역 구분
	   	var detail_location = document.querySelector(".detail_location")
		var detail_area_wrap = document.querySelector(".detail_area_wrap")
	   	 if (num == 0 ) {
	   			detail_location.className 	= 'detail_location hide'
	   			detail_area_wrap.className 	= 'detail_area_wrap'
		 }else if (num == 1 ){
		   		detail_area_wrap.className 	= 'detail_area_wrap hide'
	   			detail_location.className 	= 'detail_location'
		 }
   	
   	
   	 }	
   }
	
   //접기 펼치기 
    function openClose(num){
       	var bk_moreList = document.getElementsByClassName("bk_more");
       	console.log(bk_moreList.length)
       	for (var i = 0; i <bk_moreList.length; i++) {
	       	 if (num == i ) {
	       		var bk_more = document.getElementsByClassName("bk_more")[i];
	       			bk_more.style.display 	= 'none'
	       			
	    	 }else{
	    		var bk_more = document.getElementsByClassName("bk_more")[i];
	       			bk_more.style.display 	= 'block'
	    	 }
		}
       	var store_details = document.querySelector(".store_details")
       	if (num == 0) {
       		store_details.className = 'store_details'
		}else if (num == 1) {
			store_details.className = 'store_details close3'
		}     	
   }
   
	function imageChange(){
    	var promoimg 	= document.querySelector(".visual_img")
    	var promoitem 	= document.querySelector(".visual_img").children
    		promoimg.style.right = "0px"
    		count = count + 18;
    		promoimg.style.right = parseInt(promoimg.style.right) + count +"px";
    		console.log(promoitem)
    		console.log(count)
    		//픽셀이동 414가 딱 한칸 414 도달하면 지나간 값을 appendChild를 해줬을경우 제일 마지막에붙게된다.
    		if (count >= 414) {
				//픽셀 이동 카운트 초기화 아래서 어팬드 차일드해서  li 값을 뒤에 붙여줄거기 때문에 결론은 414만 움직이면 li순서가 appendChild로인해 첫번째것은 제일 마지막으로 보내지고 한칸씩 당겨지기 떄문에
				count= 0;
				promoimg.style.right = "0px"
    			promoimg.appendChild(promoitem[0]);
// 				setTimeout(aaa,3000)
				function aaa(){
					//위에 선언된 ul의 칠드런 값중 제일 첫번째(이미 지나간 li)를 어팬드 해주면 마지막에 붙는다. 그래서 지나간 li들은 마지막에 붙게된다.
// 			    	requestAnimationFrame(function(){imageChange()});
				}
			//픽셀이동 414 까지는 계속 애니메이션 프레임 작동해야하기때문에 else의 경우 	계속 재귀
			}else{
    			requestAnimationFrame(imageChange)
			}
    } 
    
	function goreserve() {
		console.log("aaa")
		location.href='/main/reserve?id='+dno
	}
	
	</script>
</head>
<body>
    <div id="container">
        <div class="header fade">
            <header class="header_tit">
                <h1 class="logo">
                    <a href="/main/home" class="lnk_logo" title="네이버"> <span class="spr_bi ico_n_logo">네이버</span> </a>
                    <a href="/main/home" class="lnk_logo" title="예약"> <span class="spr_bi ico_bk_logo">예약</span> </a>
                </h1>
                <a href="#" class="btn_my"> <span title="예약확인">예약확인</span> </a>
            </header>
        </div>
        <div class="ct main">
            <div>
                <div class="section_visual">
                    <header>
                        <h1 class="logo">
                            <a href="/main/home" class="lnk_logo" title="네이버"> <span class="spr_bi ico_n_logo">네이버</span> </a>
                            <a hre="/main/home" class="lnk_logo" title="예약"> <span class="spr_bi ico_bk_logo">예약</span> </a>
                        </h1>
                        <a href="" class="btn_my"> <span class="viewReservation" title="예약확인">예약확인</span> </a>
                    </header>
                    <div class="pagination">
                        <div class="bg_pagination"></div>
                        <div class="figure_pagination">
                            <span class="num">1</span>
                            <span class="num off">/ <span>2</span></span>
                        </div>
                    </div>
                    <div class="group_visual">
                        <div>
                            <div class="container_visual" style="width: 414px;">
                                <ul class="visual_img detail_swipe">
                                    <li class="item" style="width: 414px;"> 
                                    	<img alt="" class="img_thumb" src=""> 
                                    		<span class="img_bg"></span>
                                        <div class="visual_txt">
                                            <div class="visual_txt_inn">
                                                <h2 class="visual_txt_tit"> <span></span> </h2>
                                                <p class="visual_txt_dsc"></p>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="prev">
                                <div class="prev_inn hide">
                                    <a href="#" class="btn_prev" title="이전">
                                        <!-- [D] 첫 이미지 이면 off 클래스 추가 -->
                                        <i class="spr_book2 ico_arr6_lt off"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="nxt">
                                <div class="nxt_inn">
                                    <a href="#" class="btn_nxt" title="다음">
                                        <i class="spr_book2 ico_arr6_rt"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="section_store_details">
                    <!-- [D] 펼쳐보기 클릭 시 store_details에 close3 제거 -->
                    <div class="store_details close3">
                        <p class="dsc">
                        </p>
                    </div>
                    <!-- [D] 토글 상황에 따라 bk_more에 display:none 추가 -->
                    <a class="bk_more _open" id="0"> 
                    <span class="bk_more_txt" id="0">펼쳐보기</span> 
                    	<i class="fn fn-down2" id="0"></i> 
                    </a>
                    
                    <a class="bk_more _close" id="1"style="display: none;"> 
                    <span class="bk_more_txt" id="1">접기</span>
                     	<i class="fn fn-up2" id="1"></i> 
                    </a>
                </div>
                
                <div class="section_event">
                    <div class="event_info_box">
                        <div class="event_info_tit">
                            <h4 class="in_tit"> <i class="spr_book ico_evt"></i> <span>이벤트 정보</span> </h4>
                        </div>
                        <div class="event_info">
                            <div class="in_dsc">[네이버예약 특별할인]<br>R석 50%, S석 60% 할인</div>
                        </div>
                    </div>
                </div>
                
                <div class="section_btn"> 
                	<button type="button" class="bk_btn" onclick="goreserve()" >
                	 <i class="fn fn-nbooking-calender2"></i> <span>예매하기</span> 
                	 </button> 
                </div>
                <div class="section_review_list">
                    <div class="review_box">
                        <h3 class="title_h3">예매자 한줄평</h3>
                        <div class="short_review_area">
                            <div class="grade_area">
                                <!-- [D] 별점 graph_value는 퍼센트 환산하여 width 값을 넣어줌 -->
                                <span class="graph_mask"> <em class="graph_value" style="width: 0%;"></em> </span>
                                <strong class="text_value"> <span class="cscore">0.0</span> <em class="total">5.0</em> </strong>
                                <span class="join_count"><em class="green"> </em> 등록</span>
                            </div>
                            <ul class="list_short_review">
                                <li class="list_item">
                                    <div>
                                        <div class="review_area">
                                            <div class="thumb_area">
                                                <a href="#" class="thumb" title="이미지 크게 보기"> <img width="90" height="90" class="img_vertical_top" src="http://naverbooking.phinf.naver.net/20170306_3/1488772023601A4195_JPEG/image.jpg?type=f300_300" alt="리뷰이미지"> </a> <span class="img_count" style="display:none;">1</span>                                                </div>
                                            <h4 class="resoc_name"></h4>
                                            <p class="review">2층이어서 걱정했는데 꽤잘보여서 좋았습니다 고미오 너무 멋있었습니다 사진은 커튼콜때 찍었습니다 끝나고 퇴근길도 봐서 너무 좋았어요</p>
                                        </div>
                                        <div class="info_area">
                                            <div class="review_info"> <span class="grade">4.0</span> <span class="name">dbfl****</span> <span class="date">2017.3.5. 방문</span> </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <p class="guide"> <i class="spr_book2 ico_bell"></i> <span>네이버 예약을 통해 실제 방문한 이용자가 남긴 평가입니다.</span> </p>
                    </div>
                    <a class="btn_review_more"> 
                    		<span>예매자 한줄평 더보기</span> 
                    	<i class="fn fn-forward1"></i> 
                    </a>
                </div>
                <div class="section_info_tab">
                    <!-- [D] tab 선택 시 anchor에 active 추가 -->
                    <ul class="info_tab_lst">
                        <li class="item active _detail" id="0">
                            <a class="anchor active"> <span id="0">상세정보</span> </a>
                        </li>
                        <li class="item _path" id="1">
                            <a class="anchor"> <span id="1">오시는길</span> </a>
                        </li>
                    </ul>
                    <!-- [D] 상세정보 외 다른 탭 선택 시 detail_area_wrap에 hide 추가 -->
                    <div class="detail_area_wrap">
                        <div class="detail_area">
                        <div class="detail_info">
                                <h3 class="blind">상세정보</h3>
                                <ul class="detail_info_group">
                                    <li class="detail_info_lst">
                                        <strong class="in_tit">[소개]</strong>
                                        <p class="in_dsc">aaa
                                        </p>
                                    </li>
                                    <li class="detail_info_lst"> <strong class="in_tit">[공지사항]</strong>
                                        <ul class="in_img_group">
                                            <li class="in_img_lst"> <img alt="" class="img_thumb" src="https://ssl.phinf.net/naverbooking/20170131_238/14858250829398Pnx6_JPEG/%B0%F8%C1%F6%BB%E7%C7%D7.jpg?type=a1000"> </li>
                                        </ul>
                                    </li>
                                    <!-- <li class="detail_info_lst"> <strong class="in_tit">[공연정보]</strong>
                                        <ul class="in_img_group">
                                            <li class="in_img_lst"> <img alt="" class="img_thumb" src="https://ssl.phinf.net/naverbooking/20170131_255/1485825099482NmYMe_JPEG/%B0%F8%BF%AC%C1%A4%BA%B8.jpg?type=a1000"> </li>
                                        </ul>
                                    </li> -->
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- [D] 오시는길 외 다른 탭 선택 시 detail_location에 hide 추가 -->
                    <div class="detail_location hide">
                        <div class="box_store_info no_topline">
                            <a href="#" class="store_location" title="지도웹으로 연결">
                                <img class="store_map img_thumb" alt="map" src="https://simg.pstatic.net/static.map/image?version=1.1&amp;crs=EPSG:4326&amp;baselayer=bl_vc_bg&amp;exception=xml&amp;scale=2&amp;caller=mw_smart_booking&amp;overlayers=ol_vc_an&amp;center=127.0011948,37.5717079&amp;markers=type,default2,127.0011948,37.5717079&amp;level=11&amp;w=340&amp;h=150">
                                <span class="img_border"></span>
                                <span class="btn_map"><i class="spr_book2 ico_mapview"></i></span>
                            </a>
                            <h3 class="store_name">엔에이치엔티켓링크(주)</h3>
                            <div class="store_info">
                                <div class="store_addr_wrap">
                                    <span class="fn fn-pin2"></span>
                                    <p class="store_addr store_addr_bold">서울특별시 종로구 종로33길 15 </p>
                                    <p class="store_addr">
                                        <span class="addr_old">지번</span>
                                        <span class="addr_old_detail">서울특별시 종로구 연지동 270 </span>
                                    </p>
                                    <p class="store_addr addr_detail">두산아트센터 연강홀</p>
                                </div>
                                <div class="lst_store_info_wrap">
                                    <ul class="lst_store_info">
                                        <li class="item"> 
	                                        <span class="item_lt">
		                                         <i class="fn fn-call2"></i> 
		                                         <span class="sr_only">전화번호</span> 
	                                         </span> <span class="item_rt"> 
                                         		<a href="tel:02-548-0597" class="store_tel">02-548-0597</a></span> 
                                         </li>
                                    </ul>
                                </div>
                            </div>
							<!-- [D] 모바일 브라우저에서 접근 시 column2 추가와 btn_navigation 요소 추가 -->
                            <div class="bottom_common_path column2">
                                <a href="#" class="btn_path"> <i class="fn fn-path-find2"></i> <span>길찾기</span> </a>
								<a href="#" class="btn_navigation before"> <i class="fn fn-navigation2"></i> <span>내비게이션</span> </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="gototop">
            <a href="#" class="lnk_top"> <span class="lnk_top_text">TOP</span> </a>
        </div>
        <div class="footer">
            <p class="dsc_footer">네이버(주)는 통신판매의 당사자가 아니며, 상품의정보, 거래조건, 이용 및 환불 등과 관련한 의무와 책임은 각 회원에게 있습니다.</p>
            <span class="copyright">© NAVER Corp.</span>
        </div>
    </footer>
    <div id="photoviwer"></div>
    
    
	<script type="myTemplate" id="detailE">
 		<li class="item" style="width: 414px;"> 
        	<img alt="" class="img_thumb" src="{{save_file_name}}"> 
        		<span class="img_bg"></span>
            <div class="visual_txt">
                <div class="visual_txt_inn">
                    <h2 class="visual_txt_tit"> <span>{{description}}</span> </h2>
                    <p class="visual_txt_dsc"></p>
                </div>
            </div>
        </li>	
	</script>
	
	
	<script type="myTemplate" id="detailStore">
		<div class="box_store_info no_topline">
	        <a href="#" class="store_location" title="지도웹으로 연결">
	            <img class="store_map img_thumb" alt="map" src="{{map_file}}">
	            <span class="img_border"></span>
	            <span class="btn_map"><i class="spr_book2 ico_mapview"></i></span>
	        </a>
	        <h3 class="store_name">{{description}}</h3>
	        <div class="store_info">
	            <div class="store_addr_wrap">
	                <span class="fn fn-pin2"></span>
	                <p class="store_addr store_addr_bold">{{place_street}}</p>
	                <p class="store_addr">
	                    <span class="addr_old">지번</span>
	                    <span class="addr_old_detail">{{place_lot}}</span>
	                </p>
	                <p class="store_addr addr_detail">{{place_name}}</p>
	            </div>
	            <div class="lst_store_info_wrap">
	                <ul class="lst_store_info">
	                    <li class="item"> 
							<span class="item_lt"> 
								<i class="fn fn-call2"></i> 
							<span class="sr_only">전화번호</span> </span> 
							<span class="item_rt"> <a href="tel:{{tel}}" class="store_tel">{{tel}}</a></span> </li>
	                </ul>
	            </div>
	        </div>
			<!-- [D] 모바일 브라우저에서 접근 시 column2 추가와 btn_navigation 요소 추가 -->
	        <div class="bottom_common_path column2">
	            <a href="#" class="btn_path"> <i class="fn fn-path-find2"></i> <span>길찾기</span> </a>
				<a href="#" class="btn_navigation before"> <i class="fn fn-navigation2"></i> <span>내비게이션</span> </a>
	        </div>
	    </div>
	</script>
	
	<script type="myTemplate" id="detailComentList">
		<li class="list_item">
	        <div>
	            <div class="review_area">
				{{#if save_file_name}}
	                <div class="thumb_area">
	                    <a href="#" class="thumb" title="이미지 크게 보기"> 
							<img width="90" height="90" class="img_vertical_top" src="{{save_file_name}}" alt="리뷰이미지"> 
						</a> 
						<span class="img_count" style="display:none;">1</span>                                                
					</div>
				{{else}}
 				{{/if}}
	                <h4 class="resoc_name"></h4>
	                <p class="review">{{comment}}</p>
	            </div>
	            <div class="info_area">
	                <div class="review_info"> 
						<span class="grade">{{score}}</span> 
						<span class="name">{{reservation_name}}</span> 
						<span class="date">{{create_date}} 방문</span> </div>
					</div>
	        </div>
	    </li>
	</script>
	
</body>




</html>
