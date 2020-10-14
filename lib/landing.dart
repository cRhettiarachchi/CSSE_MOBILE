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
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (context) => NewOrder());
                          Navigator.push(context, route);
                        },
                        child: Text('New Order', style: TextStyle(color: Colors.white),),
                        color: Colors.black,
                      ),
                    ),
                ),
                Expanded(
                  child:Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {

                      },
                      child: Text('View Drafts', style: TextStyle(color: Colors.white),),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
