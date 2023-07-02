import 'dart:convert';
import 'package:elcriticoapp/models/user.dart';
import 'package:elcriticoapp/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _authTokenKey = 'auth_token';
  static const String _apiBasePath = apiURL;
  static final Map<String, AuthService> _cache = <String, AuthService>{};

  factory AuthService() {
    return _cache.putIfAbsent('AuthService', () => AuthService._internal());
  }

  AuthService._internal();

  User? _user;
  final _storage = const FlutterSecureStorage();

  User? get user {
    return _user;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    const failReason = {
      400: 'Usuário e senha não podem ser vazios!',
      404: 'O usuário informado não existe.',
      401: 'Senha incorreta!'
    };
    final payload = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
        Uri.parse(
          '$_apiBasePath/auth/login/',
        ),
        body: jsonEncode(payload),
        headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      _user = User.fromJson(responseJson['user']);

      await _storage.write(
        key: _user!.hash,
        value: _user.toString(),
      );
      await _storage.write(
        key: _authTokenKey,
        value: _user?.hash,
      );
      return {'success': true};
    }
    return {
      'success': false,
      'code': response.statusCode,
      'reason': failReason[response.statusCode],
    };
  }

  Future<bool> hasToken() async {
    String? authToken = await _storage.read(key: _authTokenKey);

    if (authToken != null) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    const failReason = {
      400: 'Usuário e senha não podem ser vazios!',
      409: 'O nome de usuário informado já existe.',
    };

    final payload = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
        Uri.parse(
          '$_apiBasePath/auth/register/',
        ),
        body: jsonEncode(payload),
        headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      // it's not 201 because on success the API's AuthController
      // will return the match_credential pair.
      // is it bad? yes
      // do I know how to do it in other way? yes
      // will I? no.
      // https://i.kym-cdn.com/photos/images/newsfeed/001/044/247/297.png

      final responseJson = jsonDecode(response.body);
      _user = User.fromJson(responseJson['user']);

      await _storage.write(
        key: _user!.hash,
        value: _user.toString(),
      );
      await _storage.write(
        key: _authTokenKey,
        value: _user?.hash,
      );

      return {'success': true};
    }
    return {
      'success': false,
      'code': response.statusCode,
      'reason': failReason[response.statusCode],
    };
  }
}
