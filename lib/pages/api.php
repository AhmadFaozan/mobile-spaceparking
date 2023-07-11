<?php
// Koneksi ke database phpMyAdmin
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "space_parking";

$conn = new mysqli($servername, $username, $password, $dbname);

// Cek koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mengambil data dari database
$sql = "SELECT * FROM detection";
$result = $conn->query($sql);
$data = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// Mengirim data sebagai respons
header('Content-Type: application/json');
echo json_encode($data);

$conn->close();
?>
