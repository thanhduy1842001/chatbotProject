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
    DELETE
    FROM suggested_answers
    WHERE id = ?
    ";

    $statement = $connect->prepare($query);
    $statement->execute(array($_POST['id']));
    echo "success";
?>