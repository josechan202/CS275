import MySQLdb
import json
import urlparse
def application(environ, start_response):
    #rows_count = cursor.execute("SELECT club_id, clubname FROM Club WHERE clubname LIKE %%%s%% LIMIT %s, %s;", (query, int(startIndex), int(groupSize), ))
    # try catch block attempts to connect to a db
    try:
		cnx = MySQLdb.connect(user="abarson_reader", passwd="ZvFaslmH5NXg",host="webdb.uvm.edu",db="ABARSON_TEST")

    except MySQLdb.Error, err:
        if not err:
            err = "no data available"
        # use of the start_response function to send text/html data about an error
        start_response("500 database error", [('Content_Type','application/json')])
        # the text/html payload
        return "Could not connect to database"
    if environ["REQUEST_METHOD"]== 'POST':
        try:
            request_body_size = int(environ.get('CONTENT_LENGTH'))
            request_body = environ['wsgi.input'].read(request_body_size)
            j = json.loads(request_body)
            username = j['username']
            clubname = j['clubname']
            message = j['message']
        except:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "parameters missing j = " + j})



        cursor = cnx.cursor()
        
        rows_count = cursor.execute("SELECT username FROM User WHERE username = %s;", (username))

        if rows_count == 0:
            start_response("404 Not Found", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "Username or password invalid"})
                
                
        
        sql = "SELECT Admins.club_id FROM Admins INNER JOIN Club ON Admins.club_id=Club.club_id WHERE Admins.username = %s AND Club.clubname = %s"
        
        rows_count = cursor.execute(sql, (username, clubname))
        
        if rows_count == 0:
            start_response("401 Unauthorized", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "User " + username + "Does not have admin privilages over club " + clubname})
        else:
            
            club_id = cursor.fetchall()
            
            sql = "INSERT INTO Notification (club_id, post_body) VALUES (%s, %s)"
            
            try:
                cursor.execute(sql, (club_id, message))
                cnx.commit()
                success = True
                message = "Message successfully added."
                start_response("201 success", [('Content_Type','application/json')])
            
            except:
                success = False
                message = "Database failed to add notification."
                start_response("500 Internal Server Error", [('Content_Type','application/json')])

            return json.dumps({"success": success, "message": message})
    

    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
