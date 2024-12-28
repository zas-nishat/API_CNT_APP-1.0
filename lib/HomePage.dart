import 'package:api_data/Controller/API%20SERVICE.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/CreateUserController.dart';
import 'NewUserPage.dart';
import 'UpdateUserPage.dart';

class HomePage extends StatelessWidget {
  final PeopleController _controller = Get.put(PeopleController());

  // Future<void> deleteUser(int id) async {
  //   bool isDeleted = await ApiService.deleteUser(id);
  //   if(isDeleted) {
  //     Get.snackbar(
  //       "Success",
  //       "User deleted successfully!",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //     _controller.fetchPeopleData();
  //   } else {
  //     Get.snackbar(
  //       "Failed",
  //       "User deleted unsuccessfully!",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreatePostPage())?.then((_) {
            _controller.fetchPeopleData();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (_controller.people.isEmpty) {
          return const Center(child: Text('No data found'));
        }
        return ListView.builder(
          reverse: true,
          itemCount: _controller.people.length,
          itemBuilder: (context, index) {
            final person = _controller.people[index];
            return GestureDetector(
              onTap: () {
                // Navigate to UpdatePage with the current user's data
                Get.to(() => UpdateUserPage(person: person))?.then((_) {
                  _controller.fetchPeopleData(); // Reload data after updating
                });
              },
              onLongPress: (){
                _controller.deleteUser(person.id);
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(person.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle:
                      Text('Age: ${person.age}, Address: ${person.address}'),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
