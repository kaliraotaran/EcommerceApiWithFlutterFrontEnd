import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:store_with_api/consts/api_const.dart';
import 'package:store_with_api/models/categories_model.dart';
import 'package:store_with_api/models/products_model.dart';
import 'package:store_with_api/models/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/$target");
      var response = await http.get(uri);

      // print(jsonDecode(response.body));
      var data = jsonDecode(response.body);

      List tempList = [];

      if (response.statusCode != 200) {
        throw data['messsage'];
      }

      for (var v in data) {
        tempList.add(v);
      }
      return tempList;
    } catch (e) {
      print('error occured $e');
      throw e.toString();
    }
  }

  static Future<List<ProductsModel>> getAllProducts(
      {required String limit}) async {
    // var uri = Uri.https(BASE_URL, "api/v1/products");
    // var response = await http.get(uri);

    // // print(jsonDecode(response.body));
    // var data = jsonDecode(response.body);

    // List tempList = [];

    // for (var v in data) {
    //   tempList.add(v);
    // }
    List temp = await getData(target: 'products');
    return ProductsModel.productsFromsnapshot(temp);
  }

  static Future<List<CategoryModel>> getAllCategories(
      {required String limit}) async {
    // var uri = Uri.https(BASE_URL, "api/v1/categories");
    // var response = await http.get(uri);

    // // print(jsonDecode(response.body));
    // var data = jsonDecode(response.body);

    // List tempList = [];

    // for (var v in data) {
    //   tempList.add(v);
    // }
    List temp = await getData(target: 'categories');

    return CategoryModel.categoriesFromsnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers({required String limit}) async {
    List temp = await getData(target: 'users');
    return UsersModel.usersFromsnapshot(temp);
  }

  static Future<ProductsModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri);

      // print(jsonDecode(response.body));
      var data = jsonDecode(response.body);

      return ProductsModel.fromJson(data);
    } catch (e) {
      print('error occured while getting product details $e');
      throw e.toString();
    }
  }
}
