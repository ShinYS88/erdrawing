<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/css/bootstrap_erd.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link href="/css/erdDrawing.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script> 

<script src="https://unpkg.com/konva@3.2.0/konva.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
<script src="/js/drawing/minimap.js"></script>
<script src="/js/drawing/attribute.js"></script>
<script src="/js/drawing/style.js"></script>
<script src="/js/drawing/realation.js"></script>
<script src="/js/drawing/sqlexport.js"></script>
<script src="/js/drawing/sqlimport.js"></script>
</head>

<body id='my_body'>

<tiles:insertAttribute name="content"/>
<tiles:insertAttribute name="module"/>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="/js/drawing/drawingAjax.js"></script>
<script src="/js/drawing/chat.js"></script>

</body>
</html>