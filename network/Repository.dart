import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class Repository {
  static Future getUsers() {
    var url = "$baseUrl/users";
    return http.get(Uri.parse(url));
  }

  static Future getUser(String id) {
    var url = "$baseUrl/users/$id";
    return http.get(Uri.parse(url));
  }
}
