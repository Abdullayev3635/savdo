part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitLoginEvent extends LoginEvent {

}

class SendLoginEvent extends LoginEvent {
  final String tel;
  final String pass;

  SendLoginEvent(this.tel, this.pass);
}
