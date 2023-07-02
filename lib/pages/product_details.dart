// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flower_app/models/product.dart';
import 'package:flower_app/shared/appbar.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Items product;

  Details({required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isshowmore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbargreen,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [productandprice()],
        title: Text("DETAILS SCREEN"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imgpath),
            SizedBox(height: 11),
            Text(
              "\$ ${widget.product.price}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  // ignore: sort_child_properties_last
                  child: Text(
                    "NEW",
                    style: TextStyle(fontSize: 12),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4)),
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.yellowAccent,
                    ),
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.yellowAccent,
                    ),
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.yellowAccent,
                    ),
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.yellowAccent,
                    ),
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.yellowAccent,
                    ),
                  ],
                ),
                SizedBox(width: 70),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.edit_location,
                      size: 25,
                      color: Colors.green,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "flower shop",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                "DETAILS : ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: Text(
                  "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae)."
                  " The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs.",
                  style: TextStyle(fontSize: 18),
                  maxLines: isshowmore ? 3 : null,
                  overflow: TextOverflow.fade,
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    isshowmore = !isshowmore;
                  });
                },
                child: Text(
                  isshowmore ? "show more" : "show less",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
