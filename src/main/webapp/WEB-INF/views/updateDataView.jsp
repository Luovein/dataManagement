<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>上传资料页面</title>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap-4.1.3-dist/js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/js/bootstrap-4.1.3-dist/css/bootstrap.css">
<script type="text/javascript">
$(function(){
	$.ajax({
		url:"${pageContext.request.contextPath}/login/getTeamNames.do",
		type :"post",
		dataType:"json",
		async:false,
		success:function(data){
			var str = '';
			for (var i = 0; i < data.length; i++) {
				str+="<option value='"+data[i]+"'>"+data[i]+"</option>";
			}
			$("#teamName").empty().append(str);
		},
		error:function(data){
			alert("连接服务器失败");
		}
	});
	$("#canBut").click(function(){
		window.location.href="${pageContext.request.contextPath}/login/goDataList.do";
	});
});
</script>
</head>
<body>
	<div class="container">
		<div style="position: absolute; left: 84%; top: 4%;">欢迎您，${loginUser.fullName }[${loginUser.userName }]<a href="${pageContext.request.contextPath}/login/logout.do">注销</a></div>
		<h2 style="margin-top: 10%; color: blue;" align="center">修改资料</h2>
		<form class="form-horizontal" id="myForm" action="${pageContext.request.contextPath}/login/updateDataInfo.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${dataManage.id }">
			<div class="form-group row">
				<label for="dataName" class="col-md-2 control-label">资料名称</label>
				<div class="col-md-8">
					<input type="text" class="form-control" id="dataName" name="dataName"
						placeholder="资料名称" value="${dataManage.dataName }">
				</div>
			</div>
			<div class="form-group row">
				<label for="teamName" class="col-md-2 control-label">小组名称</label>
				<div class="col-md-8">
					<select class="form-control" id="teamName" name="teamName" value="${dataManage.teamName }">
					
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label for="uploadBy" class="col-md-2 control-label">上传人</label>
				<div class="col-md-8">
					<input type="text" class="form-control" id="uploadBy" name="uploadBy" value="${dataManage.uploadBy }" readonly="readonly">
				</div>
			</div>
			<div class="form-group row">
				<label for="dataDesc" class="col-md-2 control-label">资料简介</label>
				<div class="col-md-8">
					<textarea class="form-control" id="dataDesc" name="dataDesc">${dataManage.dataDesc }</textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="url" class="col-md-2 control-label">上传附件</label>
				<div class="col-md-8">
					<input type="file"  class="form-control" id="file" name="file" value="${dataManage.url }">
				</div>
			</div>
			
			<div class="form-group row">
			<div class="col-md-3"></div>
			<button class="btn btn-primary btn-default col-md-2" id="createBut" type="submit">修改</button>
			<div class="col-md-1"></div>
			<button class="btn btn-primary btn-default col-md-2" id="canBut" type="button">取消</button>
			</div>
		</form>
	</div>
</body>
</html>