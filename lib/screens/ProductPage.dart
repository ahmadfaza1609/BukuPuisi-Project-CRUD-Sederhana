import 'package:flutter/material.dart';
import 'package:project_sederhana_app/database/dbhelper.dart';
import 'package:project_sederhana_app/model/mydata.dart';
import 'dart:ui';

import 'package:project_sederhana_app/screens/bodyHome.dart';

class ProductPage extends StatefulWidget {
  ProductPage(this._myData, this._isNew);

  final MyData _myData;
  final bool _isNew;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String title;
  bool btnSave = false;
  bool btnEdit = true;
  bool btnDelete = true;

  MyData myData;
  String createDate;

  // final cImageUrl = TextEditingController();
  final cTitle = TextEditingController();
  final cNote = TextEditingController();
  final cKarya = TextEditingController();

  var now = DateTime.now();

  bool _enabledTextField = true;

  Future addRecord() async {
    var db = DBhelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}";

    var myData =
        MyData(cTitle.text, cNote.text,cKarya.text, dateNow, dateNow, now.toString());

    await db.saveData(myData);
    print("saved");
  }

  Future updateRecord() async {
    var db = new DBhelper();
    String dateNow =
        "${now.hour}:${now.minute}";

    var myData =
        MyData(cTitle.text, cNote.text, cKarya.text, createDate, dateNow, now.toString());

    myData.setDataId(this.myData.id);
    await db.updateData(myData);
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
    Navigator.of(context).pop();
  }

  void _editData() {
    setState(() {
      _enabledTextField = true;
      btnSave = true;
      btnEdit = false;
      btnDelete = true;
      title = "Edit Note";
    });
  }

  void delete(MyData myData) {
    var db = new DBhelper();
    db.deleteData(myData);
  }

  void _confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        'Yakin ingin dihapus ?..',
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text('Hapus!'),
          onPressed: () {
            Navigator.pop(context);
            delete(myData);
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          color: Colors.blueAccent,
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      child: alertDialog,
    );
  }

  @override
  void initState() {
    if (widget._myData != null) {
      myData = widget._myData;
      cTitle.text = myData.title;
      cNote.text = myData.deskripsi;
      cKarya.text = myData.karya;
      title = "My Puisiku";
      _enabledTextField = false;
      createDate = myData.createDate;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "New Data";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (BuildContext context) => BodyHome(),
              ),
            ),
            icon: Icon(
              Icons.close_rounded,
              color: Colors.black,
              size: 25.0,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CreateButton(
                    icon: Icons.save,
                    enable: btnSave,
                    onpress: _saveData,
                  ),
                  CreateButton(
                    icon: Icons.edit,
                    enable: btnEdit,
                    onpress: _editData,
                  ),
                  CreateButton(
                    icon: Icons.delete,
                    enable: btnDelete,
                    onpress: _confirmDelete,
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cTitle,
                  decoration: InputDecoration(
                    hintText: "Title",
                    
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cKarya,
                  decoration: InputDecoration(
                    hintText: "Karya Cipta",
                    
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cNote,
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[800],
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  CreateButton({this.icon, this.enable, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: enable ? Color(0xff392850) : Colors.grey,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 18.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}
