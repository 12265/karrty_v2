import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'http_requests.dart';
class ApiClient{
  static Client client = InterceptedClient.build(interceptors: [
    AuthorizationInterceptor()
  ],retryPolicy: ExpiredTokenRetryPolicy());
}