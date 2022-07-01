$(function() {
    "use strict";
    // for better performance - to avoid searching in DOM
    var content = $("#chatbox");
    var input = $("#message");
    var lang;
    var to = -1;
    var timeout = 500;
    var typing_time;
    var t = 0;
    var staff_avatar;
    var customer_avatar;
    var new_message = 0;
    var color;
    var current_author;
    // my name sent to the server
    var myName = false;
    var connection;
    // if user is running mozilla then use it"s built-in WebSocket
    window.WebSocket = window.WebSocket || window.MozWebSocket;
    // if browser doesn"t support WebSocket, just show
    // some notification and exit
    var dict;

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

    function generateAvatar(name) {
        var matches = removeVietnameseTones(name).match(/\b(\w)/g).slice(-2);
        var acronym = matches.join('').toUpperCase();
        return `<div class="avatar" style="background-color:${generateDarkColorHex()}">${acronym}</div>`;
    }

    function generateDarkColorHex() {
        let color = "#";
        for (let i = 0; i < 3; i++)
          color += ("0" + Math.floor(Math.random() * Math.pow(16, 2) / 2).toString(16)).slice(-2);
        return color;
    }

    $.notify.defaults({globalPosition: 'top left'});

    function init(){
        myName = getCookie("name");
        if (myName == null) {
            $("#input_info").show();
            $("#chat").hide();
            $("#myname").empty();
        } else connect();
    }
    
    $.getJSON("language.json", function(json) {
        dict = json;
    });
    // open connection
    
    function connect() {
        connection = new WebSocket("ws://172.16.90.133:1337");
        connection.onopen = function() {
            //first we want users to enter their names
            myName = getCookie("name");
            to = getCookie("to");
            color = getCookie("color");          
            let json = JSON.stringify({
                name: myName,
                email: getCookie("email"),
                tel: "",
                address: "",
                company: "",
                note: ""
            });
            connection.send("cfrom: " + json);
            connection.send("cto: " + to);
            $("#end_chat").css('display','flex');
            $("#input_info").hide();
            $("#chat").show();
            $("#myname").text(myName);
            $("#staff_info").text(to);

            staff_avatar = generateAvatar(to);
            $("#staff_avatar").html(staff_avatar);
            customer_avatar = generateAvatar(myName);

            if(to=='Chatbot') {
                input.hide();
                $("#staff_avatar").hide();
                $("#bot-avatar").show();
            }
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
                        if(i == 0 || current_author!=json.data[i].author) {
                            addMessageAvatar(json.data[i].author, json.data[i].text, new Date(json.data[i].time));
                            current_author = json.data[i].author;
                        }
                        else
                            addMessage(json.data[i].author, json.data[i].text, new Date(json.data[i].time));
                    break;
                case "message":
                    input.removeAttr("disabled").trigger("focus");
                    
                    if (json.data.author == to){
                        if(current_author!=json.data.author) {
                            addMessageAvatar(json.data.author, json.data.text, new Date(json.data.time));
                            current_author = json.data.author;
                        }
                        else addMessage(json.data.author, json.data.text, new Date(json.data.time));
                    }

                    if ($("#contentbox").css("display")=="none" || json.data.author != to || $("#body").css("display")=="none"){
                        $.notify("Nhận được tin nhắn mới từ " + json.data.author,"info");
                    }

                    if($("#body").css("display")=="none"){
                        new_message += 1;
                        if (new_message>99) $("#new_message").text("99+");
                        else $("#new_message").text(new_message);
                        $("#new_message").show();
                    }

                    break;
                case "end_chat":
                    alert("Xin chào tạm biệt quý khách!");
                    setCookie("name", "");
                    setCookie("to", "");
                    location.reload();
                    break;
                case "typing":
                    if (json.data == to) {
                        $("#typing").show()
                        typing_time = 2;
                    }
                    break;
                case "get_staff":
                    to = json.data;
                    setCookie("to", to);
                    connection.send("cto: " + to);
                    $("#staff_info").text(to);
                    
                    staff_avatar = generateAvatar(to);
                    $("#staff_avatar").html(staff_avatar);

                    $("#staff_avatar").show();
                    $("#bot-avatar").hide();

                    setCookie("color",color);
                    input.show();
                    break;
                default:
                    console.log("Hmm..., I\"ve never seen JSON like this:", json);
                    break;
            }
        };

        connection.onclose = function() {
            setTimeout(function() {
                connect();
            }, 2500);
        };
    }

    function getCookie(cname) {
        var cookieArr = document.cookie.split(";");
        for (var i = 0; i < cookieArr.length; i++) {
            var cookiePair = cookieArr[i].split("=");
            if (cname == cookiePair[0].trim() && cookiePair[1] != "") {
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
            }
            else
                addMessage(obj.author, obj.text, new Date(obj.time));
            connection.send(msg);
            return false;
        }
    });

    $('#chatbox').on("keydown","input",function(e) {
        if (e.key === "Enter") {
            var msg = $(this).val();
            if (!msg) {
                return;
            }
            var obj = {
                time: (new Date()).getTime(),
                text: msg,
                author: myName,
            };
            addMessage(obj.author, obj.text, new Date(obj.time));
            connection.send(msg);
            $(this).val("");
            $('#form').remove();
            t = 0;
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
        var email = $("#email").val();
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

        if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))) {
            $("#email").addClass("error-input");
            alert("Email không hợp lệ");
            return true;
        }

        return false;
    }

    $("#end_chat").on("click",function() {
        if (confirm("Bạn có chắc chắn muốn kết thúc cuộc trò chuyện") == true) {
            connection.send("end_chat");
        } 
    });

    $("#message").on("input", function(e) {
        if (myName != false && to != -1) {
            connection.send("typing");
        }
        t = 0;
    })

    $("input, textarea").each(function() {
        $(this).focusin(function() {
            $(this).removeClass("error-input");
            $(this).addClass("change-input");
        });
        $(this).focusout(function() {
            $(this).removeClass("change-input");
        });
    });

    $("#open_chat_box").on("click",function() {
        $("#contentbox").slideToggle("fast");
        $("#up_down").toggleClass("fa-arrow-down");
    });

    $("#up_down").on("click",function() {
        content.scrollTop(content[0].scrollHeight);
        $("#contentbox").slideToggle("fast");
        $("#up_down").toggleClass("fa-arrow-down");
    });

    $("#volume").on("click",function() {
        $("#volume").attr("src", $("#volume").attr("src") == "https://p7.hiclipart.com/preview/554/784/884/computer-icons-sound-icon-volume.jpg" ? "https://www.kindpng.com/picc/m/287-2877466_mute-icon-png-transparent-png.png" : "https://p7.hiclipart.com/preview/554/784/884/computer-icons-sound-icon-volume.jpg");
    });

    $("#change_language").on("change",function() {
        lang = $("#change_language").val();
        $(".lang").each(function() {
            var id = $(this).attr("id");
            console.log(id);
            var tagname = $(this).prop("tagName").toLowerCase();
            if (tagname != "input") $(this).text(dict[id][lang]);
            else $(this).attr("placeholder", dict[id][lang]);
        });
        $("#change_language option:first").prepend("&#xf0ac; ");
    });

    $("#start_chat").on("click",function() {
        if (check_valid()) return;
        setCookie("name", $("#fullname").val());
        to = "Chatbot";
        setCookie("to", to);
        setCookie("email", $("#email").val());
        connect();
    });

    $('#chatbox').on('click', 'button', function() {
        var msg = $(this).text();
        var obj = {
            time: (new Date()).getTime(),
            text: msg,
            author: myName,
        };
        addMessageAvatar(obj.author, obj.text, new Date(obj.time));
        current_author = myName;
        connection.send(msg);
        $('#form').remove();
    });

    $('#chatbox').on('click', 'a', function() {
        var msg = $(this).text();
        var obj = {
            time: (new Date()).getTime(),
            text: msg,
            author: myName,
        };
        addMessageAvatar(obj.author, obj.text, new Date(obj.time));
        current_author = myName;
        connection.send(msg);
        $('#form').remove();
    });

    $('#chatbox').on('click', 'img', function() {
        var src = $(this).attr('src');
        $.fancybox.open({
            src  : src
        });
    });

    $(document).on("mousemove",function(event) {
        t = 0;
    });

    $("#chatbox").on('focusout','input',function(event){
        $(this).removeClass('change-input');
    });

    $("#chatbox").on('focusin','input',function(event){
        $(this).addClass('change-input');
    });

    // setInterval(function() { // Chat timeout
    //     if (getCookie("name") != null) t += 1;

    //     if (t == timeout) {
    //         connection.send("end_chat");
    //         t = 0;
    //     } else if (t == timeout - 10) {
    //         $.notify("Nếu quý khách không còn gì trao đổi thì cuộc chat sẽ kết thúc sau 10s nữa","warn");
    //     }
    // }, 1000);

    setInterval(function() { // typing timeout
        if (typing_time == 0) $("#typing").hide();
        else typing_time = typing_time - 1;
    }, 250);

    $("#icon_chat_container").on("click",function(){
        new_message = 0;
        $("#icon_chat_container").hide();
        $("#new_message").hide();
        $("#body").show();
    });

    $("#close").on("click",function(){
        $("#to").val("Chọn khách hàng");
        $("#contentbox").hide();
        $("#up_down").removeClass("fa-arrow-down");
        $("#icon_chat_container").show();
        $("#body").hide();
    });

    init();
});