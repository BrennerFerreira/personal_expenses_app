import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/home_page/widgets/carousel_dot.dart';

class PageDots extends StatelessWidget {
  final PageViewBloc bloc;

  const PageDots({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageViewBloc, int>(
      value: bloc,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselDot(
              currentIndex: state,
              page: 0,
            ),
            CarouselDot(
              currentIndex: state,
              page: 1,
            ),
            CarouselDot(
              currentIndex: state,
              page: 2,
            ),
            CarouselDot(
              currentIndex: state,
              page: 3,
            ),
          ],
        );
      },
    );
  }
}
