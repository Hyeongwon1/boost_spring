<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="네이버 예약, 네이버 예약이 연동된 곳 어디서나 바로 예약하고, 네이버 예약 홈(나의예약)에서 모두 관리할 수 있습니다.">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
    <title>네이버 예약</title>
    <link href="../resources/css/style.css" rel="stylesheet">
    <style>
    .event .section_visual .group_visual .container_visual .visual_img .item {
    width: 100%;
/*     background-size: contain; */
	}
    
    </style>
    <script>
   	var mainList		= 0; //리스트 전역으로쓰기
    var mainCount		= 0; //가능한 행사 몇개 보이기
    var moreCount		= 0; //더보기
	var categoryId		= 0; //탭 ui 
	var count = 0;
    var data = {
    	  category_id : categoryId,
    	  promo_id : "0",
    	  limit	   : 4,	
    	  start    : 0
    }
    document.addEventListener("DOMContentLoaded", function() {
    	  console.log("돔 온로드")
    	  ajaxFn('POST','/main/mainList',data);
    	  
    	  //탭UI클릭
    	  var tabui = document.querySelector(".section_event_tab");
    	  tabui.addEventListener("click", function (evt) {
    		  data.category_id = parseInt(evt.target.id)
    		  //처음 프로모션 정보 가져오고 다음부터 안가져오기위해 1을 줬음 0일때만 조회하게 설정
    		  data.promo_id = "1"
    		  //탭 변경시마다 페이징 초기화
    		  data.start = 0
    		  mainList = 0; 
     		  //탭 변경시마다 총 개수 밑 더보기 초기화
    		  mainCount = 0;
    		  moreCount = 0; 
    		  //탭 변경시마다 앵커 위치 변경 설정위한 셋팅값
    		  anchorChange(evt.target.id)
    		  
    		  ajaxFn('POST','/main/mainList', data);
          });
    	  
    	  //더보기 클릭
    	  document.getElementById("more").onclick = function()
    	    {
    		  moreCount += 4;
    		  //더보기 클릭시마다 limit start+4씩 증가
    		  data.start = moreCount
    		  ajaxFn('POST','/main/mainList', data);
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
    function onready()
    {
        if( xmlHttp.readyState==4){
            if( xmlHttp.status==200){
            	responseObject = JSON.parse(xmlHttp.responseText)
            	mainList = responseObject.mainList
            	promoList = responseObject.promoList
            	mainCount = responseObject.mainCount
//             		console.log(mainList)
// 	            	mainCount = mainList.length
//             		console.log(mainCount)
	            	var counthtml = document.querySelector("#listCount").innerHTML;
	            	var recount = counthtml.replace("{mainCount}", mainCount);
//             		console.log(recount);
	            	document.querySelector(".event_lst_txt").innerHTML = recount
	            	//start 값을 전달해 주는이유는 더보기 보이고 안보이고 설정값에 사용하기 위함 
	            	//4,8 증가해서 총 갯수를 넘었을때 더보기 사라지게 하기 위함
	            	addlist(data.start)
	            	
            	if (promoList != null) {
            		promoSetting(promoList);
				}
            	
            	
            }
        }
    }
    
    
    function addlist(moreCount){
    	var html = document.querySelector("#itemList").innerHTML;
    	var resultHTML = "";
    	var resultHTMLA = "";
    	var morebtn = document.getElementById("morebtn");

//     	console.log("mainCount"+mainCount)
//     	console.log("moreCount"+moreCount)
    	
    	for(var i= 0 ; i< mainList.length ; i++) {
        	if (i % 2 == 0) {
            	    resultHTML += html.replace("{id}"			, mainList[i].id)
            	                      .replace("{description}"	, mainList[i].description)
            	                      .replace("{description}"	, mainList[i].description)
            	                      .replace("{savefilename}"	, mainList[i].save_file_name)
            	                      .replace("{content}"		, mainList[i].content)
            	                      .replace("{placeName}"	, mainList[i].place_name);
				}else{
            	    resultHTMLA += html.replace("{id}"			, mainList[i].id)
				                       .replace("{description}"	, mainList[i].description)
				                       .replace("{description}"	, mainList[i].description)
				                       .replace("{savefilename}", mainList[i].save_file_name)
				                       .replace("{content}"		, mainList[i].content)
				                       .replace("{placeName}"	, mainList[i].place_name);						
				}
        	}		
	    	var dd = document.getElementsByClassName("lst_event_box")[0]
	    	var cc = document.getElementsByClassName("lst_event_box")[1]
		
	    //moreCount는 0,4,8 이렇게 증가하므로 메인카운트를 넘나 확인하려면 mainlist의 수량을 더해야 확실히 확인가능
	    if ( moreCount+mainList.length  >= mainCount) {
	    	morebtn.style.visibility="hidden";
		}else{
			morebtn.style.visibility="visible";
		}	    	
	    	
	    //탭 변경시 처음 값으로 셋팅위한것.
	    if (moreCount  == 0) {
	    	dd.innerHTML = resultHTML;
	    	cc.innerHTML = resultHTMLA;
		//더보기 시 추가
	    }else{
	    	dd.innerHTML += resultHTML;
	    	cc.innerHTML += resultHTMLA;
		}
    	
   }
    
    function anchorChange(num){
    	 var anchList = document.getElementsByClassName("anchor");
    	 console.log(anchList.length)
    	 for (var i = 0; i < anchList.length; i++) {
			if (i == num) {
    	 		var anchor = document.getElementsByClassName("anchor")[i];
    		 	anchor.className ='anchor active';
			}else{
				var anchor = document.getElementsByClassName("anchor")[i];
	    		anchor.className ='anchor';
			}
		 }
		 console.log(anchor)
    }
    
    function promoSetting(data){
    	var promohtml = document.querySelector("#promotionItem").innerHTML;
    	var presultHTML = "";
    	var promolen = data.length;
    	for(var i= 0 ; i< promolen; i++) {
    		presultHTML += promohtml.replace("{savefilename}", data[i].save_file_name);
    	}
    	var promoresult = document.querySelector(".visual_img")
    	promoresult.innerHTML += presultHTML
    	
    	promoChange();
    }
 
    function promoChange(){
    	
    	var promoimg = document.querySelector(".visual_img")
    	var promoitem = document.querySelector(".visual_img").children
    		promoimg.style.right = "0px"
    		count = count + 18;
    		promoimg.style.right = parseInt(promoimg.style.right) + count +"px";
//     		console.log(promoimg.style.right)
//     		console.log(count)
    		//픽셀이동 414가 딱 한칸 414 도달하면 지나간 값을 appendChild를 해줬을경우 제일 마지막에붙게된다.
    		if (count >=  414) {
//     			console.log(promoimg) 
//     			console.log(promoimg.lastElementChild) 
				//픽셀 이동 카운트 초기화 아래서 어팬드 차일드해서  li 값을 뒤에 붙여줄거기 때문에 결론은 414만 움직이면 li순서가 appendChild로인해 첫번째것은 제일 마지막으로 보내지고 한칸씩 당겨지기 떄문에
				count= 0;
				setTimeout(aaa,3000)
				function aaa(){
					//위에 선언된 ul의 칠드런 값중 제일 첫번째(이미 지나간 li)를 어팬드 해주면 마지막에 붙는다. 그래서 지나간 li들은 마지막에 붙게된다.
    				promoimg.appendChild(promoitem[0])
			    	requestAnimationFrame(function(){promoChange()});
				}
			//픽셀이동 414 까지는 계속 애니메이션 프레임 작동해야하기때문에 else의 경우 	계속 재귀
			}else{
    			requestAnimationFrame(promoChange)
			}
    } 
    
//     function promoChange(){
// //     	console.log(promolen)
//     	var totalcount =  parseInt(414*(promolen-1)) ;
// //     	console.log(totalcount)
//     	var promoimg = document.querySelector(".visual_img")
//     	promoimg.style.right = "-414px"
    	
//     	 if(count >= totalcount){
//      	     fcount = fcount + 18;
//     		 promoimg.style.right = parseInt(promoimg.style.right) + fcount +"px";
//     		 if (fcount >= 414) {
    			 
//  				setTimeout(aaa,3000)
//  				function aaa(){
//  					fcount= 0;
//  					count = 0;
// //     				promoimg.style.right = -totalcount+"px"
//  			    	requestAnimationFrame(function(){promoChange()});
//  				}

//  			}else{
//  				fcount =0;
//  				count = 0;
//     		 requestAnimationFrame(promoChange)
//  			}
//     	 }else{
    		 
//     	    count = count + 18;
//     	    fcount = fcount + 18;
//     		promoimg.style.right = parseInt(promoimg.style.right) + count +"px";
//     		console.log(promoimg.style.right)
//     		console.log(count)
//     		console.log(fcount)
//     		if (fcount >=  414) {
				
// 				fcount= 0;
// 				setTimeout(aaa,3000)
				
// 				function aaa(){
// 			    	requestAnimationFrame(function(){promoChange()});
// 				}

// 			}else{
				
//     			requestAnimationFrame(promoChange)
				
// 			}
//     	 }
// //      		setTimeout(promoChange,3000)
//     } 
    
    
/*     function promoChange(){
    	console.log(promolen)
    	var totalcount =  parseInt(414*(promolen-1)) ;
    	console.log(totalcount)
    	console.log(count)
    	var promoimg = document.querySelector(".visual_img")
    	promoimg.style.right = "-414px"
    	 if(count >= totalcount){
    		 count = 414;
    		 promoimg.style.right = parseInt(promoimg.style.right) + count +"px";
    		 setTimeout(promoChange,3000)
    	 }else{
    	    count = count + 414;
    		promoimg.style.right = parseInt(promoimg.style.right) + count +"px";
    		setTimeout(promoChange,3000)
    	 }
//      		setTimeout(promoChange,3000)
    } */
    


    </script>
</head>
<body>
    <div id="container">
        <div class="header">
            <header class="header_tit">
                <h1 class="logo">
                    <a href="https://m.naver.com/" class="lnk_logo" title="네이버"> <span class="spr_bi ico_n_logo">네이버</span> </a>
                    <a href="./myreservation.html" class="lnk_logo" title="예약"> <span class="spr_bi ico_bk_logo">예약</span> </a>
                </h1>
                <a href="./bookinglogin.html" class="btn_my"> <span class="viewReservation" title="예약확인">예약확인</span> </a>
            </header>
        </div>
        <hr>
        <div class="event">
            <div class="section_visual">
                <div class="group_visual">
                    <div class="container_visual">
                        <div class="prev_e" style="display:none;">
                            <div class="prev_inn">
                                <a href="#" class="btn_pre_e" title="이전"> <i class="spr_book_event spr_event_pre">이전</i> </a>
                            </div>
                        </div>
                        <div class="nxt_e" style="display:none;">
                            <div class="nxt_inn">
                                <a href="#" class="btn_nxt_e" title="다음"> <i class="spr_book_event spr_event_nxt">다음</i> </a>
                            </div>
                        </div>
                        <div>
                            <div class="container_visual">
                                <!-- 슬라이딩기능: 이미지 (type = 'th')를 순차적으로 노출 -->
                                <ul class="visual_img">
                                </ul>
                            </div>
                            <span class="nxt_fix" style="display:none;"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section_event_tab">
                <ul class="event_tab_lst tab_lst_min">
                    <li class="item" data-category="0">
                        <a class="anchor active"> <span id="0">전체리스트</span> </a>
                    </li>
                    <li class="item" data-category="1">
                        <a class="anchor"> <span id="1">전시</span> </a>
                    </li>
                    <li class="item" data-category="2" >
                        <a class="anchor"> <span id="2">뮤지컬</span> </a>
                    </li>
                    <li class="item" data-category="3">
                        <a class="anchor" > <span id="3">콘서트</span> </a>
                    </li>
                    <li class="item" data-category="4">
                        <a class="anchor"> <span id="4">클래식</span> </a>
                    </li>
                    <li class="item" data-category="5">
                        <a class="anchor"> <span id="5">연극</span> </a>
                    </li>
                    <!-- li class="item" data-category="7">
                        <a class="anchor"> <span>클래스</span> </a>
                    </li>
                    <li class="item" data-category="8">
                        <a class="anchor"> <span>체험</span> </a>
                    </li>
                    <li class="item" data-category="9">
                        <a class="anchor last"> <span>키즈</span> </a>
                    </li -->
                </ul>
            </div>
            <div class="section_event_lst">
                <p class="event_lst_txt">
                </p>
                <div class="wrap_event_box">
                    <!-- [D] lst_event_box 가 2컬럼으로 좌우로 나뉨, 더보기를 클릭할때마다 좌우 ul에 li가 추가됨 -->
                    <ul class="lst_event_box">
                    </ul>
                    <ul class="lst_event_box">
                    </ul>
                    <!-- 더보기 -->
                    <div class="more" id="morebtn" style="visibility:visible;">
                        <button class="btn" id="more"><span>더보기</span></button>
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


    <script type="rv-template" id="promotionItem">
    <li class="item" id="promoitem" style="background-image: url({savefilename})">
        <a href="#"> 
			<span class="img_btm_border"></span> 
			<span class="img_right_border"></span> 
			<span class="img_bg_gra"></span>
            <div class="event_txt">
                <h4 class="event_txt_tit"></h4>
                <p class="event_txt_adr"></p>
                <p class="event_txt_dsc"></p>
            </div>
        </a>
    </li>
    </script>

    <script type="rv-template" id="itemList">
        <li class="item">
            <a href="/detail.jsp?id={id}" class="item_book">
                <div class="item_preview">
                    <img alt="{description}" class="img_thumb" src="{savefilename}">
                    <span class="img_border"></span>
                </div>
                <div class="event_txt">
                    <h4 class="event_txt_tit"> <span>{description}</span> <small class="sm">{placeName}</small> </h4>
                    <p class="event_txt_dsc">{content}</p>
                </div>
            </a>
        </li>
    </script>
    <script type="rv-template" id="listCount">
               바로 예매 가능한 행사가 <span class="pink">{mainCount}개</span>있습니다
    </script>
</body>

</html>
