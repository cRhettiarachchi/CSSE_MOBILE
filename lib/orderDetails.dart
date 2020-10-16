import 'package:csse/services/itemService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals/auth.dart' as globals;

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState(id: orderId);
  final String orderId;

  OrderDetails({this.orderId});
}

class _OrderDetailState extends State<OrderDetails> {
  final String id;
  List<IndividualItem> _items = [];
  Map supplier = {};
  Map deliveryDetails = {};
  String referenceNo = '';
  String status = '';
  int total = 0;

  _OrderDetailState({this.id});

  Future<Null> getOrder(BuildContext context) async {
    print(id);
    ItemService().getOrder(globals.token, id).then((data) {
      if (data != null) {
        setState(() {
          print(data.data['data']['items']);
          _items = (data.data['data']['items'])
              .map<IndividualItem>((item) => IndividualItem.fromJson(item))
              .toList();

          supplier = data.data['data']['supplier'];
          referenceNo = data.data['data']['referenceNumber'];
          deliveryDetails = data.data['data']['deliveryDetails'];
          status = data.data['data']['status'];
          for(var i = 0; i < _items.length; i++) {
            total += _items[i].subTotal;
          }
        });
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Order Number: ',
                          style: TextStyle(fontSize: 16)),
                    ),
                      Text(referenceNo,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Supplier: ', style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(supplier['name'].toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Warehouse: ',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(deliveryDetails['name'].toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Location: ',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(deliveryDetails['address'].toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Delivery Date: ',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: Text('2020/10/20',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Status: ', style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: Text(status,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: [
                    Text('Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: _items.map((item) {
                        return new Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('Name :'),
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('Quantity :'),
                                          Text(
                                            item.qty.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('Price :'),
                                          Text(
                                            'Rs.' +
                                                item.price.toString() +
                                                '.00',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Total :'),
                                            Text(
                                              item.subTotal.toString() + '.00',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Container(
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Total :',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('Rs.' + total.toString() + '.00',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class IndividualItem {
  final String name;
  final String id;
  final String price;
  final String code;
  final int subTotal;
  final String qty;

  IndividualItem(
      {this.name, this.id, this.price, this.code, this.subTotal, this.qty});

  factory IndividualItem.fromJson(Map<String, dynamic> json) {
    return new IndividualItem(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        code: json['code'],
        qty: json['qty'],
        subTotal: json['subTotal']);
  }
}
