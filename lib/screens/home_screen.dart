import 'package:flutter/material.dart';
import 'package:searchification/screens/search_screen.dart';
import 'package:searchification/utils/app_bar.dart';
import 'package:searchification/utils/miscellaneous_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SearchificationAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                  child: Text.rich(
                TextSpan(
                    text:
                        'Click on your favorite search provider to get started!\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '~ Unfortunately, only Google is available for now, but others will be made available soon! ~',
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontStyle: FontStyle.normal,
                            color: Colors.indigo),
                      )
                    ]),
              )),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ButtonBar(
                      buttonPadding: EdgeInsets.all(5),
                      alignment: MainAxisAlignment.center,
                      children: [
                        SearchificationButtons.logoButton('assets/yahoo_logo.png',
                            () => print('yahoo'), Colors.purple),
                        SearchificationButtons.logoButton(
                            'assets/google_logo.png',
                            () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()),
                                ),
                            Colors.deepOrange,
                            true),
                        SearchificationButtons.logoButton('assets/baidu_logo.png',
                            () => print('baidu'), Colors.blue),
                      ],
                ),
              )
          ],
        ),
            ),
      ),
    ]));
  }
}
