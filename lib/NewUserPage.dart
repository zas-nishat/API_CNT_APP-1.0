import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/API SERVICE.dart';
import 'Controller/CreateUserController.dart';

class CreatePostPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(PeopleController());  // Using the controller

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Name is required" : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Age is required";
                  }
                  if (int.tryParse(value) == null) {
                    return "Enter a valid number";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) =>
                value == null || value.isEmpty ? "Address is required" : null,
              ),
              SizedBox(height: 20),
              Obx(() {
                return _controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.createPerson(
                        nameController.text,
                        int.parse(ageController.text),
                        addressController.text,
                      );
                    }
                  },
                  child: Text("Submit"),
                );
              }),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
