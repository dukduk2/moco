$(function(){	
	$(".update").click(function(){
		var value1 = ($(this).attr('class')).split(' ')[0]+"select";
		var value2 = ($(this).attr('class')).split(' ')[1]+"select";

		var selectId = $(this).attr("id");		
		var selectJoinState = $("."+value2).val();
		var selectGrade = $("."+value1).val();
		
		/* alert(" selectGrade(value1) : "+value1+"\n selectGrade : "+selectGrade+"\n selectGrade(value2) : "+value2+"\n selectJoinState : "+selectJoinstate); */
		
		$.post("managementUpdate", {
			id: selectId,
			joinState : selectJoinState,
			grade : selectGrade
		}, function(data) {
			$("#result").html(data);
		})
	})

	$(".delete").click(function(){
		var selectId = $(this).attr("id");
		
		$.post("managementDelete", {
			id: selectId
		}, function(data) {
			$("#result").html(data);
		})
	})
	
	$("#back").click(function(){
		location.href="javascript:history.back()";
	})
	
	$("#refreash").click(function(){
		location.href="javascript:location.reload()";
	})
	
	$("#home").click(function(){
		location.href="../";
	});
	
	$(".go").click(function(){
		var curPage=$(this).attr("id"); 
		location.href="./memberList?curPage="+curPage+"&kind=${kind}&search=${search}";
	});
	
	//js 파일로 하려면  함수를 불러들이는 걸 만들라??
});