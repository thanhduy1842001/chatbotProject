var connection;

function connect(){
    connection = new WebSocket("ws://172.16.90.133:1337");

    connection.onopen = function() {
        connection.send("admin");
    };

    connection.onmessage = function(message) {
        getHistory();
    };

    connection.onclose = function() {
        setTimeout(function() {
            connect();
        }, 2500);
    };
}

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
var customer;
var staff;
var date;
var history = {};
var matches;
var id;
var acronym;
var randomColor;
var staff_avatar;
var customer_avatar;

$("#chatbox").hide();
connect();

function normalize(str) {
    return removeVietnameseTones(str).toLowerCase();
}

function generateDarkColorHex() {
    let color = "#";
    for (let i = 0; i < 3; i++)
      color += ("0" + Math.floor(Math.random() * Math.pow(16, 2) / 2).toString(16)).slice(-2);
    return color;
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

function generateAvatar(name,id,color){
    matches = removeVietnameseTones(name).match(/\b(\w)/g).slice(-2);
    acronym = matches.join('').toUpperCase();
    $(id).text(acronym);
    $(id).css('background-color',color);
}

function addMessageAvatar(author, message, dt, i , pos) {
    var content = $('#chatbox');

    var time = (dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours()) + ":" +
            (dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes());
    
    if(author == customer){
        content.append(`
        <div class="row_customer">
            <div class="avatar customer-avatar"></div>
            <div class="chat-customer-message left"  style="margin-top:20px;">
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
        let avatar;
        if(author == staff) avatar = `<div class="avatar staff-avatar"></div>`;
        else avatar = `<img src="https://livechat.pavietnam.vn/images/conong.png" class="avatar" id="bot-avatar">`;
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
            ${avatar}
        </div>`
        );
    }

    // if(i==pos || pos==-1) content.scrollTop(content[0].scrollHeight);
}

function addMessage(author, message, dt, i , pos) {
    var content = $('#chatbox');

    var time = (dt.getHours() < 10 ? "0" + dt.getHours() : dt.getHours()) + ":" +
            (dt.getMinutes() < 10 ? "0" + dt.getMinutes() : dt.getMinutes());
    
    if(author == customer){
        content.append(`
        <div class="row_customer" style="margin-left:45px">
            <div class="chat-customer-message">
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
        <div class="row-staff" style="margin-right:45px">
            <div class="chat-staff-message">
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

    // if(i==pos || pos==-1) content.scrollTop(content[0].scrollHeight);
}

function display(){
    var pos = urlParams.has('pos') ? parseInt(urlParams.get('pos')) : -1;
    customer = history[id]['customer']['name'];
    staff = history[id]['staff'];

    $('#chatbox').empty();
    for(let [i, message] of history[id]['json'].entries()){
        if(i==0 || message.author!=history[id]['json'][i-1].author)
        addMessageAvatar(message.author,message.text,new Date(message.time),i,pos);
        else
        addMessage(message.author,message.text,new Date(message.time),i,pos);
    }
    $('#chatbox').append("<div style='margin-bottom:5px'><div>");
    $('#chatbox').scrollTop($('#chatbox')[0].scrollHeight);

    let customer_email = history[id]['customer']['email'];
    let customer_tel = history[id]['customer']['tel'];
    let customer_address = history[id]['customer']['address'];
    let customer_company = history[id]['customer']['company'];
    let customer_note = history[id]['customer']['note'];

    if(staff!="") {
        $("#staff-name").text(staff);
        generateAvatar(staff,".staff-avatar",generateDarkColorHex());
    }else{
        $("#staff-name").text("Chatbot");
        $(".staff-avatar").html(`<img src="https://livechat.pavietnam.vn/images/conong.png" class="avatar" id="bot-avatar">`);
    }

    $("#customer-name").text(customer);
    generateAvatar(customer,".customer-avatar", $("#"+id+" .avatar").css('background-color'));

    if(customer_email!="") $("#customer-email").text(customer_email);
    else $("#customer-email").text("Chưa có dữ liệu");
    $("#customer_email").val(customer_email);

    if(customer_tel!="") $("#customer-tel").text(customer_tel);
    else $("#customer-tel").text("Chưa có dữ liệu");
    $("#customer_tel").val(customer_tel);

    if(customer_address!="") $("#customer-address").text(customer_address);
    else $("#customer-address").text("Chưa có dữ liệu");
    $("#customer_address").val(customer_address);

    if(customer_company!="") $("#customer-company").text(customer_company);
    else $("#customer-company").text("Chưa có dữ liệu");
    $("#customer_company").val(customer_company);

    if(customer_note!="") $("#customer-note").text(customer_note);
    else $("#customer-note").text("Chưa có dữ liệu");
    $("#customer_note").val(customer_note);
}

function getHistory() {
    $.ajax({
        url: "getChat.php",
        type: "get",
        success:function(data){
            $('#select').empty();
            var obj = JSON.parse(data);
            for(let i of obj){
                randomColor = generateDarkColorHex();
                history[i['id']] = i;
                history[i['id']]['json'] = JSON.parse(i['json']);
                history[i['id']]['customer'] = JSON.parse(i['customer']);
                matches = removeVietnameseTones(history[i['id']]['customer']['name']).match(/\b(\w)/g).slice(-2);
                acronym = matches.join('').toUpperCase();
                date = i['date'].slice(0,-3);
                var html = `
                    <div class="row-select" id="${i['id']}">
                        <div class="avatar" style="background-color:${randomColor};">${acronym}</div>
                        <span>
                            <div style="display:flex">
                                <div class="customer-name">${history[i['id']]['customer']['name']}</div>
                                <div class= "date">${date}</div>
                            </div>
                            <div class="last-mess">${history[i['id']]['json'].slice(-1)[0]['text']}</div>
                        </span>
                    </div>
                `;
                $('#select').append(html);
            }

            if(urlParams.has('id')){
                const id = urlParams.get('id');
                $("#" + id).trigger('click');
            }
        }
    });
}

$("#select").on('click','.row-select',function(){

    $(".row-select").each(function(){
        $(this).removeClass("on-select");
    });

    id = $(this).attr("id");
    $(this).addClass("on-select");
    $("#chat_info").show();
    $("#chatbox").show();
    display();
});

$("#search").on('input',function(){
    s = $('#search').val();
    $("#select > *:not('b')").hide();
    var keys = Object.keys(history).reverse();
    for(let i of keys){
        s = normalize(s);
        customer = normalize(history[i]['customer']['name']);
        staff = normalize(history[i]['staff']);
        if(customer.includes(s) || staff.includes(s)) $("#" + history[i]['id']).show();
    }
});

$("#update-info").on('click',function(){
    $.fancybox.open({
        src  : '#edit_customer_info',
        type : 'inline',
        opts : {
            'buttons': false,
	        'smallBtn': false,
        }
    });
});

$(".btn-cancel").on("click",function(){
    $.fancybox.close();
});

$(".btn-save").on("click",function(){
    $.fancybox.close();
    let customer_email = $('#customer_email').val();
    let customer_tel = $('#customer_tel').val();
    let customer_address = $('#customer_address').val();
    let customer_company = $('#customer_company').val();
    let customer_note = $('#customer_note').val();

    if(customer_email!="") {
        $("#customer-email").text(customer_email);
        history[id]['customer']['email'] = customer_email;
    }

    if(customer_tel!="") {
        $("#customer-tel").text(customer_tel);
        history[id]['customer']['tel'] = customer_tel;
    }

    if(customer_address!="") {
        $("#customer-address").text(customer_address);
        history[id]['customer']['address'] = customer_address;
    }

    if(customer_company!="") {
        $("#customer-company").text(customer_company);
        history[id]['customer']['company'] = customer_company;
    }

    if(customer_note!="") {
        $("#customer-note").text(customer_note);
        history[id]['customer']['note'] = customer_note;
    }

    $.ajax({
        url: "updateCustomerInfo.php",
        type: "post",
        data: {
            Customer : JSON.stringify(history[id]["customer"]),
            Id : id
        },
        success:function(data) {
            if(data=="success") $.notify("Cập nhật thành công","success");
            else $.notify("Cập nhật thất bại");
        }
    });
});

$("a").each(function() {
   if( $(this).attr('href') == window.location.href) 
   $(this).addClass('on-select');
});

getHistory();

