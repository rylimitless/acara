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

CREATE TABLE IF NOT EXISTS Events(
    event_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    FOREIGN KEY (group_id) REFERENCES EventGroups(group_id)

);



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