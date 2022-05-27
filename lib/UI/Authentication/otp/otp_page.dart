import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state_managment/otp/otp_cubit.dart';
import 'components/otp_code_component.dart';
import 'components/text_top_page.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
          child: BlocBuilder<OtpCubit, OtpState>(
            builder: (context, state) {
              return Column(
                children: [
                  ExpandedBlank(),
                  const Flexible(
                    child: TextTopOfPage(),
                    flex: 2,
                  ),
                  Expanded(
                    child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OtpCodeComponent()),
                    flex: 3,
                  ),
                  ExpandedBlank(
                    flex: 5,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ExpandedBlank extends StatelessWidget {
  int flex;

  ExpandedBlank({this.flex = 1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(),
      flex: flex,
    );
  }
}
