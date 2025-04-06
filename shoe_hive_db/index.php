<?php

header('Content-Type: application/json');

class Constants
{
    static $DB_SERVER = "localhost";
    static $DB_NAME = "product_db";
    static $USERNAME = "root";
    static $PASSWORD = "";
}

class Products
{
    public function connect()
    {
        $conn = new mysqli(Constants::$DB_SERVER, Constants::$USERNAME, Constants::$PASSWORD, Constants::$DB_NAME, 3306);
        if ($conn->connect_error) {
            die(json_encode(["error" => "Database connection failed"]));
        }
        return $conn;
    }

    public function select($category)
    {
        $conn = $this->connect();
        $allowedTables = ["nike","adidas","bata","puma","campus","woodland","reebok"];
        if (!in_array($category, $allowedTables)) {
            die(json_encode(["error" => "Invalid category"]));
        }

        $sql = "SELECT * FROM $category";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $products = [];
            while ($row = $result->fetch_assoc()) {
                array_push($products, [
                    "id" => $row['id'],
                    "name" => $row['name'],
                    "model" => $row['model'],
                    "price" => (float) $row['price'],
                    "imgAddress" => $row['imgAddress']
                ]);
            }
            echo json_encode($products);
        } else {
            echo json_encode(["error" => "No products found"]);
        }

        $conn->close();
    }
}

if (isset($_GET['category'])) {
    $category = $_GET['category'];
    $products = new Products();
    $products->select($category);
} else {
    echo json_encode(["error" => "Category not provided"]);
}

?>