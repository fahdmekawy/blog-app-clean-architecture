part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {}

final class BlogsDisplayedSuccess extends BlogState {
  final List<BlogEntity> blogs;

  const BlogsDisplayedSuccess(this.blogs);
}

final class BlogFailure extends BlogState {
  final String error;

  const BlogFailure(this.error);
}
