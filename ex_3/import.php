<?php
sleep(1);
$output = '';
$scenarios = [];
$attr = ['scenario_id', 'title', 'content', 'type', 'url', 'image', 'file_name', 'action', 'phong_ban', 'nhan_vien', 'next_jump', 'parent_id'];
function process($parentID, $data){
    $tmp = [];
    $data['parent_id'] = $parentID;

    foreach($GLOBALS["attr"] as $i) $tmp[$i] = $data[$i];
    array_push($GLOBALS["scenarios"], $tmp);

    if (array_key_exists('children', $data)){
        foreach($data['children'] as $scenario){
            process($data['scenario_id'],  $scenario);
        }
    }
}

function connect2Server(){
    $servername = "localhost";
    $username = 'root';
    $password = '';
    try {
        $connect = new PDO("mysql:host=$servername;dbname=chatbot;charset=UTF8", $username, $password);
        $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "<div class='alert alert-success'>Connect to server successfully</div>";
    } catch(PDOException $e) {
    echo "<div class='alert alert-warning'>Connection failed: " . $e->getMessage() . "</div>";
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

if(isset($_FILES['file']['name']) &&  $_FILES['file']['name'] != ''){
    $valid_extension = array('json');
    $file_data = explode('.', $_FILES['file']['name']);
    $file_extension = end($file_data);
    if(in_array($file_extension, $valid_extension))
    {
        $connect = connect2Server();
        $jsondata = file_get_contents($_FILES['file']['tmp_name']);
        $data = json_decode($jsondata, true);
        process("", $data);

        $typeId = get_typeId($connect);
        $query = "
        INSERT INTO scenario (scenario_id, title, content, type_id, url, image, file_name, action, phong_ban, nhan_vien, next_jump, parent_id)
        VALUES(:scenario_id, :title, :content, :type_id, :url, :image, :file_name, :action, :phong_ban, :nhan_vien, :next_jump, :parent_id);
        ";
        $statement = $connect->prepare($query);

        foreach($GLOBALS["scenarios"] as $scenario){
            $statement->execute(
                array(
                    ':scenario_id' => intval($scenario['scenario_id']),
                    ':title' => $scenario['title'],
                    ':content' => $scenario['content'],
                    ':type_id' => intval($typeId[$scenario['type']]),
                    ':url' => $scenario['url'],
                    ':image' => $scenario['image'],
                    ':file_name' => $scenario['file_name'],
                    ':action' => $scenario['action'],
                    ':phong_ban' => intval($scenario['phong_ban']),
                    ':nhan_vien' => intval($scenario['nhan_vien']),
                    ':next_jump' => intval($scenario['next_jump']),
                    ':parent_id' => intval($scenario['parent_id'])
                )
            );
        }
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);
        if(isset($result)) $output = '<div class="alert alert-success">Import Data Done</div>';
    } else $output = '<div class="alert alert-warning">Invalid File</div>';
} else $output = '<div class="alert alert-warning">Please Select Json File</div>';

echo $output;
$connect = null;
?>