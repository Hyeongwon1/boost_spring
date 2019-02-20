<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INSERT PAGE</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#submit").on("click",function(){
		
		var frm = $('.Writeform :input');
		var param = frm.serialize();
		
		$.ajax({
		    url : "/board/boardWriteAc.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data)
		    {
		    	console.log(data.success)
		    	
		    	if (data.success == "Y") {
		    		
					alert("작성성공");
					location.href = "/board/boardListf.do";
			    	
				}else if(data.success == "N"){
			    	
			    	alert("실패");
					
				}
		    },
		    error: function (errorThrown)
		    {
		    console.log("에러");
		    }
		});
	});
	
	
});
</script>
</head>
<body>
<header align="center">
		<h1>게시판 입력</h1>
	</header>

	<div class="container" id="mycon" style="height: 100%;" align="center">
		<form class="Writeform" >
			<input type="hidden" name="reg_id" id="reg_id" value="<%=session.getAttribute("loginId") %>" />
			<table border="1">
				<tr>
					<td><label>제목</label></td>
					<td><input type="text" name="title" id="title" value=""></td>
				</tr>
				<tr>
					<td><label>내용</label></td>
					<td><textarea name="contents" id="contents" rows="30" cols="50" ></textarea></td>
				</tr>
			</table>
		</form>
			<input type="submit" id="submit" value="저장" />
			<button onclick="javascript:history.back();">취소</button>
			
	</div>
			
</body>
</html>