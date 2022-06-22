<?php
    Sleep(1);
    function connect2Server(){
        $servername = "localhost";
        $username = 'root';
        $password = '';
        try {
            $connect = new PDO("mysql:host=$servername;dbname=chatbot;charset=UTF8", $username, $password);
            $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo "fail";
        }
        return $connect;
    }

    function map($s){
        if($_POST[$s] == "") return "";
        if(is_string($_POST[$s])) return $s . "= '" . $_POST[$s] . "'";
        return $s . "=" . $_POST[$s];
    }

    function not_blank($s){
        return !($s == "");
    }

    function set(){
        $attr = ['scenario_id', 'content', 'type_id', 'url', 'image', 'file_name', 'action', 'phong_ban', 'nhan_vien', 'next_jump', 'parent_id'];
        $res = array_map('map', $attr);
        $res = array_filter($res, "not_blank");
        $res = implode(',', $res);
        return $res;
    }

    $a = [];
    $connect = connect2Server();
    $query = "
    UPDATE scenario
    SET ";
    $query .= set();
    $query .= " WHERE scenario_id = " . $_POST['scenario_id'];
    $statement = $connect->prepare($query);
    $statement->execute();
    echo "success";
?>