<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%
String cp = request.getContextPath();
response.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SELECT PAGE</title>
<link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style>
.inputfield{

height:22px

}

/* 기본 설정*/
/*  u{text-decoration:none; color:#000000;}	 */
/*  u:hover{color:#ff0000; cursor: pointer;}  */
/*  strong{color:#ff0000; cursor: pointer; font:bold 15px Dotum;}  */
/*  /* nav tag */  */
/*  .pg li{display:inline; /* 세로나열을 가로나열로 변경 */  */
/* 			border-left:1px solid #999; /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */  */
/* 			 font:bold 12px Dotum; /* 폰트 설정 - 12px의 돋움체 굵은 글씨로 표시 */  */
/* 			 padding:0 10px; /* 각 메뉴 간격 */  */
/*  			}  */
/* .pg li:first-child{border-left:none;} /* 메뉴 분류중 제일 왼쪽의 "|"는 삭제 */
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	search(1);
	$('#searchbtn').on('click', function(){
		search(1);
	})

});	

	
	function search(cPage) {
		console.log(cPage)
		var cPage ;
		
		console.log(cPage)
		console.log($("#searchKey").val())
		console.log($("#searchWord").val())
		var param = {
	
			'searchKey'  : $("#searchKey").val(),
			'searchWord' : "%"+$("#searchWord").val()+"%",
			'cpage'   :  cPage
		}
	
		$.ajax({
			url : "/board/boardList.do" ,
			data:  JSON.stringify(param),
			dataType : "json",
			contentType :"application/json",
			type : "POST",
			success : function(data) {
	              console.log(data)
	              console.log(data.list)
	              console.log(data.totalRows)
	              console.log(data.cPage)
	              
	             var totalRows = data.totalRows
	             var cPage = data.cPage
	             
	             listfn(data.list);
	             console.log("totalRows")
	             console.log(totalRows)
	             pagerfn(totalRows,cPage);
	// 			alert("셀렉완료");
				},
				error : function(errorThrown) {
					alert("실패");
				}
			});
}

function listfn(data) {
	
	$('#list').empty();
	$.each(data, function(index, item) {
// 		console.log(item.reg_date)
// 		var mdate = item.reg_date
// 		var mdate2 = new Date(mdate);
// 		var mdate3 = mdate2.getFullYear() + "-"
// 				+ Number(mdate2.getMonth() + 1) + "-"
// 				+ mdate2.getDate();
		
// 		// GET CURRENT DATE
// 		var date = new Date(mdate);
		 
// 		// GET YYYY, MM AND DD FROM THE DATE OBJECT
// 		var yyyy = date.getFullYear().toString();
// 		var mm = (date.getMonth()+1).toString();
// 		var dd  = date.getDate().toString();
		 
// 		// CONVERT mm AND dd INTO chars
// 		var mmChars = mm.split('');
// 		var ddChars = dd.split('');
		 
// 		// CONCAT THE STRINGS IN YYYY-MM-DD FORMAT
// 		var datestring = yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);
		
		$('#list').append(
				"<tr><td>"
				+ item.seq 
				+ "</td><td>" 
				+ "<a href ="+ "/board/boardRead.do?seq=" + item.seq + ">"+ item.title + "</a>" 
				+ "</td><td>"
				+ item.reg_id
				+ "</td><td>" 
				+ item.mod_id
				+ "</td><td>" 
				+ item.reg_date
				
				+ "</td></tr>")

	})
}

function pagerfn(data,cppage) {
	
	$('#pager').empty();
	//var totalRows = data
	
	var totalRows = data; //총 row 수
	var cPage = cppage;
	var pageBlock = 10;     // 페이지 블럭 개수
	//var pageGroup ;         //pageGroup
 	var totalPages ; 		// 전체페이지
    
   //나머지 여부확인 : 나머지가 있으면 +1
	var mod = totalRows % pageBlock;
	console.log("mod:"+mod)
	if (mod > 0) { 
		 totalPages = parseInt(totalRows / pageBlock) + 1;
	} else {
		 totalPages = parseInt(totalRows / pageBlock) ;
	}
	 console.log("cpage:"+ cPage)
	 console.log("totalPage:"+ totalPages )
	// 자바에서는 소숫점으로 안떨어 졌으나 스크립트에서는 소수점으로 떨어져서 보정이 필요했음. 그것이 오류의 원인
	// parseInt () 함수는 문자열을 구문 분석하고 정수를 반환합니다.
	// Math.ceil() : 소수점 올림, 정수형 반환
	// Math.floor() : 소수점 버림, 정수형 반환
	// Math.round() : 소수점 반올림, 정수형 반환
	var pageGroup  = parseInt((totalPages/pageBlock)) + 1; // 전체 페이지 그룹 (1~10 : 1그룹, 11 ~20:2그룹)
	var cPageGroup = parseInt((cPage - 1) / pageBlock) + 1; // 현재 페이지 그룹
	
	var firstGo = (cPage <= pageBlock) ? false : true; // 첫페이지 이동 설정(현재페이지가 1그룹안에 있으면 false)
	var prevGo 	= (cPageGroup == 1) ? false : true; 	// 이전페이지 이동(현재페이지가 1그룹에 있으면 false)
	var nextGo	= (cPageGroup == pageGroup) ? false : true ; // 다음페이지 이동(현재페이지가 마지막 그룹에 속해있으면 false)
	var lastGo 	= (cPage >= pageBlock && cPageGroup == pageGroup) ? false : true; // 라스트페이지 이동  설정
	
 	 console.log("pageGroup:"+pageGroup) 
 	 console.log("cPageGroup:"+cPageGroup)
 	 
	var firstPage = 1; // 첫페이지값
	var prevPage = (cPageGroup - 1) * pageBlock - (pageBlock-1); // 이전페이지값
	var nextPage = (cPageGroup + 1) * pageBlock - (pageBlock-1); // 다음페이지값
	var lastPage = totalPages; // 마지막페이지값
 	
	
	
	var startRow = (cPage <= pageBlock) ? 1 : parseInt( cPage / pageBlock) * pageBlock + 1; // 페이지 리스트 첫번째 배열값 현재페이지보다 페이지 블럭이 적으면 1 : 블럭을 현재페이지로 나누어서 
  	var endRow =  startRow + pageBlock - 1;// 10,20,30,40... 리스트 블럭 끝	
  	if(endRow > totalPages){endRow = totalPages;}
//   	var endRow = (cPageGroup < pageGroup) ? startRow + pageBlock - 1 : totalPages; // 페이지 리스트 마지막 배열값
	console.log("startRow"+startRow)   
 	console.log("endRow:"+endRow)
			var navigation_html="";
		if(firstGo == true){ 
			navigation_html += '<li class="">'; 
		    navigation_html += '<a href="javascript:search(' + firstPage +')">'+ "처음" +'</a>'; 
		   	navigation_html += '</li>';
// 			$('#pager').append("<li onclick='search(" + firstPage + ")'>"+"<u>"+ "처음" +"</u>"  + "</li>")
		}
		if(prevGo == true){ 
			navigation_html += '<li class="">'; 
		    navigation_html += '<a href="javascript:search(' + prevPage +')">'+ "이전" +'</a>'; 
		   	navigation_html += '</li>';
// 			$('#pager').append("<li onclick='search(" + prevPage + ")'>"+"<u>"+ "이전" +"</u>"  + "</li>")
		}
		for(var i = startRow ; i<= endRow ; i++){
			if (i==cPage) {
				navigation_html += '<li class="active" id="id' + i +'">';  
			    navigation_html += '<a href="javascript:search(' + i +')" longdesc="' + i +'">'+ i +'</a>';
			   	navigation_html += '</li>';
// 			$('#pager').append("<li onclick='search(" + i + ")'>"+"<u>"+ "<strong>"+ i+ "</strong>"+"</u>"  + "</li>")
			}else{ 
				navigation_html += '<li class= >';  
			    navigation_html += '<a href="javascript:search(' + i +')" longdesc="' + i +'">'+ i +'</a>';
			   	navigation_html += '</li>';
<%-- 			page_html += "<li><a onclick='search(<%= "#" %>{i})'></a></li>"; --%>  //#을 사용 하니  제스퍼 관련 오류가 나서 컴파일 되지 않는다고 떳음  , 스크립트릿으로 감싸서 활용하니 오류는 사라졌음. 하지만 펑션이 호출된것은 아님/.
<%-- 			page_html = page_html.replace(/<%= "#" %>{i}/gi, '"' + i + '"'); --%>  //변수값이 변수로 안들어가고 그냥 변수 명으로 들어가나 싶어서 리플레이스 해서 넣어줘 봤음 . 
// 			$('#pager').append("<a onclick='search(" + i + ")'>"+"<u>"+ i +"</u>"  + "</a>") //온클릭에다 펑션을 호출했을시  타입에러 났었음.. href에다 하니까 됨.. 자세한 이유는 찾아 봐야 할듯..
			}
		} 
		if(nextGo == true ){
			navigation_html += '<li class="">'; 
		    navigation_html += '<a href="javascript:search(' + nextPage +')">'+ "다음" +'</a>'; 
		   	navigation_html += '</li>';
// 			$('#pager').append("<li onclick='search(" + nextPage + ")'>"+"<u>"+ "다음" +"</u>"  + "</li>")
		}
		if(lastGo == true ){
			navigation_html += '<li >'; 
		    navigation_html += '<a href="javascript:search(' + lastPage +')">'+ "마지막" +'</a>'; 
		   	navigation_html += '</li>';
// 			$('#pager').append("<li onclick='search(" + lastPage + ")'>"+"<u>"+ "마지막" +"</u>"  + "</li>")
		}

		    $('#pager').append(navigation_html); //부트스트랩으로 활용하니 css에서 적용한  커서 포인터 등등이 필요 없어짐.
}




function fn_logout() {
	
		
	location.href='/sign/signIn.do'
}


</script>
</head>
<body>
	<header align="center">
		<h1>SELECT PAGE</h1>
	</header>
		<div class="container">
			
			<button class="btn btn-xs pull-right" id="logout"  onclick="fn_logout();" >로그아웃</button>
			<table class="">
					<tr>
						<td colspan="5">
							<select class="inputfield" name="searchKey" id="searchKey">
								<option value="TITLE">제목</option>
								<option value="MOD_ID">아이디</option>
							</select>
							<input class="inputfield" type="text" name="searchWord" id="searchWord" value="" />
							<button id="searchbtn" class="btn btn-success btn-xs" value="검색" >검색</button>
						</td>
					</tr>
			</table>
		</div>
		<br>
		<div class="container">
				<table class="table table-hover">
						<tr>
							<th>글번호</th>
							<th width="200">제목</th>
							<th>작성자ID</th>
							<th>작성자이름</th>
							<th>작성일</th>
						</tr>
					<tbody id="list">
					
					</tbody>
				</table>
			<hr>
					
			<button type="button"  class="btn btn-primary active btn-sm pull-right"  onclick="location.href='/board/boardWrite.do'">글쓰기</button>
			
			<div id="" class="text-center">
				<ul id="pager" class="pagination pagination-sm">
				</ul>
			</div>
		</div>

</body>
</html>