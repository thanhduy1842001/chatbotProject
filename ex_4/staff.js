$(function() {
    "use strict";
    // for better performance - to avoid searching in DOM
    var content = $("#chatbox");
    var input = $("#message");
    var to;
    var typing_time;
    var customer;
    var color;
    var current_author;
    // my name sent to the server
    var myName = false;
    var lang = "vi";
    var connection;
    // if user is running mozilla then use it"s built-in WebSocket
    window.WebSocket = window.WebSocket || window.MozWebSocket;
    // if browser doesn"t support WebSocket, just show
    // some notification and exit
    var dict;
    var answers;
    var staff_avatar;
    var customer_avatar;

    $.notify.defaults({globalPosition: 'top left'});

    function generateDarkColorHex() {
    let color = "#";
    for (let i = 0; i < 3; i++)
        color += ("0" + Math.floor(Math.random() * Math.pow(16, 2) / 2).toString(16)).slice(-2);
    return color;
    }

    $.ajax({ // get answers
    url: "getAnswers.php",
    type: "get",
    success:function(data){
        answers = JSON.parse(data);
    }
    });

    function init() {
        $.get('language.json', function(data) {
            dict = data;
            customer = getCookie("customer");
            if (customer != null) {
                customer = JSON.parse(customer);
                customer = new Set(customer);
                $("#to").empty();
                $("#to").append("<option class='lang' id ='customer' selected disabled>" + dict["customer"][lang] + "</option>");
                for (let i of customer) $("#to").append("<option>" + i + "</option>");
            } else customer = new Set();
            myName = getCookie("name");
            if (myName != null) {
                connect();
                $("#up_down").hide();
                $("#myname").text(myName);
            } else {
                $("#input_info").show();
                $("#up_down").show();
                $("#chat").hide();
            }
        }, 'json');
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

    $.notify.addStyle('suggestbox', {
    html:
    `<div>
        <img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QYFAhkSsdes/QAAA8dJREFUOMvVlGtMW2UYx//POaWHXg6lLaW0ypAtw1UCgbniNOLcVOLmAjHZolOYlxmTGXVZdAnRfXQm+7SoU4mXaOaiZsEpC9FkiQs6Z6bdCnNYruM6KNBw6YWewzl9z+sHImEWv+vz7XmT95f/+3/+7wP814v+efDOV3/SoX3lHAA+6ODeUFfMfjOWMADgdk+eEKz0pF7aQdMAcOKLLjrcVMVX3xdWN29/GhYP7SvnP0cWfS8caSkfHZsPE9Fgnt02JNutQ0QYHB2dDz9/pKX8QjjuO9xUxd/66HdxTeCHZ3rojQObGQBcuNjfplkD3b19Y/6MrimSaKgSMmpGU5WevmE/swa6Oy73tQHA0Rdr2Mmv/6A1n9w9suQ7097Z9lM4FlTgTDrzZTu4StXVfpiI48rVcUDM5cmEksrFnHxfpTtU/3BFQzCQF/2bYVoNbH7zmItbSoMj40JSzmMyX5qDvriA7QdrIIpA+3cdsMpu0nXI8cV0MtKXCPZev+gCEM1S2NHPvWfP/hL+7FSr3+0p5RBEyhEN5JCKYr8XnASMT0xBNyzQGQeI8fjsGD39RMPk7se2bd5ZtTyoFYXftF6y37gx7NeUtJJOTFlAHDZLDuILU3j3+H5oOrD3yWbIztugaAzgnBKJuBLpGfQrS8wO4FZgV+c1IxaLgWVU0tMLEETCos4xMzEIv9cJXQcyagIwigDGwJgOAtHAwAhisQUjy0ORGERiELgG4iakkzo4MYAxcM5hAMi1WWG1yYCJIcMUaBkVRLdGeSU2995TLWzcUAzONJ7J6FBVBYIggMzmFbvdBV44Corg8vjhzC+EJEl8U1kJtgYrhCzgc/vvTwXKSib1paRFVRVORDAJAsw5FuTaJEhWM2SHB3mOAlhkNxwuLzeJsGwqWzf5TFNdKgtY5qHp6ZFf67Y/sAVadCaVY5YACDDb3Oi4NIjLnWMw2QthCBIsVhsUTU9tvXsjeq9+X1d75/KEs4LNOfcdf/+HthMnvwxOD0wmHaXr7ZItn2wuH2SnBzbZAbPJwpPx+VQuzcm7dgRCB57a1uBzUDRL4bfnI0RE0eaXd9W89mpjqHZnUI5Hh2l2dkZZUhOqpi2qSmpOmZ64Tuu9qlz/SEXo6MEHa3wOip46F1n7633eekV8ds8Wxjn37Wl63VVa+ej5oeEZ/82ZBETJjpJ1Rbij2D3Z/1trXUvLsblCK0XfOx0SX2kMsn9dX+d+7Kf6h8o4AIykuffjT8L20LU+w4AZd5VvEPY+XpWqLV327HR7DzXuDnD8r+ovkBehJ8i+y8YAAAAASUVORK5CYII='>
        <span class='title' data-notify-html='title'/></span>
        <div class='buttons' data-notify-html='buttons'>
    </div>`
    });

    function checkKeyword(mess) {
        let cnt = 0;
        var html = "";
        mess = removeVietnameseTones(mess).toLowerCase();
        for(let i of answers){
            if(mess.includes(i['keyword'])) {
                html += `<button>${i['answer']}</button>`;
                cnt++;
            }
        }

        if(cnt!=0){
            $.notify({
                title: `Phát hiện ${cnt} gợi ý trả lời`,
                buttons: html,
            }, { 
                style: 'suggestbox',
                autoHide: false,
                clickToHide: false
            });
        }
    }

    function generateAvatar(name) {
    var matches = removeVietnameseTones(name).match(/\b(\w)/g).slice(-2);
    var acronym = matches.join('').toUpperCase();
    return `<div class="avatar" style="background-color:${generateDarkColorHex()}">${acronym}</div>`;
    }

    // open connection
    function connect() {
        connection = new WebSocket("ws://172.16.90.133:1337");
        connection.onopen = function() {
            //first we want users to enter their names
            myName = getCookie("name");
            customer_avatar = generateAvatar(myName);

            connection.send("sfrom: " + myName);
            $("#input_info").hide();
        };

        // most important part - incoming messages
        connection.onmessage = function(message) {
            // try to parse JSON message. Because we know that the server
            // always returns JSON this should work without any problem but
            // we should make sure that the massage is not chunked or
            // otherwise damaged.
            try {
                var json = JSON.parse(message.data);
            } catch (e) {
                console.log("Invalid JSON: ", message.data);
                return;
            }
            // NOTE: if you"re not sure about the JSON structure
            // check the server source code above

            switch (json.type) {
                case "history":
                    content.empty();
                    for (var i = 0; i < json.data.length; i++)
                    if(current_author == "" || current_author!=json.data[i].author) {
                        addMessageAvatar(json.data[i].author, json.data[i].text, new Date(json.data[i].time));
                        current_author = json.data[i].author;
                    }
                    else
                        addMessage(json.data[i].author, json.data[i].text, new Date(json.data[i].time));
                    break;
                case "message":
                    input.removeAttr("disabled").trigger("focus");
                    if (json.data.author == to) {
                    if(current_author != json.data.author) {
                        addMessageAvatar(json.data.author, json.data.text, new Date(json.data.time));
                        current_author = json.data.author;
                    }
                    else
                        addMessage(json.data.author, json.data.text, new Date(json.data.time));
                    checkKeyword(json.data.text);
                    }
                    if ($("#contentbox").css("display")=="none" || json.data.author != to)
                    $.notify("Nhận được tin nhắn mới từ " + json.data.author,"info");
                    break;
                case "req":
                    $.notify("Có yêu cầu hỗ trợ mới từ " + json.data,"info");
                    customer.add(json.data);
                    setCookie("customer", JSON.stringify(Array.from(customer)));
                    $("#to").empty();
                    $("#to").append("<option class='lang' id ='customer' selected disabled>" + dict["customer"][lang] + "</option>");
                    for (let i of customer) $("#to").append("<option>" + i + "</option>");
                    break;
                case "typing":
                    if (json.data == to) {
                        typing_time = 2;
                        $("#typing").show();
                    }
                    break;
                case "end_chat":
                    $.notify("Khách hàng " + json.data + " đã kết thúc cuộc trò chuyện!", "info");
                    if (json.data == to) {
                        setCookie("to", "");
                        $('#chat').hide();
                        $('#up_down').trigger('click');
                        $("#up_down").hide();
                    }
                    customer.delete(json.data);
                    setCookie("customer", JSON.stringify(Array.from(customer)));
                    $("#to").empty();
                    $("#to").append("<option class='lang' id ='customer'>" + dict["customer"][lang] + "</option>");
                    for (let i of customer) $("#to").append("<option>" + i + "</option>");
                    break;
                default:
                    console.log("Hmm..., I\"ve never seen JSON like this:", json);
                    break;
            }
        };

        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 1000);
        };

        connection.onerror = function() {
        // setCookie("name", "");
        // setCookie("to", "");
        // setCookie("color", "");
        // location.reload();
        };
    }

    function getCookie(cname) {
        var cookieArr = document.cookie.split(";");
        for (var i = 0; i < cookieArr.length; i++) {
            var cookiePair = cookieArr[i].split("=");
            if (cname == cookiePair[0].trim() && cookiePair[1] != "" && cookiePair[1] != "{}") {
                return decodeURIComponent(cookiePair[1]);
            }
        }
        return null;
    }

    function setCookie(cname, cval) {
        document.cookie = cname + "=" + cval + "; path=/;";
    }

    //Send message when user presses Enter key
    input.on("keydown",function(e) {
        if (e.key === "Enter" && !e.shiftKey) {
        var msg = input.val();
        input.val("").on("focus");
        if (!msg.trim()) {
            return false;
        }

        var obj = {
            time: (new Date()).getTime(),
            text: msg,
            author: myName,
        };

        if(current_author!=obj.author) {
            addMessageAvatar(obj.author, obj.text, new Date(obj.time));
            current_author = obj.author;
        } else addMessage(obj.author, obj.text, new Date(obj.time));

            // send the message as an ordinary text
            connection.send(msg);
            return false;
        }
    });

    //Add message to the chat window
    function addMessageAvatar(author, message, dt) {
    var avatar;
    if(author == "Chatbot") avatar = `<img src="https://livechat.pavietnam.vn/images/conong.png" class="avatar">`;
    else avatar = staff_avatar;
    var content = $('#chatbox');

    var time = (dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours()) + ":" +
            (dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes());

    if(author != myName){
        content.append(`
        <div class="row_customer">
            ${avatar}
            <div class="chat-customer-message left" style="margin-top:20px;">
                <b> ${author}</b>
                <div style="white-space: pre-line;">${message}</div>
                <div class="time">
                    <i class="fa fa-clock-o" style="padding:3px"></i>
                    ${time}
                </div>
            </div>
        </div>`
        );
    } else {
        content.append(`
        <div class="row-staff">
            <div class="chat-staff-message right" style="margin-top:20px;">
                <b> ${author}</b>
                <div style="white-space: pre-line;">${message}</div>
                <div class="time">
                    <i class="fa fa-clock-o" style="padding:3px"></i>
                    ${time}
                </div>
            </div>
            ${customer_avatar}
        </div>`
        );
    }

    content.scrollTop(content[0].scrollHeight);
    }

    function addMessage(author, message, dt) {
    var content = $('#chatbox');

    var time = (dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours()) + ":" +
            (dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes());

    if(author != myName){
        content.append(`
        <div class="row_customer">
            <div class="chat-customer-message" style="margin-left:55px">
                <b> ${author}</b>
                <div style="white-space: pre-line;">${message}</div>
                <div class="time">
                    <i class="fa fa-clock-o" style="padding:3px"></i>
                    ${time}
                </div>
            </div>
        </div>`
        );
    } else {
        content.append(`
        <div class="row-staff">
            <div class="chat-staff-message" style="margin-right:55px">
                <b> ${author}</b>
                <div style="white-space: pre-line;">${message}</div>
                <div class="time">
                    <i class="fa fa-clock-o" style="padding:3px"></i>
                    ${time}
                </div>
            </div>
        </div>`
        );
    }
    content.scrollTop(content[0].scrollHeight);
    }

    function check_valid() {
    var check = false;
    var name = $("#fullname").val();
    var to = $("#to").val();
    if (/\d/.test(name)) {
        $("#fullname").addClass("error-input");
        $.notify("Họ và tên không được chứa số", "error");
        return true;
    }
    if (name.length == 0) {
        $("#fullname").addClass("error-input");
        $.notify("Họ và tên không được để trống", "error");
        return true;
    }

    return false;
    }

    $("#end_chat").on("click", function() {
        connection.send("end_chat");
    });

    $("#message").on("input", function(e) {
        if (myName != false && to != -1) {
            connection.send("typing");
        }
    })

    $("input, textarea").each(function() {
        $(this).on("focusin",function() {
            $(this).removeClass("error-input");
            $(this).addClass("change-input");
        });
        $(this).on("focusout",function() {
            $(this).removeClass("change-input");
        });
    });

    $("#open_chat_box").on("click",function() {
        $("#contentbox").slideToggle("fast");
        $("#up_down").toggleClass("fa-arrow-down");
    });

    $("#up_down").on("click",function() {
        $("#contentbox").slideToggle("fast");
        $("#up_down").toggleClass("fa-arrow-down");
        content.scrollTop(content[0].scrollHeight);
    });

    $("#change_language").on("change",function() {
        lang = $("#change_language").val();
        $(".lang").each(function() {
            var id = $(this).attr("id");
            var tagname = $(this).prop("tagName").toLowerCase();
            if (tagname != "input") $(this).text(dict[id][lang]);
            else $(this).attr("placeholder", dict[id][lang]);
        });
    });

    $("#sign_in").on("click",function() {
        if (check_valid()) return;
        let name = $("#fullname").val();
        setCookie("name", name);
        $("#myname").text(name);
        $('#up_down').trigger('click');
        $("#up_down").hide();
        $.notify("Đăng nhập thành công","success");
        connect();
    });

    $("#suggest").on("change",function() {
    var mess = $("#suggest option:selected").text();
    $("#message").val(mess);
    $("#suggest").val("default");
    });

    $("#to").on("change",function() {
        to = $("#to option:selected").text();
        setCookie("to", to);
        connection.send("sto: " + to);
        $("#wait_room").hide();
        $("#chat").show();
        $("#up_down").show();
        $("#staff_info").text(to);
        if($("#contentbox").css("display")=="none") $('#up_down').trigger("click");
        staff_avatar = generateAvatar(to);
        $("#customer_avatar").html(staff_avatar);
        setCookie("color",color);
        current_author="";
    });

    $(document).on('click', '.notifyjs-suggestbox-base button', function() {
    var msg = $(this).text();
    input.val(msg);
    input.trigger('focus');
    $(this).trigger('notify-hide');
    });


    $("#icon_chat_container").on("click",function(){
        $("#icon_chat_container").hide();
        $("#body").show();
    });

    $("#close").on("click",function(){
        $("#icon_chat_container").show();
        $("#body").hide();
    });

    setInterval(function() {
        if (typing_time == 0) $("#typing").hide();
        else typing_time = typing_time - 1;
    }, 250);

    init();
});
