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

    function display_data($data) {
        $output = '<table>';
        foreach($data as $key => $var) {
            $output .= '<tr>';
            foreach($var as $k => $v) {
                if ($key === 0) {
                    $output .= '<td><strong>' . $k . '</strong></td>';
                } else {
                    $output .= '<td>' . $v . '</td>';
                }
            }
            $output .= '</tr>';
        }
        $output .= '</table>';
        echo $output;
    }

    function build_list($array) {
        $list = "<ul>";
        foreach($array as $key => $value) {
            if (is_array($value) || is_object($value)) {
                $list .= "<li><strong>$key</strong>: " . build_list($value) . '</li>';
            } else $list .= "<li><strong>$key</strong>: $value</li>";
        }
        $list .= '</ul>';
        return $list;
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