<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
    
<%@include file="./includes/header.jsp" %>
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">BBS</h1>

                        <div class="card mb-4">
                            <div class="card-header"><i class="fas fa-table mr-1"></i>BBS Read Page</div>
                            <div class="card-body">
                                <div class="table-responsive">
	                                	<div class="form-group">
	               							<label>Bno</label>
	               								<input class="form-control" name="bno" 
	               								value="<c:out value='${board.bno}'/>" readonly> 
	               						</div>
					                  	<div class="form-group">
					                		<label>Title</label>
					                		<input class="form-control" name="title"
					                		value="<c:out value='${board.title}' />"  readonly>
					                	</div>   
					                	<div class="form-group">
					                		<label>Text area</label>
					                		<textarea class="form-control" rows="3" 
					                			name="content" readonly><c:out value="${board.content}" /></textarea>
					                	</div>		
					                	<div class="form-group">
					                		<label>Writer</label>
					                		<input class="form-control" 
					                		name="writer"
					                		value="<c:out value='${board.writer}'/>" readonly>
					                	</div>	
                						<button data-oper="modify" class="btn btn-default">Modify</button>
                						<button data-oper="list"  class="btn btn-info" >List</button>					                					                				                	                             
					            		
					            		<form id="operForm" action="/board/modify" method="get">
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
                        		
                        			<div class="panel-heading" style="margin-bottom:30px">
                        				<i class="fa fa-comments fa-fw"></i>Reply
                        				<button id="addReplyBtn" class="btn btn-primary btn-sm float-right">New Reply</button>
                        			</div>
                        			
                        			<div class="panel-body">
                        				<ul class="chat">
				        					                   					
                        				</ul>
                        			</div>
                        			<div class="panel-footer">
                        			
                        			</div>
                        		</div>
                        	</div>
                        </div>
                    </div>
                    
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
										<input class="form-control" name="reply" value="New Reply!!!!">
									</div>
									<div class="form-group">
										<label>Replyer</label>
										<input class="form-control" name="replyer" value="replyer">
									</div>
									<div class="form-group">
										<label>Reply</label>
										<input class="form-control" name="replyDate" value="">
									</div>
								</div>
								<div class="modal-footer">
									<button id="modalModBtn" type="button" class="btn btn-warning" data-dismiss="modal">Modify</button>
									<button id="modalRemoveBtn" type="button" class="btn btn-danger" data-dismiss="modal">Remove</button>
									<button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">Register</button>									
									<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>                   
                    
                    
                </main>
                
                <script type="text/javascript">
					$(document).ready(function(){
						var operForm = $("#operForm");
						
						$("button[data-oper='modify']").on("click", function(e){
								operForm.submit();
							});
						$("button[data-oper='list']").on("click", function(e){
							operForm.find("#bno").remove();
							operForm.attr("action", "/board/list");
							operForm.submit();

						});
					});	
                </script>
                
                <script type="text/javascript" src="/resources/js/reply.js"></script>
                <script type="text/javascript">
                
					$(document).ready(function(){
							//console.log(replyService);
							var bno = ${board.bno} ;
							var replyUL = $(".chat");
							showList(1);

							function showList(page) {
								replyService.getList({bno:bno, page:page||1}, function(replyCnt, list){
										var str ="";

										if(list == null || list.length == 0) {
											replyUL.html("");
											return;
										}

										for(var i = 0; i < list.length; i++) {
											str += "<li class='left clearfix' data-rno='" + list[i].rno +"'>";
											str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer +"</strong>";
											str += "<small class='float-right text-muted'>" + 
													replyService.displayTime(list[i].replyDate) + "</small></div>";
											str += "<p>" + list[i].reply + "</p></div></li>";
										}
										
										replyUL.html(str);
										
										showReplyPage(replyCnt);

									});
							}

							var replyPageFooter = $(".panel-footer");
							var pageNum = 1; 
							
							function showReplyPage(replyCnt) {
								var endPage = Math.ceil(pageNum/10.0)*10;
								var startPage = endPage - 9;

								var prev = startPage != 1;
								var next = false;

								if (endPage * 10 >= replyCnt) {
									endPage = Math.ceil(replyCnt/10.0)
								}

								if (endPage * 10 < replyCnt) {
									next = true;
								}

								var str = "<ul class='pagination float-right'>";

								if (prev) {
									str += "<li class='page-item'><a class='page-link' href='" + (startPage - 1) + "'>Previous</a></li>";
								}

								for (var i = startPage; i <= endPage; i++) {
									var active = pageNum==i?"active":"";
									str+= "<li class='page-item " + active +"'><a class='page-link' href='"+i+"'>" + i + "</a></li>";
								}

								if (next) {
									str += "<li class='page-item'><a class='page-link' href='" + (endPage + 1) + "'>Next</a></li>";
								}

								str += "</ul>";

								console.log(str);

								replyPageFooter.html(str);
							}

							replyPageFooter.on("click", "li a", function(e){
									e.preventDefault();

									console.log("page click");

									var targetPageNum = $(this).attr("href");
									console.log("targetPageNum:"+ targetPageNum);

									pageNum = targetPageNum;
									
									showList(pageNum);
								});


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
									modal.find("button[id!='modalCloseBtn']").hide();

									modalRegisterBtn.show();

									modal.modal("show"); // $(".modal").modal("show");


								});

							modalRegisterBtn.on("click", function(e){

									var reply = {reply: modalInputReply.val(), 
												replyer: modalInputReplyer.val(), 
												bno:bno
											};
									replyService.add(reply, function(result){
											alert(result);

											modal.find("input").val("");
											modal.modal("hide");

											pageNum  = 1;
											showList(pageNum);
										});
								});
							

							$(".chat").on("click", "li", function(e){
									var rno = $(this).data("rno");
									console.log(rno);

									replyService.get(rno, function(result){
											modalInputReply.val(result.reply);
											modalInputReplyer.val(result.replyer);
											modalInputReplyDate.val(replyService.displayTime(result.replyDate)).attr("readonly", "readonyly");
											modal.data("rno", result.rno);

											modal.find("button[id!='modalCloseBtn']").hide();
											modalModBtn.show();
											modalRemoveBtn.show();

											$(".modal").modal("show");
										});
									
								});

							modalModBtn.on("click", function(e){
									var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};

									replyService.update(reply, function(result){
											alert(result);
											modal.modal("hide");
											showList(pageNum);
										});
								});

							modalRemoveBtn.on("click", function(e){
									var rno = modal.data("rno");
									replyService.remove(rno, function(result){
											alert(result);
											$(".modal").modal("hide");
											showList(pageNum);
										});
								});
							/*
							replyService.add({reply:"AJAX Test", replyer:"성춘향", bno:bno}, function(result){
								alert("RESULT:"+result)
								});
							*/

							/*
							replyService.getList({bno:bno, page:1}, function(list){
									for (var i = 0, len= list.length || 0; i < len ; i++ ) {
										console.log(list[i]);
									}
								});
							*/

							/*
							replyService.remove(10, function(result){
										console.log(result);
										if(result === "success") {
											alert("REMOVED");
										}
								}, function(err){
										alert("ERROR..."+err);
									});
							*/
							/*
							replyService.update({rno:9, reply:'Modified Reply^^...'}, function(result){
										if (result === "success")
											alert("수정완료...:"+result);
								});
							*/
							/*
							replyService.get(11, function(result){
									console.log(result);
								});
							*/
						});
                </script>

<%@include file="./includes/footer.jsp" %>   