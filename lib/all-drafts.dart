import 'package:csse/draft-detail.dart';
import 'package:csse/services/drafts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'globals/auth.dart' as globals;
import 'models/Order.dart';

class AllDrafts extends StatefulWidget {
  @override
  _AllDrafts createState() => _AllDrafts();
}

class _AllDrafts extends State<AllDrafts> {
  List<Order> _allDrafts = [];

  Future<Null> getAllDrafts(BuildContext context) async {
    DraftService().getAllDrafts(globals.token).then((data) {
      if (data != null) {
        setState(() {
          _allDrafts = (data.data['data'])
              .map<Order>((order) => Order.fromJson(order))
              .toList();
        });

        print(_allDrafts[0].total);
        print(DateTime.parse(_allDrafts[0].date));
        print(DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(_allDrafts[0].date))));
        print(DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(_allDrafts[0].date))));
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getAllDrafts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Drafts'),
        backgroundColor: Colors.black,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroud.jpg'),
                fit: BoxFit.cover)),
        child: ListView.builder(
          itemCount: _allDrafts.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new InkWell(
              onTap: () {
                Route route = MaterialPageRoute(
                    builder: (context) =>
                        DraftDetail(orderId: _allDrafts[index].id));
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.all(1),
                height: 50,
                decoration: BoxDecoration(color: Colors.white,
                    // set border width
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey[300],
                          offset: Offset(1, 3))
                    ] // make rounded corner of border
                    ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              DateTime.parse(DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(
                                              _allDrafts[index].date)))
                                      .year
                                      .toString() +
                                  '-' +
                                  DateTime.parse(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(
                                              _allDrafts[index].date)))
                                      .month
                                      .toString() +
                                  '-' +
                                  DateTime.parse(DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(_allDrafts[index].date)))
                                      .day
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text('Order Total :'
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              'Rs.' +
                                  _allDrafts[index].total.toString() +
                                  '.00',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
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

