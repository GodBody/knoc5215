<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<strong>${user_email}</strong> 님의 비밀번호 변경

	<form method="post" role="form">

		비밀번호 변경  : <input type="password" name="upw" id="upw" placeholder="변경할 비밀번호를 입력하세요"> <br> 
		비밀번호 변경 확인 : <input type="password" name="upw2" id="upw_chk" placeholder="비밀번호 확인"> <br> 
		<input type="submit" class="btn btn-primary" onclick="check()" value="SUBMIT">

	</form>

	<script type="text/javascript">
		var userEmail = '${user_email}';

		alert(userEmail + '님의 PASSWORD 변경 페이지 입니다.');

		function check() {

			if (document.userRegisterForm.upw.value == "") {
				alert("insert PASSWORD");
				document.userRegisterForm.upw.focus();
				event.preventDefault();
			}

			else if (document.userRegisterForm.upw_chk.value == "") {
				alert("insert PASSWORD CHECK");
				document.userRegisterForm.upw_chk.focus();
				event.preventDefault();
			}

			else if ((document.userRegisterForm.upw.value != document.userRegisterForm.upw_chk.value)
					&& ((document.userRegisterForm.upw.length != 0) && (document.userRegisterForm.upw_chk.length != 0))) {
				alert("Not same password and pssword_check");
				document.userRegisterForm.upw.focus();
				event.preventDefault();
			}

		}
	</script>
</body>
</html>