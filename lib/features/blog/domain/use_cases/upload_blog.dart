import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usercase.dart';
import '../entities/blog_entity.dart';

class UploadBlog implements UseCase<BlogEntity, UploadBlogParams> {
  BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });
}
