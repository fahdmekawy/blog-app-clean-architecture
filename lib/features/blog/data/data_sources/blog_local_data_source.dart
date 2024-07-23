import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/blog_entity.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});

  List<BlogEntity> loadBlogs();
}

class BlogLocalDataSourceImplementation implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImplementation(this.box);

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (int i = 0; i < blogs.length; i++) {
      box.write(() => box.put(i.toString(), blogs[i].toJson()));
    }
  }

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogs;
  }
}
