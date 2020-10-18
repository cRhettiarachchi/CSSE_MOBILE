import 'package:csse/landing.dart';
import 'package:csse/orderDetails.dart';
import 'package:csse/services/drafts.dart';
import 'package:csse/services/itemService.dart';
import 'package:csse/services/siteService.dart';
import 'package:csse/services/suppliers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals/auth.dart' as globals;
import 'models/Item.dart';
import 'models/Site.dart';
import 'models/Supplier.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  List<Item> _items = [];
  List finalItems = [];
  List finalData = [];
  List<Supplier> _suppliers = [];
  List<Site> _sites = [];
  Map individualItem;
  List<Map> tempIndividualItems = [];
  List<IndividualItem> individualItems = [];
  String selectedItem = '';
  String selectedSupplier = '';
  String selectedSite = '';
  int totalPrice = 0;
  int selectedQuantity = 1;

  Future<Null> getSites(BuildContext context) async {
    SiteService().getWareHouses(globals.token).then((data) {
      if (data != null) {
        _sites = (data.data['data'])
            .map<Site>((item) => Site.fromJson(item))
            .toList();
        setState(() {
          selectedSite = _sites[0].id;
        });
      }
    });
  }

  Future<Null> getValue(BuildContext context) async {
    ItemService().getItems(globals.token).then((data) {
      if (data != null) {
        _items = (data.data['data'])
            .map<Item>((item) => Item.fromJson(item))
            .toList();
        setState(() {
          selectedItem = _items[0].id;
        });
      }
    });
  }

  Future<Null> getSupplier(BuildContext context) async {
    SupplierService().getSuppliers(globals.token).then((data) {
      if (data != null) {
        _suppliers = (data.data['data'])
            .map<Supplier>((item) => Supplier.fromJson(item))
            .toList();
        setState(() {
          selectedSupplier = _suppliers[0].id;
        });
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getValue(context);
    getSupplier(context);
    getSites(context);
  }

  @override
  Widget build(BuildContext context) {
    var requisiteNo, comment;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroud.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Suppliers :'),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              child: DropdownButton(
                        hint: Text('Select Value'),
                        value: selectedSupplier,
                        items: _suppliers.map((supplier) {
                          return new DropdownMenuItem<String>(
                            value: supplier.id,
                            child: new Text(supplier.name,
                                style: new TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSupplier = value;
                          });
                        },
                      ))),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Warehouses :'),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              child: DropdownButton(
                        hint: Text('Select Value'),
                        value: selectedSite,
                        items: _sites.map((site) {
                          return new DropdownMenuItem<String>(
                            value: site.id,
                            child: new Text(site.name,
                                style: new TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSite = value;
                          });
                        },
                      ))),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, border: Border.all(width: 1.0)),
                  padding: EdgeInsets.all(5),
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
                              ),
                              DropdownMenuItem(
                                child: Text('4'),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                child: Text('5'),
                                value: 5,
                              ),
                              DropdownMenuItem(
                                child: Text('10'),
                                value: 10,
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
                              ItemService()
                                  .getItem(globals.token, selectedItem)
                                  .then((data) => {
                                        if (data != null)
                                          {
                                            setState(() {
                                              individualItem =
                                                  data.data['data'];

                                              individualItem[
                                                  'total'] = int.parse(
                                                      individualItem['price']) *
                                                  selectedQuantity;

                                              individualItem['qty'] =
                                                  selectedQuantity;

                                              totalPrice +=
                                                  individualItem['total'];
                                              tempIndividualItems
                                                  .add(individualItem);

                                              // Mapping to the individual Items array
                                              individualItems =
                                                  (tempIndividualItems)
                                                      .map<IndividualItem>(
                                                          (item) =>
                                                              IndividualItem
                                                                  .fromJson(
                                                                      item))
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
                    ],
                  ),
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
                                        Text(
                                          'Total :',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                            'Rs.' +
                                                item.total.toString() +
                                                '.00',
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
                    child: (individualItems.length > 0
                        ? (Row(
                            children: [
                              Spacer(),
                              Text(
                                'Total :',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Rs.' + totalPrice.toString() + '.00',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ))
                        : null)),
                new Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: totalPrice > 100000
                      ? (Text(
                          'This order will require approval from manager',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ))
                      : null,
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: individualItems.length > 0
                      ? (RaisedButton(
                          onPressed: () {
                            finalItems = individualItems
                                .map((e) => {
                                      "_id": e.id,
                                      "qty": e.qty.toString(),
                                      "name": e.name,
                                      "price": e.price,
                                      "subTotal": int.parse(e.price) * e.qty
                                    })
                                .toList();
                            finalData.add({"items": finalItems});
                            finalData.add({"supplier": selectedSupplier});
                            finalData.add({"createdBy": globals.userId});

                            ItemService()
                                .purchaseOrder(
                                    globals.token,
                                    finalItems,
                                    selectedSupplier,
                                    globals.userId,
                                    selectedSite,
                                    totalPrice)
                                .then((data) {
                              if (data != null) {
                                Route route = MaterialPageRoute(
                                    builder: (context) => OrderDetails(
                                        orderId: data.data['newPurchaseOrder']
                                            ['_id']));
                                Navigator.push(context, route);
                              }
                            });
                          },
                          child: totalPrice > 100000
                              ? (Text(
                                  'Request Permission',
                                  style: TextStyle(color: Colors.white),
                                ))
                              : (Text(
                                  'Create Purchase',
                                  style: TextStyle(color: Colors.white),
                                )),
                          color: Colors.black,
                        ))
                      : null,
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: individualItems.length > 0
                      ? (RaisedButton(
                          onPressed: () {
                            finalItems = individualItems
                                .map((e) => {
                                      "_id": e.id,
                                      "qty": e.qty.toString(),
                                      "name": e.name,
                                      "price": e.price,
                                      "subTotal": int.parse(e.price) * e.qty
                                    })
                                .toList();
                            finalData.add({"items": finalItems});
                            finalData.add({"supplier": selectedSupplier});
                            finalData.add({"createdBy": globals.userId});

                            DraftService()
                                .createDraft(
                                    globals.token,
                                    finalItems,
                                    selectedSupplier,
                                    globals.userId,
                                    selectedSite,
                                    totalPrice)
                                .then((data) {
                              if (data != null) {
                                Fluttertoast.showToast(
                                  msg: 'Draft Saved',
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                                Route route = MaterialPageRoute(
                                    builder: (context) => Landing(token: ''));
                                Navigator.push(context, route);
                              }
                            });
                          },
                          child: (Text(
                            'Save to drafts',
                            style: TextStyle(color: Colors.white),
                          )),
                          color: Colors.black,
                        ))
                      : null,
                ),
              ],
            ),
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
