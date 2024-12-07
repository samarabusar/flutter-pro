import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<dynamic> _courses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    final url = Uri.parse("${ApiService.baseUrl}/courses");
    final response = await http.get(
      url,
      headers: {"Authorization": ApiService.authToken ?? 
      ""},
    );

    if (response.statusCode == 200) {
      setState(() {
        _courses = json.decode(response.body)['courses'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load courses.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feeds')),
      body: ListView.builder(
        itemCount: _courses.length,
        itemBuilder: (context, index) {
          final course = _courses[index];
          return ListTile(
            title: Text(course['name']),
  subtitle: Text("${course['college']} - ${course['id']}"),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Handle subscribe/unsubscribe
              },
            ),
          );
        },
      ),
    );
  }
}