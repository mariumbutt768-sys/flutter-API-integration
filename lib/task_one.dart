import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_model.dart';

class Networking extends StatefulWidget {
  const Networking({super.key});

  @override
  State<Networking> createState() => _NetworkingState();
}

class _NetworkingState extends State<Networking> {
  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Posts",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        backgroundColor: const Color(0xFF6C3483), // Deep Purple
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // Success
          List<Post> posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color(0xFFFFF9E6),
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF6C3483),
                    child: Text(
                      "${posts[index].id}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    posts[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C3483),
                    ),
                  ),
                  subtitle: Text(posts[index].body),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
