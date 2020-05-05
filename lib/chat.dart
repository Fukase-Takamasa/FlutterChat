import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  var _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Size device = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.photo_camera, size: 26,),
              onPressed: () {
                //
              },
            );
          },
        ),
        centerTitle: true,
        elevation: 0.0,
        title: Text('Flutter-Chat',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontFamily: "Montserrat",
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  void _addMessage() {
    Firestore.instance
        .collection("chat")
        .add({
      "message": _textController.text
    });
    _textController.text = "";
  }

  Widget _buildBody(context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("chat").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          color: Colors.lightGreenAccent,
                          child: ((){
                            return Text(document["message"]) != null ? Text(document["message"]) : Text("Loading...");
                          }()),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                    _addMessage();
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}