var index;
var SA;
var connection;

function drawTable(){
    $("#tableSA tbody").empty();
    for(const [index, value] of SA.entries()){
        let table_row = `
        <tr>
            <td>${value['keyword']}</td>
            <td>${value['answer']}</td>
            <td id="${index}" class="edit">
                <script src="https://cdn.lordicon.com/xdjxvujz.js"></script>
                <lord-icon
                    src="https://cdn.lordicon.com/puvaffet.json"
                    trigger="hover"
                    colors="primary:#fff,secondary:#fff"
                    style="width:35px;height:35px">
                </lord-icon>
            </td>
            <td id="${index}" class="remove">
                <script src="https://cdn.lordicon.com/xdjxvujz.js"></script>
                <lord-icon
                    src="https://cdn.lordicon.com/gsqxdxog.json"
                    trigger="hover"
                    colors="primary:#fff,secondary:#fff"
                    style="width:35px;height:35px">
                </lord-icon>
            </td>
        </tr>`;
        $("#tableSA tbody").append(table_row);
    }
}

function getSA(){
    $.ajax({
        url: "getSA.php",
        type: "get",
        success:function(data){
            SA = JSON.parse(data);
            drawTable();
        }
    });
}

function removeVietnameseTones(str) {
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    str = str.replace(/À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ/g, "A");
    str = str.replace(/È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ/g, "E");
    str = str.replace(/Ì|Í|Ị|Ỉ|Ĩ/g, "I");
    str = str.replace(/Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ/g, "O");
    str = str.replace(/Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ/g, "U");
    str = str.replace(/Ỳ|Ý|Ỵ|Ỷ|Ỹ/g, "Y");
    str = str.replace(/Đ/g, "D");
    // Some system encode vietnamese combining accent as individual utf-8 characters
    str = str.replace(/\u0300|\u0301|\u0303|\u0309|\u0323/g, ""); // ̀ ́ ̃ ̉ ̣  huyền, sắc, ngã, hỏi, nặng
    str = str.replace(/\u02C6|\u0306|\u031B/g, ""); // ˆ ̆ ̛  Â, Ê, Ă, Ơ, Ư
    // Remove extra spaces
    str = str.replace(/ + /g, " ");
    str = str.trim();
    // Remove punctuations
    str = str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\"|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g, " ");
    return str;
}

function normalize(str) {
    return removeVietnameseTones(str).toLowerCase();
}

function findSA(msg) {
    var check= true;
    $("#tableSA tbody > *").hide();
    msg = normalize(msg);
    console.log(msg);
    for(const [index, value] of SA.entries()){
        if(msg.includes(value['keyword'])) {
            $("#SA ul").append(`<li>${value['answer']}</li>`);
            $('table tbody tr').eq(index).show();
            check = false;
        }
    }
    if(check) $("#SA ul").append(`<li>Không tìm thấy gợi ý trả lời</li>`);
}

$(document).on("ready",function(){ 
    function connect() {
        connection = new WebSocket("ws://172.16.90.133:1337");

        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 2500);
        };
    }

    $(document).on('click', '.remove', function () {
        let index = parseInt($(this).attr("id"));
        if (confirm(`Bạn có chắc chắn muốn xóa gợi ý trả lời này`) == true) {
            $.ajax({
                url: "deleteSA.php",
                type: "post",
                dataType: 'html',
                data: {
                    id: SA[index]['id'],
                },
                success:function(data) {
                    if(data=="success") $.notify("Xóa thành công","success");
                    else $.notify("Xóa thất bại");
                    getSA();
                    connection.send("update_SA");
                }
            });
        } 
    });

    $(document).on('click', '.edit', function () {
        index = parseInt($(this).attr("id"));
        $("#edit_keyword").val(SA[index]['keyword']);
        $("#edit_answer").val(SA[index]['answer']);
        $.fancybox.open({
            src  : '#editSA',
            type : 'inline',
            opts : {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $(".btn-cancel").on("click",function(){
        $.fancybox.close();
    });
    
    $("#addSA .btn-save").on("click",function(){
        let add_keyword = $('#add_keyword').val();
        let add_answer = $('#add_answer').val();
    
        if(add_keyword=="") {
            $('#add_keyword').notify("Từ khóa không thể để trống");
            return;
        }

        if(add_answer=="") {
            $('#add_answer').notify("Câu trả lời không thể để trống");
            return;
        }

        $.fancybox.close();

        $.ajax({
            url: "insertSA.php",
            type: "post",
            data: {
            keyword: add_keyword,
            answer: add_answer
            },
            success:function(data){
                console.log(data);
                if(data=="success") $.notify("Thêm thành công","success");
                else $.notify("Thêm thất bại");
                getSA();
                connection.send("update_SA");
            }
        });

        $('#add_keyword').val("");
        $('#add_answer').val("");
    });

    $("#editSA .btn-save").on("click",function(){
        let edit_keyword = $('#edit_keyword').val();
        let edit_answer = $('#edit_answer').val();
    
        if(edit_keyword=="") {
            $('#edit_keyword').notify("Từ khóa không thể để trống");
            return;
        }

        if(edit_answer=="") {
            $('#edit_answer').notify("Câu trả lời không thể để trống");
            return;
        }

        $.fancybox.close();

        $.ajax({
            url: "updateSA.php",
            type: "post",
            data: {
            id: SA[index]['id'],
            keyword: edit_keyword,
            answer: edit_answer
            },
            success:function(data){
                if(data=="success") $.notify("Chỉnh sửa thành công","success");
                else $.notify("Chỉnh sửa thất bại");
                getSA();
                connection.send("update_SA");
            }
        });
    });

    $("#addSA_button").on("click",function(){
        $("#edit_keyword").val("");
        $("#edit_answer").val("");
        $.fancybox.open({
            src  : '#addSA',
            type : 'inline',
            opts : {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#search").on('input',function(){
        s = $('#search').val();
        $("table tbody > *").hide();
        for(const [index, value] of SA.entries()){
            s = normalize(s);
            if(value['keyword'].includes(s)) {
                $('table tbody tr').eq(index).show();
            }
        }
    });

    $("#testSA_button").on("click",function(){
        if($("#testSA").css("display") != "none") {
            $("#tableSA tbody > *").show();
        }
        $("#test").val("");
        $("#testSA").toggle();
        $("#SA ul").empty();
        $("#SA").hide();
    });

    $("#send_button").on("click",function(){
        $("#SA ul").empty();
        $("#SA").show();
        var msg = $("#test").val();
        findSA(msg);
    });
    
    getSA();
    connect();
});