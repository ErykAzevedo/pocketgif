import 'package:dartz/dartz.dart';

import '../../../home/domain/errors/errors.dart';
import '../../../home/domain/repositories/back_repository.dart';

abstract class UpdateLikeGif {
  Future<Either<FailureHome, String>> call(String id, String title, String url);
}

class UpdateLikeGifImpl implements UpdateLikeGif {
  final BackRepository repository;
  UpdateLikeGifImpl(this.repository);

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

    return repository.updateLikeGif(id, title, url);
  }
}
