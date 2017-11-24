<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World

  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  
if($_SERVER['REQUEST_METHOD']=="POST") {
      
    $entityBody = file_get_contents('php://input');
	
  	$requestBody = json_decode($entityBody, true) or die("Could not decode JSON");
  	
	$username = $requestBody["username"];
	$club_id = $requestBody["clubID"];
	

	//instantiate the database connection
	$dbUserName = 'abarson' . '_writer';
	$whichPass = "w"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseWriter = new Database($dbUserName, $whichPass, $dbName);
	
	$errorMessages = "";
    
    //First, make sure the user actually exists
	$query = "select * from User where username = ?";
    
	$parameters = array($username);
	$results = $thisDatabaseWriter->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	$fetchSub = $results[0][0];
	if (empty($fetchSub)){
		$errorMessages = $errorMessages."Username invalid ";
	}
    
    //Then, make sure the club exists
    $query = "select * from Club where club_id = ?";
    $parameters = array($club_id);
	$results = $thisDatabaseWriter->select($query, $parameters, 1, 0, 0, 0, false, false);
	$fetchSub = $results[0][0];
	if (empty($fetchSub)){
		$errorMessages = $errorMessages."Club invalid";
	}
      
      //If they are subscribing, the subscription should not exist in the db; If they are unsubscribing, the subscription should exist in the db.
    if (!empty($errorMessages)){
    	echo json_encode(array('success' => false, 'message' => $errorMessages));
    } else { 
    	//If both the user and club exist, we can begin the subscription process
    	$query = "select club_id from Subscriptions where username = ?";
    	$parameters = array($username);
    	$results = $thisDatabaseWriter->select($query, $parameters, 1, 0, 0, 0, false, false);
	
		//find out if the user is subscribed or not
		$subscribed = false;
		foreach($results as $val){
			if ($club_id == $val[0]){
				$subscribed = true;
				break;
			}
		}
		
		//if not subscribed, add a subscription
		if (!$subscribed){
			$query = "INSERT INTO `Subscriptions` (`username`, `club_id`) VALUES (?, ?)";
			$parameters = array($username, $club_id);
			$result = $thisDatabaseWriter->insert($query, $parameters, 0,0,0,0,false,false);
			if ($result == 'true'){
				echo json_encode(array('success' => true, 'message' => 'subscribed'));
			} else {
				echo json_encode(array('success' => false, 'message' => 'Failed to subscribe'));
			}
		} else { //otherwise, delete their subscription
			$query = "DELETE FROM `Subscriptions` WHERE username = ? AND club_id = ?";
			$parameters = array($username, $club_id);
			$result = $thisDatabaseWriter->delete($query, $parameters, 1,1,0,0,false,false);
			if ($result == 'true'){
				echo json_encode(array('success' => true, 'message' => 'unsubscribed'));
			} else {
				echo json_encode(array('success' => false, 'message' => 'Failed to subscribe'));
			}
		}
	}	
	header( 'HTTP/1.1 201: Resource created' );	
  } else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>
