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
        start_response("500 database error", [('Content-Type', 'text/html')])
        # the text/html payload
        return "Could not connect to database"
    if environ["REQUEST_METHOD"]== 'POST':
        try:
            request_body_size = int(environ.get('CONTENT_LENGTH'))
            request_body = environ['wsgi.input'].read(request_body_size)
            j = json.loads(request_body)
            username = j['username']
            password = j['password']
        except:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "Username or password invalid"})



        cursor = cnx.cursor()
        
        rows_count = cursor.execute("SELECT username FROM User WHERE username = %s AND password = %s;", (username, password,))

        if rows_count == 0:
            start_response("201 OK", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "Username or password invalid"})
        
        
        rows_count = cursor.execute("SELECT club_id FROM Subscriptions WHERE username = %s;", (username,))
        
        if rows_count == 0:
            start_response("201 success", [('Content_Type','application/json')])
            return json.dumps({"success": True, "username": username, "clubs": []})
        else:
            start_response("201 success", [('Content_Type','application/json')])
            
            club_list = cursor.fetchall()
            clubs_out = []
            for i in range(rows_count):
                clubs_out.append(str(club_list[i][0]))

            return json.dumps({"success": True, "username": username, "clubs": clubs_out})
    

    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
