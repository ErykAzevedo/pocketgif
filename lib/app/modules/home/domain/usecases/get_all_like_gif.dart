import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/result_like_gif.dart';
import '../../../home/domain/errors/errors.dart';
import '../../../home/domain/repositories/back_repository.dart';

abstract class GetAllLikeGif {
  Future<Either<FailureHome, List<ResultLikeGif>>> call();
}

class GetAllLikeGifImpl implements GetAllLikeGif {
  final BackRepository repository;
  GetAllLikeGifImpl(this.repository);

  @override
  Future<Either<FailureHome, List<ResultLikeGif>>> call() async {
    return repository.getAllLikeGif();
  }
}
