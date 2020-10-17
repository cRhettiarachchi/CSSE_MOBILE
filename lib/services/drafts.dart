import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DraftService {
  Dio dio = new Dio();

  createDraft(String token, List allItems, String supplier, String id,
      String site, int total) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.post(
          DotEnv().env['API_path'] + 'drafts/', data: {
        "supplier": supplier,
        "createBy": id,
        "items": allItems,
        "deliveryDetails": site,
        "total": total
      });
    } on DioError catch (error) {
      print(error.response.data.toString());
      Fluttertoast.showToast(
        msg: 'Adding Draft Failed',
        backgroundColor: Color.fromARGB(255, 123, 255, 123),
        textColor: Color.fromARGB(255, 255, 255, 255),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  getAllDrafts(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'drafts');
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

  getDraft(token, id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'drafts/$id');
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
