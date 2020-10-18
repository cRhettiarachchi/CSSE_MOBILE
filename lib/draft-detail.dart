// package imports
import 'package:csse/services/drafts.dart';
import 'package:csse/services/itemService.dart';
import 'package:csse/services/siteService.dart';
import 'package:csse/services/suppliers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Globals
import 'globals/auth.dart' as globals;

// Model imports
import 'models/Item.dart';
import 'models/Site.dart';
import 'models/Supplier.dart';


class DraftDetail extends StatefulWidget {
  @override
  _DraftDetailState createState() => _DraftDetailState(id: orderId);
  final String orderId;

  DraftDetail({this.orderId});
}

class _DraftDetailState extends State<DraftDetail> {
  final String id;
  List<IndividualItem> selectedItems = [];
  Map supplier = {};
  Map deliveryDetails = {};
  int total = 0;
  int selectedQuantity = 1;
  IndividualItem selectedValue;

  // updated data
  String selectedSupplier = '';
  String selectedSite = '';
  String selectedItem = '';

  // lists
  List<Supplier> _suppliers = [];
  List<Site> _sites = [];
  List<Item> _items = [];

  _DraftDetailState({this.id});

  ///
  /// Method to get all drafts
  Future<Null> getDraft(BuildContext context) async {
    print(id);
    DraftService().getDraft(globals.token, id).then((data) {
      if (data != null) {
        setState(() {
          print(id);
          selectedItems = (data.data['data']['items'])
              .map<IndividualItem>((item) => IndividualItem.fromJson(item))
              .toList();

          selectedSupplier = data.data['data']['supplier'] != null
              ? data.data['data']['supplier']['_id']
              : null;
          selectedSite = data.data['data']['deliveryDetails'] != null
              ? data.data['data']['deliveryDetails']['_id']
              : null;
          total = data.data['data']['total'];
        });
      }
    });
  }

  Future<Null> getSites(BuildContext context) async {
    SiteService().getWareHouses(globals.token).then((data) {
      if (data != null) {
        _sites = (data.data['data'])
            .map<Site>((item) => Site.fromJson(item))
            .toList();
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
      }
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getDraft(context);
    getSites(context);
    getValue(context);
    getSupplier(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continue Order'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
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
                                  .then((data) {
                                if (data != null) {
                                  print(data.data['data']);

                                  selectedValue = new IndividualItem(
                                      name: data.data['data']['name'],
                                      price: data.data['data']['price'],
                                      id: data.data['data']['_id'],
                                      subTotal: int.parse(
                                              data.data['data']['price']) *
                                          selectedQuantity,
                                      qty: selectedQuantity.toString());

                                  setState(() {
                                    selectedItems.add(selectedValue);
                                    total += selectedValue.subTotal;
                                  });
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
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Items',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: selectedItems.map((item) {
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
                                                item.subTotal.toString() +
                                                    '.00',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                new Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: RaisedButton(
                    onPressed: () {
                      ItemService()
                          .purchaseOrder(
                              globals.token,
                              selectedItems,
                              selectedSupplier,
                              globals.userId,
                              selectedSite,
                              total)
                          .then((data) {
                        if (data != null) {
                          print(data.data['newPurchaseOrder']);
                          // Route route = MaterialPageRoute(
                          //     builder: (context) => OrderDetails(
                          //         orderId: data.data['newPurchaseOrder']
                          //         ['_id']));
                          // Navigator.push(context, route);
                        }
                      });
                    },
                    child: total > 100000
                        ? (Text(
                            'Request Permission',
                            style: TextStyle(color: Colors.white),
                          ))
                        : (Text(
                            'Create Purchase',
                            style: TextStyle(color: Colors.white),
                          )),
                    color: Colors.black,
                  ),
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
  final int subTotal;
  final String qty;

  IndividualItem({this.name, this.id, this.price, this.subTotal, this.qty});

  factory IndividualItem.fromJson(Map<String, dynamic> json) {
    return new IndividualItem(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        qty: json['qty'],
        subTotal: json['subTotal']);
  }
}
