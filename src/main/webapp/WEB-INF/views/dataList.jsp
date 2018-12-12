<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>资料管理页面</title>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/bootstrap-4.1.3-dist/js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/js/bootstrap-4.1.3-dist/css/bootstrap.css">
<script type="text/javascript">
	$(function() {
		$("#registerBut").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/login/register.do",
				type : "post",
				dataType : "json",
				data : $("#myForm").serialize(),
				async : false,
				success : function(data) {
					if (data.flag) {
						alert("注册成功！");
					} else {
						alert("注册失败：" + data.message);
					}
				},
				error : function(data) {
					alert("连接服务器失败");
				}
			});
		});
		
	});
	
	var uploadData = function(){
		window.location.href="${pageContext.request.contextPath}/login/goUploadView.do";
	}
</script>
</head>
<body>
	<div class="container">
		<div style="position: absolute; left: 84%; top: 4%;">欢迎您，${loginUser.fullName }[${loginUser.userName }]</div>
		<h2 style="margin-top: 10%; color: blue;" align="center">分享会资源管理平台</h2>
		<div  class="form-inline">
			<input name="serchType" type="radio" checked="checked" value="0">按资料名称
			<input name="serchType" type="radio" value="1">按小组名称
			<input type="text" ><input type="button" value="搜索">
			<input type="button" onclick="uploadData();" value="上传资料"> 
		</div>
		<table class="table table-bordered table-striped table-hover"
			style="margin-top: 2%">
			<thead style="background-color: blue;color: white;">
				<td>小组名称</td>
				<td>资料名称</td>
				<td>IP</td>
				<td>上传人</td>
				<td>创建时间</td>
				<td>更新时间</td>
				<td>浏览数</td>
			</thead>
			<c:forEach items="${dataList }" var="data">
				<tr class="success">
					<td>${data.teamName }</td>
					<td><a href="${pageContext.request.contextPath}/login/viewDataInfo.do?id=${data.id}">${data.dataName }</a></td>
					<td>${data.ip }</td>
					<td>${data.uploadBy }</td>
					<td>${data.createTime }</td>
					<td>${data.updateTime }</td>
					<td>${data.viewCount }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	</body>
</html>