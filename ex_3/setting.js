var setting;

$(document).on("ready", function() {

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

    $("#update_timeout_form .btn-save").on("click", function() {
        setting['timeout'] = $("#timeout").val();
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
            }
        });
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

    $("#update_send_form .btn-save").on("click", function() {
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
            }
        });


        $.fancybox.close();
    });

    $("#receive").on("click", function() {
        $("#email_receive").val("");
        $("#keyword_table").hide();
        $("#receive_table").show();
    });

    $("#keyword").on("click", function() {
        $("#new_keyword").val("");
        $("#receive_table").hide();
        $("#keyword_table").show();
    });

    $("#receive_table .add").on("click", function() {
        $.fancybox.open({
            src: '#update_receive_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#keyword_table .add").on("click", function() {
        $.fancybox.open({
            src: '#update_keyword_form',
            type: 'inline',
            opts: {
                'buttons': false,
                'smallBtn': false
            }
        });
    });

    $("#update_keyword_form .btn-save").on("click", function() {
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
            }
        });
        drawTable("#table_keyword","keyword");
        $.fancybox.close();
    });

    $("#update_receive_form .btn-save").on("click", function() {
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
            }
        });
        drawTable("#table_receive","email_receive");
        $.fancybox.close();
    });
});