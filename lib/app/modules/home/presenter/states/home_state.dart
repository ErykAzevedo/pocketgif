import '../../domain/errors/errors.dart';

abstract class HomeState {}

class StartState implements HomeState {
  const StartState();
}

class LoadingState implements HomeState {
  const LoadingState();
}

class SuccessState implements HomeState {
  //final List<ResultLikeGif> list;
  //const SuccessState(this.list);
  const SuccessState();
}

class ErrorState implements HomeState {
  final FailureHome error;
  const ErrorState(this.error);
}
