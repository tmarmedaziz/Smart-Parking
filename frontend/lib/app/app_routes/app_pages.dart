import 'package:get/get.dart';
import 'package:frontend/app/app_pages/auth/signin/views/signin_view.dart';
import 'package:frontend/app/app_pages/auth/signup/views/signup_view.dart';
import 'package:frontend/app/app_pages/auth/signin/bindings/signin_binding.dart';
import 'package:frontend/app/app_pages/auth/signup/bindings/signup_binding.dart';
import 'package:frontend/app/app_pages/home/bindings/home_binding.dart';
import 'package:frontend/app/app_pages/home/views/home_view.dart';
import 'package:frontend/app/app_pages/welcome_page/bindings/welcome_page_binding.dart';
import 'package:frontend/app/app_pages/welcome_page/views/welcome_page_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.welcome_page,
      page: () => WelcomePageView(),
      binding: WelcomePageBinding(),
    ),

    GetPage(
      name: _Paths.SIGNIN,
      page: () => LoginView(),
      binding: SigninBinding(),

    ),
     GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),

     ),
  ];
}
