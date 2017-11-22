<?php
  // example request: "https://www.uvm.edu/~\(Constants.ZOO_NAME)/rest/searchClubs.php?startIndex=\(startIndex)&groupSize=\(groupSize)&query=\(query)"
    // test request: "https://www.uvm.edu/~jfhurley/rest/searchClubs.php?startIndex=0&groupSize=10&query="
  require_once "constants.php";
  require_once "pass.php";
  require_once "Database.php";
  
  //First, detect if we are receiving a GET request
  if($_SERVER['REQUEST_METHOD']=="GET")
  {	
	//extract the username from the header
      $startIndex = $_GET['startIndex'];
      $groupSize = $_GET['groupSize'];
	  $searchTerm = $_GET['query'];
      
      
      //echo "searchTerm = " . $searchTerm;
      //echo "\nstartIndex = " . $startIndex;
      //echo "\ngroupSize = " . $groupSize;
	
	//instantiate the database connection
	$dbUserName = 'abarson' . '_reader';
	$whichPass = "r"; //flag for which one to use.
	$dbName = DATABASE_NAME;
	$thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);
	
	//build our query
	//$query = "select age from name_age where name = ?";
      //$query = "SELECT club_id, clubname FROM Club WHERE clubname LIKE CONCAT(`'%`, :searchTerm,`%'`) LIMIT :startIndex,:groupSize";
      $query = "SELECT club_id, clubname FROM Club WHERE clubname LIKE '%" . $searchTerm . "%' LIMIT " . $startIndex . "," . $groupSize;
	//$parameters = array($searchTerm, $startIndex, $groupSize);
      
      $stmt = $thisDatabaseReader->db->prepare($query);
      //$stmt->bindParam(':startIndex', $startIndex);
      //$stmt->bindParam(':groupSize', $groupSize);
      //$stmt->bindParam(':searchTerm', $searchTerm);
      $stmt->execute();
      //var_dump($stmt);
      $count = $stmt->rowCount();
      $results = $stmt->fetchAll();
      $stmt->closeCursor();
      
      //var_dump($results);
	//execute the query on the database object
	//$results = $thisDatabaseReader->select($query, $parameters, 1, 0, 0, 0, false, false);
	
	//extract the results and write them to a string for packaging to JSON
	//$resultString = "";
	//foreach($results as $val){
			//$resultString[] = $val[0] . $val[1];
		//}
	$club_info = array();
	foreach($results as $val){
		$club_info[] = array("club_id" => $val[0], "clubname" => $val[1]);
	}
      
      $lastGroup = false;
      if ($count < $groupSize) {
          $lastGroup = true;
      }
	
	echo json_encode(array('lastGroup' => $lastGroup,'clubs' => $club_info));
	//echo count($results[0][0]);
  }
  else{
	header('HTTP/1.1 501: NOT SUPPORTED');
  }
?>
