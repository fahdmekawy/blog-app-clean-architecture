import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/extensions/context.dart';
import 'package:blog_app/core/theme/colors.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/show_snackbar.dart';
import 'add_new_blog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchAllBlogs());
    super.initState();
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBack(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplayedSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blogEntity: blog,
                  color: AppColors.gradient1,
                );
              },
              itemCount: state.blogs.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
