<?php
    function connect2Server(){
        $servername = "localhost";
        $username = 'root';
        $password = '';
        try {
            $connect = new PDO("mysql:host=$servername;dbname=chatbot;charset=UTF8", $username, $password);
            $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
        }
        return $connect;
    }
    
    $connect = connect2Server();

    $query = "
    SELECT keyword, answer
    FROM suggested_answers
    ";

    $statement = $connect->prepare($query);
    $statement->execute();

    $data = $statement->fetchAll(PDO::FETCH_ASSOC);
    $json = json_encode($data, JSON_UNESCAPED_UNICODE);
    echo $json;
?>