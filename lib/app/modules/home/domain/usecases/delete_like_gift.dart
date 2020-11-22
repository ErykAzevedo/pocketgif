import 'package:dartz/dartz.dart';
import '../../../home/domain/errors/errors.dart';
import '../../../home/domain/repositories/back_repository.dart';

abstract class DeleteLikeGif {
  Future<Either<FailureHome, String>> call(String id);
}

class DeleteLikeGifImpl implements DeleteLikeGif {
  final BackRepository repository;
  DeleteLikeGifImpl(this.repository);

  @override
  Future<Either<FailureHome, String>> call(String id) async {
    if (id == null || id.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.deleteLikeGif(id);
  }
}
