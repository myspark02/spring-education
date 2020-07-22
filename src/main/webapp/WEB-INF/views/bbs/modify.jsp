<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="./includes/header.jsp" %>
    <div class="container-fluid">
        <h1 class="mt-4">Board Update Page</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">Board Update Page</li>
        </ol>
        <div class="card mb-4">
            <div class="card-header"><i class="fas fa-table mr-1"></i>게시글 수정</div>
            <div class="card-body">
                <div class="table-responsive">
               		<form role="form" action="/bbs/modify" method="post">
	               		<div class="form-group">
	               			<label>Bno</label>
	               			<input class="form-control" name="bno" value="<c:out value='${board.bno}'/>" readonly> 
	               		</div>
	                	<div class="form-group">
	                		<label>Title</label>
	                		<input class="form-control" name="title" value="<c:out value='${board.title}'/>">
	                	</div>
	                	<div class="form-group">
	                		<label>Text area</label>
	                		<textarea class="form-control" rows="3" 
	                			name="content" ><c:out value="${board.content}" /></textarea>
	                	</div>
	                	<div class="form-group">
	                		<label>Writer</label>
	                		<input class="form-control" name="writer" value="<c:out value='${board.writer}'/>">
	                	</div>
	                	<div class="form-group">
	                		<label>Registered Date</label>
	                		<input class="form-control" name="regdate" 
	                			value="<fmt:formatDate pattern="yyyy/MM/dd" 
	                				value='${board.regdate}'/>" readonly>
	                	</div>
	                	<div class="form-group">
	                		<label>Update Date</label>
	                		<input class="form-control" name="updatedate" 
	                			value="<fmt:formatDate pattern="yyyy/MM/dd" 
	                				value='${board.updatedate}'/>" readonly>
	                	</div>       
	                	
	                	<input type="hidden" name="pageNum" value="${crt.pageNum}">
	                	<input type="hidden" name="amount" value="${crt.amount}">
	                	<input type="hidden" name="type" value="${crt.type}">
	                	<input type="hidden" name="keyword" value="${crt.keyword}">	                	
	                	     		                	
	                	<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
	                	<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
	                	<button type="submit" data-oper="list" class="btn btn-info">List</button>
	                	
	                </form>		
                </div>
            </div>
        </div>
    </div>  
    
    <script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form");

			$("button").on("click", function(e){
				e.preventDefault();

				var operation = $(this).data("oper");
				console.log(operation);

				if(operation == 'remove') {
					formObj.attr("action", "/bbs/remove");
				} else if(operation=='list') {
					//self.location = "/bbs/list";
					formObj.attr("action", "/bbs/list").attr("method", "get");

					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var typeTag = $("input[name='type']").clone();
					var keywordTag = $("input[name='keyword']").clone();					

					formObj.empty();
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(typeTag);
					formObj.append(keywordTag);
					//return;
				}

				formObj.submit();
			});
	
		});
    </script>
                     
<%@include file="./includes/footer.jsp" %>