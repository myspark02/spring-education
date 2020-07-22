<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>Error Page</h1>
	<p>${exception.getMessage()}</p>
	<c:forEach items="${exception.getStackTrace()}" var="stt">
		<p>${stt.toString()}</p>
	</c:forEach>
	
</body>
</html>