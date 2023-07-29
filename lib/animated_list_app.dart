import 'package:animated_liist/data/cart_data.dart';
import 'package:animated_liist/data/top_card_data.dart';
import 'package:animated_liist/widgets/cart_item.dart';
import 'package:animated_liist/widgets/custom_clipper.dart';
import 'package:animated_liist/widgets/persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedListApp extends StatefulWidget {
  const AnimatedListApp({super.key});

  @override
  State<AnimatedListApp> createState() => _AnimatedListAppState();
}

class _AnimatedListAppState extends State<AnimatedListApp> {
  final _scrollController = ScrollController();
  double itemHeight = 180.0;
  bool isStartScrolling = false;

  void onListenToScroll() {
    if (_scrollController.offset > 50) {
      isStartScrolling = true;
    } else if (_scrollController.offset < 50) {
      isStartScrolling = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(onListenToScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late double opacity;
    if (_scrollController.hasClients) {
      opacity = 2 - (_scrollController.offset / itemHeight * 2);
      if (opacity > 1.0) opacity = 1.0;
      if (opacity < 0.0) opacity = 0.0;
    } else {
      opacity = 1.0;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomAppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            clipBehavior: Clip.antiAlias,
            slivers: [
              SliverToBoxAdapter(
                child: Opacity(
                  opacity: isStartScrolling ? opacity : 1.0,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 270,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 25, bottom: 10, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discover",
                                  style: GoogleFonts.tajawal().copyWith(
                                    color: Colors.black54,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "View all>",
                                  style: GoogleFonts.quicksand().copyWith(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topCard.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                color: topCard[index].color,
                                child: SizedBox(
                                  width: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 10.0,
                                      right: 15,
                                      bottom: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          topCard[index].title,
                                          style:
                                              GoogleFonts.quicksand().copyWith(
                                            color: Colors.grey.shade300,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            Icon(
                                              topCard[index].icon,
                                              color: Colors.grey.shade300,
                                              size: 35,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentHeader(title: "My Coupons"),
                floating: true,
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final cartItem = items[index];
                    final itemPositionOffset = index * itemHeight / 1.42;
                    final difference =
                        _scrollController.offset - itemPositionOffset;
                    final percent = 1.2 - (difference / (itemHeight / 1.2));

                    double opacity = percent;
                    if (opacity > 1.0) opacity = 1.0;
                    if (opacity < 0.0) opacity = 0.0;

                    return Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Align(
                        heightFactor: 0.6,
                        child: Opacity(
                          opacity: opacity,
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 40.0,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: CartItem(
                                  cart: cartItem,
                                  itemHeight: itemHeight,
                                  scale: opacity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ],
          ),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100, //New
                    blurRadius: 40.0,
                    offset: const Offset(0, -20),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 45.0, right: 45.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Transform.rotate(
                          angle: 30.5,
                          child: Icon(
                            Icons.send,
                            color: Colors.grey.shade400,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Send Money",
                          style: GoogleFonts.quicksand().copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.grey.shade400,
                          size: 32,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Services",
                          style: GoogleFonts.quicksand().copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -40),
            child: const CircleAvatar(
              radius: 42,
              backgroundColor: Colors.lightBlueAccent,
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
