import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> _userList;

  Future<List<dynamic>> _fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('data')) {
        return responseData['data'];
      } else {
        throw Exception('Data not found in response');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    _userList = _fetchUsers();
  }

  void _navigateToUserDetail(BuildContext context, int userId) {
    Navigator.pushNamed(context, '/user_detail', arguments: userId);
  }

  void _navigateToAddUserScreen(BuildContext context) {
    Navigator.pushNamed(context, '/add_user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Handle snapshot.data that might be null or empty
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var user = snapshot.data![index];
                  return ListTile(
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    onTap: () {
                      _navigateToUserDetail(context, user['id']);
                    },
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddUserScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
