import 'package:http/http.dart' as http;

// In a prod environment, keys as such should definitely be stored differently.
// Obtain and enter your API_KEY where it says <replace with API_KEY>. Keep
// quotes.
const String API_KEY =
    "<replace with API_KEY>";

/// This class is our point of contact with the search api. It creates the URL
/// (with the [urlBuilder] function) as the API wants and then
/// queries it (with [queryAPI] function) with specific params.
///
class SearchAPI {

  String urlBuilder(
      {required String query,
      int pageNumber = 0}) {
    var baseUrl = 'https://serpapi.com/search.json?engine=google&q=$query&'
        'tbm=isch&ijn=$pageNumber&api_key=$API_KEY';
    return baseUrl;
  }

  Future<http.Response> queryAPI (String query, int? pageNum) async {
    final url = urlBuilder(query: query, pageNumber: pageNum ?? 0);
    print('new url: $url');
    return await http.get(Uri.parse(url));
  }

}
