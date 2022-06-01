import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/router_const.dart';
import 'package:honar_gallary/state_managment/splash/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  void navigationToHomePage() {
    Navigator.pushReplacementNamed(context, homePagePath);
  }

  void navigationToAuthPage() {
    Navigator.pushReplacementNamed(context, authPagePath);
  }

  late bool startApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: Scaffold(
          body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashGoToAuth) {
            navigationToAuthPage();
          }
          if (state is SplashGoToHome) {
            navigationToHomePage();
          }
        },
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state is SplashInitial && startApp) {
              startApp = false;
              BlocProvider.of<SplashCubit>(context).verifyToken();
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: ColorPallet.colorPalletDark),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: const Center(
                            child: Text(
                              "نگاره",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const CircularProgressBar(),
                ],
              ),
            );
          },
        ),
      )),
    );
  }

  void startTime() {}
}
