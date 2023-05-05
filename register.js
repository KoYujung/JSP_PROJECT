$(function() {
    var flag = 0;
    $(".password img").click(function() {
        if (flag == 0){
            $(".password .inp").attr("type","text");
            $(this).attr("src","images/open.png");
            flag = 1;
        } else {
            $(".password .inp").attr("type","password");
            $(this).attr("src","images/close.png");
            flag = 0;
        }
    });
    $(".repassword img").click(function() {
        if (flag == 0){
            $(".repassword .inp").attr("type","text");
            $(this).attr("src","images/open.png");
            flag = 1;
        } else {
            $(".repassword .inp").attr("type","password");
            $(this).attr("src","images/close.png");
            flag = 0;
        }
    });

    $(".reg_form #tel").blur(function() {
        if ($(this).val().length == 0) {
            $(this).siblings("span").attr("class","hint");
            $(this).siblings("span").children("i").attr("class","hint_icon");
            $(this).siblings("span").children("em").text("请휴대폰 번호 11자리를 입력하세요!");
        } else {
            if ($(this).val().length != 11) {
                $(this).siblings("span").attr("class","error");
                $(this).siblings("span").children("i").attr("class","error_icon");
                $(this).siblings("span").children("em").text("휴대폰 번호 형식이 잘못되었습니다! 다시 입력하십시오!");
            } else {
                $(this).siblings("span").attr("class","success");
                $(this).siblings("span").children("i").attr("class","success_icon");
                $(this).siblings("span").children("em").text("휴대폰 번호 형식이 정확합니다!");
            }
        }
    });

    $(".reg_form #psw").blur(function() {
        if ($(this).val().length == 0) {
            $(this).siblings("span").attr("class","hint");
            $(this).siblings("span").children("i").attr("class","hint_icon");
            $(this).siblings("span").children("em").text("비밀번호 6~16자리를 입력하세요!");
        } else {
            if ($(this).val().length < 6 || $(this).val().length > 16) {
                $(this).siblings("span").attr("class","error");
                $(this).siblings("span").children("i").attr("class","error_icon");
                $(this).siblings("span").children("em").text("비밀번호 형식이 잘못되었습니다! 다시 입력하십시오!");
            } else {
                $(this).siblings("span").attr("class","success");
                $(this).siblings("span").children("i").attr("class","success_icon");
                $(this).siblings("span").children("em").text("비밀번호 형식이 정확합니다!");
            }
        }
    });

    $(".reg_form #repsw").blur(function() {
        if ($(this).val().length == 0) {
            $(this).siblings("span").attr("class","hint");
            $(this).siblings("span").children("i").attr("class","hint_icon");
            $(this).siblings("span").children("em").text("비밀번호를 다시 입력해 주세요!");
        } else {
            if ($(this).val() != $(".reg_form #psw").val()) {
                $(this).siblings("span").attr("class","error");
                $(this).siblings("span").children("i").attr("class","error_icon");
                $(this).siblings("span").children("em").text("비밀번호가 앞뒤가 맞지 않으니 다시 입력하세요!");
            } else {
                $(this).siblings("span").attr("class","success");
                $(this).siblings("span").children("i").attr("class","success_icon");
                $(this).siblings("span").children("em").text("비밀번호 확인 완료했습니다!");
            }
        }
    });

    $("form").submit(function() {
        if ($("#tel").val() == '') {
            alert("휴대폰 번호는 비워둘 수 없습니다!");
        } else if ($("#code").val() == '') {
            alert("문자 메시지 인증 번호는 비워둘 수 없습니다!");
        } else if ($("#psw").val() == '') {
            alert("비밀번호는 비워둘 수 없습니다!");
        } else if ($("#repsw").val() == '') {
            alert("비밀번호 확인은 비워둘 수 없습니다!");
        } else if (!$(".agree input[type='checkbox']").prop("checked")){
            alert("먼저 《중고문고 등록약정과 프라이버시 정책》 협의에 동의하십시오.");
        } else {
            alert("회원가입 완료되었습니다!");
            $("form").attr("action","login.html");
        } 
    });
});