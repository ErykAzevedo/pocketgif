import 'package:dartz/dartz.dart';

import '../../../home/domain/entities/result_like_gif.dart';
import '../../../home/domain/errors/errors.dart';

abstract class BackRepository {
  Future<Either<FailureHome, List<ResultLikeGif>>> getAllLikeGif();
  Future<Either<FailureHome, String>> saveLikeGif(String id, String title, String url);
  Future<Either<FailureHome, String>> deleteLikeGif(String id);
  Future<Either<FailureHome, String>> updateLikeGif(String id, String title, String url);
}
