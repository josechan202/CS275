import MySQLdb
import json
import urlparse
def application(environ, start_response):
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
    if environ["REQUEST_METHOD"]== 'GET':
        try:
            par = urlparse.parse_qs(environ['QUERY_STRING'])
            club_id = par['club_id'][0]
        except:
            start_response("400 argument error", [('Content-Type', 'text/html')])
            return json.dumps({"success": False, "message": "No club id provided"})
        cursor = cnx.cursor()
        rows_count = cursor.execute("SELECT * FROM Club WHERE club_id=%s;",(club_id,))
        
        start_response("201 OK", [('Content_Type','application/json')])
        if rows_count > 0:
            fetched_club = cursor.fetchall()[0]
            cursor.close()
            cnx.close()
            return json.dumps({"success":True, "club_id":fetched_club[0], "clubname":fetched_club[1],"clubDescription":fetched_club[2],"clubInfo":fetched_club[3],"bannerURL":fetched_club[4]})
            
            
        else:
            cursor.close()
            cnx.close()
            return json.dumps({"success": False, "message": "Club not found"})

    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
