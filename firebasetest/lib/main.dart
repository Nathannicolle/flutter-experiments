import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetest/components/TimersList.dart';
import 'package:firebasetest/components/UsersList.dart';
import 'package:firebasetest/models/User.dart' as MyUser;
import 'package:firebasetest/routes/UserPage.dart';
import 'package:firebasetest/routes/AppRouter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const config = FirebaseOptions(
      apiKey: "AIzaSyBG3z0Evn0OTW9rnclTyamuNN-8caI1Avk",
      appId: "1:466985884951:web:8705c8444474b43aa16b52",
      messagingSenderId: "466985884951",
      projectId: "multi-timer-5d435"
  );
  await Firebase.initializeApp(options: config);
  checkConnection();
  // Log(FirebaseDatabase.instance.toString());

  final querySnapshot = await MyUser.UserCollectionReference().get();
  final allUsers = querySnapshot.docs.map((userData) => userData.data).toList();
  // log(allUsers.toString());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: AppRouter.getRoutes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _currentUsername = "";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [UsersList(), TimersList(), TextButton(onPressed: () { testConnection('test@test.fr', 'test1234'); }, child: Text("Connexion")), TextButton(onPressed: () { disconnect(); }, child: Text("Déconnexion"))],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            MyUser.usersRef.add(MyUser.User(name: 'test', age: 43));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  testConnection(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      setState(() {
        _currentUsername = FirebaseAuth.instance.currentUser!.email??'';
      });

      Navigator.pushNamed(context, UserPage.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  disconnect() {
    FirebaseAuth.instance.signOut();
    setState(() {
      _currentUsername='';
    });
  }
}

checkConnection() {
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}