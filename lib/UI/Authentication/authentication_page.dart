import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';
import 'package:honar_api_v17/api.dart';
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

  String get _username => 'نام و نام خانوادگی';

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

              Navigator.pushReplacementNamed(context, homePagePath);
              ConfigGeneralValues.getInstance().putToken(token.access);
              HttpBearerAuth auth = HttpBearerAuth();
              auth.accessToken = token.access;
              interfaceOfUser = ApiClient(authentication: auth);
              CategoryApi categoryApi = CategoryApi(interfaceOfUser);
              ConfigGeneralValues.getInstance()
                  .setListCategory((await categoryApi.categoryGetAllList())!);
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
              return '';
            } catch (e) {
              print(e);
              final snackBar = SnackBar(
                padding: const EdgeInsets.only(left: 20),
                content: const Text(
                  "نام کاربری یا رمز عبور نادرست وارد شده است.",
                  textAlign: TextAlign.start,
                ),
                backgroundColor: (Colors.black12),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return "نام کاربری یا رمز عبور نادرست وارد شده است";
            }
          },
          onSignup: (login) async {
            try {
              UserId? userId = await authApi.authRegisterCreate(Register(
                  email: login.email,
                  password: login.password,
                  firstName: "s",
                  lastName: login.name));
              try {
                await authApi.authSendOtpCodeCreate(userId!.id.toString());
              } catch (e) {}
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
              showSnackBar(context, "اطلاعات را به درستی وارد نمایید.");
              return "اطلاعات را به درستی وارد نمایید.";
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
              return 'تعداد حروف باید بیشتر باشد';
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
