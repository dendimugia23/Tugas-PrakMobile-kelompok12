import 'package:flutter/material.dart';
import 'package:tugas_pmob/AddUserScreen.dart';
import 'package:tugas_pmob/UserListScreen.dart';
import 'package:tugas_pmob/userdetailscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Tugas Kelompok 12'),
      routes: {
        '/user_list': (context) => UserListScreen(),
        '/user_detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;

          if (args is int) {
            return UserDetailScreen(userId: args as int);
          } else {
            return Scaffold(
              body: Center(
                child: Text('Invalid user ID'),
              ),
            );
          }
        },
        '/add_user': (context) => AddUserScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/user_list');
          },
          child: Text('Show User List'),
        ),
      ),
    );
  }
}
