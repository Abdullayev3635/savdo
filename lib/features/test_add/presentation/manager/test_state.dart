part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}
class TestLoading extends TestState {}
class TestLoaded extends TestState {
  final List<TestModel> list;
  TestLoaded({required this.list});
}
class TestFail extends TestState {}
