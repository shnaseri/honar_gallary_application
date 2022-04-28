import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/extenstion_methods.dart';
import 'package:honar_gallary/logic/router_const.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,

        backgroundColor: ColorPallet.colorPalletNightFog,
        // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        textFormStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Sahel',
        ),
        actionButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorPallet.colorPalletSambucus),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  side: BorderSide(
                      color: ColorPallet.colorPalletBlueGam,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50))),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontFamily: 'Sahel',
              color: Colors.white,
              fontSize: 20,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: ColorPallet.colorPalletNightFog)),
        ),

        // actionButtonStyle: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all(Colors.blue),
        // ),
      );

  LoginTexts get _loginTexts => LoginTexts(
    nameHint: _username,
        login: _login,
        signUp: _signup,
        welcomeBack: _welcomeBack,
        emailHint: _hintOfEmail,
        passwordHint: _hintOfPass,
        forgotPassword: _forgetPass,
        notHaveAnAccount: _notAccount,
        welcome: _welcome,
        confirmPasswordHint: _confirmPass,
        alreadyHaveAnAccount: _alreadyHaveAccount,
        welcomeDescription: _descWelcome,
        welcomeBackDescription: _descWelcomeBack,
        passwordMatchingError: _matchPassError,
      );

  String get _username => 'نام کاربری';

  String get _login => 'ورود';

  String get _signup => 'ثبت نام';

  String get _welcomeBack => 'خوش اومدی';

  String get _hintOfEmail => 'پست الکترونیکی';

  AuthMode currentMode = AuthMode.login;

  String get _hintOfPass => 'رمز عبور';

  String get _forgetPass => 'فراموشی رمز عبور';

  String get _notAccount => 'هنوز حساب کاربری نداری؟ ';

  String get _welcome => 'به نگاره خوش اومدی';

  String get _confirmPass => 'تایید رمز عبور';

  String get _alreadyHaveAccount => 'حساب کاربری داری؟ ';

  String get _descWelcome =>
      'توی این برنامه هر چی که از هنر میخوای رو میتونی پیدا کنی';

  String get _descWelcomeBack => 'بزن بریم برای عمق دریای هنر';

  String get _matchPassError => 'تاییدیه رمز عبور مطابقت ندارد';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          fontFamily: 'Sahel',
          primaryColor: Colors.white,
          iconTheme: IconThemeData(color: ColorPallet.colorPalletDark),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.black12)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedLogin(
          onLogin: (login) async {
            Navigator.pushReplacementNamed(context, homePagePath);
            return "";
          },
          onSignup: (login) async {
            return "";
          },
          onForgotPassword: (login) async {
            return "";
          },
          // logo: Image.asset('assets/images/logo.gif'),
          // backgroundImage: 'images/background_image.jpg',
          signUpMode: SignUpModes.both,
          // socialLogins: _socialLogins(context),
          loginDesktopTheme: _desktopTheme,
          loginMobileTheme: _mobileTheme,
          loginTexts: _loginTexts,
          initialMode: currentMode,
          nameValidator: ValidatorModel(customValidator: (String? email) {
            if (((email?.length) ?? 0) < 4) {
              return 'نام کاریری باید بیش از 3 حرف باشد';
            }
            return null;
          }),
          emailValidator: ValidatorModel(customValidator: (String? email) {
            if (!((email ?? "").isValidEmail)) {
              return 'پست الکترونیکی نامعتبر است';
            }
            return null;
          }),
          passwordValidator: ValidatorModel(
              customValidator: (String? password) {
                if (((password?.length) ?? 0) < 6) {
                  return 'رمز عبور حداقل باید 6 رقم باشد.';
                }
                return null;
              },
              checkUpperCase: true),
          onAuthModeChange: (AuthMode newMode) => currentMode = newMode,
        ),
      ),
    );
  }
}
