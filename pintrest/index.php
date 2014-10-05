<html>
<head>
     <?php
	include("conf.php");
	session_start();
                if(isset($_POST['submit'])){
                        $username= mysqli_real_escape_string($sql_con,$_POST['username']);
			$passwd= mysqli_real_escape_string($sql_con,$_POST['password']);
                        $query = "select * from user where user_id='".$username."' and password=md5('".$passwd."');";
                        echo "$query<br/>";
                        $result = mysqli_query($sql_con,$query);
			if(mysqli_num_rows($result) == 1){
        			$row = mysqli_fetch_array($result);
        			session_start();
        			$_SESSION['username'] = $row['user_id'];
        			$_SESSION['row'] = $row;
        			$_SESSION['logged'] = TRUE;
        			header("Location: home.php"); // Modify to go to the page you would like
        			exit;
    			}
		}
		elseif(isset($_SESSION['username'])){
			header("Location:home.php");
			exit;
		}


                

    ?>
</head>
<body style='padding-right: 60px; padding-left: 60px;padding-top:60px;' >
	<div class='jumbotron' > 
		<h1>Welcome to Pintrest</h1>
		<p>
		<?php
			if(isset($_POST['submit'])){
			echo "<p class='text-warning'>invalid username or password tryagain</p>";
			}
		?>
		<form action="index.php" method="post">
    			User Name:<br/>
    			<input type="text" name="username"/><br/>
    			Password:<br/>
    			<input type="password" name="password"/><br/>
			<p style='padding-top:10px;'>
    			<input class="btn btn-primary btn-defalut" type="submit" name="submit" value="LOGIN"/>
		</p>
			<a class="btn btn-default" href='register.php'>click here to sign up</a>
		</form>
		</p>
		
	
	</div>
</body>
</html>
