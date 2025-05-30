/**
*	비동기식으로 처리하기 위한 ajax
*/

// 댓글 쓰기를 위한 ajax add함수

function add(reply, callback, error){
	console.log("reply........");
	
	// ajax를 이용해서 비동식으로 ReplyController 를 실행
	$.ajax({
		type:"post",
		url:"/replies/new",
		data:JSON.stringify(reply),
		contentType:"application/json;charset=UTF-8",
		success:function(result){
			if(callback) callback(result);
		},
		error:function(){
		
		}		
	})
}

// 댓글 목록 리스트를 위한 ajax list함수

function list(param, callback){
	// type이 get일 때만 사용할 수 있는 축약형
	$.getJSON("/replies/pages/"+param.bno+".json",function(data){
		console.log("댓글 목록 데이터 : " , data)
	
		if(callback){
			callback(data)
		}	

	})
}

// 댓글 수정을 위한 ajax update함수 선언
function update(reply, callback){
	$.ajax({
		type:"put",
		url:"/replies/" + reply.rno,
		data:JSON.stringify(reply),
		contentType:"application/json;charset=UTF-8",
		success:function(result){
			if(callback) callback(result);
		},
		error:function(){
		}
		
	})

}
// 댓글 삭제를 위한 ajax delete 함수 선언
function remove(rno, callback){
	$.ajax({
		type:'delete',
		url: "/replies/" + rno,
		success: function(result){
			if(callback) callback(result);
		},
		error: function(){
		}

	})
}





















