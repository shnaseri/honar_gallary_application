// import 'package:animated_login/animated_login.dart';
// import 'package:flutter/material.dart';
// import 'package:honar_gallary/const/color_const.dart';
// import 'package:honar_gallary/logic/extenstion_methods.dart';
// import 'package:honar_gallary/logic/router_const.dart';
//
// class AuthenticationPage extends StatefulWidget {
//   const AuthenticationPage({Key? key}) : super(key: key);
//
//   @override
//   _AuthenticationPageState createState() => _AuthenticationPageState();
// }
//
// class _AuthenticationPageState extends State<AuthenticationPage> {
//   LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
//     // To set the color of button text, use foreground color.
//     actionButtonStyle: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all(Colors.white),
//     ),
//     dialogTheme: const AnimatedDialogTheme(
//       languageDialogTheme: LanguageDialogTheme(
//           optionMargin: EdgeInsets.symmetric(horizontal: 80)),
//     ),
//   );
//
//   /// You can adjust the colors, text styles, button styles, borders
//   /// according to your design preferences for *MOBILE* view.
//   /// You can also set some additional display options such as [showLabelTexts].
//   LoginViewTheme get _mobileTheme => LoginViewTheme(
//     // showLabelTexts: false,
//
//     backgroundColor: ColorPallet.colorPalletNightFog,
//     // const Color(0xFF6666FF),
//     formFieldBackgroundColor: Colors.white,
//     formWidthRatio: 60,
//     textFormStyle: TextStyle(
//       color: Colors.black,
//       fontFamily: 'Sahel',
//     ),
//     actionButtonStyle: ButtonStyle(
//       backgroundColor:
//       MaterialStateProperty.all<Color>(ColorPallet.colorPalletSambucus),
//       shape: MaterialStateProperty.all<OutlinedBorder>(
//           RoundedRectangleBorder(
//               side: BorderSide(
//                   color: ColorPallet.colorPalletBlueGam,
//                   width: 1,
//                   style: BorderStyle.solid),
//               borderRadius: BorderRadius.circular(50))),
//       textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
//           fontFamily: 'Sahel',
//           color: Colors.white,
//           fontSize: 20,
//           decorationStyle: TextDecorationStyle.solid,
//           decorationColor: ColorPallet.colorPalletNightFog)),
//     ),
//
//     // actionButtonStyle: ButtonStyle(
//     //   foregroundColor: MaterialStateProperty.all(Colors.blue),
//     // ),
//   );
//
//   LoginTexts get _loginTexts => LoginTexts(
//     nameHint: _username,
//     login: _login,
//     signUp: _signup,
//     welcomeBack: _welcomeBack,
//     emailHint: _hintOfEmail,
//     passwordHint: _hintOfPass,
//     forgotPassword: _forgetPass,
//     notHaveAnAccount: _notAccount,
//     welcome: _welcome,
//     confirmPasswordHint: _confirmPass,
//     alreadyHaveAnAccount: _alreadyHaveAccount,
//     welcomeDescription: _descWelcome,
//     welcomeBackDescription: _descWelcomeBack,
//     passwordMatchingError: _matchPassError,
//   );
//
//   String get _username => '?????? ????????????';
//
//   String get _login => '????????';
//
//   String get _signup => '?????? ??????';
//
//   String get _welcomeBack => '?????? ??????????';
//
//   String get _hintOfEmail => '?????? ????????????????????';
//
//   AuthMode currentMode = AuthMode.login;
//
//   String get _hintOfPass => '?????? ????????';
//
//   String get _forgetPass => '?????????????? ?????? ????????';
//
//   String get _notAccount => '???????? ???????? ???????????? ???????????? ';
//
//   String get _welcome => '???? ?????????? ?????? ??????????';
//
//   String get _confirmPass => '?????????? ?????? ????????';
//
//   String get _alreadyHaveAccount => '???????? ???????????? ?????????? ';
//
//   String get _descWelcome =>
//       '?????? ?????? ???????????? ???? ???? ???? ???? ?????? ???????????? ???? ???????????? ???????? ??????';
//
//   String get _descWelcomeBack => '?????? ???????? ???????? ?????? ?????????? ??????';
//
//   String get _matchPassError => '?????????????? ?????? ???????? ???????????? ??????????';
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//           fontFamily: 'Sahel',
//           primaryColor: Colors.white,
//           iconTheme: IconThemeData(color: ColorPallet.colorPalletDark),
//           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
//               .copyWith(secondary: Colors.black12)),
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: AnimatedLogin(
//           onLogin: (login) async {
//             print(login.email);
//             print('4');
//             Navigator.pushReplacementNamed(context, HOME_PAGE_PATH);
//             return "";
//           },
//           onSignup: (login) async {
//             return "";
//           },
//           onForgotPassword: (login) async {
//             return "";
//           },
//           // logo: Image.asset('assets/images/logo.gif'),
//           // backgroundImage: 'images/background_image.jpg',
//           signUpMode: SignUpModes.both,
//           // socialLogins: _socialLogins(context),
//           loginDesktopTheme: _desktopTheme,
//           loginMobileTheme: _mobileTheme,
//           loginTexts: _loginTexts,
//           initialMode: currentMode,
//           nameValidator: ValidatorModel(customValidator: (String? email) {
//             if (((email?.length) ?? 0) < 4) {
//               return '?????? ???????????? ???????? ?????? ???? 3 ?????? ????????';
//             }
//           }),
//           emailValidator: ValidatorModel(customValidator: (String? email) {
//             if (!((email ?? "").isValidEmail)) {
//               return '?????? ???????????????????? ?????????????? ??????';
//             }
//           }),
//           passwordValidator: ValidatorModel(
//               customValidator: (String? password) {
//                 if (((password?.length) ?? 0) < 6) {
//                   return '?????? ???????? ?????????? ???????? 6 ?????? ????????.';
//                 }
//               },
//               checkUpperCase: true),
//           onAuthModeChange: (AuthMode newMode) => currentMode = newMode,
//         ),
//       ),
//     );
//   }
// }
