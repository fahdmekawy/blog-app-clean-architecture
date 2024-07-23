import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/connection_checker.dart';
import '../data_sources/blog_local_data_source.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImplementation(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required List<String> topics,
      required String posterId}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        imageUrl: '',
        content: content,
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModel: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlogs(blogModel);
      blogRemoteDataSource.uploadBlogs(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
