import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var requisiteNo;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
          Container(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Requisite No'),
                  onChanged: (val) {
                    requisiteNo = val;
                  },
                ),
          ),

            Container(
              child: TextField(
                decoration: InputDecoration(labelText: 'date'),
                onChanged: (val) {
                  requisiteNo = val;
                },
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       child: Text('Requisite No.'),
            //     ),
            //     Container(
            //       child: TextField(
            //         decoration: InputDecoration(labelText: 'Requisite No'),
            //         onChanged: (val) {
            //           requisiteNo = val;
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
