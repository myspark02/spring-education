<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<%@include file="./includes/header.jsp" %>
    <div class="container-fluid">
        <h1 class="mt-4">Board Read Page</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">Board Read Page</li>
        </ol>
        <div class="card mb-4">
            <div class="card-header"><i class="fas fa-table mr-1"></i>게시글 상세 정보</div>
            <div class="card-body">
                <div class="table-responsive">
               		<div class="form-group">
               			<label>Bno</label>
               			<input class="form-control" name="bno" value="<c:out value='${board.bno}'/>" readonly> 
               		</div>
                	<div class="form-group">
                		<label>Title</label>
                		<input class="form-control" name="title" value="<c:out value='${board.title}' />" readonly>
                	</div>
                	<div class="form-group">
                		<label>Text area</label>
                		<textarea class="form-control" rows="3" name="content" 
                			readonly><c:out value="${board.content}" /></textarea>
                	</div>
                	<div class="form-group">
                		<label>Writer</label>
                		<input class="form-control" name="writer" value="<c:out value='${board.writer}'/>" readonly>
                	</div>
                	<!-- 
                	<button data-oper="modify" class="btn btn-info"
                		onclick="location.href='/bbs/modify?bno=<c:out value='${board.bno}'/>'">Modify</button>
                	<button data-oper="list" class="btn btn-info"
                		onclick="location.href='/bbs/list'">List</button>
                	 -->	
            		<button data-oper="modify" class="btn btn-default">Modify</button>
            		<button data-oper="list" class="btn btn-info">List</button>
            		
            		<form id="operForm" action="/bbs/modify" method="get">
            			<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>" >
            			<input type="hidden" name="pageNum" value="${crt.pageNum}">
            			<input type="hidden" name="amount" value="${crt.amount}">
            			<input type="hidden" name="type" value="${crt.type}">
            			<input type="hidden" name="keyword" value="${crt.keyword}">
            		</form>
                </div>
            </div>
        </div>
        
        <div class="row">
        	<div class="col-lg-12">
        		<div class="panel panel-default">
        			<!-- 
        			<div class="panel-heading">
        				<i class="fa fa-comments fa-fw"></i>
        				Reply
        			</div>
        		 	-->	
        			<div class="panel-heading" style="margin-bottom:20px">
        				<i class="fa fa-comments fa-fw"></i>Reply
        				<button id = 'addReplyBtn' class='btn btn-primary btn-sm float-right'>New Reply</button>
        			</div>
        			
        			<div class="panel-body">
        				<ul class="chat">
        					<li class="left clearfix" data-rno="12">
        						<div>
        							<div class="header">
        								<strong class="primary-font">user00</strong>
        								<small class="float-right text-muted">2020-01-01 13:13</small>
        							</div>
        							<p>Good Job!</p>
        						</div>
        					</li>
        				</ul>
        			</div>
        			<div class="panel-footer">
        			
        			</div>
        		</div>        		        		
        	</div>
        </div>     
    </div>     
    

   <!--  Modal 추가 -->
   <div class="modal" id="myModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        
	       	<h4 class="modal-title">Reply Modal</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      
	       	
	      </div>
	      <div class="modal-body">
	        <div class="form-group">
	      		<label>Reply</label>
	      		<input class="form-control" name="reply" value="New Reply!!!">  	
	        </div>
	        <div class="form-group">
	        	<label>Replyer</label>
	        	<input class="form-control" name="replyer" value="replyer">
	        </div>
	        <div class="form-group">
	        	<label>Reply Date</label>
	        	<input class="form-control" name="replyDate" value=''>
	        </div>
	      </div>
	      
	      <div class="modal-footer">
	        <button id = "modalModBtn" type="button" class="btn btn-warning" data-dismiss="modal">Modify</button>
	        <button id = "modalRemoveBtn" type="button" class="btn btn-danger" data-dismiss="modal">Remove</button>
	        <button id = "modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">Register</button>
	        <button id = "modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
   
    
    
                  
    <script type="text/javascript">
    	$(document).ready(function(){
			var operForm = $("#operForm");

			$("button[data-oper='modify']").on("click", function(e){
				operForm.attr("action", "/bbs/modify").submit();
			});

			$("button[data-oper='list']").on("click", function(e){
				operForm.find("#bno").remove();
				operForm.attr("action", "/bbs/list").submit();
			});
			
        });
    </script>
    
    <script type="text/javascript" src="/resources/js/reply.js"></script>
    <script>
	$(document).ready(function() {
		console.log(replyService)
		var bno = ${board.bno};
		var replyUL = $(".chat");
		showList(1);

		function showList(page) {
			replyService.getList({bno:bno, page:page||1}, function(replyCnt, list) {
					console.log("replyCnt: " + replyCnt);
					console.log("list: " + list);

					var str = "";
					if(list==null || list.length==0) {
						replyUL.html("");
						return;
					}

					for (var i = 0, len = list.length; i < len; i++) {
						str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
						str += " <div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
						str += " <small class='float-right text-muted'>" + 
									replyService.displayTime(list[i].replyDate)+"</small></div>";
						str += " <p>"+ list[i].reply+"</p></div></li>";
					}
			
					replyUL.html(str);		
				});
		};


		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");

		$("#addReplyBtn").on("click", function(e){
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id != 'modalCloseBtn']").hide();

				modalRegisterBtn.show();

				$(".modal").modal("show");

			});

		modalRegisterBtn.on("click", function(e){
				var reply = {
							reply: modalInputReply.val(), 
							replyer : modalInputReplyer.val(),
							bno:bno
						};

				replyService.add(reply, function(result){
						alert(result);

						modal.find("input").val("");
						modal.modal("hide");

						showList(1);
					});
			});


		$(".chat").on("click", "li", function(e){
				var rno = $(this).data("rno");
				
				replyService.get(rno, function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
						modal.data("rno", reply.rno);

						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						

						//modalRegisterBtn.hide();

						$(".modal").modal("show");
						
					});
			});


		modalModBtn.on("click", function(e){
				var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};

				replyService.update(reply, function(result){
					alert(result);
					modal.modal("hide");
					showList(1);
					});
			});

		modalRemoveBtn.on("click", function(e){

			replyService.remove(modal.data("rno"), function(result){
					alert(result);
					modal.modal("hide");
					showList(1);
				});

			}); 
		
		/*
		replyService.add({reply:"JS Test", replyer:"tester", bno:bno}, 
				function(result){
					alert("RESULT: " + result);
				});
		*/

		/*
		replyService.getList({bno:bno, page:1}, function(list) {
			for (var i = 0, len = list.length || 0; i < len; i++) {
				console.log(list[i]);
			}
		});
		*/
		/*
		replyService.remove(2, 
				function(result){
					console.log(result);
					if (result === "success") {
						alert("REMOVED");
					}
				}, 
				function(err){
					alert("ERROR...: " + err);
				});
		*/

		/*
		replyService.update({rno:3, bno:bno, reply:"Modified Reply...."}, function(result){
									alert("수정 완료...");
			});
		*/
		/*
		replyService.get(10, function(data) {console.log(data);});
		*/
		 	
	});
    </script>
<%@include file="./includes/footer.jsp" %>










