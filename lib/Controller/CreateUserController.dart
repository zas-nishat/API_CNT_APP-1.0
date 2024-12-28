import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Model.dart';
import 'API SERVICE.dart';

class PeopleController extends GetxController {
  var people = <Person>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPeopleData();
  }

  void fetchPeopleData() async {
    isLoading.value = true;
    try {
      final fetchedPeople = await ApiService.getPersonData();
      people.value = fetchedPeople;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch people: $e");
    } finally {
      isLoading.value = false;
    }
  }


  ///Create User
  Future<void> createPerson(String name, int age, String address) async {
    isLoading.value = true;
    try {
      bool success = await ApiService.createPerson(name, age, address);
      if (success) {
        Get.snackbar("Success", "Person created successfully!");
      } else {
        Get.snackbar("Error", "Failed to create person.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  ///Update User Details
  Future<void> updateUserDetails( int id, String name, int age, String address) async {
    try {
      bool isUpdated = await ApiService.updateUser(id,name, age, address);
      if (isUpdated) {
        Get.snackbar("Success", "Details updated successfully!");
        fetchPeopleData();
      } else {
        Get.snackbar("Error", "Failed to update details.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  ///Delete User
  Future<void> deleteUser(int id) async {
    bool isDeleted = await ApiService.deleteUser(id);
    if(isDeleted) {
      Get.snackbar(
        "Success",
        "User deleted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchPeopleData();
    } else {
      Get.snackbar(
        "Failed",
        "User deleted unsuccessfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
