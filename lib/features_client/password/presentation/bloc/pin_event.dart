part of 'pin_bloc.dart';

@immutable
abstract class PinEvent {}

// ignore: must_be_immutable
class OnPressedEvent extends PinEvent {
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  OnPressedEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

// ignore: must_be_immutable
class IsSharedPinEmpty extends PinEvent {
  IsSharedPinEmpty();
}
