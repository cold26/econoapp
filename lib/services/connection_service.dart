import 'dart:async';

import 'package:http/http.dart';

class ConnectionService {
  const ConnectionService();

  static bool _isConnected = false;

  bool get isConnected => _isConnected;

  Client get _client => Client();

  Future<void> checkConnection() async {
    try {
      final response = await _client.get(Uri.parse('https://arriving-tick-95.hasura.app/v1/graphql'));

      _isConnected = response.statusCode == 200;
    } catch (_) {
      _isConnected = false;
    }
  }
}