<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>SingUp PAGE</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

	var re_id 	= /^[a-z0-9_-]{3,16}$/; // 아이디 검사식
	var re_pw 	= /^[a-z0-9_-]{6,18}$/; // 비밀번호 검사식
	var re_name =  /^[가-힣]+$/; // 이름 검사식
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; // 이메일 검사식
	var re_tel 	= /^[0-9]{8,11}$/; // 전화번호 검사식			
	
	
			
	$(document).ready(function(){

	var user_id  	= document.getElementById("user_id");
    var user_nm 	= document.getElementById("user_nm");
	var user_pw  	= document.getElementById("user_pw");
	var user_pw2  	= document.getElementById("user_pw2");
	var email   	= document.getElementById("email");
    var user_idspan = document.getElementById("user_idspan");
    var user_pwspan = document.getElementById("user_pwspan");
		
		$("#submit").on("click",function(){
		
// 			if (re_id.test(user_id.value) != true) { // 아이디 검사
// 		    	console.log(user_id.value)
// 		        alert('[ID 입력 오류] 유효한 ID를 입력해 주세요. 영어 숫자만 3~16자리.');
// 		        user_id.focus();
// 		        return false;
// 		    } else if(re_name.test(user_nm.value) != true ){ // 이름 검사
// 		    	console.log(user_nm.value)
// 		        alert('[NM입력 오류] 유효한 이름을 입력해 주세요. 초성없이 한글만');
// 		        user_nm.focus();
// 		        return false;
// 		    } else if(re_pw.test(user_pw.value) != true) { // 비밀번호 검사
// 		        alert('[PW 입력 오류] 유효한 PW를 입력해 주세요. 영어숫자만 6~18자리.');
// 		        user_pw.focus();
// 		        return false;
// 		    } else if(re_mail.test(email.value) != true) { // 이메일 검사
// 		        alert('[Email 입력 오류] 유효한 이메일 주소를 입력해 주세요.');
// 		        email.focus();
// 		        return false;
// 		  	} else if(user_pw.value != user_pw2.value) { // 이메일 검사
// 		        alert('[PW 입력 오류] 비밀번호확인 과 동일해야합니다.');
// 		        user_pw2.focus();
// 		        return false;
// 		  	}				 
					
			var frm = $('.logupfrom :input');
			var param = frm.serialize();
			
			$.ajax({
			    url : "/sign/signUpAc.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data)
			    {
			    	console.log(data.succes)
			    	if (data.success == "Y") {
						alert("가입성공");
						console.log("loginsuc")
						location.href = "/sign/signIn.do";
					}else{
				    	alert("실패");
					}
			    },
			    error: function (errorThrown)
			    {
			    console.log("에러");
			    }
			});
		});
	
		
// 		$('#user_id').keyup(function() {
// 			user_id = $('#user_id').val()
// 			if (user_id.length == 0) { // 입력 값이 없을 때
// 	       		$('#user_idspan').text(''); // strong 요소에 포함된 문자 지움
// 	        } else if (user_id.length < 3) { // 입력 값이 3보다 작을 때
// 	       		$('#user_idspan').text('너무 짧아요.'); // strong 요소에 문자 출력
// 	        } else if (user_id.length > 16) { // 입력 값이 16보다 클 때
// 	        	$('#user_idspan').text('너무 길어요.');; // strong 요소에 문자 출력
// 	        } else { // 입력 값이 3 이상 16 이하일 때
// 	        	$('#user_idspan').text('적당해요.');; // strong 요소에 문자 출력
// 	        }
// 	    });		
		
// 	    $('#user_nm').keyup(function() {
// 	    	user_nm = $('#user_nm').val()
// 			if (re_name.test(user_nm) != true ) {
// 				$('#user_nmspan').text('한글만 사용가능');
// 			} else {
// 				$('#user_nmspan').text('');
// 			}
// 	    });
	      
// 	    $('#user_pw').keyup(function() {
//    		 user_pw = $('#user_pw').val()
//    		 user_pw2 = $('#user_pw2').val()
   		 
// 			if (user_pw != "") {
// 				if (user_pw != user_pw2 ){ 
// 					 user_pwspan.innerHTML="비밀번호 불일치";
// 					 $('#user_pwspan').text('비밀번호 불일치');
// 				} else {
// 					 $('#user_pwspan').text('비밀번호 일치');
// 				}
// 			} else {
// 				$('#user_pwspan').text('');
// 			}
//    		});
	    
// 	    $('#user_pw2').keyup(function() {
// 	   		 user_pw = $('#user_pw').val()
// 	   		 user_pw2 = $('#user_pw2').val()
	   		 
// 				if (user_pw2 != "") {
// 					if (user_pw != user_pw2 ){ 
// 						 user_pwspan.innerHTML="비밀번호 불일치";
// 						 $('#user_pwspan').text('비밀번호 불일치');
// 					} else {
// 						 $('#user_pwspan').text('비밀번호 일치');
// 					}
// 				} else {
// 					$('#user_pwspan').text('');
// 				}
// 	   		});		     
	    	 
});
	
	
    
//     user_nm.onkeyup= function() {
// 			if (re_name.test(user_nm.value) != true ) {
// 					user_nmspan.innerHTML="한글만 사용가능";
// 				} else {
// 					user_nmspan.innerHTML="";
// 				}
// 			};
    
//     user_pw.onkeyup= function() {
// 			if (user_pw.value != "") {
// 				if (user_pw.value != user_pw2.value) {
// 					 user_pwspan.innerHTML="비밀번호 불일치";
// 					} else {
// 					 user_pwspan.innerHTML="비밀번호 일치";
// 					}
// 				} else {
// 					user_pwspan.innerHTML="";
// 				}
// 			};
			
//     user_pw2.onkeyup= function() {
// 			if (user_pw2.value != "") {
// 				if (user_pw.value != user_pw2.value) {
// 					 user_pwspan.innerHTML="비밀번호 불일치";
// 					} else {
// 					 user_pwspan.innerHTML="비밀번호 일치";
// 					}
// 				} else {
// 					user_pwspan.innerHTML="";
// 				}
// 			};
			
	

// 	//DOM이 모두 로드 되었을 때
// 	function domReady () {
		
// 		re_id 	= /^[a-z0-9_-]{3,16}$/; // 아이디 검사식
// 		re_pw 	= /^[a-z0-9_-]{6,18}$/; // 비밀번호 검사식
// 		re_name =  /^[가-힣]+$/; // 이름 검사식
// 		re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; // 이메일 검사식
// 		re_tel 	= /^[0-9]{8,11}$/; // 전화번호 검사식

// 		var user_id  	= document.getElementById("user_id");
// 	    var user_nm 	= document.getElementById("user_nm");
// 		var user_pw  	= document.getElementById("user_pw");
// 		var user_pw2  	= document.getElementById("user_pw2");
// 		var email   	= document.getElementById("email");
// 	    var user_idspan = document.getElementById("user_idspan");
// 	    var user_pwspan = document.getElementById("user_pwspan");
	
	
// 	    user_id.onkeyup= function() {
// 	         if (user_id.value.length == 0) { // 입력 값이 없을 때
// 	        	 user_idspan.innerHTML=''; // strong 요소에 포함된 문자 지움
// 	         } else if (user_id.value.length < 3) { // 입력 값이 3보다 작을 때
// 	        	 user_idspan.innerHTML='너무 짧아요.'; // strong 요소에 문자 출력
// 	         } else if (user_id.value.length > 16) { // 입력 값이 16보다 클 때
// 	        	 user_idspan.innerHTML='너무 길어요.'; // strong 요소에 문자 출력
// 	         } else { // 입력 값이 3 이상 16 이하일 때
// 	        	 user_idspan.innerHTML='적당해요.'; // strong 요소에 문자 출력
// 	         }
// 	     };
	     
// 	     user_nm.onkeyup= function() {
// 				if (re_name.test(user_nm.value) != true ) {
// 						user_nmspan.innerHTML="한글만 사용가능";
// 					} else {
// 						user_nmspan.innerHTML="";
// 					}
// 				};
	     
// 	     user_pw.onkeyup= function() {
// 				if (user_pw.value != "") {
// 					if (user_pw.value != user_pw2.value) {
// 						 user_pwspan.innerHTML="비밀번호 불일치";
// 						} else {
// 						 user_pwspan.innerHTML="비밀번호 일치";
// 						}
// 					} else {
// 						user_pwspan.innerHTML="";
// 					}
// 				};
				
// 	     user_pw2.onkeyup= function() {
// 				if (user_pw2.value != "") {
// 					if (user_pw.value != user_pw2.value) {
// 						 user_pwspan.innerHTML="비밀번호 불일치";
// 						} else {
// 						 user_pwspan.innerHTML="비밀번호 일치";
// 						}
// 					} else {
// 						user_pwspan.innerHTML="";
// 					}
// 				};
				
// 	}
	
// 		function fn_signup(){
		
// 			 if (re_id.test(user_id.value) != true) { // 아이디 검사
// 			    	console.log(user_id.value)
// 			        alert('[ID 입력 오류] 유효한 ID를 입력해 주세요. 영어 숫자만 3~16자리.');
// 			        user_id.focus();
// 			        return false;
// 			    } else if(re_name.test(user_nm.value) != true ){ // 이름 검사
// 			    	console.log(user_nm.value)
// 			        alert('[NM입력 오류] 유효한 이름을 입력해 주세요. 초성없이 한글만');
// 			        user_nm.focus();
// 			        return false;
// 			    } else if(re_pw.test(user_pw.value) != true) { // 비밀번호 검사
// 			        alert('[PW 입력 오류] 유효한 PW를 입력해 주세요. 영어숫자만 6~18자리.');
// 			        user_pw.focus();
// 			        return false;
// 			    } else if(re_mail.test(email.value) != true) { // 이메일 검사
// 			        alert('[Email 입력 오류] 유효한 이메일 주소를 입력해 주세요.');
// 			        email.focus();
// 			        return false;
// 			  	} else if(user_pw.value != user_pw2.value) { // 이메일 검사
// 			        alert('[PW 입력 오류] 비밀번호확인 과 동일해야합니다.');
// 			        user_pw2.focus();
// 			        return false;
// 			  	}
			    
			    
// 			    document.forms[0].submit();
// 		};	
		
		function fn_check(){
			console.log("체크하신걸환영합니다.")
			 
			};
			

	




</script>

</head>
<body>
	<header align="center">
		<h1>회원가입</h1>
	</header>

	<section>
	
		<form class="logupfrom">
			<table align="center" border="1">
				<tr>
					<td><label>아이디*</label></td>
					<td><input type="text" name="user_id" id="user_id" value="" /> <button type="button" onclick="fn_check();">중복체크</button>
					
					<span id="user_idspan"></span></td>
				</tr>
				<tr>
					<td><label>이름*</label></td>
					<td><input type="text" name="user_nm" id="user_nm" value="" />
					<span id="user_nmspan"></span></td>
				</tr>
				<tr>
					<td><label>비밀번호</label></td>
					<td><input type="password" name="user_pw" id="user_pw" value="" /></td>
				</tr>
				<tr>
					<td><label>비밀번호</label></td>
					<td><input type="password" name="user_pw2" id="user_pw2" value="" />
					<span id="user_pwspan"></span></td>
				</tr>
				<tr>
					<td><label>이메일</label></td>
					<td><input type="email" name="email" id="email" value="" /></td>
				</tr>
			</table>
		</form>
					
				
				<div align="center">
					 <input type="submit" id="submit" value="가입">
					 <input type="button" onclick="location.href='/sign/signIn.do'" value="취소" />
				</div>
	</section>

	<footer></footer>
</body>
</html>