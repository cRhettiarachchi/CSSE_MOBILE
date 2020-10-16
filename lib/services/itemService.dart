import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemService {
  Dio dio = new Dio();

  getItems(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'items');
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

  getItem(token, itemId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'items/$itemId');
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

  purchaseOrder(String token, List allItems, String supplier, String id, String site) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.post(DotEnv().env['API_path'] + 'purchaseOrders/', data: {
        "supplier": supplier,
        "createBy": id,
        "items": allItems,
        "referenceNumber": '1010',
        "deliveryDetails": site
      });
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

  getAllOrders(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'purchaseOrders');
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

  getOrder(token, id) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get(DotEnv().env['API_path'] + 'purchaseOrders/$id');
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
