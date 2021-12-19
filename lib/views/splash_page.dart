import 'dart:async';

import 'package:agenda_boa_task/main.dart';
import 'package:agenda_boa_task/views/home_page.dart';
import 'package:agenda_boa_task/views/user_details.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xff242157),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: const Center(
          child: Image(image: AssetImage('assets/logo.png')),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3),
        onDoneLoading); // timer set to 1 second after that onDoneLoading is called
  }

  onDoneLoading() {
    if (sharedPref.getString('email') != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const UserDetailsPage(isRegistered: false)));
    }
  }
}
