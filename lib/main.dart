import 'package:flutter/material.dart';
import 'myPage.dart';
import 'chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter-Chat',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State {

  int _currentPageIndex = 0;

  var pages = [Chat(), MyPage(),];

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
    // TODO: implement build
    return Scaffold(
      body: pages[_currentPageIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            activeIcon: Icon(Icons.chat),
            title: Text("")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,),
            activeIcon: Icon(Icons.person),
            title: Text("")

          )
        ],
      ),
    );
  }

}