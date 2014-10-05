<html>
<head>
<?php
	session_start();
	include("conf.php");
	if(!isset($_SESSION['username']))
	{
		header('Location:index.php');
	}
?>
</head>
<body>
<?php include("header.php") ?>
<?php include("left_nav.php") ?>
Welcome <?php echo $_SESSION['username']; ?>
<?php include("footer.php") ?>
</body>
</html>
