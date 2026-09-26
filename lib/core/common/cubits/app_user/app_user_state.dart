import '../../../entity/user.dart';

abstract class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn(this.user);
}

//core cannot depend on other features
//other features can depend on core
