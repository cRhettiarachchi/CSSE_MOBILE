import 'package:csse/all-orders.dart';
import 'package:csse/login.dart';
import 'package:csse/new-order.dart';
import 'package:flutter/material.dart';
import 'globals/auth.dart' as globals;

class Landing extends StatelessWidget {
  final String token;

  Landing({this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.black,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => print(''),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: Text('Welcome', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => NewOrder());
                    Navigator.push(context, route);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 50,),
                      Text('New Order', style: TextStyle(color: Colors.white, fontSize: 35),),
                    ],
                  ),
                  color: Colors.black,
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => AllOrders());
                    Navigator.push(context, route);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, color: Colors.white, size: 50,),
                      Text('All Orders', style: TextStyle(color: Colors.white, fontSize: 35),),
                    ],
                  ),
                  color: Colors.black,
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => AllOrders());
                    Navigator.push(context, route);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.drafts, color: Colors.white, size: 45,),
                      Text('View Drafts', style: TextStyle(color: Colors.white, fontSize: 35),),
                    ],
                  ),
                  color: Colors.black,
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => Login());
                    Navigator.push(context, route);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.white, size: 45,),
                      Text('Logout', style: TextStyle(color: Colors.white, fontSize: 35),),
                    ],
                  ),
                  color: Colors.black,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
