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
    INSERT INTO scenario (title, content, type_id, url, image, file_name, action, phong_ban, nhan_vien, next_jump, parent_id)
    VALUES(:title, :content, :type_id, :url, :image, :file_name, :action, :phong_ban, :nhan_vien, :next_jump, :parent_id);
    ";
    $statement = $connect->prepare($query);
    $statement->execute(
        array(
            ':title' => $_POST['title'],
            ':content' => $_POST['content'],
            ':type_id' => intval($typeId[$_POST['type']]),
            ':url' => $_POST['url'],
            ':image' => $_POST['image'],
            ':file_name' => $_POST['file_name'],
            ':action' => $_POST['action'],
            ':phong_ban' => $_POST['phong_ban'],
            ':nhan_vien' => $_POST['nhan_vien'],
            ':next_jump' => $_POST['next_jump'],
            ':parent_id' => $_POST['parent_id']
        )
    );
    echo "success";
?>