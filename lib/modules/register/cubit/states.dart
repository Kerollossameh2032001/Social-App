abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeVisibilityState extends RegisterStates {}

class RegisterCreateUserLoadingState extends RegisterStates {}

class RegisterCreateUserSuccesState extends RegisterStates {
  final String uId;

  RegisterCreateUserSuccesState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterStates {}

class RegisterGoogleAccountLoadingState extends RegisterStates {}

class RegisterGoogleAccountSuccesState extends RegisterStates {}

class RegisterGoogleAccountErrorState extends RegisterStates {}
