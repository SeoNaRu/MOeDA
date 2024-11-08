import 'package:http/http.dart' as http;
import 'dart:convert';

class NiceApiService {
  final String clientId = '3a8f3ef6-fd9f-402f-a116-5a7a3c01912d';
  final String clientSecret = '348cdba284bab957c5cdc0bdc2e751f4';

  Future<String> getAccessToken() async {
    final String authorization =
    base64Encode(utf8.encode('$clientId:$clientSecret'));
    print(authorization);
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic $authorization'
    };
    final response = await http.post(
      Uri.parse('https://svc.niceapi.co.kr:22001/digital/niceid/oauth/oauth/token'),
      headers: headers,
      body: {'scope': 'default', 'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('responseData 토큰 생성 $responseData');

      return responseData['dataBody']['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }
}
