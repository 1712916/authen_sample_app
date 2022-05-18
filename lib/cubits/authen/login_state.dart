import '../../data/data.dart';
import '../cubits.dart';

class LoginState extends BaseState implements Copyable<LoginState> {
  final String? loginMessage;
  final String? registerMessage;

  LoginState({this.loginMessage, this.registerMessage});

  @override
  LoginState copy() {
    return this;
  }

  @override
  LoginState copyWith({
    String? loginMessage,
    String? registerMessage,
  }) {
    return LoginState(
      loginMessage: loginMessage ?? this.loginMessage,
      registerMessage: registerMessage ?? this.registerMessage,
    );
  }

  @override
  List<Object?> get props => [
    loginMessage,
    registerMessage,
  ];
}
