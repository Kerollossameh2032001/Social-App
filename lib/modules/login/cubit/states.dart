abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeVisibilityState extends LoginStates {}

class LoginWithEmailAndPasswordLoadingState extends LoginStates {}

class LoginWithEmailAndPasswordSuccesState extends LoginStates {
  final String uId;

  LoginWithEmailAndPasswordSuccesState(this.uId);
}

class LoginWithEmailAndPasswordErrorState extends LoginStates {
  final String error;

  LoginWithEmailAndPasswordErrorState(this.error);
}

class LoginWithGoogleAccountLoadingState extends LoginStates {}

class LoginWithGoogleAccountSuccesState extends LoginStates {}

class LoginWithGoogleAccountErrorState extends LoginStates {}

class LoginCreateUserSuccesState extends LoginStates{
  final String uId;

  LoginCreateUserSuccesState(this.uId);
}

class LoginCreateUserErrorState extends LoginStates{
  final String error;

  LoginCreateUserErrorState(this.error);
}
