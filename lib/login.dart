import 'package:csse/landing.dart';
import 'package:csse/services/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'globals/auth.dart' as globals;
import 'package:jwt_decoder/jwt_decoder.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email, password, token;
    return Scaffold(
      appBar: AppBar(
        title: Text('Procurement'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 80, 30, 30),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Please enter login details',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextField(
                decoration: InputDecoration(labelText: 'email'),
                onChanged: (val) {
                  email = val;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'password'),
                onChanged: (val) {
                  password = val;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: RaisedButton(
                  onPressed: () {
                    AuthService().login(email, password).then((data) {
                      if (data != null) {
                        token = data.data['data']['token'];
                        globals.token = token;
                        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
                        globals.userId = decodedToken['_id'];
                        Route route = MaterialPageRoute(builder: (context) => Landing(token: token,));
                        Navigator.push(context, route);
                      }
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                )),
          ],
        ),
      ),
    );
  }
}