import 'package:flutter/material.dart';

class CarouselDot extends StatelessWidget {
  final double currentIndex;
  final double page;

  const CarouselDot({
    Key? key,
    required this.currentIndex,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: currentIndex >= page - 0.5 && currentIndex < page + 0.5 ? 15 : 5,
      height: 5,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: currentIndex >= page - 0.5 && currentIndex < page + 0.5
            ? Theme.of(context).accentColor
            : Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
