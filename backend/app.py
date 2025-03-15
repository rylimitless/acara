from flask import Flask, request , session
import functions

app = Flask(__name__)
app.secret_key = 'f5a5f4bbc884a568e918fb416ee39535'

@app.route('/')
def start():
    return {'name': 'Hello World!'}



@app.route('/login', methods=['POST'])
def login():
    if request.is_json:
        data = request.get_json()
    else:
        data = request.form

    username = data.get('username')

    password = data.get('password')
  
    if not all([username, password]):
        return {'error': 'Missing username or password'}, 400
    
    success, user_id = login_user(username, password)
    # TODO: Add your login authentication logic here
    if not success:
        return {'error': 'Invalid credentials'}, 401
        
    return {
        'message': 'Login successful',
        'username': username,
        'user_id': user_id
    }, 200

@app.route('/register', methods=['POST'])
def register():
    if request.is_json:
        data = request.get_json()
    else:
        data = request.form
        
    username = data.get('username')
    password = data.get('password')
    name = data.get('name')

    if not all([username, password, name]):
        return {'error': 'Missing required fields'}, 400

    status = signup(username, password, name)
    if not status:
        return {'error': 'Username already exists'}, 400
    return {'status': 'success', 'message': f'User {username} created successfully'}, 201

@app.route('/create_org', methods=['POST'])
def create_organization():
    if request.is_json:
        data = request.get_json()
    else:
        data = request.form
        
    name = data.get('name')
    description = data.get('description')
    admin_id = data.get('admin_id')

    if not all([name, description, admin_id]):
        return {'error': 'Missing required fields'}, 400
    if not user_exist(admin_id):
        return {'error': 'User does not exist'}, 400

    status = create_org(name, description, admin_id)
    if not status:
        return {'error': 'Organization already exists'}, 400
    return {'status': 'success', 'message': f'Organization {name} created successfully'}, 201



@app.route('/create_event', methods=['POST'])
def create_event_plan():
    if request.is_json:
        data = request.get_json()
    else:
        data = request.form
        
    name = data.get('name')
    description = data.get('description')
    group_id = data.get('group_id')

    if not all([name, description, group_id]):
        return {'error': 'Missing required fields'}, 400
    if not org_exist(group_id):
        return {'error': 'Organization does not exist'}, 400

    status = create_event(name, description, group_id)
    if not status:
        return {'error': 'Event already exists'}, 400
    return {'status': 'success', 'message': f'Event {name} created successfully'}, 201

@app.route('/getevents',)
def get_events():
    id = request.args.get('id')
    if not id:
        return {'error': 'Missing required fields'}, 400
    
    return functions.get_events()


if __name__ == '__main__':  
    app.run(debug=True)