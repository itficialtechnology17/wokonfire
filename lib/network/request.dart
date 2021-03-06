import 'package:http/http.dart' as http;
import 'package:wokonfire/utils/url.dart';

class Request {
  final String url;
  final dynamic body;

  Request({this.url, this.body});

  Future<http.Response> post() {
    return http.post(urlBase + url, body: body).timeout(Duration(minutes: 2));
  }

  Future<http.Response> get() {
    return http.get(urlBase + url).timeout(Duration(minutes: 2));
  }

  Future<http.Response> delete() {
    return http.delete(urlBase + url).timeout(Duration(minutes: 2));
  }
}
