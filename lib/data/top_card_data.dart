import 'package:animated_liist/models/top_card_model.dart';
import 'package:flutter/cupertino.dart';

final List<TopCardModel> topCard = [
  TopCardModel(
    color: const Color(0xffeaae36),
    icon: CupertinoIcons.heart,
    title: "Most Favourites",
  ),
  TopCardModel(
    color: const Color(0xff46c0f5),
    icon: CupertinoIcons.arrow_2_circlepath_circle,
    title: "Newest",
  ),
  TopCardModel(
    color: const Color(0xffadd6f5),
    icon: CupertinoIcons.alarm,
    title: "Supers",
  ),
];
