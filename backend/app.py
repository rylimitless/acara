from flask import Flask, request
from functions import *

app = Flask(__name__)

@app.route('/')
def start():
    return {'name': 'Hello World!'}


@app.route('/login')
def login():
    username = request.args.get('username')
    password = request.args.get('password')

    if username == None or password == None:
        return {'error': 'Missing username or password'} , 400
        
    return {'name': request.args.get('username')}
    #login function here

@app.route('/register')
def register():
    username = request.args.get('username')
    password = request.args.get('password')
    name   = request.args.get('name')

    if username == None or password == None:
        return {'error': 'Missing username or password'} , 400

    status = signup(username, password, name)
    if status == False:
        return {'error': 'Username already exists'} , 400
    return {'status': 'success'} , 200
    #register function here

if __name__ == '__main__':  
    app.run(debug=True)