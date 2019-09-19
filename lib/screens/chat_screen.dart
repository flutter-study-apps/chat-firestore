import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance; 
  final messageTextController=TextEditingController();
  FirebaseUser LoggedInUser;
  String messageText;
  


  @override
  void initState() {
       super.initState();
       getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null){
        LoggedInUser = user;
        // print(LoggedInUser);
      }
    } catch (e) {
    }
  }

  // void getMessages() async  {
  //  final messages = await _firestore.collection('messages').getDocuments();
  //   for (var message in messages.documents){
  //     print(message.data);
  //   }
  // }


  // void messagesStream() async{
  //   //think about snopshots as a future list 
  //   await for(var snapshot in _firestore.collection('messages').snapshots()){
  //     for (var message in snapshot.documents){
  //       print(message.data);
  //     }
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //Implement logout functionality
              _auth.signOut();
              Navigator.pop(context);
              // getMessages();
              // messagesStream();
            }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           MessagesStream(),
            Container(  
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear() ;
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender':LoggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot){

        if (!snapshot.hasData){
          return  Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
          final messages = snapshot.data.documents;

          //Notice that we used MessageBubble as the type of List from being a text. because messagesBubbles must be the same 
          //with it which is another statelesswidget we created below and we don't use text for List anymore
          List<MessageBubble> messageBubbles = [];
          for (var message in messages){
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            final messageBubble = MessageBubble(messageSender,messageText) ;
            messageBubbles.add(messageBubble);
          }  

          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageBubbles,
            ),
          );
      },
    );
  }
}



class MessageBubble extends StatelessWidget {

  MessageBubble(this.sender,this.text);
 
  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    //return a Material widget so that you can specify background and other things
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54
            ),
          ),
          Material(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30),
              // use elevation to add shadow to widget
              elevation: 5 ,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(
                '$Text from $sender',
                style: TextStyle(
                  fontSize: 15, 
                  color: Colors.white
                ),

            ),
              ),
          ),
        ],
      ),
    );
  }
}