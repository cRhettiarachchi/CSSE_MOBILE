import 'package:csse/new-order.dart';
import 'package:csse/orderDetails.dart';
import 'package:csse/services/itemService.dart';
import 'package:flutter/material.dart';
import 'globals/auth.dart' as globals;

class AllOrders extends StatefulWidget {
  @override
  _AllOrderState createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrders> {
  List<Order> _allOrders = [];

  Future<Null> getAllOrders(BuildContext context) async {
    ItemService().getAllOrders(globals.token).then((data) {
      if (data != null) {
        setState(() {
          _allOrders = (data.data['data'])
              .map<Order>((order) => Order.fromJson(order))
              .toList();
        });

        print(_allOrders);
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getAllOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
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
                fit: BoxFit.cover
            )
        ),
        child: ListView.builder(
          itemCount: _allOrders.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new InkWell(
              onTap: () {
                Route route = MaterialPageRoute(
                    builder: (context) =>
                        OrderDetails(orderId: _allOrders[index].id));
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
                              _allOrders[index].referenceNumber,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            child: Text('Status :'),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              _allOrders[index].status,
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

class Order {
  final String referenceNumber;
  final String id;
  final String status;

  Order({this.referenceNumber, this.id, this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return new Order(
        id: json['_id'],
        referenceNumber: json['referenceNumber'],
        status: json['status']);
  }
}
