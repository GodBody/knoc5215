<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Starter</title>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="/resources/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>

<style type="text/css">
* {
	font-family: NanumGothic, 'Malgun Gothic';
}

body {
	padding-top: 50px;
}

.popup {
	position: absolute;
}

.back {
	background-color: gray;
	opacity: 0.5;
	width: 100%;
	height: 300%;
	overflow: hidden;
	z-index: 1101;
}

.front {
	z-index: 1110;
	opacity: 1;
	boarder: 1px;
	margin: auto;
}

.show {
	position: relative;
	max-width: 1200px;
	max-height: 800px;
	overflow: auto;
}
</style>

<div class='popup back' style="display: none;"></div>
<div id="popup_front" class='popup front' style="display: none;">
	<img id="popup_img">
</div>
<section>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle Navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"><b>MyProject</b></a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="http://localhost:8080/user/home">Home</a></li>
					<li><a href="http://localhost:8080/uboard/list">Notice</a></li>
					<li class="active"><a href="http://localhost:8080/sboard/list">Board</a></li>
					<li id="loginDiv">
					<c:choose>

							<c:when test="${sessionScope.login eq null}">
								<li><a href="http://localhost:8080/user/login">Login</a></li>
							</c:when>
							<c:when test="${sessionScope.login ne null}">
								<li><a href="http://localhost:8080/user/logout">Logout</a></li>
								<li><a href="http://localhost:8080/user/info">Info</a></li>
								<li><a href="http://localhost:8080/user/message">Message</a></li>
							</c:when>

						</c:choose>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">

		<div class="col-md-12">
			<!-- general form elements -->

			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Read Board PAGE</h3>
				</div>
				<!-- /.box-header -->

				<!--  form  -->
				<form role="form" action="modifyPage" method="post">
					<input type='hidden' name='bno' value="${board.bno}"> <input
						type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">
				</form>

				<div class="box-body">
					<div class="form-group">
						<label for="title">제목</label> <input type="text" name='title'
							class="form-control" value="${board.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control" name="content" rows="3"
							readonly="readonly">${board.content}</textarea>
					</div>
					<div class="form-group">
						<label for="writer">작성자</label> <input type="text"
							name="writer" class="form-control" value="${board.writer}"
							readonly="readonly">
					</div>
				</div>
				<!-- /.box-body -->
				<div class="box-footer">

					<div>
						<hr>
					</div>

					<ul class="mailbox-attachments clearfix uploadedList">

					</ul>
				
						<button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
					
					<button type="submit" class="btn btn-primary" id="goListBtn">LIST</button>
				</div>
				<!-- /.box-footer -->

			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

		<div class="row">
			<div class="col-md-12">
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">ADD NEW APPLY</h3>
					</div>
					<c:if test="${not empty login }">
						<div class="box-body">
							<label for="newReplyWriter">작성자</label> <input
								class="form-control" type="text" id="newReplyWriter"
								placeholder="USER ID" value="${login.uid }" readonly="readonly">
							<label for="newReplyText">댓글</label> <input
								class="form-control" type="text" id="newReplyText"
								placeholder="REPLY TEXT">
						</div>
						<!--  /.box-body -->
						<div class="box-footer">
							<button type="submit" class="btn btn-primary" id="replyAddBtn">등록</button>
						</div>
					</c:if>

					<c:if test="${empty login }">
						<div class="box-body">
							<div>
								<a href="javascript:goLogin();">Login Please</a>
							</div>
						</div>
					</c:if>
				</div>

				<!-- time Line -->
				<ul class="timeline">
					<li class="time-label" id="repliesDiv"><span class="bg-green">목록<small id='replycntSmall'>[${board.replycnt }]</small>
					</span></li>
				</ul>

				<div class='text-center'>
					<ul id="pagination" class="pagination pagination-sm no-margin">
					</ul>
				</div>
			</div>
			<!-- /. col -->
		</div>
		<!--  /.row -->
	</div>

	<!-- Modal -->
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p>
						<input type="text" id="replytext" class="form-control">
					</p>
				</div>
				<div class="modal-footer">


					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</section>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
	<li class="replyLi" data-rno={{rno}}>
    		<i class="fa fa-comments bg-blue"></i>
    		<div class="timeline-item" >
                <span class="time">
                  <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
                </span>
                <h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
                <div class="timeline-body">{{replytext}} </div>
								<div class="timeline-footer">
								{{#eqReplyer replyer }}
                  <a class="btn btn-primary btn-xs" 
									data-toggle="modal" data-target="#modifyModal">Modify</a>
								{{/eqReplyer}}
							  </div>
	            </div>			
	</li>
{{/each}}
</script>


<script>
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);

	}

	Handlebars.registerHelper("eqReplyer", function(replyer, block) {
		var accum = '';

		if (replyer == '${login.uid}') {
			accum += block.fn();
		}
		return accum;
	});

	var bno = ${board.bno};
	//var bno = ${board.bno};
	var replyPage = 1;

	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		});
	}

	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};

	$("#repliesDiv").on("click", function() {

		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/replies/" + bno + "/1");

	});

	$(".pagination").on("click", "li a", function(event) {

		event.preventDefault();

		replyPage = $(this).attr("href");

		getPage("/replies/" + bno + "/" + replyPage);

	});

	$("#replyAddBtn").on("click", function() {

		var replyerObj = $("#newReplyWriter");
		var replytextObj = $("#newReplyText");
		var replyer = replyerObj.val();
		var replytext = replytextObj.val();

		$.ajax({
			type : 'post',
			url : '/replies/',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("Insert Complete!");
					replyPage = 1;
					getPage("/replies/" + bno + "/" + replyPage);
					replyerObj.val("");
					replytextObj.val("");
				}
			}
		});
	});

	$(".timeline").on("click", ".replyLi", function(event) {

		var reply = $(this);

		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));

	});

	$("#replyModBtn").on("click", function() {

		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'put',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({
				replytext : replytext
			}),
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("Modify Complete!");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	});

	$("#replyDelBtn").on("click", function() {

		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("Delete Complete!");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	});
</script>

<script>
	$(document).ready(function() {

		var formObj = $("form[role='form']");

		console.log(formObj);

		$("#modifyBtn").on("click", function() {
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});

		$("#removeBtn").on("click", function() {

			var replyCnt = $("#replycntSmall").html().replace(/[^0-9]/g, "");

			if (replyCnt > 0) {
				alert("can not delete board with reply");
				return;
			}

			var arr = [];
			$(".uploadedList li").each(function(index) {
				arr.push($(this).attr("data-src"));
			});

			if (arr.length > 0) {
				$.post("/deleteAllFiles", {
					files : arr
				}, function() {

				});
			}

			formObj.attr("action", "/admin/boardRemove");
			formObj.submit();
		});

		$("#goListBtn ").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/admin/boardList");
			formObj.submit();
		});

	});
</script>

<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>

<script>
	var bno = ${board.bno};
	//var bno = ${board.bno};
	var template = Handlebars.compile($("#templateAttach").html());

	$.getJSON("/sboard/getAttach/" + bno, function(list) {
		$(list).each(function() {

			var fileInfo = getFileInfo(this);

			var html = template(fileInfo);

			$(".uploadedList").append(html);

		});
	});

	$(".uploadedList").on("click", ".mailbox-attachment-info a",
			function(event) {

				var fileLink = $(this).attr("href");

				if (checkImageType(fileLink)) {

					event.preventDefault();

					var imgTag = $("#popup_img");
					imgTag.attr("src", fileLink);

					console.log(imgTag.attr("src"));

					$(".popup").show('slow');
					imgTag.addClass("show");
				}
			});

	$("#popup_img").on("click", function() {

		$(".popup").hide('slow');

	});
</script>