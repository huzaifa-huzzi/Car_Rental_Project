import 'package:car_rental_project/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:car_rental_project/Authentication/Login/Login.dart';
import 'package:car_rental_project/Authentication/LoginController.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreen.dart';
import 'package:car_rental_project/Authentication/RecoveryShowScreen/RecoveryShowScreenTwo.dart';
import 'package:car_rental_project/Authentication/Register/RegisterScreen.dart';
import 'package:car_rental_project/Authentication/TwoStepVerificationOne/TwoStepVerificationOne.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
        path: '/login',
        builder: (context, state) {
          Get.put(LoginController());
          return const LoginScreen();
        }
    ),

    GoRoute(
        path: '/signUp',
        builder: (context, state) {
          Get.put(LoginController());
          return const RegisterScreen();
        }
    ),

    GoRoute(
        path: '/forgotPassword',
        builder: (context, state) {
          Get.put(LoginController());
          return const ForgotPassword();
        }
    ),

    GoRoute(
        path: '/authSuccess',
        builder: (context, state) {
          Get.put(LoginController());
          return const RecoveryShowScreenOne();
        }
    ),

    GoRoute(
        path: '/authSuccess2',
        builder: (context, state) {
          Get.put(LoginController());
          return RecoveryShowScreenTwo();
        }
    ),

    GoRoute(
        path: '/twoStepVerificationOne',
        builder: (context, state) {
          Get.put(LoginController());
          return const TwoStepVerificationOne();
        }
    ),
  ];
}