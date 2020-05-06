import 'dart:ui';

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
        return Column(
            children: <Widget>[
              Container( //スペーサー
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                    var text = (document["message"] != null) ? document["message"] : Text("Loading...");
                    return _messageItem(text);
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
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
              ),
            ],
        );
      },
    );
  }

  Widget _messageItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/inabaIcon.jpg")
                  )
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("稲葉っち",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(text,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}