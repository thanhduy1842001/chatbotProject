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

    function process($row){
        $row['children'] = [];
        foreach($GLOBALS['data'] as $i){
            if($i['parent_id'] == $row['scenario_id']) array_push($row['children'],process($i));
        }
        return $row;
    }

    {
        $connect = connect2Server();

        $query = "
        SELECT *
        FROM scenario
        ORDER BY parent_id ASC
        ";

        $statement = $connect->prepare($query);
        $statement->execute();

        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
        $jsonObj = process($data[0]);
        $json = json_encode($jsonObj, JSON_UNESCAPED_UNICODE);
        echo $json;
    }
?>