import 'dart:async';

import 'package:agenda_boa_task/main.dart';
import 'package:agenda_boa_task/utils/firebase_client.dart';
import 'package:agenda_boa_task/views/home_page.dart';
import 'package:agenda_boa_task/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetailsPage extends StatefulWidget {
  final bool isRegistered;

  const UserDetailsPage({Key? key, required this.isRegistered})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<UserDetailsPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseDataClient _client = FirebaseDataClient();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        centerTitle: false,
        backgroundColor: const Color(0xff242157),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                enabled: !widget.isRegistered,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  fillColor: Color(0xFFF6F8FA),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 50),
                child: TextButton(
                  onPressed: () async {
                    if (!widget.isRegistered) {
                      bool _isValid =
                          _emailRegExp.hasMatch(_emailController.text.trim());
                      if (_isValid) {
                        bool registered = await _client.registerUser(
                                email: _emailController.text.trim()) ??
                            false;
                        if (!registered) {
                          return;
                        }
                        sharedPref.setString('email', _emailController.text.trim());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Please enter valid email address.'),
                            action:
                                SnackBarAction(label: 'Ok', onPressed: () {}),
                          ),
                        );
                      }
                    } else {
                      sharedPref.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: widget.isRegistered
                        ? Colors.red
                        : const Color(0xff242157),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64)),
                  ),
                  child: Text(widget.isRegistered ? 'Log out' : 'Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isRegistered) {
      _emailController.text = sharedPref.getString('email') ?? '';
    }
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3),
        onDoneLoading); // timer set to 1 second after that onDoneLoading is called
  }

  onDoneLoading() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
