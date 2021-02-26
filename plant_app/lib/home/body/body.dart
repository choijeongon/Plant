import 'package:flutter/material.dart';
import 'package:plant_app/home/body/detail/bottomCard.dart';
import 'package:plant_app/home/body/detail/headerWithSearchbox.dart';
import 'package:plant_app/home/body/detail/middleSlider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // it enable scrolling on small device
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          MiddleSlider(),
          BottomCard()
        ],
      ),
    );
  }
}