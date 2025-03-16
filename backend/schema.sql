-- Active: 1739830206872@@127.0.0.1@3306@acara
CREATE TABLE IF NOT EXISTS Users (
    user_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL, 
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255)
);  

CREATE TABLE IF NOT EXISTS EventGroups(
    group_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    admin INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS GroupMembers(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (group_id) REFERENCES EventGroups(group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

<<<<<<< HEAD
CREATE TABLE IF NOT EXISTS Events(
    event_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES EventGroups(group_id)
);


=======
>>>>>>> ry

CREATE TABLE IF NOT EXISTS Tasks(
    task_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    priority INTEGER DEFAULT 0,
    assigned_user_id INT,
    event_id INT NOT NULL
); 


CREATE TABLE IF NOT EXISTS Events(
    event_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES EventGroups(group_id)
);

CREATE TABLE IF NOT EXISTS UserEvents(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- Insert into UserEvents
INSERT INTO UserEvents (user_id, event_id) VALUES 
(1, 1), -- John Doe attending Event 1
(2, 1), -- Jane Smith attending Event 1
(2, 2), -- Jane Smith attending Event 2
(3, 2), -- Alice Jones attending Event 2
(1, 3), -- John Doe attending Event 3
(3, 3); -- Alice Jones attending Event 3

-- Insert into Users
INSERT INTO Users (username, password, name) VALUES 
('john_doe', 'password123', 'John Doe'),
('jane_smith', 'password456', 'Jane Smith'),
('alice_jones', 'password789', 'Alice Jones');

-- Insert into EventGroups
INSERT INTO EventGroups (username, description, admin) VALUES 
('john_doe', 'Group for project A', 1),
('jane_smith', 'Group for project B', 2),
('alice_jones', 'Group for project C', 3);

-- Insert into GroupMembers
INSERT INTO GroupMembers (group_id, user_id) VALUES 
(1, 1), -- John Doe in Group 1
(1, 2), -- Jane Smith in Group 1
(2, 2), -- Jane Smith in Group 2
(2, 3), -- Alice Jones in Group 2
(3, 1), -- John Doe in Group 3
(3, 3); -- Alice Jones in Group 3

-- Insert into Events
INSERT INTO Events (group_id, name, description, dt) VALUES 
(1, 'Kickoff Meeting', 'Initial meeting to discuss project A', '2025-03-15 10:00:00'),
(2, 'Planning Session', 'Planning session for project B', '2025-03-16 14:00:00'),
(3, 'Review Meeting', 'Review meeting for project C', '2025-03-17 09:00:00');

-- Insert into Tasks
INSERT INTO Tasks (title, description, priority, assigned_user_id, event_id) VALUES 
('Design Mockups', 'Create design mockups for project A', 1, 1, 1), -- Assigned to John Doe, Event 1
('Write Documentation', 'Write documentation for project B', 2, 2, 2), -- Assigned to Jane Smith, Event 2
('Code Review', 'Review code for project C', 3, 3, 3); -- Assigned to Alice Jones, Event 3
