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
    pass

def signup(username:str,password:str,name:str) -> str:
    cur.execute('SELECT * FROM Users WHERE username = %s', (username,))
    if cur.fetchone() != None:
        return False
    cur.execute('INSERT INTO Users (username, password, name) VALUES (%s, %s, %s)', (username, hash_password(password), name))
    conn.commit()
    return True

signup('test', 'test', 'test') # True
signup('test' , 'test','test') # False