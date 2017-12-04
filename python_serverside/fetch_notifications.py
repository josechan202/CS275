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
            username   = ""
            startIndex = par['startIndex'][0]
            time = par['time'][0]
            groupSize  = par['groupSize'][0]
            subsOnly   = str(par['subsOnly'][0])
            try:
                username = par['username'][0]
            except:
                if subsOnly == True:
                    start_response("400 argument error", [('Content_Type','application/json')])
                    return json.dumps({"success": False, "message": "Missing arguments"})
        except:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "Missing arguments"})

        cursor = cnx.cursor()
        if subsOnly.lower() == "true":
            sql = "select notification_id, Club.clubname, post_body, time from Subscriptions, Notification, Club where Subscriptions.username = %s AND Subscriptions.club_id = Notification.club_id AND time < %s AND Club.club_id = Notification.club_id ORDER BY time DESC LIMIT %s, %s;"
            rows_count = cursor.execute(sql, (username, time, int(startIndex), int(groupSize)))
        else:
            sql = "select notification_id, Club.clubname, post_body, time from Notification, Club where time < %s AND Club.club_id = Notification.club_id ORDER BY time DESC LIMIT %s, %s"
            rows_count = cursor.execute(sql, (time, int(startIndex), int(groupSize)))
        if rows_count == 0:
            pass

        notifs = cursor.fetchall()
        notif_info = []
        for i in range(rows_count):
            
            n = {}
            n["notification_id"] = str(notifs[i][0])
            n["clubname"] = str(notifs[i][1])
            n["post_body"] = str(notifs[i][2])
            n["time"] = str(notifs[i][3])
            
            notif_info.append(n)
        start_response("201 success", [('Content_Type','application/json')])
        lastGroup = False
        if (rows_count < int(groupSize)):
            lastGroup = True
        return json.dumps({"lastGroup": lastGroup, "notifications": notif_info})
        
    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application

