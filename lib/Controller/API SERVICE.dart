import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';

class ApiService extends GetxController{

  static const String apiUrl = "https://nishat945.pythonanywhere.com";

  ///Get All User
  static Future<List<Person>> getPersonData() async {
    final response = await http.get(Uri.parse("$apiUrl/users"));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Person.fromMap(data)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  ///Create New User
  static Future<bool> createPerson(String name, int age, String address) async {
    try {
      Person person = Person(id: 0, age: age, name: name, address: address);
      final response = await http.post(
        Uri.parse("$apiUrl/create/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(person.toMap()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///Update User Details
  static Future<bool> updateUser(int id, String name, int age, String address) async {
    try {
      Person person = Person(id: id, age: age, name: name, address: address);

      final response = await http.put(
        Uri.parse("$apiUrl/update/$id/"), // Adjust the URL according to your API
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(person.toMap()),
      );

      if (response.statusCode == 200) {
        return true; // User updated successfully
      } else {
        return false; // Failed to update user
      }
    } catch (e) {
      return false; // Handle any exceptions
    }
  }


  ///Delete User
  static Future<bool> deleteUser(int id) async {
    try{
      final response = await http.delete(Uri.parse("$apiUrl/delete/$id/"));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
