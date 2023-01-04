part of 'app_pages.dart';


abstract class Routes {
  static const SIGNIN = _Paths.SIGNIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const HOME = _Paths.HOME;
  static const welcome_page = _Paths.welcome_page;

}

abstract class _Paths {
  static const SIGNIN = '/signin';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const welcome_page = '/welcome_page';

}
