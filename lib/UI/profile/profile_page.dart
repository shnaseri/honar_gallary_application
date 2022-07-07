import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v14/api.dart';
import 'package:honar_gallary/UI/utils/auto_text_direction.dart';
import 'package:honar_gallary/const/color_const.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:honar_gallary/state_managment/profile/profile_cubit.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Authentication/authentication_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  late TextEditingController _name;
  late TextEditingController _lastname;
  late TextEditingController _email;

  late TextEditingController _phoneNumber;
  late TextEditingController _about;
  late FullUser profile;

  late bool selectedImage;
  File? selectedFile;

  @override
  void initState() {
    // TODO: implement initState
    profile = ConfigGeneralValues.getInstance().profile;
    super.initState();
    print(profile);
    _name = TextEditingController(text: profile.firstName);
    _lastname = TextEditingController(text: profile.lastName);
    _email = TextEditingController(text: profile.email);
    _phoneNumber = TextEditingController(text: profile.userProfile.phoneNumber);
    selectedImage = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: Scaffold(
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
            child: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const Text(
                      "تغییر اطلاعات کاربری",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            child: selectedImage && selectedFile != null
                                ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(selectedFile!))),
                                  )
                                : CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: imageProvider)),
                                      );
                                    },
                                    placeholder: (context, strImage) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      );
                                    },
                                    imageUrl: profile.userProfile.avatar != null
                                        ? profile.userProfile.avatar.image
                                        : 'https://picsum.photos/id/237/200/300',
                                    fit: BoxFit.fill,
                                    height: context.height() * 0.05,
                                    width: context.width(),
                                  ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: selectedImage && selectedFile != null
                                  ? GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          selectedFile = null;
                                          selectedImage = false;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                              'bmp',
                                              'jpg',
                                              'png'
                                            ]);

                                        if (result != null) {
                                          setState(() {
                                            selectedFile =
                                                File(result.files.single.path!);
                                            selectedImage = true;
                                          });
                                        } else {
                                          selectedImage = false;
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Expanded(child: TextFieldEdit("نام", "", false, _name)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFieldEdit(
                                "نام خانوادگی", "", false, _lastname)),
                      ],
                    ),
                    TextFieldEdit(
                      "ایمیل",
                      "",
                      false,
                      _email,
                      enabled: false,
                    ),
                    TextFieldEdit("شماره موبایل", "", false, _phoneNumber,
                        multiLine: true),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (state is ProfileSendingState) {
                                    return;
                                  }
                                  if (_name.text == "" ||
                                      _lastname.text == "" ||
                                      _email.text == "" ||
                                      _phoneNumber.text == "") {
                                    return;
                                  }
                                  print("---- send info profile ---");
                                  try {
                                    await BlocProvider.of<ProfileCubit>(context)
                                        .uploadProfile(selectedFile!);
                                    profile =
                                        await BlocProvider.of<ProfileCubit>(
                                                context)
                                            .sendInfoProfile(
                                                _name.text,
                                                _lastname.text,
                                                _email.text,
                                                _phoneNumber.text);
                                    ConfigGeneralValues.getInstance()
                                        .setProfile(profile);
                                    showSnackBar(
                                        context, "اطلاعات با موفقیت انجام شد");
                                  } catch (e) {
                                    showSnackBar(
                                        context, "اطلاعات با موفقیت انجام شد");
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                            (states) =>
                                        ColorPallet.colorPalletBlueGam),
                                    padding: MaterialStateProperty.resolveWith(
                                            (states) => const EdgeInsets.symmetric(
                                            horizontal: 50)),
                                    elevation: MaterialStateProperty.resolveWith(
                                            (states) => 2),
                                    shape: MaterialStateProperty.resolveWith(
                                            (states) => RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)))),
                                child: state is ProfileSendingState
                                    ? Row(
                                  children: const [
                                    CircularProgressIndicator(),
                                  ],
                                )
                                    : const Text(
                                  "ذخیره",
                                  style: TextStyle(
                                      fontFamily: 'Sahel',
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.resolveWith(
                                      (states) => const BorderSide(
                                      width: 2.0, color: Colors.white)),
                              padding: MaterialStateProperty.resolveWith(
                                      (states) => const EdgeInsets.symmetric(
                                      horizontal: 50)),
                              shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            onPressed: () {
                              _name = TextEditingController(
                                  text: profile.firstName);
                              _lastname =
                                  TextEditingController(text: profile.lastName);
                              _email =
                                  TextEditingController(text: profile.email);
                              _phoneNumber = TextEditingController(
                                  text: profile.userProfile.phoneNumber);
                              selectedFile = null;
                              selectedImage = false;
                              setState(() {});
                            },
                            child: const Text("بازنشانی",
                                style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class TextFieldEdit extends StatefulWidget {
  String labelText;
  String placeholder;
  bool isPasswordTextField;
  TextEditingController controller;
  bool multiLine;
  bool enabled;

  TextFieldEdit(this.labelText, this.placeholder, this.isPasswordTextField,
      this.controller,
      {Key? key, this.multiLine = false, this.enabled = true})
      : super(key: key);

  @override
  State<TextFieldEdit> createState() => _TextFieldEditState();
}

class _TextFieldEditState extends State<TextFieldEdit> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(color: Colors.white),
        ),
        6.height,
        AutoDirection(
          text: widget.controller.text,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: TextField(
              enabled: widget.enabled,
              obscureText: widget.isPasswordTextField ? showPassword : false,
              minLines: 1,
              controller: widget.controller,
              keyboardType: widget.multiLine
                  ? TextInputType.multiline
                  : TextInputType.text,
              maxLines: widget.multiLine ? 10 : 1,
              onChanged: (str) {
                setState(() {});
              },
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white, style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.indigoAccent, style: BorderStyle.solid),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white, style: BorderStyle.solid),
                  ),
                  suffixIcon: widget.isPasswordTextField
                      ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white60,
                    ),
                  )
                      : null,
                  contentPadding:
                  const EdgeInsets.only(bottom: 3, left: 8, right: 8),
                  labelStyle: const TextStyle(
                    fontSize: 19,
                    color: Colors.white70,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.placeholder,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
