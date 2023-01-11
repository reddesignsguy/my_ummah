import "package:http/http.dart" as http;

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);

      // Successful GET
      if (response.statusCode == 200) return response.body;
    } catch (e) {
      print("Unsuccessful HTTP request");
    }

    return null;
  }
}
