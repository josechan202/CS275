<?php
  // example request: http://path/to/resource/Example?method=sayHello&name=World

  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  

  //Otherwise, test if we are receiving a POST request
  if($_SERVER['REQUEST_METHOD']=="POST") {
    
//    //write to log file.
//    $logfile = fopen("log.txt", "w") or die("Unable to open file!");
//    $txt1 = "Inside Subscribe.php POST request.\n";
//    fwrite($logfile, $txt1);
//    fclose($logfile);
      
	$entityBody = file_get_contents('php://input');
	
  	$requestBody = json_decode($entityBody, true) or die("Could not decode JSON");
    
//      //write to log file.
//      $logfile = fopen("log.txt", "w") or die("Unable to open file!");
//      $txt1 = "$requestBody = "+ $requestBody +"\n";
//      fwrite($logfile, $txt1);
//      fclose($logfile);
  	
	//extract the username and the age variable from the header
      
	$username = $requestBody["username"];
	$club_id = $requestBody["clubID"];
    $isSubbing = $requestBody["isSubbing"];

	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_writer';
	$whichPass = "w"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseWriter = new Database($dbUserName, $whichPass, $dbName);
	
      
	$query = "select * from Subscriptions where username = ? AND club_id = ?";
	
      
	$parameters = array($username, club_id);
	//execute the query on the database object
	$results = $thisDatabaseWriter->select($query, $parameters, 1, 1, 0, 0, false, false);
      
//      //write to log file
//      $logfile = fopen("log.txt", "w") or die("Unable to open file!");
//      $txt1 = "Select $results = "+ $results +"\n";
//      fwrite($logfile, $txt1);
//      fclose($logfile);
	
	//extract the results and write them to a string for packaging to JSON
	$fetchSub = $results[0][0];
      $subNotExists = empty($fetchSub);
      
      //If they are subscribing, the subscription should not exist in the db; If they are unsubscribing, the subscription should exist in the db.
      if ($isSubbing == $subNotExists){
        if (isSubbing) { //Executes if they are subscribing
            $query = "INSERT INTO Subscriptions (club_id, username) VALUES (?, ?)";
            
            $parameters = array($club_id, $username);
            $result = $thisDatabaseWriter->insert($query, $parameters, 0,0,0,0,false,false);
            
//            //write to log file
//            $logfile = fopen("log.txt", "w") or die("Unable to open file!");
//            $txt1 = "Insert $results = "+ $results +"\n";
//            fwrite($logfile, $txt1);
//            fclose($logfile);
            
            echo json_encode(array('success' => true, 'message' => $result));
        } else { //Executes if they are unsubscribing to the club
            $query = "DELETE FROM Subscriptions WHERE club_id = ? AND username = ?";
            $parameters = array($club_id, $username);
            $result = $thisDatabaseWriter->delete($query, $parameters, 1,1,0,0,false,false);
            
//            //write to log file
//            $logfile = fopen("log.txt", "w") or die("Unable to open file!");
//            $txt1 = "Delete $results = "+ $results +"\n";
//            fwrite($logfile, $txt1);
//            fclose($logfile);
            
            echo json_encode(array('success' => true, 'message' => $result));
        }
	} else { // Executes when $isSubbing and $subNotExists don't match
        echo json_encode(array('success' => false, 'message' => "whoops"));
	}
	
	header( 'HTTP/1.1 200: Logged In' );	
  } else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>
