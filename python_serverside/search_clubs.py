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
            startIndex = par['startIndex'][0]
            groupSize  = par['groupSize'][0]
            query = ""
            try:
                query      = par['query'][0]
            except:
                pass
        except:
            start_response("400 argument error", [('Content-Type', 'text/html')])
            return json.dumps({"success": False, "message": "Missing arguments"})

        cursor = cnx.cursor()

        sql = "SELECT club_id, clubname FROM Club WHERE clubname LIKE %s LIMIT %s, %s"
        rows_count = cursor.execute(sql, ("%" + query + "%", int(startIndex), int(groupSize)))
        if rows_count == 0:
            pass

        clubs = cursor.fetchall()
        club_info = []
        for i in range(rows_count):
            
            c = {}
            c["club_id"] = str(clubs[i][0])
            c["clubname"] = clubs[i][1]
            club_info.append(c)
        start_response("400 argument error", [('Content-Type', 'text/html')])
        lastGroup = False
        if (rows_count < int(groupSize)):
            lastGroup = True
        return json.dumps({"lastGroup": lastGroup, "clubs": club_info})
        
    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application

