import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  login(email, password) async {
    print('password : ');
    print(password);
    print(DotEnv().env['API_path'] + 'auth/login');
    try {
      return await dio.post(DotEnv().env['API_path'] + 'auth/login',
          data: {"email": email, "password": password});
    } on DioError catch (error) {
      print(error.response.data.toString());
      Fluttertoast.showToast(
        msg: 'Login Failed',
        backgroundColor: Color.fromARGB(255, 123, 255, 123),
        textColor: Color.fromARGB(255, 255, 255, 255),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
