<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Map"%>

  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UPDATE PAGE</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
// $(document).ready(function(){
	
<%-- 	var seq = '<%= request.getParameter("seq")%>'; --%>

// 	$.ajax({
// 		url : "/board/boardRead.do?seq="+seq,
// 		type : "POST",
// 		contentType:'application/json;charset=utf-8',
// 		dataType : "json",
// 		success : function(data){
// 			console.log(data)
// 			console.log(data.list[0].seq)
				
// 				$('#seq').html(data.list[0].seq);
// 				$('#reg_id').html(data.list[0].reg_id);
// 				$('#reg_date').html(data.list[0].reg_date);
// 				$('#title').html(data.list[0].title);
// 				$('#contents').html(data.list[0].contents);
				
// 			},
// 		    error: function (errorThrown)
// 		    {
// 		    console.log("에러");
// 		    }
// 		});
	
	
// });
</script>
</head>
<body>
	<header align="center">
		<h1>게시판 상세</h1>
	</header>

	<section>
		<form id="update" >
			<table border="1" align="center">
				<tr>
				<td colspan="5" id="seq">${list.seq}</td>
				</tr>
				<tr>
					<td><label>작성자</label></td>
					<td id="reg_id">${list.reg_id}</td>
					
					<td><label>작성일</label></td>
					<td id="reg_date">${list.reg_date}</td>
				</tr>
				<tr>
					<td><label>제목</label></td>
					<td colspan="3" id="title">${list.title}</td>
				</tr>
				<tr>
					<td colspan=""><label>내용</label></td>
					<td colspan="3"><textarea name="content" rows="30" cols="50" id="contents">${list.contents}</textarea></td>
				</tr>
			</table>
		</form>
				<div align="center">
				<button onclick="javascript:history.back();">목록</button>
				</div>
	</section>

</body>
</html>
