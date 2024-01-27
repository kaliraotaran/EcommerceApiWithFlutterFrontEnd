import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store_with_api/consts/global_colors.dart';
import 'package:store_with_api/models/products_model.dart';
import 'package:store_with_api/services/api_handler.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.id});
  final String id;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductsModel? productsModel;

  Future<void> getProductInfo() async {
    productsModel = await APIHandler.getProductById(id: widget.id);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: productsModel == null
            ? Center(child: const CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsModel!.category!.name.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(
                                  productsModel!.title.toString(),
                                  textAlign: TextAlign.start,
                                  style: titleStyle,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                      text: '\$ ',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.green),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                productsModel!.price.toString(),
                                            style: TextStyle(
                                                color: lightTextColor,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return FancyShimmerImage(
                            width: double.infinity,
                            imageUrl: productsModel!.images![index].toString(),
                            boxFit: BoxFit.fill,
                          );
                        },

                        autoplay: true,
                        itemCount: 3,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.red,
                          ),
                        ),
                        // control: const SwiperControl(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text('Description', style: titleStyle)),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            productsModel!.description.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
