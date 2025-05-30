<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h3>상세 내용 보기</h3>
	<table border="1">
		<tr>
			<td>제목</td>
			<td>${board.title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${board.content}</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="/board/modify?bno=${board.bno}">[수정]</a>
				<a href="/board/remove?bno=${board.bno}">[삭제]</a>
			</td>
		</tr>
	</table>

	<div>
		<input type="text" id="bno" name="bno" value="${board.bno}">
		<input type="text" id="replyer" name="replyer" value="홍길동">
	</div>
	<div><textarea id="reply" name="reply" cols="80" rows="10"></textarea></div>
	
	<div class="uploadResult">
		<ul>
			
		</ul>
	</div>
	
	
	
	
	<input type="button" id="RegisterBtn" value="댓글작성">
	<div>
		<ul id="replyView">
			
		</ul>
	</div>
	
	
	
	<script src="/resources/js/reply.js"></script>
	<script>
		$(document).ready(function(){
			
			// 댓글 관련
			let bno = 0;
			let reply = "";
			let replyer = "";
			
			showList();
			
			function showList(){
				
				list({bno : $("#bno").val()},function(data){
					
					console.log(data)
					let str=""
					
					for(let i = 0; i < data.length; i++){
						str += "<li class='left clearfix' data-rno='" + data[i].rno + "'>";
						str += "	<div><div class='header'><strong class='primary-font'>["
							+ data[i].rno + "] " + data[i].replyer + "</strong>";
						str += "	</div><textarea readonly>" + data[i].reply + "</textarea>"
						str += "<button class='ModBtn' data-rno='" + data[i].rno + "'>수정</button>"
						str += "<button class='RemoveBtn' data-rno='" + data[i].rno + "'>삭제</button>"
						str += "</div></li>";
						
					}
					
					$("#replyView").html(str)
				})	
			}
			
			
			

			// 댓글 작성 버튼을 선택한 후 클릭 이벤트 연결
			$("#RegisterBtn").on("click",function(){
				let replyvo = {
						
					reply : $("#reply").val(),		// reply 값 가져오기
				
					replyer : $("#replyer").val(),	// replyer 값 가져오기
				
					bno : $("#bno").val()			// bno 값 가져오기
				}	
				
				console.log(replyvo);
				add(replyvo, function(){
					showList();
				});
				
			})
		
		// 댓글 수정버튼을 선택한 후 클릭이벤트 연결
		$("#replyView").on("click",".ModBtn", function(){
			
			let $btn = $(this);
			let $textarea = $btn.siblings("textarea");	// 댓글 내용 (textarea 선택)
			let rno = $(this).data("rno");				// 댓글 번호
			
			if($btn.text() == "수정"){
				
				// 수정 버튼을 누르면 readonly 를 지워서 편집 가능하게 해라
				$textarea.removeAttr("readonly").focus();
				$btn.text("저장")		// 수정 -> 저장
				
			}// 저장 버튼을 누르면 update 작업 실시
			else if($btn.text() == "저장"){	
				// 댓글 내용
				let updateReply = $textarea.val();
				// 댓글 번호
				update({rno:rno, reply:updateReply},	// 댓글 수정한 후
				function(){								// 후속 처리
					
					$btn.text("수정")		// 저장 -> 수정
					$textarea.attr("readonly",true)		// readonly 를 활성화
					
					showList();
				})
			}
			
			
			
			
			
			//console.log($(this).data("rno"))
			
		})
	
						// 댓글 삭제 버튼을 선택한 후 클릭 이벤트 연결
		$('#replyView').on("click",".RemoveBtn", function(){
				
			// 댓글 번호
			let $btn = $(this);
			// 댓글 번호
			let rno = $(this).data("rno");
			
			console.log(rno)
					
					
			remove(rno, function(data){		// 후속처리
				showList();
						
			})
		})
		
		// 첨부파일 관련
		
		bno = $("#bno").val();
		
		console.log(bno);
		
		var str =""
			
		$.getJSON("/board/getAttachList", {bno:bno},function(arr){
			
			console.log(arr);
			
			$(arr).each(function(i, obj){	// 파일 업로드를 하게되면
				// ul 테그 안에 li 로 나타나게 만드는 작업
				
				console.log(obj)

				if(!obj.fileType){	// 첨부 파일이 이미지가 아님
					
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					str += "<li><a href='/download?fileName=" + fileCallPath +"'>[다운로드]" + obj.fileName + "</a></li>"
				}
				else{		// 첨부 파일이 이미지 파일임
				//str += "<li>" + obj.fileName + "</li>"
			
			
					// 파일 이름에 한글이 들어가면 깨지는 현상을 막아줌
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);	// 썸네일 파일 경로
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;	//원본 이미지 파일 경로
					originPath = originPath.replace(new RegExp(/\\/g),"/")
					
					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName="+fileCallPath+"'></a></li>";
				}
			
			});			
			$(".uploadResult ul").append(str);
			
			
			
		})
		
		
})
	
		

	</script>
</body>
</html>