import 'package:e_commerce_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(60)
      .padding(const EdgeInsets.all(4))
      .make();
}
