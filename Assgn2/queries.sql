-- Create database
CREATE TABLE Student (
    Roll INT PRIMARY KEY,
    name VARCHAR(255),
    Dept VARCHAR(255)
);

CREATE TABLE Role (
    RID INT PRIMARY KEY,
    Rname VARCHAR(255),
    Description VARCHAR(255)
);

CREATE TABLE Event (
    EID INT PRIMARY KEY,
    Date DATE,
    EName VARCHAR(255),
    Type VARCHAR(255)
);

CREATE TABLE Volunteer (
    Roll INT PRIMARY KEY,
    FOREIGN KEY (Roll) REFERENCES Student(Roll)
);

CREATE TABLE College (
    Name VARCHAR(255) PRIMARY KEY,
    Location VARCHAR(255)
);

CREATE TABLE Participant (
    PID INT PRIMARY KEY,
    Name VARCHAR(255),
    CollegeName VARCHAR(255),
    FOREIGN KEY (CollegeName) REFERENCES College(Name)
);

CREATE TABLE StudentRole (
    Roll INT,
    RID INT,
    PRIMARY KEY (Roll, RID),
    FOREIGN KEY (Roll) REFERENCES Student(Roll),
    FOREIGN KEY (RID) REFERENCES Role(RID)
);

CREATE TABLE EventManager (
    EID INT,
    Roll INT,
    PRIMARY KEY (EID, Roll),
    FOREIGN KEY (EID) REFERENCES Event(EID),
    FOREIGN KEY (Roll) REFERENCES Student(Roll)
);

CREATE TABLE EventParticipant (
    EID INT,
    PID INT,
    PRIMARY KEY (EID, PID),
    FOREIGN KEY (EID) REFERENCES Event(EID),
    FOREIGN KEY (PID) REFERENCES Participant(PID)
);

CREATE TABLE EventVolunteer (
    EID INT,
    Roll INT,
    PRIMARY KEY (EID, Roll),
    FOREIGN KEY (EID) REFERENCES Event(EID),
    FOREIGN KEY (Roll) REFERENCES Volunteer(Roll)
);

-- Insert sample records into Student table
INSERT INTO Student (roll, name, dept) VALUES
  (1, 'Krish', 'CSE'),
  (2, 'Sahil', 'EE'),
  (3, 'Sammy', 'MA'),
  (4, 'Bob', 'PH'),
  (5, 'Aubrey', 'EC'),
  (6, 'Anita', 'ME'),
  (7, 'Maxx', 'CSE'),
  (8, 'Wynn', 'EE'),
  (9, 'Symere', 'PH'),
  (10, 'Matt', 'EC');

-- Insert sample records into Role table
INSERT INTO Role (RID, Rname, Description) VALUES
  (1, 'Admin', 'Administrator role'),
  (2, 'Staff', 'Staff role'),
  (3, 'Student', 'Student role'),
  (4, 'Secretary', 'Secretary role'),
  (5, 'Head', 'Head role');

-- Insert sample records into Event table
INSERT INTO Event (EID, Date, EName, Type) VALUES
  (101, '2024-01-04', 'Megaevent', 'Concert'),
  (102, '2024-01-04', 'Workshop Z', 'Workshop'),
  (103, '2024-01-03', 'Seminar C', 'Seminar'),
  (104, '2024-01-02', 'Hackathon D', 'Hackathon'),
  (105, '2024-01-01', 'Exhibition A', 'Exhibition');

-- Insert sample records into Volunteer table
INSERT INTO Volunteer (Roll) VALUES
  (1),
  (2),
  (4),
  (6),
  (8);

-- Insert sample records into College table
INSERT INTO College (Name, Location) VALUES
  ('IITB', 'Powai'),
  ('IITKGP', 'Kharagpur'),
  ('VIT', 'Vellore'),
  ('BITS', 'Dubai'),
  ('VJTI', 'Mumbai');

-- Insert sample records into Participant table
INSERT INTO Participant (PID, Name, CollegeName) VALUES
  (101, 'Participant A', 'IITB'),
  (102, 'Participant B', 'IITKGP'),
  (103, 'Participant C', 'VIT'),
  (104, 'Participant D', 'VIT'),
  (105, 'Participant E', 'BITS');

-- Insert sample records into StudentRole table
INSERT INTO StudentRole (roll, RID) VALUES
  (1, 4),  -- Krish has Secretary role
  (2, 2),  -- Sahil has Staff role
  (3, 3),  -- Sammy has Student role
  (4, 1),  -- Bob has Admin role
  (5, 5);  -- Aubrey has Head role

-- Insert sample records into EventManager table
INSERT INTO EventManager (EID, Roll) VALUES
  (101, 1),  -- Megaevent is managed by Krish
  (102, 2),  -- Workshop Z is managed by Sahil
  (103, 3),  -- Seminar C is managed by Sammy
  (101, 4),  -- Megaevent is managed by Bob
  (105, 5);  -- Exhibition A is managed by Aubrey

-- Insert sample records into EventParticipant table
INSERT INTO EventParticipant (EID, PID) VALUES
  (101, 101),  -- Megaevent has Participant A
  (102, 102),  -- Workshop Z has Participant B
  (103, 103),  -- Seminar C has Participant C
  (104, 104),  -- Hackathon D has Participant D
  (105, 105);  -- Exhibition A has Participant E

-- Insert sample records into EventVolunteer table
INSERT INTO EventVolunteer (EID, Roll) VALUES
  (101, 1),  -- Megaevent has Volunteer 1
  (101, 2),  -- Megaevent has Volunteer 2
  (103, 6),  -- Seminar C has Volunteer 3
  (104, 4),  -- Hackathon D has Volunteer 4
  (105, 8);  -- Exhibition A has Volunteer 5

-- queries (crosscheck pls????)

-- 1.
SELECT Student.roll, Student.name
FROM EventManager
JOIN Student ON EventManager.roll = Student.roll
JOIN Event ON EventManager.EID = Event.EID
WHERE Event.EName = 'Megaevent';

-- 2.
SELECT Student.roll, Student.name
FROM EventManager
JOIN StudentRole ON EventManager.roll = StudentRole.roll
JOIN Student ON StudentRole.roll = Student.roll
JOIN Role ON StudentRole.RID = Role.RID
JOIN Event ON EventManager.EID = Event.EID
WHERE Event.EName = 'Megaevent' AND Role.Rname = 'Secretary';

-- 3.
SELECT Participant.Name
FROM Participant
JOIN College ON Participant.CollegeName = College.Name
JOIN EventParticipant ON Participant.PID = EventParticipant.PID
JOIN Event ON EventParticipant.EID = Event.EID
WHERE College.Name = 'IITB' AND Event.EName = 'Megaevent';


-- 4.
SELECT DISTINCT College.Name
FROM College
JOIN Participant ON College.Name = Participant.CollegeName
JOIN EventParticipant ON Participant.PID = EventParticipant.PID
JOIN Event ON EventParticipant.EID = Event.EID
WHERE Event.EName = 'Megaevent';

-- 5.
SELECT DISTINCT Event.EName
FROM Event
JOIN EventManager ON Event.EID = EventManager.EID
JOIN StudentRole ON EventManager.roll = StudentRole.roll
JOIN Role ON StudentRole.RID = Role.RID
WHERE Role.Rname = 'Secretary';

-- 6.
SELECT DISTINCT Student.name
FROM Student
JOIN Volunteer ON Student.roll = Volunteer.roll
JOIN EventVolunteer ON Volunteer.roll = EventVolunteer.roll
JOIN Event ON EventVolunteer.EID = Event.EID
WHERE Student.dept = 'CSE' AND Event.EName = 'Megaevent';

-- 7.
SELECT DISTINCT Event.EName
FROM Event
JOIN EventVolunteer ON Event.EID = EventVolunteer.EID
JOIN Volunteer ON EventVolunteer.Roll = Volunteer.roll
JOIN Student ON Volunteer.roll = Student.roll
WHERE Student.dept = 'CSE';

-- 8.
SELECT College.Name
FROM College
JOIN Participant ON College.Name = Participant.CollegeName
JOIN EventParticipant ON Participant.PID = EventParticipant.PID
JOIN Event ON EventParticipant.EID = Event.EID
WHERE Event.EName = 'Megaevent'
GROUP BY College.Name
ORDER BY COUNT(Participant.PID) DESC
LIMIT 1;

-- 9.
SELECT College.Name
FROM College
JOIN Participant ON College.Name = Participant.CollegeName
GROUP BY College.Name
ORDER BY COUNT(Participant.PID) DESC
LIMIT 1;

-- 10.
SELECT Student.dept
FROM Student
JOIN Volunteer ON Student.roll = Volunteer.roll
JOIN EventVolunteer ON Volunteer.roll = EventVolunteer.roll
JOIN EventParticipant ON EventVolunteer.EID = EventParticipant.EID
JOIN Event ON EventParticipant.EID = Event.EID
JOIN Participant ON EventParticipant.PID = Participant.PID
JOIN College ON Participant.CollegeName = College.Name
WHERE College.Name = 'IITB'
GROUP BY Student.dept
ORDER BY COUNT(DISTINCT Volunteer.roll) DESC
LIMIT 1;

-- End of queries.sql

-- DROP TABLE college,event,eventmanager,eventparticipant,eventvolunteer,participant,role,student,studentrole,volunteer;
