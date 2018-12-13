<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"  %>
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
		$("#infoDiv").hide();
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
		$("#delBut").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/login/deleteDataInfo.do",
				type : "post",
				dataType : "json",
				data : {"id":$("#checkedId").val()},
				async : false,
				success : function(data) {
					if(data.success){
						alert(data.message);
						window.location.href="${pageContext.request.contextPath}/login/goDataList.do";
					}else{
						alert(data.message);
					}
				},
				error : function(data) {
					alert("连接服务器失败");
				}
			});
		});
		$("#updateBut").click(function() {
			window.location.href="${pageContext.request.contextPath}/login/goUpdateView.do?id="+$("#checkedId").val();
		});
		$("#downloadBut").click(function() {
			 window.location.href="${pageContext.request.contextPath}/login/download.do?id="+$("#checkedId").val();
		});
	});
	
	var uploadData = function(){
		window.location.href="${pageContext.request.contextPath}/login/goUploadView.do";
	}
	
	var loadInfo = function(id){
		$("#checkedId").val(id);
		$("#infoDiv").show();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/login/queryInfo.do",
			type : "post",
			dataType : "json",
			data : {"id":$("#checkedId").val()},
			async : false,
			success : function(data) {
				$("#info").empty().val(data.dataDesc);
				$("#viewCount").val(data.viewCount);
			},
			error : function(data) {
				alert("连接服务器失败");
			}
		});
		
	}
</script>
</head>
<body>
	<div class="container">
		<div style="position: absolute; left: 84%; top: 4%;">欢迎您，${loginUser.fullName }[${loginUser.userName }]<a href="${pageContext.request.contextPath}/login/logout.do">注销</a></div>
		<h2 style="margin-top: 10%; color: blue;" align="center">分享会资源管理平台</h2>
		<form method="post" action="${pageContext.request.contextPath}/login/goDataList.do">
		<div  class="form-inline">
			<input class="form-control" name="serchType" type="radio" checked="checked" value="0">按资料名称
			<input class="form-control" name="serchType" type="radio" value="1">按小组名称
			<input class="form-control" type="text" name="serchContext"><button type="submit" class="btn btn-primary btn-default">搜索</button>
			<button class="btn btn-primary btn-default" type="button" onclick="uploadData();" >上传资料</button> 
		</div>
		</form>
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
					<td onclick="loadInfo(${data.id});"><a href="#">${data.dataName }</a></td>
					<td>${data.ip }</td>
					<td>${data.uploadBy }</td>
					<td><fmt:formatDate type="both" 
            dateStyle="medium" timeStyle="medium" 
            value="${data.createTime }" /></td>
					<td><fmt:formatDate type="both" 
            dateStyle="medium" timeStyle="medium" 
            value="${data.updateTime }" /></td>
					<td id="viewCount">${data.viewCount }</td>
				</tr>
			</c:forEach>
		</table>
		<div id="infoDiv">
			<input type="hidden" id="checkedId">
			<h3>资料简介</h3>
			<textarea  id="info" class="form-control"></textarea>
			<button class="btn btn-primary btn-default col-md-2" id="delBut">删除</button>
			<button class="btn btn-primary btn-default col-md-2" id="updateBut">修改资料</button>
			<button class="btn btn-primary btn-default col-md-2" id="downloadBut">附件下载</button>
		</div>
	</div>
	</body>
</html>