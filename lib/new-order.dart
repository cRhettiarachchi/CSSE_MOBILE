import 'package:csse/services/itemService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals/auth.dart' as globals;

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  List<Item> _items = [];
  Map individualItem;
  List<Map> tempIndividualItems = [];
  List<IndividualItem> individualItems = [];
  String selectedItem = '';
  int totalPrice = 0;
  int selectedQuantity = 1;

  Future<Null> getValue(BuildContext context) async {
    ItemService().getItems(globals.token).then((data) {
      if (data != null) {
        _items = (data.data['data'])
            .map<Item>((item) => Item.fromJson(item))
            .toList();
        setState(() {
          selectedItem = _items[0].id;
          print(selectedItem);
        });
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getValue(context);
  }

  @override
  Widget build(BuildContext context) {
    var requisiteNo, comment;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text('Items :'),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          child: DropdownButton(
                    hint: Text('Select Value'),
                    value: selectedItem,
                    items: _items.map((item) {
                      return new DropdownMenuItem<String>(
                        value: item.id,
                        child: new Text(item.name,
                            style: new TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                    },
                  ))),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text('Quantity :'),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          child: DropdownButton(
                    hint: Text('Select Value'),
                    value: selectedQuantity,
                    items: [
                      DropdownMenuItem(
                        child: Text('1'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text('2'),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text('3'),
                        value: 3,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value;
                      });
                    },
                  ))),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      print(selectedItem);
                      ItemService()
                          .getItem(globals.token, selectedItem)
                          .then((data) => {
                                if (data != null)
                                  {
                                    // print(data.data['data'])
                                    setState(() {
                                      individualItem = data.data['data'];
                                      individualItem['total'] =
                                          int.parse(individualItem['price']) *
                                              selectedQuantity;
                                      individualItem['qty'] = selectedQuantity;
                                      totalPrice += individualItem['total'];
                                      tempIndividualItems.add(individualItem);
                                      // Mapping to the individual Items array
                                      individualItems = (tempIndividualItems)
                                          .map<IndividualItem>((item) =>
                                              IndividualItem.fromJson(item))
                                          .toList();
                                    })
                                  }
                              });
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: individualItems.map((item) {
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
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('Code :'),
                                          Text(
                                            item.code,
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
                                            'Rs.' + item.price.toString(),
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
                                      Text(
                                        'Total :',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text('Rs.' + item.total.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
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
                child: (
                    individualItems.length > 0 ? (
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Total :',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('Rs.' + totalPrice.toString(),
                                style:
                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        )
                    ) : null
                )
              ),

                new Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: individualItems.length > 0 ? (RaisedButton(
                    onPressed: () {
                      print(individualItems.map((e) => e.total));
                      ItemService().purchaseOrder(globals.token, individualItems);
                    },
                    child: Text(
                      'Create Purchase',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  )) : null,
                ),

            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String id;
  final String name;

  Item({this.id, this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return new Item(id: json['_id'], name: json['name']);
  }
}

class IndividualItem {
  final String name;
  final String id;
  final String price;
  final String code;
  final int total;
  final int qty;

  IndividualItem(
      {this.name, this.id, this.price, this.code, this.total, this.qty});

  factory IndividualItem.fromJson(Map<String, dynamic> json) {
    return new IndividualItem(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        code: json['code'],
        qty: json['qty'],
        total: json['total']);
  }
}
