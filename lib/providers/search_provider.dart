import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:searchification/models/Search_result.dart';
import 'package:searchification/services/search_api_service.dart';

/// This provider class is our business logic that rests between the [SearchAPI]
/// service and the UI. This helps decouple our services (backend) from our
/// screens/UI (frontend).
///
class SearchProvider extends ChangeNotifier {
  final SearchAPI searchService;
  String _query = "";

  SearchProvider() : searchService = SearchAPI();

  setQuery(newQuery) {
    _query = newQuery;
    print('new query: $newQuery');
    // the only listener interested in being notified of a  new
    // query is the ResultsScreen.
    notifyListeners();
  }

  isQueryEmpty() => _query.isEmpty;

  /// Main function that does the search, gets the results, and converts it
  /// to our data model: [SearchResultImage].
  ///
  Future<List<SearchResultImage>> searchImages([int? pageNum]) async {
    if (_query.isEmpty) return <SearchResultImage>[];
    var response = await searchService.queryAPI(_query, pageNum);
    if (response.statusCode == 200) {
      var imagesResults = jsonDecode(response.body)['images_results']
          .map((rawInfo) => SearchResultImage.fromJson(rawInfo));
      print('from provider; imagesResults length is: ${imagesResults.length}');
      return <SearchResultImage>[...imagesResults];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return <SearchResultImage>[];
    }
  }
}
