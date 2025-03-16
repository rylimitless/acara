import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
/* 

assigned_user_id": 1,
      "description": "Create design mockups for project A",
      "event_id": 1,
      "priority": 1,
      "task_id": 1,
      "title": "Design Mockups"

*/
class Task {
  int taskId = 0;
  int eventId;
  int assignedUserId;
   String title;
   String description;
   int priority;

  Task({
    required this.taskId,
    required this.eventId,
    required this.assignedUserId,
    required this.title,
    required this.description,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['task_id'],
      eventId: json['event_id'],
      assignedUserId: json['assigned_user_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
    );
  }
}

/*
{
    "description": "Initial meeting to discuss project A",
    "dt": "Sat, 15 Mar 2025 10:00:00 GMT",
    "event_id": 1,
    "group_id": 1,
    "name": "Kickoff Meeting"
  },

*/

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}


class Event {
  final String description;
  final String name;
  final int group_id;
  final String dt;

  Event({
    required this.description,
    required this.dt,
    required this.group_id,
    required this.name
  });
}

class HomeProvider extends ChangeNotifier {
  List<Task> tasks = [];
  List<Event> events = [];
    final _chatbbot = const types.User(id:"10-223");

  final List<types.Message> messages = [];


   Future<void> getTasks() async {

    tasks.clear();

    final params = {
    'id': '1',
   };

    final url = Uri.http('backend.filetree.tech', '/getTasks', params);
    //  final response = await http.get(Uri.parse('http://localhost:5000/getTasks'));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['data'];
      
      for (var item in items ){
        tasks.add(Task(taskId: item['task_id'], eventId: item['event_id'], assignedUserId: item['assigned_user_id'], title: item['title'], description: item['description'], priority: item['priority']));

      }

      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> getUserEvents() async {


    events.clear();

    final params = {
    'id': '1',
   };

    final url = Uri.http('backend.filetree.tech', '/getevents', params);
    //  final response = await http.get(Uri.parse('http://localhost:5000/getTasks'));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['data'];
      
      for (var item in items ){
        events.add(
          Event(description: item['description'], dt: item['dt'], group_id: item['group_id'], name: item['name'])
        );
      }

      print(events.toList());
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

   void handleSendPressed(types.PartialText message) async{
  const _user =  types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

    final params = {
    'query': message.text,
    };

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    addMessage(textMessage);


    if(message.text!=""){
        final url = Uri.https('backend.filetree.tech', '/getQuery', params);
    //  final response = await http.get(Uri.parse('http://localhost:5000/getTasks'));
    final response = await http.get(url);

     


    if (response.statusCode == 200) {
       var data = json.decode(response.body);
        var reply = data['reply']['candidates'][0]['content']['parts'][0]['text'];
        print(reply);
        final botMessage = types.TextMessage(
        author: _chatbbot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: reply,
        );

        addMessage(botMessage);
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

   
  }

  void addMessage(types.Message message) {
        messages.insert(0,message);
        notifyListeners();
  }

}