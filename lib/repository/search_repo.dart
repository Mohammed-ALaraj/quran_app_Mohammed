import 'package:quran_app/models/search_model.dart';
import 'package:quran_app/network/network_helper.dart';

class SearchRepo {
  static Future<SearchResponse?> getPage(String keySearch) async {
    Map<String, dynamic>? response =
        await NetworkHelper("https://api.quran.com/api/v4/search?q=$keySearch")
            .getData();
    if (response != null) {
      return SearchResponse.fromJson(response);
    } else {
      return null;
    }
  }
}
