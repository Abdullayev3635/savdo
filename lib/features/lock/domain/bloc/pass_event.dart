part of 'pass_bloc.dart';


abstract class PassEvent {}
class PassCompileEvent extends PassEvent{
  TextEditingController passController = TextEditingController();
  PassCompileEvent({required this.passController});
}