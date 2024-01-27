import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_with_api/consts/global_colors.dart';
import 'package:store_with_api/models/products_model.dart';
import 'package:store_with_api/screens/category_screen.dart';
import 'package:store_with_api/screens/feed_screen.dart';
import 'package:store_with_api/screens/users_screen.dart';
import 'package:store_with_api/services/api_handler.dart';
import 'package:store_with_api/widgets/feedsGrid.dart';

import 'package:store_with_api/widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _textEditingController;
  List<ProductsModel> productsList = [];

  @override
  void initState() {
    _textEditingController =
        TextEditingController(); // with this, the data persists
    super.initState();
  }

  @override
  void dispose() {
    // when you change screens and come back, that data is erased from earlier interaction
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(limit: '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        leading: AppBarIcon(
          function: () {
            Navigator.push(
                context,
                PageTransition(
                    child: CategoryScreen(), type: PageTransitionType.fade));
          },
          icon: IconlyBold.category,
        ),
        actions: [
          AppBarIcon(
            function: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: UsersScreen(), type: PageTransitionType.fade));
            },
            icon: IconlyBold.user3,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1)),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconsColor,
                    )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.25,
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SaleWidget(),
                        );
                      },
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white, activeColor: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Latest Products",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        AppBarIcon(
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FeedsScreen(
                                        productsList: productsList,
                                      )));
                            },
                            icon: IconlyBold.arrowRight2),
                      ],
                    ),
                  ),
                  FutureBuilder<List<ProductsModel>>(
                    future: APIHandler.getAllProducts(limit: '4'),
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

                      return FeedsGridWidget(productsList: snapshot.data!);
                    }),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key, required this.icon, required this.function});
  final IconData icon;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).cardColor),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
