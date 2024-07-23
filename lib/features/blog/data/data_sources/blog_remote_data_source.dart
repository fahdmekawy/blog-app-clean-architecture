import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlogs(BlogModel blogModel);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  });
}

class BlogRemoteDataSourceImplementation implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImplementation(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlogs(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      print(e.message);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      supabaseClient.storage.from('blog_images').upload(
            blogModel.id,
            image,
          );

      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
