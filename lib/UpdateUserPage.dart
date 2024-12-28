import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/CreateUserController.dart';
import 'Controller/Model.dart';

class UpdateUserPage extends StatefulWidget {
  final Person person;

  UpdateUserPage({required this.person});

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.person.name;
    _ageController.text = widget.person.age.toString();
    _addressController.text = widget.person.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedName = _nameController.text;
                final updatedAge = int.tryParse(_ageController.text) ?? widget.person.age;
                final updatedAddress = _addressController.text;

                // Call the controller's updateUser method to update the user data
                Get.find<PeopleController>().updateUserDetails(
                  widget.person.id,
                  updatedName,
                  updatedAge,
                  updatedAddress,
                );
                Get.back(); // Go back to the previous page
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
