import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'iw8MUAfTq00XXo41rEferzK5XAmROBrG';

class LocationHelper {
  static String getLocationPreview(
      {required double latitude, required double longitude}) {
    return 'https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&zoom=12&center=$longitude%2C%20$latitude&width=512&height=512&view=IN&key=iw8MUAfTq00XXo41rEferzK5XAmROBrG';
  }

  static Future<String> getAddress(
      {required double latitude, required double longitude}) async {
    final url = Uri.https(
        'api.tomtom.com', '/search/2/reverseGeocode/37.8328,-122.27669.json', {
      'returnSpeedLimit': 'false',
      'radius': '10000',
      'returnRoadUse': '10000',
      'allowFreeformNewLine': 'false',
      'returnMatchType': 'false',
      'view': 'IN',
      'key': 'iw8MUAfTq00XXo41rEferzK5XAmROBrG',
    }).toString().replaceAll(',', '%2c');

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = json.decode(response.body)['addresses'][0]['address']
        ['freeformAddress'];

    return data;
  }
}
