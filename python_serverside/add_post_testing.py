import MySQLdb
import json
import urlparse
#!/usr/bin/env python
from apns import APNs, Payload
import sys

def push_all (tokenlist, message):
    for token in tokenlist:
        push_user(token[0], message)

def push_user(token_hex, message):
    #arguments ordered as: 0=scriptname 1=deviceHex 2=message
    token_hex = sys.argv[1]
    message = sys.argv[2]
    
    apns = APNs(use_sandbox=True, cert_file='pushKeys/certfile.pem', key_file='pushKeys/keyfile.pem')
    payload = Payload(alert=message, sound="default", badge=1)
    apns.gateway_server.send_notification(token_hex, payload)

def application(environ, start_response):
    #rows_count = cursor.execute("SELECT club_id, clubname FROM Club WHERE clubname LIKE %%%s%% LIMIT %s, %s;", (query, int(startIndex), int(groupSize), ))
    # try catch block attempts to connect to a db
    try:
        cnx = MySQLdb.connect(user="abarson_admin", passwd="dmnFKw6KSiW9",host="webdb.uvm.edu",db="ABARSON_TEST")

    except MySQLdb.Error, err:
        if not err:
            err = "no data available"
        # use of the start_response function to send text/html data about an error
        start_response("500 database error", [('Content_Type','application/json')])
        # the text/html payload
        return "Could not connect to database"
    if environ["REQUEST_METHOD"]== 'GET':
        try:
            par = urlparse.parse_qs(environ['QUERY_STRING'])
            username = par['username'][0]
            clubname = par['clubname'][0]
            message = par['message'][0]
        except:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": "parameters missing j = "})
        cursor = cnx.cursor()
        sql = "SELECT Admins.club_id FROM Admins INNER JOIN Club ON Admins.club_id=Club.club_id WHERE Admins.username = %s AND Club.clubname = %s;"
        
        rows_count = cursor.execute(sql, (username, clubname))

        if rows_count == 0:
            start_response("400 argument error", [('Content_Type','application/json')])
            return json.dumps({"success": False, "message": username + ' ' + clubname}) 
        else:
            club_id = cursor.fetchone()
            messageBack = "Database failed to add notification"
            success = "blurb"

            try:
                sql = "INSERT INTO Notification (club_id, post_body) VALUES (%s, %s);"
                cursor.execute(sql, (club_id, message))
                cnx.commit()
            except ValueError as e:
                raise e
                start_response("600 server error", [('Content_Type','application/json')])
                return json.dumps({"success": False, "message": "push notifications not sent."})
            
            try:
                sql = "SELECT appleToken FROM User WHERE User.username = (SELECT username Subscriptions FROM  WHERE club_id = %s);"
                rows_count = cursor.execute(sql, (club_id))
                if rows_count == 0:
                    start_response("500 server error", [('Content_Type','application/json')])
                    return json.dumps({"success": False, "message": 'Failed to retrieve tokens from subs of ' + clubname})
                tokens = cursor.fetchall()
                push_all(tokens, message)
                start_response("201 Added", [('Content_Type','application/json')])
                return json.dumps({"success": True, "message": "Message inserted"})
                cnx.close()
            except ValueError as e:
                raise e
                start_response("500 server error", [('Content_Type','application/json')])
                return json.dumps({"success": False, "message": "push notifications not sent."})
    

    start_response("400 error",[('Content-Type','text/html')])
    return ""

#IMPORTANT!!!! set the request_handler to your response function to get the script to work on silk
request_handler = application

