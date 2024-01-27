import 'package:flutter/material.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
              colors: [
                Color(0xFF1B1360),
                Color(0xFFA5273D),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 84, 72, 135),
                    borderRadius: BorderRadius.circular(18)),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'EOS SALE',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Flexible(
                          flex: 3,
                          child: SizedBox(
                            height: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '70% OFF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Image.asset(
                  'assets/images/shoe.png',
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ))
        ],
      ),
    );
  }
}
