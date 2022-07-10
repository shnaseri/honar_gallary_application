import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/state_managment/home_page/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool startApp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp = true;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if(state is HomeInitial && startApp) {
              BlocProvider.of<HomeCubit>(context).fetchHome();
              startApp = false;
            }
            if(state is HomeLoaded) {
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ],
            );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("متاسفانه در لود شدن  این صفحه مشکلی به وجود امده است",style: TextStyle(
                  color: ColorPallet.colorPalletSambucus,fontWeight: FontWeight.w800
                ),))
              ],
            );
          },
        ),
      ),
    );
  }
}
