import 'package:flutter/material.dart';
import 'package:project_sederhana_app/database/dbhelper.dart';
import 'package:project_sederhana_app/screens/bodyHome.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puisiku',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = new DBhelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.edit,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.purple,
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) => new ProductPage(null, true),
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
      //   leading: Container(
      //     padding: EdgeInsets.all(8.0),
      //     child: Icon(Icons.book),
      //   ),
      //   title: Text(
      //     'Buku Puisiku',
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600),
      //   ),
      //   backgroundColor: Colors.purple,
      // ),
      //backgroundColor: Colors.grey[200],
      body: BodyHome(),
      //bottomNavigationBar: FancyTabBar(),
    );
  }
}
