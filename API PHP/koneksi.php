<?php
// Membuat variabel, ubah sesuai dengan nama host dan database pada hosting 
$host = "localhost";
$user = "root";
$password = "";
$database = "unes";

//Menggunakan objek mysqli untuk membuat koneksi dan menyimpan nya dalam variabel $mysqli	
$mysqli = new mysqli($host, $user, $password, $database);

?>
