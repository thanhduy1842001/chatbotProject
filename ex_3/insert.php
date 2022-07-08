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

    function get_typeId($connect){
        $query = "
        SELECT type, type_id 
        FROM scenario_type
        ";
        $statement = $connect->prepare($query);
        $statement->execute();
        $typeId = $statement->fetchAll(PDO::FETCH_KEY_PAIR);
        return $typeId;
    }

    $connect = connect2Server();
    $typeId = get_typeId($connect);
    $query = "
    INSERT INTO scenario (title, content, type_id, url, image, action, next_jump, parent_id)
    VALUES(:title, :content, :type_id, :url, :image, :action, :next_jump, :parent_id);
    ";
    $statement = $connect->prepare($query);
    $statement->execute(
        array(
            ':title' => $_POST['title'],
            ':content' => $_POST['content'],
            ':type_id' => $_POST['type_id'],
            ':url' => $_POST['url'],
            ':image' => $_POST['image'],
            ':action' => $_POST['action'],
            ':next_jump' => $_POST['next_jump'],
            ':parent_id' => $_POST['parent_id']
        )
    );
    echo "success";
?>