<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World
  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  //First, detect if we are receiving a GET request
  if($_SERVER['REQUEST_METHOD']=="GET")
  {	
	//extract the username from the header
	$clubname = $_GET['clubname'];
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	//build our query
	//$query = "select age from name_age where name = ?";
	$query = "select * from Club";
	$parameters = array($clubname);
	//execute the query on the database object
	$results = $thisDatabaseReader->select($query, $parameters, 0, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$resultString = "";
	//foreach($results as $val){
			//$resultString[] = $val[0] . $val[1];
		//}
	$club_info = array();
	foreach($results as $val){
		$club_info[] = array("club_id" => $val[0], "clubname" => $val[1]);
	}
	
	echo json_encode(array('clubs' => $club_info));
	//echo count($results[0][0]);
  }
  else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>
