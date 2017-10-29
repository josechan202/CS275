<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World

  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  //First, detect if we are receiving a GET request
  if($_SERVER['REQUEST_METHOD']=="GET")
  {	
	//extract the username from the header
	$net_id = $_GET['net_id'];
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	//build our query
	//$query = "select age from name_age where name = ?";
	$query = "select * from Student where net_id = ?";

	$parameters = array($net_id);
	//execute the query on the database object
	$results = $thisDatabaseReader->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$resultString = "";
	foreach($results as $val){
		for ($x = 0; $x <= count($val); $x++) {
    		$resultString = $resultString.$val[$x];
    		if ($x != count($val) - 1){
    			$resultString = $resultString.", ";
    		}
		} 
	}
	echo json_encode(array('student' => $resultString));
	//echo count($results[0][0]);
  }
  //Otherwise, test if we are receiving a POST request
  elseif($_SERVER['REQUEST_METHOD']=="POST")
  {
  	$entityBody = file_get_contents('php://input');
  	$requestBody = json_decode($entityBody) or die("Could not decode JSON");
  	
	//extract the username and the age variable from the header
	
	$username = $_GET["username"];
	$password = $_GET["password"];
	//create the database writerObject
	$dbUserName = 'abarson' . '_writer';
	$whichPass = "w"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseWriter = new Database($dbUserName, $whichPass, $dbName);
	
	//build and execute the query
	$query = "INSERT INTO `name_age`(`name`, `age`) VALUES (?, ?)";
	$parameters = array($name, $age);
	$result = $thisDatabaseWriter->insert($query, $parameters, 0,0,0,0,false,false);
	
	header( 'HTTP/1.1 201: Resource Created' );	
  }
  else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>