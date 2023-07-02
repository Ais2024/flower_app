// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_import, camel_case_types

import 'package:flower_app/models/product.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class check extends StatelessWidget {
  const check({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [productandprice()],
        backgroundColor: appbargreen,
        title: Text("Check out"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: carttt.selectedproducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(carttt.selectedproducts[index].name),
                          subtitle:
                              Text("${carttt.selectedproducts[index].price}"),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                carttt.selectedproducts[index].imgpath),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              carttt.delete(carttt.selectedproducts[index]);
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "pay ${carttt.price}",
                style: TextStyle(fontSize: 19),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(BTNpink),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
