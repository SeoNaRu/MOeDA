import 'dart:convert';

import 'nice_api_servic.dart';
import 'package:http/http.dart' as http;

class NiceAuthService {
  final NiceApiService _apiService = NiceApiService();

  Future<Map<String, String>> requestEncryptionToken() async {
    final accessToken = await _apiService.getAccessToken();
    final String authorization = base64Encode(utf8.encode('$accessToken:${DateTime.now().millisecondsSinceEpoch ~/ 1000}:${_apiService.clientId}'));
    print('authorization $authorization');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization',
      'client_id': _apiService.clientId,
      'productID': '2101979031',
    };

    final requestBody = json.encode({
      'dataHeader': {'CNTY_CD': 'ko'},
      'dataBody': {
        'req_dtim': DateTime.now().toIso8601String(),
        'req_no': '713945680123456789012345678901',
        'enc_mode': '1',
      }
    });
    print(requestBody);
    final response = await http.post(
      Uri.parse('https://svc.niceapi.co.kr:22001/digital/niceid/api/v1.0/common/crypto/token'),
      headers: headers,
      body: requestBody,
    );
    print('responseBody ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('responseData ${responseData['dataBody']}');
      return {
        'siteCode': responseData['dataBody']['site_code'],
        'tokenVal': responseData['dataBody']['token_val'],
        'tokenVersionId': responseData['dataBody']['token_version_id'],
      };
    } else {
      throw Exception('Failed to request encryption token');
    }
  }
}
