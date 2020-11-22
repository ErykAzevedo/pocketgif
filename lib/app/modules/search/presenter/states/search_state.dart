import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState implements SearchState {
  const LoadingState();
}

class SuccessState implements SearchState {
  final List<ResultSearch> list;
  const SuccessState(this.list);
}

class ErrorState implements SearchState {
  final FailureSearch error;
  const ErrorState(this.error);
}
