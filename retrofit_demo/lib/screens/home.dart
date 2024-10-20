import 'package:flutter/material.dart';
import 'package:retrofit_demo/main.dart';
import 'package:retrofit_demo/models/post.dart';
import 'package:retrofit_demo/service/api_service.dart';
import 'package:dio/dio.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("Retrofit Demo", style: TextStyle(color: Colors.white)),
      ),
      body: _body(),
    );
  }

  // FutureBuilder
  FutureBuilder _body() {
    dio.options.contentType = "application/json";
    final apiService = ApiService(dio);

    return FutureBuilder(
      future: apiService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<PostModel> posts = snapshot.data;
          print(posts.length);
          return _posts(posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _posts(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black38, width: 1, style: BorderStyle.solid)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(posts[index].title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
              const SizedBox(height: 8,),
              Text(posts[index].body,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
            ],
          ),
        );
      },
    );
  }
}