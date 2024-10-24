import 'dart:convert';

import 'package:http/http.dart' as http;

/// dealing with network requests
class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<Map<String, dynamic>?> getData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
