import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  String _getEmail(String firstName, String lastName) {
    return '$firstName$lastName@reqres.in';
  }

  String _getAvatar(String email) {
    final emailHash =
        md5.convert(utf8.encode(email.trim().toLowerCase())).toString();
    return 'https://www.gravatar.com/avatar/$emailHash?s=200';
  }

  Future<void> _addUser(
      String firstName, String lastName, String email, String avatar) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'avatar': avatar,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      print('User added successfully');
      Navigator.pop(context);
    } else {
      throw Exception('Failed to add user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String firstName = _nameController.text;
                String lastName = _jobController.text;
                String email = _getEmail(firstName, lastName);
                String avatar = _getAvatar(email);
                _addUser(firstName, lastName, email, avatar);
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
