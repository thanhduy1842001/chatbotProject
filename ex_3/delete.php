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

    function findId2Delete($id) {
        array_push($GLOBALS['Id2Delete'],$id);
        foreach($GLOBALS['data'] as $i){
            if($i['parent_id'] == $id) findId2Delete($i['scenario_id']);
        }
    }

    {
        $connect = connect2Server();

        $query = "
        SELECT *
        FROM scenario
        ORDER BY parent_id ASC
        ";

        $Id2Delete = [];
        $statement = $connect->prepare($query);
        $statement->execute();

        $data = $statement->fetchAll(PDO::FETCH_ASSOC);

        findId2Delete($_POST['scenario_id']);

        $query = "
        DELETE
        FROM scenario
        WHERE scenario_id IN (" . implode(',',$Id2Delete) . ")";

        $statement = $connect->prepare($query);
        $statement->execute();
        echo "success";
    }
?>