<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World

  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  //test if we are receiving a POST request
  if($_SERVER['REQUEST_METHOD']=="POST")
  {
	//extract the username from the header
	//$username = $_GET['username'];
	//$password = $_GET['password'];
	$entityBody = file_get_contents('php://input');
	
  	$requestBody = json_decode($entityBody, true) or die("Could not decode JSON");
  	
	//extract the username and the age variable from the header
	
	$username = $requestBody["username"];
	$password = $requestBody["password"];
	
	
	$dbUserName = 'abarson' . '_writer';
	$whichPass = "w"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseWriter = new Database($dbUserName, $whichPass, $dbName);
	
	
	$query = "select username from User where username = ?";

	$parameters = array($username);
	//execute the query on the database object
	$results = $thisDatabaseWriter->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$fetchUser = $results[0][0];
	if (empty($fetchUser)){
		//build and execute the query
		$query = "INSERT INTO `User` (`username`, `password`) VALUES (?, ?)";

		$parameters = array($username, $password);
		$result = $thisDatabaseWriter->insert($query, $parameters, 0,0,0,0,false,false);
		echo json_encode(array('success' => true, 'message' => $result));
	} else {
		echo json_encode(array('success' => false, 'message' => "Username taken"));
	}
	header( 'HTTP/1.1 201: Resource created' );	
  }
  else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>