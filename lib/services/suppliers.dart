import 'dart:ui';

import 'package:csse/new-order.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupplierService {
  Dio dio = new Dio();

  getSuppliers(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'suppliers');
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
