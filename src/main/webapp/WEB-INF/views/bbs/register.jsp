<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="./includes/header.jsp" %>
    <div class="container-fluid">
        <h1 class="mt-4">Board Register Page</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">Board Register Page</li>
        </ol>
        <div class="card mb-4">
            <div class="card-header"><i class="fas fa-table mr-1"></i>게시글 입력 폼</div>
            <div class="card-body">
                <div class="table-responsive">
                <form role="form" action="/bbs/register" method="post">
                	<div class="form-group">
                		<label>Title</label>
                		<input class="form-control" name="title">
                	</div>
                	<div class="form-group">
                		<label>Text area</label>
                		<textarea class="form-control" rows="3" name="content"></textarea>
                	</div>
                	<div class="form-group">
                		<label>Writer</label>
                		<input class="form-control" name="writer">
                	</div>
                	<button type="submit" class="btn btn-default">Submit</button>
                	<button type="reset" class="btn btn-default">Reset</button>
                </form>
                </div>
            </div>
        </div>
    </div>                   
<%@include file="./includes/footer.jsp" %>