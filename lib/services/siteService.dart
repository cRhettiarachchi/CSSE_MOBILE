import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SiteService {
  Dio dio = new Dio();

  getWareHouses(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'warehouses');
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
