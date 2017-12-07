import MySQLdb
import json
import urlparse
def application(environ, start_response):
    #rows_count = cursor.execute("SELECT club_id, clubname FROM Club WHERE clubname LIKE %%%s%% LIMIT %s, %s;", (query, int(startIndex), int(groupSize), ))
    # try catch block attempts to connect to a db
    try:
        cnx = MySQLdb.connect(user="abarson_admin", passwd="dmnFKw6KSiW9",host="webdb.uvm.edu",db="ABARSON_TEST")
    
    except MySQLdb.Error, err:
        raise ValueError(err)
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
            appleToken = j['appleToken']
        except:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "parameters missing"})
        cursor = cnx.cursor()
	
	#for debugging

        sql = "UPDATE User SET appleToken=%s WHERE username=%s;"

        rows_count = cursor.execute(sql, (appleToken, username))
        cnx.commit()
        cnx.close()
            
        start_response("400 argument error", [('Content_Type','application/json')])
        return json.dumps({"success": True, "message": "Message inserted"})


    start_response("400 error",[('Content-Type','text/html')])
    return "grass"

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
