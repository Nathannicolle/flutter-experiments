import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  /*runApp(Container(
      color: Colors.blue,
      child: Center(
          child: Text(
              'Hello world',
              textDirection: TextDirection.ltr,
              textScaleFactor: 3,
              style : TextStyle(
                  color: Colors.black
              )
          )
      )
  ));*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Hello world app';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// FirstPage (Home)
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final currentHour = DateTime.now().hour;

  showHourMessage() {
    if (currentHour >= 0 && currentHour <= 7) {
      return const Text('Bonne nuit', textScaleFactor: 3, style: TextStyle(fontWeight: FontWeight.bold));
    } else if (currentHour <= 23 && currentHour >= 18) {
      return const Text('Bonsoir', textScaleFactor: 3, style: TextStyle(fontWeight: FontWeight.bold));
    } else {
      return const Text('Bonjour', textScaleFactor: 3, style: TextStyle(fontWeight: FontWeight.bold));
    }
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondStatefulWidget()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdStatefulWidget()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FourthStatefulWidget()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Align(
            child: Container(
                child: Column(children: [
              showHourMessage(),
              Text('Welcome on this app - Home page',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  textScaleFactor: 3,
                  style: TextStyle(
                    color: Colors.black,
                  ))
            ])),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class SecondStatefulWidget extends StatefulWidget {
  const SecondStatefulWidget({Key? key}) : super(key: key);

  @override
  State<SecondStatefulWidget> createState() => SecondRoute();
}

// SecondPage (school)
class SecondRoute extends State<SecondStatefulWidget> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.orange,
          child: Align(
            child: Container(
                child: Text('School page',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    textScaleFactor: 3,
                    style: TextStyle(
                      color: Colors.black,
                    ))),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondStatefulWidget()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdStatefulWidget()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FourthStatefulWidget()),
          );
          break;
      }
    });
  }
}

class ThirdStatefulWidget extends StatefulWidget {
  const ThirdStatefulWidget({Key? key}) : super(key: key);

  @override
  State<ThirdStatefulWidget> createState() => ThirdRoute();
}

// ThirdPage (News)
class ThirdRoute extends State<ThirdStatefulWidget> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.red,
          child: Align(
              child: Container(
                  child: Card(
            color: Color.fromRGBO(238, 226, 223, 1),
            elevation: 2,
            child: Column(children: <Widget>[
              Image.asset(
                'assets/images/proxmox.png',
                height: 300,
              ),
              Text(
                'This is the logo of our proxmox pannel',
                textScaleFactor: 2,
              ),
              TextButton(
                  onPressed: _launchURL, child: const Text('Go to website')),
              TextButton(
                  onPressed: () => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.amber,
                            duration: const Duration(seconds: 8),
                            content: const Text('Ohhh nice a snackbar !'),
                            action: SnackBarAction(
                                label: 'Cancel',
                                onPressed: () {},
                                textColor: Colors.red)))
                      },
                  child: const Text('More information')),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ActionChip(
                    label: const Text('PHP'),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PhpcategoryStatefulWidget()))
                        }),
                ActionChip(label: const Text('JS'), onPressed: () => {}),
                ActionChip(label: const Text('Framework'), onPressed: () => {}),
              ])
            ]),
          )))),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  _launchURL() async {
    const url = 'http://vm-1.sts-sio-caen.info/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondStatefulWidget()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdStatefulWidget()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FourthStatefulWidget()),
          );
          break;
      }
    });
  }
}

class FourthStatefulWidget extends StatefulWidget {
  const FourthStatefulWidget({Key? key}) : super(key: key);

  @override
  State<FourthStatefulWidget> createState() => FourthRoute();
}

// FourthPage (Account)
class FourthRoute extends State<FourthStatefulWidget>
    with TickerProviderStateMixin {
  int _selectedIndex = 3;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.deepPurple,
          child: Align(
            child: Container(
              child: RotationTransition(
                turns: _animation,
                child: Image.asset('assets/images/logo_v1.png'),
              ),
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondStatefulWidget()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdStatefulWidget()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FourthStatefulWidget()),
          );
          break;
      }
    });
  }
}

// Sixth page (PHP category)
class PhpcategoryStatefulWidget extends StatefulWidget {
  const PhpcategoryStatefulWidget({Key? key}) : super(key: key);

  @override
  State<PhpcategoryStatefulWidget> createState() => Phpcategory();
}

class Phpcategory extends State<PhpcategoryStatefulWidget> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.green,
          child: Column(
            children: [
              Text('PHP Category Page'),
              Chip(label: const Text('PHP')),
              Card(
                color: Color.fromRGBO(238, 226, 223, 1),
                elevation: 2,
                child: Column(children: <Widget>[
                  Image.asset(
                    'assets/images/proxmox.png',
                    height: 300,
                  ),
                  Text(
                    'This is the logo of our proxmox pannel. Wich is a project with Ubiquity framework developed with PHP.',
                    textScaleFactor: 2,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ActionChip(label: const Text('PHP'), onPressed: () => {}),
                    ActionChip(label: const Text('JS'), onPressed: () => {}),
                    ActionChip(
                        label: const Text('Framework'), onPressed: () => {}),
                  ])
                ]),
              ),
              Card(
                color: Color.fromRGBO(238, 226, 223, 1),
                elevation: 2,
                child: Column(children: <Widget>[
                  Image.asset(
                    'assets/images/logo_V1.png',
                    height: 300,
                  ),
                  Text(
                    'This is the logo of my own website. It\'s developed with HTML/CSS, PHP and JS',
                    textScaleFactor: 2,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ActionChip(label: const Text('PHP'), onPressed: () => {}),
                    ActionChip(label: const Text('JS'), onPressed: () => {}),
                    ActionChip(label: const Text('HTML'), onPressed: () => {}),
                    ActionChip(label: const Text('CSS'), onPressed: () => {})
                  ])
                ]),
              )
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  _launchURL() async {
    const url = 'http://vm-1.sts-sio-caen.info/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondStatefulWidget()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdStatefulWidget()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FourthStatefulWidget()),
          );
          break;
      }
    });
  }
}
