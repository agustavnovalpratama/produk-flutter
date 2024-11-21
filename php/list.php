<?php
header('Content-Type: application/json');
include "konekdb.php";

$stmt = $db->prepare("SELECT id, kode, nama, harga FROM item");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
