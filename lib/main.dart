import 'package:flutter/material.dart';
import 'spin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spin Wheel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
        backgroundColor: Colors.blue, // Customize the app bar color
      ),
      body: Center(
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Add rounded corners to the card
          ),
          child: InkWell(
            onTap: () {
              // Navigate to the second page (SpinPage)
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SpinPage(),
              ));
            },
            child: Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.blue], // Customize the background gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                "Yes/No",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Customize the text color
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
