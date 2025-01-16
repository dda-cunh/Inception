<?php

$conn = new mysqli(getenv("MYSQL_HOST"),
					getenv("MYSQL_USER"),
					getenv("MYSQL_PASS"),
					getenv("MYSQL_DB"));

if ($conn->connect_error)
	exit("Connection failed: {$conn->connect_error}");

$conn->close();
?>
