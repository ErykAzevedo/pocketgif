import 'package:dartz/dartz.dart';

import '../../domain/entities/result_like_gif.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/back_repository.dart';
import '../../infra/datasources/back_datasource.dart';

class BackRepositoryImpl implements BackRepository {
  final BackDatasource datasource;

  BackRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureHome, String>> saveLikeGif(String id, String title, String url) async {
    try {
      final result = await datasource.saveLikeGif(id, title, url);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureHome, String>> deleteLikeGif(String id) async {
    try {
      final result = await datasource.deleteLikeGif(id);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureHome, String>> updateLikeGif(String id, String title, String url) async {
    try {
      final result = await datasource.updateLikeGif(id, title, url);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureHome, List<ResultLikeGif>>> getAllLikeGif() async {
    try {
      final result = await datasource.getAllLikeGif();
      return Right(result);
    } on NotFoundGif catch (e) {
      print('Error API return SearchNotMatch: $e');
      return Left(NotFoundGif());
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
