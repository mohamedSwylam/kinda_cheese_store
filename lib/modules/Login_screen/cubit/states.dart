abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginPasswordVisibilityState extends LoginStates {}
class LoginState extends LoginStates {}

class GetUserLoginLoadingStates extends LoginStates {}

class GetUserLoginSuccessStates extends LoginStates {}

class GetUserLoginErrorStates extends LoginStates {}