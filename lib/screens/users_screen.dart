import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_with_api/models/users_model.dart';
import 'package:store_with_api/services/api_handler.dart';
import 'package:store_with_api/widgets/users_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users page'),
        ),
        body: FutureBuilder<List<UsersModel>>(
          future: APIHandler.getAllUsers(limit: '4'),
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

            return ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value: snapshot.data![index], child: UsersWidget());
                });
          }),
        ));
  }
}
