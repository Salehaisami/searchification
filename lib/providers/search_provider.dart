import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:searchification/models/search_result.dart';
import 'package:searchification/services/search_api_service.dart';

/// This provider class is our business logic that rests between the [SearchAPI]
/// service and the UI. This helps decouple our services (backend) from our
/// screens/UI (frontend).
///
class SearchProvider extends ChangeNotifier {
  final SearchAPI searchService;
  String _query = "";

  get query => _query;

  SearchProvider() : searchService = SearchAPI();

  setQuery(newQuery, [notify=true]) {
    _query = newQuery;
    print('new query set: $newQuery');
    if (notify == null || notify) notifyListeners();
  }

  isQueryEmpty() => _query.isEmpty;

  bool _isSearching = false;
  set isSearching (bool val) => _isSearching = val;
  bool get isSearching => _isSearching;

  /// Main function that does the search, gets the results, and converts it
  /// to our data model: [SearchResultImage].
  ///
  Future<List<SearchResultImage>> searchImages([int? pageNum]) async {
    if (_query.isEmpty) return <SearchResultImage>[];
    isSearching = true;
    var response = await searchService.queryAPI(_query, pageNum);
    if (response.statusCode == 200) {
      var imagesResults = jsonDecode(response.body)['images_results']
          .map((rawInfo) => SearchResultImage.fromJson(rawInfo));
      print('from provider; imagesResults length is: ${imagesResults.length}');
      isSearching = false;
      return <SearchResultImage>[...imagesResults];
    } else {
      isSearching = false;
      print('Request failed with status: ${response.statusCode}.');
      return <SearchResultImage>[];
    }
  }
}
