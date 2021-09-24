import 'package:flutter/material.dart';

class SearchificationAppBar extends StatelessWidget {
  const SearchificationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      stretch: true,
      expandedHeight: 100.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
          bottom: 8,
          top: 8,
          left: 32,
          right: 32,
        ),
        background: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.8,
                colors: [Colors.black,Colors.black],
              )),
        ),
        centerTitle: true,
        title: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: LayoutBuilder(
            builder: (context, size) {
              return Container(
                width: size.biggest.width*0.9,
                child: SafeArea(
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );;
  }
}
