var connection;
var scenario = {};
var id = false;
var form_changed;

function get_options(data) {
    scenario[data['scenario_id']] = data;
    options = "<option value=" + data['scenario_id'] + ">" + data['title'] + "</option>";
    if (data['children'].length) {
        for (let row of data['children']) options += get_options(row);
    }
    return options;
}

function getdata() {
    $.ajax({
        url: 'get_data.php',
        success: function(data) {
            $('#chart_container').empty();
            var jsonObj = JSON.parse(data);
            var oc = $('#chart_container').orgchart({
                'data': jsonObj,
                'nodeId': 'scenario_id',
                'nodeTitle': 'title',
                'nodeContent': 'content',
                'direction': 'l2r',
            });
            options = get_options(jsonObj);
            $('.id').each(function() {
                $(this).find('option').not(':first').remove();
                $(this).append(options);
            });
        }
    });
}

function checkValid(selector) {
    if(!id) {
        $.notify("Xin hãy chọn 1 nhánh trên cây kịch bản trước khi thực hiện thao tác");
        return true;
    }

    if($(selector + " #title").val().trim().length==0) {
        $(selector + " #title").notify("Tên nhánh không để trống!");
        return true;
    }

    if($(selector + " #content").val().trim().length==0) {
        $(selector + " #content").notify("Nội dung trả lời không để trống!");
        return true;
    }

    if(!$(selector + " #type_id").val()) {
        $(selector + " #type_id").notify("Hãy chọn 1 sự kiện!");
        return true;
    }

    if(!$(selector + " #action").val()) {
        $(selector + " #action").notify("Hãy chọn 1 hành động!");
        return true;
    }

    if($(selector + " #action").val() == "jump" && !$(selector + " #next_jump").val()) {
        $(selector + " #next_jump").notify("Hãy chọn nhánh kế tiếp!");
        return true;
    }

    if(!!$(selector + " #url").val() && !(/(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/.test($(selector + " #url").val()))) {
        $(selector + " #url").notify("Liên kết web không hợp lệ!");
        return true;
    }

    if(!!$(selector + " #image").val() && !(/(http[s]?:\/\/.*\.(?:png|jpg|gif|svg|jpeg))/i.test($(selector + " #image").val()))) {
        $(selector + " #image").notify("Liên kết hình ảnh không hợp lệ!");
        return true;
    }

    return false;
}

$(document).on("ready", function() {

    $("#select_box .guide").on("click", function() {
        $.notify("Click vào 1 nhánh trên cây kịch bản để xem thông tin và chỉnh sửa", "info");
    });

    function connect() {
        // connection = new WebSocket("ws://172.16.90.133:1337");
        connection = new WebSocket("ws://localhost:1337");
        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 2500);
        };
    }

    $("#add").on("click", function() {
        if (!id) {
            $.notify("Xin hãy chọn 1 nhánh trên cây kịch bản trước khi thực hiện thao tác");
            return;
        }
        $('#insert_form')[0].reset();
        $('#insert_form select').removeClass("selected");
        $("#insert_form #next_jump").hide();
        $.fancybox.open({
            src: '#insert_form',
            type: 'inline',
            opts: {}
        });
    });

    $('#update').on('click', function() {
        if (!form_changed) {
            $.notify("Thông tin nhánh chưa có sự thay dổi!");
            return;
        }

        if (checkValid("#update_form")) return;
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
            beforeSend: function() {
                $('#submit3').attr('disabled', true),
                $('#submit3').text('Đang xử lí ...');
            },
            success: function(data) {
                console.log(data);
                id = false;
                if (data == "success") $.notify("Thay đổi nhánh thành công", "success");
                else $.notify("Thay đổi nhánh thất bại");
                $("#message").html(data);
                $('#update_form')[0].reset();
                $('#update_form select').removeClass("selected");
                $("#features").hide();
                $('#update').removeAttr("disabled");
                $('#update').html('<i class="fa fa-pencil"></i> Thay đổi nhánh');
                getdata();
                connection.send('update_script');
            }
        });
    });

    $("#remove").on("click", function() {
        if (!id) {
            $.notify("Xin hãy chọn 1 nhánh trên cây kịch bản trước khi thực hiện thao tác");
            return;
        }

        if (scenario[id]['parent_id'] == -1) {
            $.notify("Không thể xóa nhánh gốc");
            return;
        }

        if (confirm(`Bạn có chắc chắn muốn xóa nhánh này và tất cả nhánh con của nó (nếu có).`)) {
            $.ajax({
                url: "delete.php",
                type: "post",
                data: {
                    'scenario_id': id
                },
                beforeSend: function() {
                    $("#remove").attr('disabled', true),
                        $("#remove").text('Đang xử lí ...');
                },
                success: function(data) {
                    id = false;
                    if (data == "success") $.notify("Xóa nhánh thành công", "success");
                    else $.notify("Xóa nhánh thất bại");
                    $('#update_form')[0].reset();
                    $('#update_form select').removeClass("selected");
                    $("#features").hide();
                    $("#remove").removeAttr("disabled");
                    $("#remove").html('<i class="fa fa-trash"></i> Xóa nhánh');
                    getdata();
                    connection.send('update_script');
                }
            });
        }
    });

    $("#chart_container").on("click", ".node", function() {
        if(form_changed && !confirm("Bạn chưa lưu lại thay đổi trên nhánh hiện tại, bạn có chắc chắn muốn chuyển nhánh không?")) {
            return;
        }

        id = $(this).attr("id");
        attr = ["title", "content", "type_id", "url", "image", "action", "next_jump"];

        for (let i of attr) {
            $("#update_form #" + i).val(scenario[id][i]).change();
        }

        $("#features").show();
        form_changed = false;
    });

    $("#submit").on("click", function() {
        if(checkValid("#insert_form")) return;
        $.fancybox.close();
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
            beforeSend: function() {
                $('#add').attr('disabled', true),
                    $('#add').text('Đang xử lí ...');
            },
            success: function(data) {
                console.log(data);
                id = false;
                if (data == "success") $.notify("Thêm nhánh thành công", "success");
                else $.notify("Thêm nhánh thất bại");
                $('#update_form')[0].reset();
                $('#update_form select').removeClass("selected");
                $("#features").hide();
                $('#add').removeAttr("disabled");
                $('#add').html('<i class="fa fa-plus-circle"></i> Thêm nhánh con');
                getdata();
                connection.send('update_script');
            }
        });
    });

    $("#insert_form #action").on("change", function() {
        action = $("#insert_form #action").val();
        if (action == "jump") {
            $("#insert_form #next_jump").removeClass("selected").show();
            $("#insert_form #next_jump option:first").attr("value", "");
            $("#insert_form #next_jump option:first").attr("disabled", 'disabled');
        } else {
            $("#insert_form #next_jump").hide();
            $("#insert_form #next_jump option:first").attr("value", 0);
            $("#insert_form #next_jump option:first").removeAttr("disabled");
            $("#insert_form #next_jump").val(0);
        }
    });

    $("#update_form #action").on("change", function() {
        action = $("#update_form #action").val();
        if (action == "jump") {
            $("#update_form #next_jump").removeClass("selected").show();
            $("#update_form #next_jump option:first").attr("value", "");
            $("#update_form #next_jump option:first").attr("disabled", 'disabled');
        } else {
            $("#update_form #next_jump").hide();
            $("#update_form #next_jump option:first").attr("value", 0);
            $("#update_form #next_jump option:first").removeAttr("disabled");
            $("#update_form #next_jump").val(0);
        }
    });

    $("form select").on("change",function(){
        $(this).addClass("selected");
    });

    $('form').on('input change paste', 'input, select, textarea', function(){
        form_changed = true;
    });

    getdata();
    connect();
});