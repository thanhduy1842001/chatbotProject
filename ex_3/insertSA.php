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
    INSERT INTO suggested_answers (keyword,answer)
    VALUES(:keyword, :answer);
    ";
    $statement = $connect->prepare($query);
    $statement->execute(
        array(
            ':keyword' => $_POST['keyword'],
            ':answer' => $_POST['answer']
        )
    );
    echo "success";
?>