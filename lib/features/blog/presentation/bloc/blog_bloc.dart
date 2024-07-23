import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/upload_blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }

  _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final response = await uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics,
        posterId: event.posterId,
      ),
    );
    response.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogSuccess()),
    );
  }
}
