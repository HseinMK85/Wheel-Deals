<?php
$host = "sql309.infinityfree.com"; 
$username = "if0_38020698"; 
$password = "FdUMLBAxjOSPE"; 
$database = "if0_38020698_XXX"; 

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_GET['min_price']) && isset($_GET['max_price'])) {
    $min_price = intval($_GET['min_price']);
    $max_price = intval($_GET['max_price']); 

    $sql = $conn->prepare("SELECT id, name, price FROM cars WHERE price BETWEEN ? AND ?");
    $sql->bind_param("ii", $min_price, $max_price);
    $sql->execute();
    $result = $sql->get_result();

    $cars = [];
    while ($row = $result->fetch_assoc()) {
        $cars[] = $row;
    }

    header('Content-Type: application/json');
    echo json_encode($cars);
} else {
    header('Content-Type: application/json');
    echo json_encode(["error" => "Invalid input. Please provide both min_price and max_price."]);
}

$conn->close();
?>
