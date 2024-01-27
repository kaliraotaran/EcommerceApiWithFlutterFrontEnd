import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_with_api/models/categories_model.dart';
import 'package:store_with_api/services/api_handler.dart';
import 'package:store_with_api/widgets/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Categories')),
        body: FutureBuilder<List<CategoryModel>>(
          future: APIHandler.getAllCategories(limit: '4'),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              Center(
                child: Text('an error has occured'),
              );
            } else if (snapshot.data == null) {
              Center(
                child: Text('No Products have been added yet'),
              );
            }

            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 1.2),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      child: const CategoryWidget());
                });
          }),
        ));
  }
}
