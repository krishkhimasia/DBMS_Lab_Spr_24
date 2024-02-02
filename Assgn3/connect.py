import psycopg2

def get_query(q,s):
    config = {}                                    # dictionary to store the configuration details of the database
    config["host"]="10.5.18.68"
    config["database"]="21CS10037"
    config["user"]="21CS10037"
    config["password"]="21CS10037"
    try:
        with psycopg2.connect(**config) as conn:        # connecting to the PostGreSQL server
            with conn.cursor() as cur:                  # cur is cursor object
                match q:
                    case 1:
                        # executing the query
                        cur.execute("SELECT Student.roll, Student.name FROM EventManager JOIN Student ON EventManager.roll = Student.roll JOIN Event ON EventManager.EID = Event.EID WHERE Event.EName = 'Megaevent';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 2:
                        # executing the query
                        cur.execute("SELECT Student.roll, Student.name FROM EventManager JOIN StudentRole ON EventManager.roll = StudentRole.roll JOIN Student ON StudentRole.roll = Student.roll JOIN Role ON StudentRole.RID = Role.RID JOIN Event ON EventManager.EID = Event.EID WHERE Event.EName = 'Megaevent' AND Role.Rname = 'Secretary';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 3:
                        # executing the query
                        cur.execute("SELECT Participant.Name FROM Participant JOIN College ON Participant.CollegeName = College.Name JOIN EventParticipant ON Participant.PID = EventParticipant.PID JOIN Event ON EventParticipant.EID = Event.EID WHERE College.Name = 'IITB' AND Event.EName = 'Megaevent';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 4:
                        # executing the query
                        cur.execute("SELECT DISTINCT College.Name FROM College JOIN Participant ON College.Name = Participant.CollegeName JOIN EventParticipant ON Participant.PID = EventParticipant.PID JOIN Event ON EventParticipant.EID = Event.EID WHERE Event.EName = 'Megaevent';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 5:
                        # executing the query
                        cur.execute("SELECT DISTINCT Event.EName FROM Event JOIN EventManager ON Event.EID = EventManager.EID JOIN StudentRole ON EventManager.roll = StudentRole.roll JOIN Role ON StudentRole.RID = Role.RID WHERE Role.Rname = 'Secretary';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 6:
                        # executing the query
                        cur.execute("SELECT DISTINCT Student.name FROM Student JOIN Volunteer ON Student.roll = Volunteer.roll JOIN EventVolunteer ON Volunteer.roll = EventVolunteer.roll JOIN Event ON EventVolunteer.EID = Event.EID WHERE Student.dept = 'CSE' AND Event.EName = 'Megaevent';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 7:
                        # executing the query
                        cur.execute("SELECT DISTINCT Event.EName FROM Event JOIN EventVolunteer ON Event.EID = EventVolunteer.EID JOIN Volunteer ON EventVolunteer.Roll = Volunteer.roll JOIN Student ON Volunteer.roll = Student.roll WHERE Student.dept = 'CSE';")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 8:
                        # executing the query
                        cur.execute("SELECT College.Name FROM College JOIN Participant ON College.Name = Participant.CollegeName JOIN EventParticipant ON Participant.PID = EventParticipant.PID JOIN Event ON EventParticipant.EID = Event.EID WHERE Event.EName = 'Megaevent' GROUP BY College.Name ORDER BY COUNT(Participant.PID) DESC LIMIT 1;")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 9:
                        # executing the query
                        cur.execute("SELECT College.Name FROM College JOIN Participant ON College.Name = Participant.CollegeName GROUP BY College.Name ORDER BY COUNT(Participant.PID) DESC LIMIT 1;")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 10:
                        # executing the query
                        cur.execute("SELECT Student.dept FROM Student JOIN Volunteer ON Student.roll = Volunteer.roll JOIN EventVolunteer ON Volunteer.roll = EventVolunteer.roll JOIN EventParticipant ON EventVolunteer.EID = EventParticipant.EID JOIN Event ON EventParticipant.EID = Event.EID JOIN Participant ON EventParticipant.PID = Participant.PID JOIN College ON Participant.CollegeName = College.Name WHERE College.Name = 'IITB' GROUP BY Student.dept ORDER BY COUNT(DISTINCT Volunteer.roll) DESC LIMIT 1; ")
                        
                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case 11:
                        # executing the query
                        cur.execute("SELECT Student.roll, Student.name FROM EventManager JOIN Student ON EventManager.roll = Student.roll JOIN Event ON EventManager.EID = Event.EID WHERE Event.EName = '"+s+"';")

                        # fetching the column names
                        columns = [desc[0] for desc in cur.description]
                        print(columns)
                        
                        # fetching the rows
                        row=cur.fetchone()
                        while row is not None:
                            print(row)
                            row = cur.fetchone()
                    
                    case _:
                        print("Invalid query number")
                    
                # close the communication with the PostgreSQL
                cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    


if __name__ == '__main__':
    print("Which query would you like to make?")
    print("(1) Roll number and name of all the students who are managing the “Megaevent”\n(2) Roll number and name of all the students who are managing “Megevent” as an “Secretary”.\n(3) Name of all the participants from the college “IITB” in “Megaevent”\n(4) Name of all the colleges who have at least one participant in “Megaevent”\n(5) Name of all the events which is managed by a “Secretary”\n(6) Name of all the “CSE” department student volunteers of “Megaevent”\n(7) Name of all the events which has at least one volunteer from “CSE”\n(8) Name of the college with the largest number of participants in “Megaevent”\n(9) Name of the college with largest number of participant overall\n(10) Name of the department with the largest number of volunteers in all the events which has at least one participant from “IITB”\n(11) Query (1) but with event entered by you.")

    q = int(input("Enter the query number: "))
    s=str()
    if q==11:
        s = input("Enter the event name: ")

    get_query(q,s)

    
