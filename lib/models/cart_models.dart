import 'package:flutter/material.dart';

class CartModel {
  final String title;
  final String image;
  final Color color;
  final String logo;
  final double price;
  final Color priceColor;

  CartModel({
    required this.title,
    required this.image,
    required this.color,
    required this.logo,
    required this.price,
    required this.priceColor,
  });
}
