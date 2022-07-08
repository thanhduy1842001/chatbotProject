var connection;
var scenario = {};
var id = false;

function get_options(data)
{
    scenario[data['scenario_id']] = data;
    options = "<option value=" + data['scenario_id'] + ">" + data['title'] + "</option>";
    if(data['children'].length) {
        for(let row of data['children']) options+=get_options(row);
    }
    return options;
}

function getdata(){
    $.ajax({
        url: 'get_data.php',
        success: function(data) {
            $('#chart_container').empty();
            var jsonObj = JSON.parse(data);
            var oc = $('#chart_container').orgchart(
                {
                    'data' : jsonObj,
                    'nodeId': 'scenario_id',
                    'nodeTitle': 'title',
                    'nodeContent': 'content',
                    'direction': 'l2r',
                }
            );
            options = get_options(jsonObj);
            $('.id').each(function(){
                $(this).find('option').not(':first').remove();
                $(this).append(options);
            });
        }
    });
}

$(document).on("ready",function(){

    $("#select_box .guide").on("click",function(){
        $.notify("Click vào 1 nhánh trên cây kịch bản để xem thông tin và chỉnh sửa",{
            className: "info",
            autoHideDelay: 5000,
        });
    });

    function connect() {
        connection = new WebSocket("ws://172.16.90.133:1337");

        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 2500);
        };
    }

    $("#add").on("click",function(){
        if(!id) {
            $.notify("Xin hãy chọn 1 nhánh trên cây kịch bản trước khi thực hiện thao tác");
            return;
        }
        $('#insert_form')[0].reset();
        $("#insert_form #next_jump").hide();
        $.fancybox.open({
            src  : '#insert_form',
            type : 'inline',
            opts : {
            }
        });
    });

    $('#update').on('click', function(){
        if(!id) {
            $.notify("Xin hãy chọn 1 trong các nhánh trước khi thực hiện thao tác");
            return;
        }
        $.ajax({
            url: "update.php",
            type: "post",
            data: {
                scenario_id: id,
                title: $("#update_form #title").val(),
                content: $("#update_form #content").val(),
                type_id: $("#update_form #type_id").val(),
                url: $("#update_form #url").val(),
                image: $("#update_form #image").val(),
                action: $("#update_form #action").val(),
                next_jump: $("#update_form #next_jump").val(),
            },
            beforeSend:function(){
                $('#submit3').attr('disabled',true),
                $('#submit3').text('Đang xử lí ...');
            },
            success:function(data){
                id = false;
                if(data == "success") $.notify("Sửa kịch bản thành công","success");
                else $.notify("Sửa kịch bản thất bại");
                $("#message").html(data);
                $('#update_form')[0].reset();
                $("#features").hide();
                $('#update').removeAttr("disabled");
                $('#update').html('<i class="fa fa-pencil"></i> Thay đổi nhánh');
                getdata();
                connection.send('update_script');
            }
        });
    });

    $("#remove").on("click",function(){
        if(!id) {
            $.notify("Xin hãy chọn 1 nhánh trên cây kịch bản trước khi thực hiện thao tác");
            return;
        }

        if(scenario[id]['parent_id'] == -1) {
            $.notify("Không thể xóa nhánh gốc");
            return;
        }

        if (confirm(`Bạn có chắc chắn muốn xóa nhánh này`) == true){
            $.ajax({
                url: "delete.php",
                type: "post",
                data: {'scenario_id': id},
                beforeSend:function(){
                    $("#remove").attr('disabled',true),
                    $("#remove").text('Đang xử lí ...');
                },
                success:function(data){
                    id = false;
                    if(data=="success") $.notify("Xóa kịch bản thành công","success");
                    else $.notify("Xóa kịch bản thất bại");
                    $('#update_form')[0].reset();
                    $("#features").hide();
                    $("#remove").removeAttr("disabled");
                    $("#remove").html('<i class="fa fa-trash"></i> Xóa nhánh');
                    getdata();
                    connection.send('update_script');
                }
            });
        }
    });

    $("#chart_container").on("click",".node",function(){
        id = $(this).attr("id");
        attr = ["title","content","type_id","url","image","action","next_jump"];

        for(let i of attr){
            $("#update_form #" + i).val(scenario[id][i]).change();
        }

        $("#features").show();
    });

    $("#insert_form").on("submit",function(event){
        $.fancybox.close();
        event.preventDefault();
        $.ajax({
            url: "insert.php",
            type: "post",
            data: {
                title: $("#insert_form #title").val(),
                content: $("#insert_form #content").val(),
                type_id: $("#insert_form #type_id").val(),
                url: $("#insert_form #url").val(),
                image: $("#insert_form #image").val(),
                action: $("#insert_form #action").val(),
                next_jump: $("#insert_form #next_jump").val(),
                parent_id: id
            },
            beforeSend:function(){
                $('#add').attr('disabled',true),
                $('#add').text('Đang xử lí ...');
            },
            success:function(data){
                console.log(data);
                id = false;
                if(data=="success") $.notify("Thêm kịch bản thành công","success");
                else $.notify("Thêm kịch bản thất bại");
                $('#update_form')[0].reset();
                $("#features").hide();
                $('#add').removeAttr("disabled");
                $('#add').html('<i class="fa fa-plus-circle"></i> Thêm nhánh con');
                getdata();
                connection.send('update_script');
            }
        });
    });

    $("#insert_form #action").on("change",function(){
        action = $("#insert_form #action").val();
        console.log(action);
        if(action == "jump") {
            $("#insert_form #next_jump").show();
            $("#insert_form #next_jump option:first").attr("value", "");
            $("#insert_form #next_jump option:first").attr("disabled", 'disabled');
        }
        else {
            $("#insert_form #next_jump").hide();
            $("#insert_form #next_jump option:first").attr("value", 0);
            $("#insert_form #next_jump option:first").removeAttr("disabled");
            $("#insert_form #next_jump").val(0);
        }
    });

    $("#update_form #action").on("change",function(){
        action = $("#update_form #action").val();
        console.log(action);
        if(action == "jump") {
            $("#update_form #next_jump").show();
            $("#update_form #next_jump option:first").attr("value", "");
            $("#update_form #next_jump option:first").attr("disabled", 'disabled');
        }
        else {
            $("#update_form #next_jump").hide();
            $("#update_form #next_jump option:first").attr("value", 0);
            $("#update_form #next_jump option:first").removeAttr("disabled");
            $("#update_form #next_jump").val(0);
        }
    });

    getdata();
    connect();
});