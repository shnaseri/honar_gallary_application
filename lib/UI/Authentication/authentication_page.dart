import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';
import 'package:honar_api_v22/api.dart';
import 'package:honar_gallary/UI/Authentication/otp/otp_page.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/extenstion_methods.dart';
import 'package:honar_gallary/logic/general_values.dart';
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
        animatedComponentOrder: <AnimatedComponent>[
          AnimatedComponent(component: LoginComponents.logo),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(
            component: LoginComponents.formTitle,
          ),
          AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(
            component: LoginComponents.changeActionButton,
          ),
          AnimatedComponent(
            component: LoginComponents.actionButton,
          ),
        ],
        backgroundColor: Color.fromRGBO(4, 9, 35, 1),
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

  String get _username => '?????? ?? ?????? ????????????????';

  String get _login => '????????';

  String get _signup => '?????? ??????';

  String get _welcomeBack => '?????? ??????????';

  String get _hintOfEmail => '?????? ????????????????????';

  AuthMode currentMode = AuthMode.login;

  String get _hintOfPass => '?????? ????????';

  String get _forgetPass => '?????????????? ?????? ????????';

  String get _notAccount => '???????? ???????? ???????????? ???????????? ';

  String get _welcome => '???? ?????????? ?????? ??????????';

  String get _confirmPass => '?????????? ?????? ????????';

  String get _alreadyHaveAccount => '???????? ???????????? ?????????? ';

  String get _descWelcome =>
      '?????? ?????? ???????????? ???? ???? ???? ???? ?????? ???????????? ???? ???????????? ???????? ??????';

  String get _descWelcomeBack => '?????? ???????? ???????? ?????? ?????????? ??????';

  String get _matchPassError => '?????????????? ?????? ???????? ???????????? ??????????';
  late AuthApi authApi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interfaceOfUser = ApiClient();
    authApi = AuthApi(interfaceOfUser);
  }

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
            try {
              AccessRefresh token = (await authApi.authLoginCreate(
                  TokenObtainPair(
                      email: login.email, password: login.password)))!;

              ConfigGeneralValues.getInstance().putToken(token.access);
              HttpBearerAuth auth = HttpBearerAuth();
              auth.accessToken = token.access;
              interfaceOfUser = ApiClient(authentication: auth);
              CategoryApi categoryApi = CategoryApi(interfaceOfUser);
              ConfigGeneralValues.getInstance()
                  .setListCategory((await categoryApi.categoryGetAllList())!);
              authApi = AuthApi(interfaceOfUser);
              AuthMeList200Response response2004 =
                  (await authApi.authMeList())!;
              ConfigGeneralValues.getInstance().setUserId(response2004.userId!);
              print(response2004.userId);
              late ProfileApi profileApi = ProfileApi(interfaceOfUser);
              profileApi = ProfileApi(interfaceOfUser);
              FullUser? fullUser =
                  await profileApi.profileRead(response2004.userId!);
              print(fullUser);
              ConfigGeneralValues.getInstance().setProfile(fullUser!);
              Navigator.pushReplacementNamed(context, homePagePath);
              return '';
            } catch (e) {
              print(e);
              final snackBar = SnackBar(
                padding: const EdgeInsets.only(left: 20),
                content: const Text(
                  "?????? ???????????? ???? ?????? ???????? ???????????? ???????? ?????? ??????.",
                  textAlign: TextAlign.start,
                ),
                backgroundColor: (Colors.black12),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return "?????? ???????????? ???? ?????? ???????? ???????????? ???????? ?????? ??????";
            }
          },
          onSignup: (login) async {
            try {
              UserId? userId = await authApi.authRegisterCreate(Register(
                  email: login.email,
                  password: login.password,
                  firstName: ".",
                  lastName: login.name));
              try {
                await authApi.authSendOtpCodeCreate(userId!.id.toString());
              } catch (e) {
                print(e);
              }
              // AccessRefresh token = await authApi.authLoginCreate(
              //     TokenObtainPair(
              //         email: login.email, password: login.password));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OTPPage(userId: userId!.id!)));

              return "";
            } catch (e) {
              print(e);
              showSnackBar(context, "?????????????? ???? ???? ?????????? ???????? ????????????.");
              return "?????????????? ???? ???? ?????????? ???????? ????????????.";
            }
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
              return '?????????? ???????? ???????? ?????????? ????????';
            }
            return null;
          }),
          emailValidator: ValidatorModel(customValidator: (String? email) {
            if (!((email ?? "").isValidEmail)) {
              return '?????? ???????????????????? ?????????????? ??????';
            }
            return null;
          }),
          passwordValidator: ValidatorModel(
              customValidator: (String? password) {
                if (((password?.length) ?? 0) < 6) {
                  return '?????? ???????? ?????????? ???????? 6 ?????? ????????.';
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

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.only(left: 20),
    content: Text(
      text,
      textAlign: TextAlign.start,
    ),
    backgroundColor: (Colors.black12),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
