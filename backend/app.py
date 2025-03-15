from flask import Flask, request , session
import functions

app = Flask(__name__)
app.secret_key = 'f5a5f4bbc884a568e918fb416ee39535'

@app.route('/')
def start():
    return {'name': 'Hello World!'}


@app.route('/login')
def login():
    username = request.args.get('username')
    password = request.args.get('password')

    if username == None or password == None:
        return {'error': 'Missing username or password'} , 400
        
    login_status = functions.login(username, password)
    if login_status == False:
        return {'error': 'Invalid username or password'} , 400
    
    session['username'] = username

    return {'status': 'success'} ,200
    #login function here

@app.route('/register')
def register():
    username = request.args.get('username')
    password = request.args.get('password')
    name   = request.args.get('name')

    if username == None or password == None:
        return {'error': 'Missing username or password'} , 400

    status = functions.signup(username, password, name)
    if status == False:
        return {'error': 'Username already exists'} , 400
    return {'status': 'success'} , 200
    #register function here

if __name__ == '__main__':  
    app.run(debug=True)