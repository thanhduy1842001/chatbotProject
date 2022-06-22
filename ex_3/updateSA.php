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

    $connect = connect2Server();
    $query = "
    UPDATE suggested_answers
    SET keyword = ?, answer = ?
    WHERE id = ?
    ";
    $statement = $connect->prepare($query);
    $statement->execute([$_POST["keyword"],$_POST["answer"],$_POST["id"]]);
    echo "success";
?>