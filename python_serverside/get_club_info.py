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
            username = par['username'][0]
        except:
            start_response("400 argument error", [('Content-Type', 'text/html')])
            return ""
        cursor = cnx.cursor()
        cursor.execute("SELECT * FROM User WHERE username=%s;",(username,))
        #cursor.fetchall() returns all data from the most recent query as a list of tuples. Each tuple is a row
        returned_age = cursor.fetchall()[0][1]
        cursor.close()
        cnx.close()
        # how to respond with a json
        start_response("201 OK", [('Content_Type','application/json')])
        return json.dumps({"age":returned_age})
#        start_response("201 OK", [('Content_Type','application/json')])
#        return json.dumps({"success":true, "club_id":fetched_club[0], "clubname":fetched_club[0][1],"clubDescription":fetched_club[0][2],"clubInfo":fetched_club[0][3],"bannerURL":fetched_club[0][4]})
    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application
