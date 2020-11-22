import 'package:dartz/dartz.dart';
import '../../../home/domain/errors/errors.dart';
import '../../../home/domain/repositories/back_repository.dart';

abstract class SalveLikeGif {
  Future<Either<FailureHome, String>> call(String id, String title, String url);
}

class SalveLikeGifImpl implements SalveLikeGif {
  final BackRepository repository;
  SalveLikeGifImpl(this.repository);

  @override
  Future<Either<FailureHome, String>> call(String id, String title, String url) async {
    if (id == null || id.isEmpty) {
      return Left(InvalidTextError());
    }

    if (title == null || title.isEmpty) {
      return Left(InvalidTextError());
    }

    if (url == null || url.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.saveLikeGif(id, title, url);
  }
}
