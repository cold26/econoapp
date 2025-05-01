abstract class SignUpState {
  const SignUpState();
}

class SignUpLoadingState extends SignUpState{}

class SignUpInitialState extends SignUpState{}

class SignUpSucessState extends SignUpState{}

class SignUpErrorState extends SignUpState{}