part of 'social_register_cubit.dart';

@immutable
abstract class SocialRegisterState {}

class SocialRegisterInitial extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {}

class SocialRegisterFailureState extends SocialRegisterState {
  final String error;

  SocialRegisterFailureState(this.error);
}

class SocialRegisterChangePasswordVisibility extends SocialRegisterState {}

class SocialCreateUserSuccess extends SocialRegisterState {}

class SocialCreateUserFailure extends SocialRegisterState {
  final String error;

  SocialCreateUserFailure(this.error);
}
