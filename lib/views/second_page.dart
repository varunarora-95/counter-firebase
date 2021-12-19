import 'package:agenda_boa_task/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPref.getString('email'))
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'Updating counter 2.',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Failed to update counter 2.',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else {
                  return Text(
                    (snapshot.data?['counter2'] ?? 1).toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
