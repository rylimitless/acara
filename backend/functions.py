import bcrypt
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


def org_exist(org_id:int) -> int:
    cur.execute('SELECT * FROM EventGroups WHERE   group_id = %s', (org_id,))
    if cur.fetchone() != None:
        return True
    return False

def create_event(name,description,group_id):
    cur.execute('INSERT INTO Events (name, description, group_id) VALUES (%s, %s, %s)', (name, description, group_id))
    conn.commit()
    return True

def get_events(group_id):
    cur.execute('SELECT * FROM Events WHERE group_id = %s', (group_id,))
    return cur.fetchall()

# def create_task(name,description,event_id,priority):
#     cur.execute('INSERT INTO Tasks (title, description, event_id) VALUES (%s, %s, %s,%s)', (name, description, event_id))
#     conn.commit()
#     return True