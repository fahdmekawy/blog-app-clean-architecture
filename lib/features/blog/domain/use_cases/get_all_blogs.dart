import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecase/usercase.dart';
import '../entities/blog_entity.dart';
import '../repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}

class NoParams {}
