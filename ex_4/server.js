process.title = "node-chat";
var webSocketsServerPort = 1337;
var fs = require("fs");

// Connect to database
var mysql = require("mysql");
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "chatbot"
});
con.connect();

var script;

function updateScript() {
    con.query("SELECT scenario_id, content, type_id, url, image, next_jump, parent_id FROM scenario", function(err, result, fields) {
        if (err) throw err;
        script = result;
    });
    console.log((new Date()) + " Script was updated");
}

updateScript();

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

// Connect to email
var nodemailer = require("nodemailer");
var transporter = nodemailer.createTransport({
    service: "yahoo",
    auth: {
        user: "duynguyen1842001@yahoo.com",
        pass: "tkskszlprorucsmi"
    }
});

var mailOptions = {
    from: "duynguyen1842001@yahoo.com",
    to: "thanhduynguyen1842001@gmail.com",
    subject: "",
    text: ""
};


// Global variable
var admin = null;
var history = {};
var clients = {};
var staff = new Set();

var WebSocketServer = require("websocket").server;
var http = require("http");
const {
    chdir,
    send
} = require("process");

const {
    client
} = require("websocket");
const { Script } = require("vm");

var server = http.createServer(function(request, response) {});

server.listen(webSocketsServerPort, function() {
    console.log((new Date()) + " Server is listening on port " + webSocketsServerPort);
});

wsServer = new WebSocketServer({
    httpServer: server
});

wsServer.on("request", function(request) {
    function botMessage(message) {
        obj = {
            time: (new Date()).getTime(),
            text: message,
            author: to,
        };
        json = JSON.stringify({
            type: "message",
            data: obj
        });
        clients[from].sendUTF(json);
    }

    function sendEmail(id) {
        var pos;
        var key_word = ["mua dien thoai", "mua tv", "mua may lanh"];
        var check = false;
        for (let i = 0; i < history[historyName].length; i++) {
            var message = history[historyName][i].text;
            message = removeVietnameseTones(message).toLowerCase();
            for (let w of key_word) {
                if (message.includes(w)) {
                    mailOptions.subject = "Notification ";
                    mailOptions.subject += "of chat have id: " + id.toString();
                    mailOptions.text = "Demo content:\n";
                    for (let cnt = 0;
                        (cnt < 3) && (i < history[historyName].length); cnt++, i++) {
                        mailOptions.text += history[historyName][i].author + ": " + history[historyName][i].text + "\n";
                        pos = i;
                    }
                    mailOptions.text += "Link to chat history: " + "http://localhost/chatbotProject/ex_5/?id=" + id + "&pos=" + pos.toString();
                    transporter.sendMail(mailOptions, function(error, info) {
                        if (error) console.log(error);
                        else console.log("Email sent: " + info.response);
                    });
                }
            }
        }
        if (historyName != "Chatbot - " + from) delete history[historyName];
        delete history["Chatbot - " + from];
    }

    function reply(message) {
        var check = true;
        var html = '';
        for (let i of script) {
            if (i['content'] == message) {
                preId = i['scenario_id'];
                
                html = message + '<br><span id="form">';
                for (let j of script) {
                    if (j['parent_id'] == i['scenario_id'] || j['scenario_id'] == i['next_jump']) {
                        switch(j['type_id']) {
                            case 1: //text
                                html += `<li>${j['content']}</li>`;
                                break;
                            case 2: // button
                                if(j['url'] == "") html += `<button class="button">${j['content']}</button>`;
                                else html += `<a class="button" href="${j['url']}" target="_blank">${j['content']}</a>`;
                                break;
                            case 3: //staff
                                html += `<button class="button">${j['content']}</button>`;
                                break;
                        }

                        if(j['image']!="") {
                            html += `<img src="${j['image']}" class="product_image">`
                        }
                        
                        check = false;
                    }
                }
                html += '<input type="text" id="dif" placeholder="Khác"></span>';
                if(check) html = "Yêu cầu của quý khách đã được ghi nhận";
                return html;
            }
        }
        return "Yêu cầu của quý khách đã được ghi nhận" + '<br><span id="form"><button class="button">Gặp nhân viên tư vấn</button></span>';
    }

    function addHistory(mess, auth){
        var obj = {
            time: (new Date()).getTime(),
            text: mess,
            author: auth,
        };
        history[historyName].push(obj);
        history[historyName] = history[historyName].slice(-100);
        return obj;
    }

    function end_chat_process(){
        var json = JSON.stringify(history[historyName]);
        var s = (to != "Chatbot")?to:"";
        var sql = "INSERT INTO history (staff,customer,json) VALUES ?";
        var values = [
            [s,JSON.stringify(customer),json]
        ];
        con.query(sql, [values], function(err, result) {
            if (err) throw err;
            console.log((new Date()) + " Insert successfully");
            sendEmail(result.insertId);
        });

        clients[from].sendUTF(JSON.stringify({
            type: "end_chat"
        }));

        if (to != "Chatbot") {
            clients[to].sendUTF(JSON.stringify({
                type: "end_chat",
                data: from
            }));
        }

        if(admin) admin.send("new_chat");
    }

    var connection = request.accept(null, request.origin);
    var customer = false;
    var from = false;
    var to;
    var timeout = false;
    var historyName;
    console.log((new Date()) + " Connection accepted.");

    connection.on("message", function(message) {
        timeout = 300; // 5 minutes
        if (message.type === "utf8") {
            switch (message.utf8Data) {
                case "admin":
                    admin = connection;
                    console.log((new Date()) + " " + "Admin connected");
                    break;
                case "end_chat":
                    end_chat_process();
                    break;
                case "update_script":
                    updateScript();
                    break;
                case "update_SA":
                    console.log((new Date()) + " SA was updated");
                    for (let s of staff){
                        clients[s].send(JSON.stringify({
                            type: "update_SA",
                        }));
                    }
                    break;
                case "typing":
                    if (from !== false && to != -1 && to != "Chatbot") {
                        clients[to].sendUTF(JSON.stringify({
                            type: "typing",
                            data: from
                        }));
                    }
                    break;
                default:
                    if (message.utf8Data.includes("from: ")) {
                        from = message.utf8Data.substring(7);
                        if (message.utf8Data[0] == "s") staff.add(from);
                        else {
                            customer = JSON.parse(from);
                            from = customer.name;
                        }
                        console.log((new Date()) + " User is known as: " + from);
                        clients[from] = connection;
                    } else if (message.utf8Data.includes("to: ")) {
                        to = message.utf8Data.substring(5);
                        if (message.utf8Data[0] == "c" && to != "Chatbot") {
                            clients[to].sendUTF(JSON.stringify({
                                type: "req",
                                data: from
                            }));
                            historyName = from + " - " + to;
                        } else historyName = to + " - " + from;
                        
                        console.log((new Date()) + " " + from + " want to chat with " + to);
        
                        if(!history.hasOwnProperty(historyName)) {
                                if(to == "Chatbot") history[historyName] = [];
                                else {
                                    history[historyName] = history["Chatbot - " + from];
                                }
                        }
                        
                        if (history[historyName].length!=0) {
                            if (to == "Chatbot") {
                                var json = JSON.stringify({
                                    type: "history",
                                    data: history[historyName]
                                });
                                connection.sendUTF(json);
                                let html = reply(history[historyName].slice(-1)[0]['text']);
                                botMessage(html);
                                }
                            else {
                                var json = JSON.stringify({
                                    type: "history",
                                    data: history[historyName]
                                });
                                connection.sendUTF(json);
                            }
                        }
                        else if (to == "Chatbot") {
                            addHistory(script[0]['content'],to);
        
                            let html = reply(script[0]['content']);
                            var obj = {
                                time: (new Date()).getTime(),
                                text: html,
                                author: to,
                            };
                            json = JSON.stringify({
                                type: "message",
                                data: obj
                            });
                            clients[from].sendUTF(json);
                        }
        
                    } else {
                        console.log((new Date()) + " Received Message from " + from + ": " + message.utf8Data);
                        var obj = addHistory(message.utf8Data, from);
        
                        var json = JSON.stringify({
                            type: "message",
                            data: obj
                        });
        
                        if (to != "Chatbot") clients[to].sendUTF(json);
                        else {
                            if (message.utf8Data == "Gặp nhân viên tư vấn") {
                                if (staff.size == 0) {
                                    botMessage("Xin lỗi hiện tại không có nhân viên nào online!");
                                    let html = reply(script[0]['content']);
                                    botMessage(html);
                                    addHistory("Xin lỗi hiện tại không có nhân viên nào online!","Chatbot");
                                    addHistory(script[0]['content'],"Chatbot");
                                } else {
                                    tmp = Array.from(staff);
                                    var s = tmp[Math.floor(Math.random() * tmp.length)];
                                    botMessage("Quý khách đã được kết nối tới nhân viên tư vấn: " + s);
                                    addHistory("Quý khách đã được kết nối tới nhân viên tư vấn: " + s, "Chatbot");
                                    var json = JSON.stringify({
                                        type: "get_staff",
                                        data: s
                                    });
                                    clients[from].sendUTF(json);
                                }
                            } else {
                                let html = reply(message.utf8Data);
                                botMessage(html);
                            }
                        }
                    }
                    break;
            }
        }
    });

    setInterval(function() { // Chat timeout
        if(customer){
            timeout-=1;
            switch(timeout){
                case 0:
                    end_chat_process();
                    customer = false;
                    break;
                case 60:
                    clients[from].sendUTF(JSON.stringify({
                        type: "timeout",
                    }));
                    break;
                default:
                    console.log(from + ": " + timeout);
                    break;
            }
        }
    }, 1000);

    connection.on("close", function(connection) {
        if (from !== false && to != -1) {
            console.log((new Date()) + " Peer " + from + " disconnected.");
            staff.delete(from);
        }
    });
});