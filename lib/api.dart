import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class CategoryController extends ChangeNotifier {
  List<ModelCategory> listCategory = [];
  List<bool> open = [];
  bool loading = true;

  Future get() async {
    Future.delayed(Duration(seconds: 3), () async {
      Uri api = Uri.parse(
          'https://sindomall.com/api/get-main-product-categories?access_token=2cfcc3c66f6663391fbeacd9726a555b69ba2f301cb95102480ea42038fba1d71042e48f7691479265184321c340b4d56581ee59b58d9d56');

      var resul = await http.post(api,
          body: {'server_key': 'c36edcc96abfc7f5a07db022f2c3b096', 'id': '1'});

      var json = jsonDecode(resul.body);

      List<ModelCategory> list = (json['data'] as List<dynamic>).map((e) {
        open.add(false);
        return ModelCategory.fromJson(e);
      }).toList();

      print(open.length);
      listCategory = list;
      print(listCategory.length);
      loading = false;

      notifyListeners();
    });
  }

  void openCart(int index) {
    Future.delayed(Duration(milliseconds: 400 + (index * 250)), () {
      open[index] = true;
      notifyListeners();
    });
  }
}
