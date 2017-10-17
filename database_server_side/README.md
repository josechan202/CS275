Instructions for creating a Restful php server script
Ian Foertsch
10-05-15


Introduction
	The following tutorial will help you setup a restful service on UVM’s zoo server which will connect to your uvm webDB administered MySQL database. The tutorial and source code make extensive use of a database connector provided by the illustrious Bob Erickson (Thanks Bob!). The Database connector class has some sql injection prevention mechanisms which make its use somewhat involved, so make sure to examine the source code in order to understand the API.  This tutorial and example make use of php server side scripting (you may want to read up on this if not familiar) to create a restful service (see https://en.wikipedia.org/wiki/Representational_state_transfer, or other background info if unfamiliar) which you may wish to use for communicating with the backend if you are developing a mobile app. 
Create a Database
1.)	Setup an account for Uvm’s webDB service: https://webdb.uvm.edu/ 
Click on the my accounts and databases link. 
2.)	Create a database:
a.	Get your current account passwords on the “My accounts and databases” link. 
b.	Login to the “manage databases online” tab as username_admin.
c.	Click on the databases tab and create a new database. 


Setup the php script
1.)	Go to https://github.com/IanPFoertsch/275_rest_php, and copy the contents to a local folder on your pc. 
2.)	In pass.php, paste your 3 database passwords into this file. (you can use putty or winscp to restrict the read/write permissions to owner and group only to secure your password).
3.)	In constants.php, online 4, edit the ‘_database_name’ to equal the name of the database you created. 
4.)	In Database.php change nothing. However, there is a $debugMe variable you can manually set to true in the source code which will print information on the status of your database connection which you may find useful.
5.)	Example.php. This is an example script I’ve created which connects to my database named “_rest”. The database is a single-table database containing usernames and ages. You will have to alter the code here to reflect your own database structure. 
a.	Note on line 9: if($_SERVER['REQUEST_METHOD']=="GET"): This line detects which HTTP method the http request is trying to invoke. 
b.	Note lines 5-8: This section creates a read-only database object accessing the database reader password (line 6- see line 9-22 in Database.php to see the password lookup mechanism in action). 
c.	Note line 21: $query = "select age from name_age where name = ?". This is a portion of my hard-coded query. The ‘?’ character will be replaced with the $name parameter I’ve recovered from the http request on line 12. 
d.	Note line 22: $parameters  = array($name). This transforms my query parameters into an array for use inside of Bob’s database class to build the query.
e.	Note line 24: this line actually executes the query on the database and returns the results. Note that the query string and query parameters are fed into the select method, followed by a string of integers and Booleans. Basically this section provides validation for expected input inside the Database class to help prevent SQL injection attacks. Take a look at the Database class to understand the function of these parameters. In my example, “1, 0, 0, 0, false, false” means 1 “WHERE” statement, 0 conditions, 0 quotes, 0 symbols, spaces allowed = ‘false’,  semicolon allowed = ‘false’. 
f.	Note lines 27-31. The query results are returned as an array of array objects, this section involves unpacked the array to access the results, and then packaging them into a json format to be returned over the http response.
6.)	Create a /rest folder inside you /public_html folder on Uvm’s zoo server (you can use putty or WINSCP to do this)
7.)	Copy the example.php (substituting your own code here), constants.php, Database.php and pass.php to the restful folder.
8.)	Access your rest service via an HTTP browser. For example, to access my example.php service, I entered the following url to my browser http://www.uvm.edu/~ifoertsc/Restful/example.php. This will execute a no-parameter get request to the service. To add parameters, add “?paramname=paramvalue” to the end of your url string. For example, for my service, the following url will return the JSON encoded age for a user with the name = “Ian” 
http://www.uvm.edu/~ifoertsc/Restful/example.php?name=Ian. 
9.)	Browsers tend to automatically generate GET requests. You will need to use a browser plugin such as Rest easy for firefox for when you want to test POST, PUT or DELETE functionality. 

