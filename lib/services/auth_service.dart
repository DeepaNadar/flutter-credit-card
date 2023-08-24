import 'dart:convert';
import 'dart:developer';
import 'package:credit_card_project/model/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://interview-api.onrender.com/v1';
  late SharedPreferences prefs;

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getToken() async {
    await _initPrefs();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    await _initPrefs();
    await prefs.setString('token', token);
  }

Future<void> logout() async {
    await _initPrefs();
    await prefs.remove('token');
  }

  Future<void> register(String name, String email, String password) async {
  final headers = {'Content-Type': 'application/json'};  
  final body = json.encode({
    'name': name,
    'email': email,
    'password': password,
  });

  final response = await http.post(
    Uri.parse('$baseUrl/auth/register'),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 201) {  
    final data = json.decode(response.body);
    final accessToken = data['tokens']['access']['token'];
    await setToken(accessToken);
  } else {
    log('Registration failed. Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
    
    throw Exception('Registration failed');
  }
}



  Future<void> login(String email, String password) async {
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: headers,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['tokens']['access']['token'];
      await setToken(accessToken);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<Map<String, dynamic>> getCardData() async {
  final token = await getToken();
  if (token == null) {
    throw Exception('Token not available');
  }

  final headers = {'Authorization': 'Bearer $token'};

  final response = await http.get(
    Uri.parse('$baseUrl/cards'), 
    headers: headers,
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data as Map<String, dynamic>; 
  } else {
    log('Failed to fetch card data. Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
    throw Exception('Failed to fetch card data');
  }
}

Future<void> sendDataToAPI(CardModel cardData) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not available');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/cards'),
        headers: headers,
        body: json.encode(cardData.toJson()),
      );

      if (response.statusCode == 201) {
        log('Data sent successfully');
      } else {
        log('Failed to send data. Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      }
    } catch (e) {
      log('Error sending data to API: $e');
    }
  }

}
