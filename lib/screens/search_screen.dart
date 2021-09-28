import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:searchification/providers/search_provider.dart';
import 'package:searchification/screens/results_screen.dart';

/// Search screen that contains and manages search bar and displays
/// the [ResultsScreen] once search results are returned.
///
class SearchScreen extends StatelessWidget {
  ScrollController? _scrollController;
  final searchController = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    if (_scrollController == null) {
      _scrollController = ScrollController();
    }
    return Consumer<SearchProvider>(
      builder: (context, provider, _) => Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            buildFloatingSearchBar(context, provider),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 4.5,
                        offset: Offset.zero),
                  ]),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.blue,
              )),
          onPressed: () {
            print('scrolling to top..');
            _scrollController!.animateTo(0.0,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          tooltip: 'scroll back to the top',
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar(context, SearchProvider provider) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      // defining this controller allows us to implement
      // the scroll back to top functionality.
      scrollController: _scrollController,
      controller: searchController,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      autocorrect: false,
      isScrollControlled: true,
      onSubmitted: (query) {
        if (query.isEmpty) return;
        print('query submitted: $query');
        provider.setQuery(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
            showIfOpened: true,
            child: CircularButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                provider.setQuery("");
                searchController.clear();
              },
            )),
      ],
      builder: (context, transition) => (!provider.isSearching &&
              !provider.isQueryEmpty())
          ? ResultsScreen()
          : Center(
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  'Enter something in the search field and submit to start searching!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.blue, fontSize: 18, height: 1.8)),
            )),

    );
  }
}
