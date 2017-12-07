import MySQLdb
import json
import urlparse
import logging
#logging.basicConfig(filename='../www-logs/error_log', level=logging.DEBUG)
def application(environ, start_response):
    #rows_count = cursor.execute("SELECT club_id, clubname FROM Club WHERE clubname LIKE %%%s%% LIMIT %s, %s;", (query, int(startIndex), int(groupSize), ))
    # try catch block attempts to connect to a db
    try:
		cnx = MySQLdb.connect(user="abarson_admin", passwd="dmnFKw6KSiW9",host="webdb.uvm.edu",db="ABARSON_TEST")

    except MySQLdb.Error, err:
        raise
        #logging.debug('except #1: {}'.format(err))
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
        
        #rows_count = cursor.execute("SELECT username FROM User WHERE username = %s;", (username))

        #if rows_count == 0:
            #start_response("404 Not Found", [('Content_Type','application/json')])
            #return json.dumps({"success": False, "message": "Username or password invalid"})
                
                
        
        sql = "SELECT Admins.club_id FROM Admins INNER JOIN Club ON Admins.club_id=Club.club_id WHERE Admins.username = %s AND Club.clubname = %s;"
        
        rows_count = cursor.execute(sql, (username, clubname))
        
        if rows_count == 0:
            start_response("401 Unauthorized", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "User " + username + "Does not have admin privilages over club " + clubname})
        else:
            
            club_id = cursor.fetchall()[0]
            messageBack = "Database failed to add notification"
            success = "blurb"
            
            try:
                cursor.execute("INSERT INTO Notification (`club_id`, `post_body`) VALUES (%d, %s);", (club_id, message))
                cnx.commit()
                cursor.close()
                cnx.close()
                success = True
                #messageBack = "Message successfully added."
                start_response("201 success", [('Content_Type','application/json')])
            
            except (MySQLdb.Error, MySQLdb.Warning) as e:
                raise
                cnx.rollback()
                cursor.close()
                cnx.close()
                success = False
                #messageBack = "Database failed to add notification."
                start_response("600 Internal Server Error", [('Content_Type','application/json')])

            return json.dumps({"success": success, "message": messageBack})
    

    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
