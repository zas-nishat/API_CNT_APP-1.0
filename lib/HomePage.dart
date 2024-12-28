import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/CreateUserController.dart';
import 'Controller/API SERVICE.dart';
import 'UpdateUserPage.dart';
import 'NewUserPage.dart';

class HomePage extends StatelessWidget {
  final PeopleController _controller = Get.put(PeopleController());

  // Function to show confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without performing any action
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Perform the delete action
                bool isDeleted = await ApiService.deleteUser(id);
                Navigator.of(context).pop(); // Close the dialog

                // Show a snackbar based on the result of the delete operation
                if (isDeleted) {
                  Get.snackbar(
                    "Success",
                    "User deleted successfully!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  _controller.fetchPeopleData(); // Reload data after deleting
                } else {
                  Get.snackbar(
                    "Failed",
                    "Failed to delete user!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Person List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search functionality
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreatePostPage())?.then((_) {
            _controller.fetchPeopleData();
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
        tooltip: 'Create New Person',
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        } else if (_controller.people.isEmpty) {
          return const Center(
            child: Text(
              'No data found',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: _controller.people.length,
          itemBuilder: (context, index) {
            final person = _controller.people[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => UpdateUserPage(person: person))?.then((_) {
                  _controller.fetchPeopleData(); // Reload data after updating
                });
              },
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    person.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  subtitle: Text(
                    'Age: ${person.age}\nAddress: ${person.address}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      _showDeleteConfirmationDialog(context, person.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
