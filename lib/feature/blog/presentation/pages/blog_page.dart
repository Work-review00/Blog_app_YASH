import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/auth/presentaion/bloc/auth_bloc.dart'; // Added AuthBloc import
import 'package:blog_app/feature/auth/presentaion/pages/login_page.dart'; // Added LoginPage import
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/presentation/pages/new_blog_page.dart';
import 'package:blog_app/feature/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the Scaffold in a BlocListener for AuthBloc
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          // 2. Redirect to Login Page and clear all previous routes
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(), // Or MaterialPageRoute(builder: (context) => const LoginPage()) if you don't have a static route() method
            (route) => false,
          );
        } else if (state is AuthFailure) {
          // 3. Show error if logout fails (e.g., no internet connection)
          showSnackbar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog App'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, NewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
            // 4. Added the Logout Button
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
              },
              icon: const Icon(CupertinoIcons.square_arrow_right),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackbar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            if (state is BlogsDisplaySuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 2 == 0
                        ? AppPallete.gradient1
                        : AppPallete.gradient2,
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
