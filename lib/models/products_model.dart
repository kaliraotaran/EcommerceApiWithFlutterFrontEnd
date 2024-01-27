import 'package:flutter/material.dart';
import 'package:store_with_api/models/categories_model.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  CategoryModel? category;

  ProductsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.images,
      this.creationAt,
      this.updatedAt,
      this.category});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
  }
  static List<ProductsModel> productsFromsnapshot(List productsnapshot) {
    return productsnapshot.map((data) {
      print(data);
      return ProductsModel.fromJson(data);
    }).toList();
  }

// we dont need this cause it's used for sending the data, not getting(recieving it)
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['price'] = this.price;
  //   data['description'] = this.description;
  //   data['images'] = this.images;
  //   data['creationAt'] = this.creationAt;
  //   data['updatedAt'] = this.updatedAt;
  //   if (this.category != null) {
  //     data['category'] = this.category!.toJson();
  //   }
  //   return data;
  // }
}
