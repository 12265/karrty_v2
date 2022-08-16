import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'karrty_url.dart';


//IMP http_interceptor and http plugin used for this

// 1 Interceptor class
class AuthorizationInterceptor implements InterceptorContract {
  final localStorage = FlutterSecureStorage();

  // We need to intercept request
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String? accessToken = await localStorage.read(key: "access_token");
    data.headers[HttpHeaders.authorizationHeader] = 'Bearer ${accessToken!}';
    data.headers['content-type'] = 'application/json';
    return data;
  }

  // Currently we do not have any need to intercept response
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    data.headers!['content-type'] = 'application/json; charset=utf-8';
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final localStorage = const FlutterSecureStorage();

  //Number of retry
  @override
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    //This is where we need to update our token on 401 response

    if (response.statusCode == 403) {
      var refreshToken = await localStorage.read(key: "refresh_token");

      final response = await get(Uri.https(baseUrl, '/api/v1/users/token/refresh'), headers: {HttpHeaders.authorizationHeader: "Bearer $refreshToken"});
      final body = jsonDecode(response.body);

      localStorage.delete(key: "access_token");
      localStorage.write(key: "access_token", value: body["access_token"]);

      return true;
    }
    return false;
  }
}
