import 'package:agenda_boa_task/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataClient {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool?> registerUser({
    required String email,
  }) async {
    try {
      var doc = await _fireStore.collection('users').doc(email).get();
      var counter1 = 0, counter2 = 0, counter3 = 0;
      if(!doc.exists) {
        _fireStore.collection('users').doc(email).set({
          'counter1': 0,
          'counter2': 0,
          'counter3': 0,
        });
      }
      else {
        counter1 = doc.data()?['counter1'] ?? 0;
        counter2 = doc.data()?['counter2'] ?? 0;
        counter3 = doc.data()?['counter3'] ?? 0;
      }
      sharedPref.setInt('counter1', counter1);
      sharedPref.setInt('counter2', counter2);
      sharedPref.setInt('counter3', counter3);
      return true;
    } on FirebaseException catch (error) {
      throw error.message ?? 'Registration Failed!';
    }
  }

  Future<bool?> updateCounter({
    required String counter,
    required int count,
  }) async {
    try {
      await _fireStore.collection('users').doc(sharedPref.getString('email')).update({
        counter: count,
      });
      return true;
    } on FirebaseException catch (error) {
      throw error.message ?? 'Counter update Failed!';
    }
  }

  Future<bool?> resetCounter() async {
    try {
      await _fireStore.collection('users').doc(sharedPref.getString('email')).update({
        'counter1': 0,
        'counter2': 0,
        'counter3': 0,
      });
      return true;
    } on FirebaseException catch (error) {
      throw error.message ?? 'Counter reset Failed!';
    }
  }

}
