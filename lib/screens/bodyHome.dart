import 'package:flutter/material.dart';
import 'package:project_sederhana_app/database/dbhelper.dart';
import 'package:project_sederhana_app/screens/Datalist.dart';


class BodyHome extends StatefulWidget {
  BodyHome({Key key}) : super(key: key);

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  var db = new DBhelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: FutureBuilder(
        future: db.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;

          return snapshot.hasData
              ? new DataList(data)
              : Center(
                  child: Text("No Data"),
                );
        },
      ),
    );
  }
}