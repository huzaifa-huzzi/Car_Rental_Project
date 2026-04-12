import 'package:car_rental_project/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:car_rental_project/Authentication/Login/Login.dart';
import 'package:car_rental_project/Authentication/NewPassword/NewPassword.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreen.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreenTwo.dart';
import 'package:car_rental_project/Authentication/Register/RegisterScreen.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/forgotPassword', builder: (context, state) => const ForgotPassword()),
    GoRoute(path: '/newPassword', builder: (context, state) => const NewPassword()),
    GoRoute(path: '/authSuccess', builder: (context, state) => const RecoveryShowScreenOne()),
    GoRoute(path: '/authSuccess2', builder: (context, state) => RecoveryShowScreenTwo()),
  ];
}