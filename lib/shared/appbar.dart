// ignore_for_file: camel_case_types, sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names

import 'package:flower_app/pages/check_screen.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productandprice extends StatelessWidget {
  const productandprice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<Cart>(builder: ((context, CartInstance, child) {
          return Stack(
            children: [
              Container(
                child: Text(
                  "${CartInstance.selectedproducts.length}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(211, 164, 255, 193),
                    shape: BoxShape.circle),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => check(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_shopping_cart,
                  )),
            ],
          );
        })),
        Consumer<Cart>(builder: ((context, CartInstance, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              "${CartInstance.price}",
              style: TextStyle(fontSize: 20),
            ),
          );
        })),
      ],
    );
  }
}
