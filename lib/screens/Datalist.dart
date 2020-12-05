import 'package:flutter/material.dart';
import 'package:project_sederhana_app/model/mydata.dart';
import 'package:project_sederhana_app/screens/ProductPage.dart';

class DataList extends StatefulWidget {
  final List<MyData> dataProduct;

  DataList(this.dataProduct, {Key key});

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
        ),
        title: Text(
          'Buku Puisiku',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "NerkoOne",
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xff392850),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new ProductPage(null, true),
              ),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3,
          ),
          itemCount:
              widget.dataProduct.length == null ? 0 : widget.dataProduct.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ProductPage(widget.dataProduct[i], false),
                  ),
                );
              },
              child: Card(
                color: Color(0xff453658),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text(
                        widget.dataProduct[i].title,
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.dataProduct[i].deskripsi,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'JosefinSans',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Karya: ${widget.dataProduct[i].karya}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
