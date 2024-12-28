class Person {
  final int id;
  final int age;
  final String name;
  final String address;

  Person({
    required this.id,
    required this.age,
    required this.name,
    required this.address,
  });

  // Factory method to create a Person from a Map (e.g., from JSON)
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      age: map['age'],
      name: map['name'],
      address: map['address'],
    );
  }

  // Method to convert a Person object to a Map (e.g., to send as JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'age': age,
      'name': name,
      'address': address,
    };
  }
}