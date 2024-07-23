import 'package:blog_app/core/extensions/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_new_blog.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () => context.navigateTo(const AddNewBlog()),
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
    );
  }
}
