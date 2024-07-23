import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/calculate_reading_time.dart';
import '../../../../core/utils/format_date.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogEntity blog;

  const BlogDetailsScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyColor,
                      fontSize: 16),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
