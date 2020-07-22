<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.uploadResult {
		width: 100%;
		background-color : gray;
	}
	
	.uploadResult ul {
		display : flex;
		flex-flow: row;
		justify-content: center;
		align-items : center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width: 20px;
	}
</style>

</head>
<body>
	<h1> Upload With Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFiles" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
	
	<script>
		$(document).ready(function(){
				var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
				var maxsize = 5242880; // 5MB : 1024*1024*5

				function checkExtension(fileName, fileSize) {
					if (fileSize >= maxsize) {
						alert("파일 사이즈 초과");
						return false;
					}
	
					if (regex.test(fileName)) {
						alert("해당 종류의 파일은 업로드할 수 없습니다.");
						return false;
					}

					return true;
				}

				var cloneUploadDiv = $(".uploadDiv").clone();
				
				$("#uploadBtn").on("click", function(e){
						var formData = new FormData();

						var inputFile = $("input[name='uploadFiles']");

						var files = inputFile[0].files;

						console.log(files);

						// add file data to formData

						for (var i = 0; i < files.length; i++) {
							if (!checkExtension(files[i].name, files[i].size)) {
								return false;
							}
							
							formData.append("uploadFiles", files[i]);
						}

						$.ajax({
							url: 'uploadAjaxAction', 
							processData: false,
							contentType: false,
							data : formData, 
							type: 'POST', 
							success: function(result) {
									//alert("Uploaded: " + result);
									console.log(result);
									showUploadedFile(result);
									$(".uploadDiv").html(cloneUploadDiv.html());
									//$("input[name='uploadFiles']").val("");
								}
							});
						
					});

				var uploadResultDiv = $(".uploadResult ul");

				function showUploadedFile(uploadResult) {
					var str = "";
					$(uploadResult).each(function(i, obj){
							if (!obj.image) {
								str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
							} else {
								// str += "<li>" + obj.fileName + "</li>";
								var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
								str += "<li><img src='display?fileName="+fileCallPath+"'><li>";
							}
						});
					uploadResultDiv.append(str);
				}
			});
	</script>
	
</body>
</html>