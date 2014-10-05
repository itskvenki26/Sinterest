<html>
<head>
	<?php 
		session_start();
		include("conf.php");
		if(isset($_POST['register'])){
                        $username= mysqli_real_escape_string($sql_con,$_POST['userid']);
                        $passwd= mysqli_real_escape_string($sql_con,$_POST['Password1']);
                        $query = "select * from user where user_id='".$username."' and password=md5('".$passwd."');";
                        echo "$query<br/>";
                        $result = mysqli_query($sql_con,$query);
                        if(mysqli_num_rows($result) == 1){
                                $row = mysqli_fetch_array($result);
                                session_start();
                                $_SESSION['username'] = $row['user_id'];
                                $_SESSION['row'] = $row;
                                $_SESSION['logged'] = TRUE;
                                header("Location: home.php");
                                exit;
                        }
                }

	?>
</head>
<body style='padding-right: 60px; padding-left: 60px;padding-top:60px;' >
        <div class='jumbotron' >
                <p>
                <form action="register.php" method="post">
                	<div class="form-group">
                                <label for="User Name">User ID</label>
                                <input type="text" class="form-control" id="User Name" name='userid' placeholder="Enter User Name">
                        </div>

			<div class="form-group">
                                <label for="Email">Email address</label>
                                <input type="email" class="form-control" id="Email" name='email' placeholder="Enter email">
                        </div>
			 <div class="form-group">
                                <label for="fname">First Name</label>
                                <input type="text" class="form-control" id="fname" name='fname' placeholder="Enter First Name">
                        </div>
			 <div class="form-group">
                                <label for="lname">Last Name</label>
                                <input type="text" class="form-control" id="lname"  name='lname' placeholder="Enter Last Name">
                        </div>
			<div class="radio">
  				<label>
    				<input type="radio" name="gender" id="optionsRadios1" value="f" checked>
    				Female
  				</label>
			</div>
			<div class="radio">
  				<label>
    				<input type="radio" name="gender" id="optionsRadios2" value=m"">
    				Male
  				</label>
			</div>
			 <div class="form-group">
                                <label for="adress">Address</label>
                                <input type="textarea" class="form-control" id="adress"  name='address' placeholder="Enter Address">
                        </div>
			 <div class="form-group">
                                <label for="city">City</label>
                                <input type="text" class="form-control" id="city"  name='city' placeholder="Enter City">
                        </div>
			 <div class="form-group">
                                <label for="zip">ZIP</label>
                                <input type="text" class="form-control" id="zip"  name='zip' placeholder="Enter ZIP Code">
                        </div>
			 <div class="form-group">
                                <label for="country">Country</label>
                                <input type="text" class="form-control" id="country"  name='country' placeholder="Enter Country">
                        </div>
			 <div class="form-group">
                                <label for="dob">Date Of Birth</label>
                                <input type="date" class="form-control" id="dob"  name='dob' placeholder="MM/DD/YYYY">
                        </div>
			<div class="form-group">
                                <label for="occupation">Occupation</label>
                                <input type="text" class="form-control" id="Occupation"  name='occupation' placeholder="Enter Your Occupation">
                        </div>
			<div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="text" class="form-control" id="phone" name='phone' placeholder="Enter Phone Number">
                        </div>
			
  			<div class="form-group">
    				<label for="Password1">Password</label>
    				<input type="password" class="form-control" id="Password1" name='password1' placeholder="Enter Password">
  			</div>
			<div class="form-group">
                                <label for="Password2">Re-Enter Password</label>
                                <input type="password" class="form-control" id="Password2" placeholder="Enter Password Again">
                        </div>

                        <input class="btn btn-primary btn-defalut" type="submit" name="register" value="REGISTER"/>
                </p>
                </form>
                </p>


        </div>
</body>

</html>
