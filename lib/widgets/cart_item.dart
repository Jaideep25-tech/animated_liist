import 'package:animated_liist/models/cart_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.cart,
    required this.itemHeight,
    required this.scale,
    super.key,
  });

  final CartModel cart;
  final double itemHeight;

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      width: MediaQuery.sizeOf(context).width * (scale + 0.1),
      child: Card(
        key: Key(cart.image),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        color: cart.color,
        child: SizedBox(
            height: itemHeight * scale,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.0 * scale, top: 10.0 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35 * scale,
                          width: 35 * scale,
                          child: Image.asset(cart.logo),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          cart.title,
                          style: GoogleFonts.quicksand().copyWith(
                            fontSize: 14 * scale,
                            color: cart.priceColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0.0, -5.0 * scale),
                          child: RichText(
                            text: TextSpan(
                              text: "- ${cart.price.toString()}",
                              style: GoogleFonts.quicksand().copyWith(
                                fontSize: 35 * scale,
                                color: cart.priceColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' %',
                                  style: TextStyle(
                                    color: cart.priceColor,
                                    fontSize: 20 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 170,
                    width: 100,
                    child: Image.asset(
                      cart.image,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
