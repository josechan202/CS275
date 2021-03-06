<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World

  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  
  /*
  //First, detect if we are receiving a GET request
  if($_SERVER['REQUEST_METHOD']=="GET")
  {	
	//extract the username from the header
	$username = $_GET['username'];
	//$first_name = $_GET['first_name'];
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	//build our query
	//$query = "select age from name_age where name = ?";
	$query = "select club_id from Subscriptions where username = ? ";

	$parameters = array($username);
	//execute the query on the database object
	$results = $thisDatabaseReader->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$resultString = array();
	
	
	foreach($results as $val){
		$resultString[] = $val[0];
	}
	
	echo json_encode(array('username' => $username, 'clubs' => $resultString));
	
  }*/
  
  if($_SERVER['REQUEST_METHOD']=="GET")
  {	
	//extract the club_id from the header
	$club_id = $_GET['club_id'];
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	//build query
    $query = "select * from Club where club_id = ?";
	$parameters = array($club_id);
	//execute the query on the database object
	$results = $thisDatabaseReader->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$fetchClub = $results[0][0];
	if (empty($fetchClub)){
        echo "ERROR: Club not found in database.";
	} else {
	
		//extract the results and write them to a string for packaging to JSON
		$resultString = array();
	
        $resultS = "";
        //echo $results;
        
        foreach($results as $val){
            for($i = 0; $i < count($val); $i+=1){
                $resultString[] = $val[$i];
            }
        }
        //echo $resultS;
        
		//foreach($results as $val){
			//$resultString[] = $val;
		//}
	
		echo json_encode(array('success' => true, 'club_id' => $resultString[0], 'clubname' => $resultString[1], 'clubDescription' => $resultString[2], 'clubInfo' => $resultString[3], 'bannerURL' => $resultString[4]));
        //echo json_encode(array('club_id' => $resultString));
        //echo json_encode(array('club' => $resultString));
	}
	
  }
    
    
  //Otherwise, test if we are receiving a POST request
  elseif($_SERVER['REQUEST_METHOD']=="POST")
  {
	//extract the username from the header
	//$username = $_GET['username'];
	//$password = $_GET['password'];
	$entityBody = file_get_contents('php://input');
	
  	$requestBody = json_decode($entityBody, true) or die("Could not decode JSON");
  	
	//extract the username and the age variable from the header
	
	$username = $requestBody["username"];
	$password = $requestBody["password"];
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	$query = "select username from User where username = ? AND password = ?";
	

	$parameters = array($username, $password);
	//execute the query on the database object
	$results = $thisDatabaseReader->select($query, $parameters, 1, 1, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$fetchUser = $results[0][0];
	if (empty($fetchUser)){
		json_encode(array('success' => false));
	} else {
		$query = "select club_id from Subscriptions where username = ? ";
		$parameters = array($username);
		$results = $thisDatabaseReader->select($query, $parameters, 1, 0, 0, 0, false, false);
	
		//extract the results and write them to a string for packaging to JSON
		$resultString = array();
	
	
		foreach($results as $val){
			$resultString[] = $val[0];
		}
	
		echo json_encode(array('success' => true, 'username' => $username, 'clubs' => $resultString));
	}
	
	
	header( 'HTTP/1.1 200: Logged In' );	
  }
  else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
    
?>
