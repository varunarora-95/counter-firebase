import 'package:agenda_boa_task/main.dart';
import 'package:agenda_boa_task/utils/firebase_client.dart';
import 'package:agenda_boa_task/views/second_page.dart';
import 'package:agenda_boa_task/views/third_page.dart';
import 'package:agenda_boa_task/views/user_details.dart';
import 'package:flutter/material.dart';

import 'first_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage()
  ];
  final FirebaseDataClient _client = FirebaseDataClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Counter ${_currentIndex + 1}"),
        centerTitle: false,
        backgroundColor: const Color(0xff242157),
        actions: [
          IconButton(
            onPressed: () {
              _client.resetCounter();
              sharedPref.setInt('counter1', 0);
              sharedPref.setInt('counter2', 0);
              sharedPref.setInt('counter3', 0);
            },
            icon: const Icon(
              Icons.restart_alt_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const UserDetailsPage(isRegistered: true)));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      // _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset('assets/1.png',
                color:
                    _currentIndex == 0 ? const Color(0xff242157) : Colors.grey,
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/2.png',
                color:
                    _currentIndex == 1 ? const Color(0xff242157) : Colors.grey,
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/3.png',
                color:
                    _currentIndex == 2 ? const Color(0xff242157) : Colors.grey,
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24),
            label: "",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var count = sharedPref.getInt('counter${_currentIndex + 1}') ?? 0;
          count++;
          sharedPref.setInt('counter${_currentIndex + 1}', count);
          await _client.updateCounter(
              counter: 'counter${_currentIndex + 1}', count: count);
        },
        tooltip: 'Increment Me!',
        child: const Icon(Icons.add),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
