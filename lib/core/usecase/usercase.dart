import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

abstract interface class UseCase<S, P> {
  Future<Either<Failure, S>> call(P params);
}
