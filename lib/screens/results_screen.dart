import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:searchification/models/search_result.dart';
import 'package:searchification/providers/search_provider.dart';
import 'package:searchification/screens/detailed_image_screen.dart';

/// Displays and shows search results in a grid view with pagination that
/// handles the fetching.
///
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  var oldQuery = '';

  final PagingController<int, SearchResultImage> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      print('next page requested: $pageKey');
      _fetchPage(pageKey);
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching new images.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }


  Future<void> _fetchPage(int pageKey) async {
    print("fetching pages....");
    try {
      var searchProvider = Provider.of<SearchProvider>(context, listen: false);
      final newImages = await searchProvider.searchImages(pageKey);
      print('images fetched: ${newImages.length}');
      print('images fetched so far: ${_pagingController.itemList?.length}');

      if (pageKey == 0) { // fetch up to 300 images only
        _pagingController.appendLastPage(newImages);
      }
      else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newImages, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    var newQuery = Provider.of<SearchProvider>(context, listen:false).query;

    if (oldQuery.isEmpty || oldQuery != newQuery){
      if (newQuery.isNotEmpty){
        oldQuery = newQuery;
        _pagingController.refresh();
      }
    }

    return RefreshIndicator(
      onRefresh: () async {
        print('refreshing results..');
        return await Future.sync(
            () => _pagingController.refresh(),
      );},
      child: Container(
        color: Colors.black,
        child: PagedGridView<int, SearchResultImage>(
          shrinkWrap: true,
          reverse: false,
            physics: ScrollPhysics(),
            pagingController: _pagingController,
            padding: const EdgeInsets.all(8),
            builderDelegate: PagedChildBuilderDelegate<SearchResultImage>(
              itemBuilder: (context, image, index){
                return DetailedImageView(image: image);
              }
            ), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        ),
      ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
