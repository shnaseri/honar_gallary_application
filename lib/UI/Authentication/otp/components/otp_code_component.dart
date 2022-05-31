import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_gallary/UI/Authentication/otp/components/text_field_otp_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../logic/router_const.dart';
import '../../../../logic/string_repository.dart';
import '../../../../state_managment/otp/otp_cubit.dart';

List<TextEditingController> numbers = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
];

class OtpCodeComponent extends StatefulWidget {
  final int userId;

  OtpCodeComponent({Key? key, required this.userId}) : super(key: key);

  @override
  State<OtpCodeComponent> createState() => _OtpCodeComponentState();
}

late OtpState otpState = OtpInitial();

class _OtpCodeComponentState extends State<OtpCodeComponent> {
  late BuildContext blocContext;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  late int sendAgainTime;
  late bool tryAgain;
  int timeSendAgain = 60;

  @override
  void initState() {
    tryAgain = true;
    sendAgainTime = timeSendAgain;
  }

  void getTimerPeriodic(timer) {
    if (sendAgainTime > 0) {
      setState(() {
        sendAgainTime--;
      });
    } else {
      setState(() {
        tryAgain = true;
      });
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        blocContext = context;
        otpState = state;
        if (state is OtpBadCode) {
          formKey.currentState!.validate();
        }
        return Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: buildDescriptionTopOfTextField(context),
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldEachCode(
                      index: 0,
                      controller: numbers[0],
                      completeFunction: checkControllerAndSendToServer,
                    ),
                    25.width,
                    TextFieldEachCode(
                      index: 1,
                      controller: numbers[1],
                      completeFunction: checkControllerAndSendToServer,
                    ),
                    25.width,
                    TextFieldEachCode(
                      index: 2,
                      controller: numbers[2],
                      completeFunction: checkControllerAndSendToServer,
                    ),
                    25.width,
                    TextFieldEachCode(
                      index: 3,
                      controller: numbers[3],
                      completeFunction: checkControllerAndSendToServer,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
              10.height,
              state is! OtpLoadingCodeState
                  ? buildForLoadingAndResendCode(state, context)
                  : const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  Expanded buildForLoadingAndResendCode(OtpState state, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          state is OtpBadCode
              ? const SizedBox(
                  height: 30,
                  child: Text(
                    "کد وارد شده اشتباه است",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                )
              : Container(),
          Expanded(
            flex: 1,
            child: Center(
              child: tryAgain
                  ? TextButton(
                      onPressed: () async {
                        setState(() {
                          timer = Timer.periodic(
                              const Duration(milliseconds: 1000),
                              getTimerPeriodic);
                          tryAgain = false;
                          sendAgainTime = timeSendAgain;
                        });
                        await BlocProvider.of<OtpCubit>(context)
                            .resendCode(widget.userId);
                        await resetState();
                      },
                      child: const Text("ارسال مجدد",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                          )),
                    )
                  : Text(
                      getTextOfResend(sendAgainTime),
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  buildDescriptionTopOfTextField(BuildContext context) {
    return Center(
      child: Text(
        descriptionTopOfTextFieldOtpPage,
        textDirection: TextDirection.rtl,
        style: primaryTextStyle(
            color: Colors.white,
            size:
                Theme.of(context).textTheme.subtitle1?.fontSize!.toInt() ?? 50,
            weight: FontWeight.w600),
      ),
    );
  }

  Future<void> checkControllerAndSendToServer() async {
    bool isFillCode = true;
    String codeOtp = "";
    if (otpState is OtpBadCode) {
      // await resetState();

    }
    for (var controller in numbers) {
      if (controller.text.isEmpty) {
        isFillCode = false;
        break;
      }
      codeOtp += controller.text;
    }
    if (isFillCode) {
      if (otpState is! OtpLoadingCodeState) {
        bool status = await BlocProvider.of<OtpCubit>(blocContext)
            .sendCodeOtp(widget.userId, codeOtp);
        if (status) {
          Navigator.pushNamedAndRemoveUntil(
              context, homePagePath, (e) => false);
        }
      }
    }
  }

  Future<void> resetState() async {
    for (var element in numbers) {
      element.clear();
    }
    await BlocProvider.of<OtpCubit>(blocContext).changeState();
    otpState = OtpInitial();
    FocusScope.of(context).unfocus();
    formKey.currentState!.validate();
  }

  String getTextOfResend(int time) {
    return " ارسال مجدد تا " + time.toString() + " ثانیه دیگر";
  }
}
