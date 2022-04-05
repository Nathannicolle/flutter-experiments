import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:firebasetest/models/Timer.dart';
import 'package:flutter/cupertino.dart';

class TimerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder<TimerQuerySnapshot>(
        ref: timersRef,
        builder: (context, AsyncSnapshot<TimerQuerySnapshot> snapshot, Widget? child) {
          if (snapshot.hasError) return Text('Something went wrong!');
          if (!snapshot.hasData) return Text('Loading users...');

          // Access the QuerySnapshot
          TimerQuerySnapshot querySnapshot = snapshot.requireData;

          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              // Access the User instance
              Timer timer = querySnapshot.docs[index].data;

              return Text('Timer name: ${timer.name}');
            },
          );
        }
    );
  }
}

@Collection<Timer>('/User/')
final timersRef = TimerCollectionReference();