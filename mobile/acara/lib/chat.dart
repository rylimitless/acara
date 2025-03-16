import 'package:acara/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          print("going back");
          //Provider.of<ChatProvider>(context,listen: false).messages.clear();
          Navigator.pop(context);
        }, icon: const Icon(Icons.keyboard_double_arrow_left)),
      ),
      body:  Consumer<HomeProvider> (
          builder: (context, chatter , child) {

            // if(chatter.q==false){
            // chatter.subscribe("s");
            // chatter.context = widget.msgContext;
            // print(chatter.context);
            // }
  
            return Chat(messages: chatter.messages, onSendPressed: chatter.handleSendPressed, user: _user);
          }

        )
        
    );
  }
}