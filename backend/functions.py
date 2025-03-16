import bcrypt
import requests
import json
import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    port=3310,
    password='root',
    database='acara'
)

cur = conn.cursor()

def hash_password(password:str):
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

def check_password(password:str, hashed:str):
    return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))

def login(username:str,password:str) -> str:
    cur.execute('SELECT * FROM Users WHERE username = %s', (username,))
    user = cur.fetchone()
    print(user)
    if user == None:
        return False
    if check_password(password, user[2]):
        return True
    return False

def signup(username:str,password:str,name:str) -> str:
    cur.execute('SELECT * FROM Users WHERE username = %s', (username,))
    if cur.fetchone() != None:
        return False
    cur.execute('INSERT INTO Users (username, password, name) VALUES (%s, %s, %s)', (username, hash_password(password), name))
    conn.commit()
    return True


def user_exist(userid:int) -> int:
    cur.execute('SELECT * FROM Users WHERE user_id = %s', (userid,))
    
    if cur.fetchone() != None:
        return True
    return False

def event_exist(event_id:int) -> int:
    cur.execute('SELECT * FROM Events WHERE event_id = %s', (event_id,))
    if cur.fetchone() != None:  
        return True
    return False

def login_user(username, password):
    # Add your authentication logic here
    # Return tuple of (success boolean, user_id)
    # Example:
    cur.execute('SELECT user_id, password FROM Users WHERE username = %s', (username,))
    user = cur.fetchone()
    
    # Check if user exists and password matches
    print(user)
    if user and check_password(password, user[1]):
        return True, user[0]  # Return success and user_id
    
    return False, None  # Return failure if no match or wrong password
  

def create_org(name,description,admin_id):
    cur.execute('INSERT INTO EventGroups (username, description, admin) VALUES (%s, %s, %s)', (name, description, admin_id))
    conn.commit()
    return True

def get_user_tasks(user_id):
    cur.execute('SELECT * FROM Tasks WHERE assigned_user_id = %s', (user_id,))
    tasks = []
    for task in cur.fetchall():
        tasks.append({
            'task_id': task[0],
            'title': task[1],
            'description': task[2],
            'event_id': task[3],
            'assigned_user_id': task[4],
            'priority': task[5]
        })
    return tasks
    # return cur.fetchall()

def org_exist(org_id:int) -> int:
    cur.execute('SELECT * FROM EventGroups WHERE   group_id = %s', (org_id,))
    if cur.fetchone() != None:
        return True
    return False

def create_event(name,description,group_id):
    cur.execute('INSERT INTO Events (name, description, group_id) VALUES (%s, %s, %s)', (name, description, group_id))
    conn.commit()
    return True

def create_task(name,description,assign_user_id,event_id,priority):
    cur.execute('INSERT INTO Tasks (title, description,priority,assigned_user_id, event_id) VALUES (%s, %s,%s ,%s,%s)', (name, description,priority,assign_user_id, event_id))
    conn.commit()
    return True
def get_events_for_user(user_id):
    cur.execute('select * from Events inner join UserEvents on Events.event_id = UserEvents.event_id where UserEvents.user_id = %s', (user_id,))
    # return cur.fetchall()
    events = []
    for task in cur.fetchall():
        events.append({
            'event_id': task[0],
            'group_id': task[1],
            'name': task[2],
            'description': task[3],
            'dt': task[4],
            # 'priority': task[5]
        })
    return events

def get_summaries(user_id):
    pass


def get_query(query):
    url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key="
    headers = {
        'Content-Type': 'application/json'
    }
    data = {
        "contents": [{
            "parts": [{"text": query}]
        }]
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))
    return response.json()
# def create_task(name,description,event_id,priority):
#     cur.execute('INSERT INTO Tasks (title, description, event_id) VALUES (%s, %s, %s,%s)', (name, description, event_id))
#     conn.commit()
#     return True
