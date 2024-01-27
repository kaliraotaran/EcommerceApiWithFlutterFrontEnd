// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_with_api/models/users_model.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UsersModel usersModelProvider = Provider.of<UsersModel>(context);
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.1,
        width: size.width * 0.10,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 35,
        ),
        imageUrl: usersModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title: Text(
        usersModelProvider.name.toString(),
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      subtitle: Text('Email '),
      trailing: Text(
        usersModelProvider.email.toString(),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
