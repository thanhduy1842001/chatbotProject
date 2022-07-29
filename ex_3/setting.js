var setting;

$(document).on("ready", function() {

    function connect() {
        connection = new WebSocket("ws://localhost:1337");

        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 2500);
        };
    }

    function drawTable(table,attr) {
        $(table + " tbody").empty();
        for (i = 0; i < setting[attr].length; i++) {
            let table_row = `
            <tr>
                <td>${i+1}</td>
                <td>${setting[attr][i]}</td>
                <td id="${i}" class="remove">
                <script src="https://cdn.lordicon.com/xdjxvujz.js"></script>
                <lord-icon
                    src="https://cdn.lordicon.com/gsqxdxog.json"
                    trigger="hover"
                    colors="primary:#fff,secondary:#fff"
                    style="width:35px;height:35px">
                </lord-icon>
            </td>
            </tr>`;
            $(table + " tbody").append(table_row);
        }
    }

    function checkEmail(selector) {
        var email = $(selector).val();

        if (!(/^[a-z0-9]+(?!.*(?:\+{2,}|\-{2,}|\.{2,}))(?:[\.+\-]{0,1}[a-z0-9])*@gmail\.com$/.test(email))) {
            $(selector).notify("Email không hợp lệ")
            return true;
        }
    
        return false;
    }

    $.ajax({
        url: "getSetting.php",
        type: "get",
        success: function(data) {
            setting = JSON.parse(data)[0];
            setting["email_receive"] =  JSON.parse(setting["email_receive"]);
            setting["keyword"] =  JSON.parse(setting["keyword"]);
            drawTable("#table_receive","email_receive");
            drawTable("#table_keyword","keyword");
        }
    });

    $("#update_timeout").on("click", function() {
        $("#timeout").val(setting['timeout']);
        $.fancybox.open({
            src: '#update_timeout_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $(".btn-cancel").on("click", function() {
        $.fancybox.close();
    });

    $("#send").on("click", function() {
        $("#email_send").val(setting['email_send']);
        $("#password").val(setting['password']);
        $.fancybox.open({
            src: '#update_send_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#receive").on("click", function() {
        $("#keyword_table").hide();
        $("#receive_table").show();
    });

    $("#keyword").on("click", function() {
        $("#receive_table").hide();
        $("#keyword_table").show();
    });

    $("#receive_table").on("click", ".add", function() {
        $("#email_receive").val("");
        $.fancybox.open({
            src: '#update_receive_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#keyword_table").on("click", ".add", function() {
        $("#new_keyword").val("");
        $.fancybox.open({
            src: '#update_keyword_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#update_timeout_form").on("click", ".btn-save", function() {
        var t = $("#timeout").val();
        if(t<=0) {
            $("#timeout").notify("Thời gian phải lớn hơn 0");
            return;
        } 
        setting['timeout'] = t;
        $.ajax({
            url: "updateSetting.php",
            type: "post",
            data: {
                query: `timeout = ${setting['timeout']}`
            },
            success: function(data) {
                if (data == "success") $.notify("Cập nhật thành công", "success");
                else $.notify("Cập nhật thất bại");
                $.fancybox.close();
                connection.send("update_setting");
            }
        });
    });

    $("#update_send_form").on("click", ".btn-save", function() {
        if(checkEmail("#email_send")) return;
        setting['email_send'] = $("#email_send").val();
        setting['password'] = $("#password").val()
        $.ajax({
            url: "updateSetting.php",
            type: "post",
            data: {
                query: `email_send = '${setting['email_send']}', password = '${setting['password']}'`
            },
            success: function(data) {
                if (data == "success") $.notify("Cập nhật thành công", "success");
                else $.notify("Cập nhật thất bại");
                $.fancybox.close();
                connection.send("update_setting");
            }
        });
    });

    $("#update_keyword_form").on("click", ".btn-save", function() {
        setting['keyword'].push($("#new_keyword").val());
        $.ajax({
            url: "updateSetting.php",
            type: "post",
            data: {
                query: `keyword = '${JSON.stringify(setting['keyword'])}'`
            },
            success: function(data) {
                if (data == "success") $.notify("Cập nhật thành công", "success");
                else $.notify("Cập nhật thất bại");
                drawTable("#table_keyword","keyword");
                $.fancybox.close();
                connection.send("update_setting");
            }
        });
    });

    $("#update_receive_form").on("click", ".btn-save", function() {
        if(checkEmail("#email_receive")) return;
        setting['email_receive'].push($("#email_receive").val());
        $.ajax({
            url: "updateSetting.php",
            type: "post",
            data: {
                query: `email_receive = '${JSON.stringify(setting['email_receive'])}'`
            },
            success: function(data) {
                if (data == "success") $.notify("Cập nhật thành công", "success");
                else $.notify("Cập nhật thất bại");
                drawTable("#table_receive","email_receive");
                $.fancybox.close();
                connection.send("update_setting");
            }
        });
    });

    $("#table_receive").on("click", ".remove", function(){
        var id = parseInt($(this).attr("id"));
        if (confirm(`Bạn có chắc chắn muốn xóa gợi ý trả lời này`) == true) {
            setting['email_receive'].splice(id,1);
            $.ajax({
                url: "updateSetting.php",
                type: "post",
                data: {
                    query: `email_receive = '${JSON.stringify(setting['email_receive'])}'`
                },
                success: function(data) {
                    if (data == "success") $.notify("Xóa thành công", "success");
                    else $.notify("Xóa thất bại");
                }
            });
            drawTable("#table_receive","email_receive");
        }
    });

    $("#table_keyword").on("click", ".remove", function(){
        var id = parseInt($(this).attr("id"));
        if (confirm(`Bạn có chắc chắn muốn xóa gợi ý trả lời này`) == true) {
            setting['keyword'].splice(id,1);
            $.ajax({
                url: "updateSetting.php",
                type: "post",
                data: {
                    query: `keyword = '${JSON.stringify(setting['keyword'])}'`
                },
                success: function(data) {
                    if (data == "success") $.notify("Xóa thành công", "success");
                    else $.notify("Xóa thất bại");
                }
            });
            drawTable("#table_keyword","keyword");
        }
    });

    connect();
});