import 'package:flutter/material.dart';
import 'package:honar_gallary/const/color_const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
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
                      Expanded(child: buildTextField("نام", "", false)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: buildTextField("نام خانوادگی", "", false)),
                    ],
                  ),
                  buildTextField("ایمیل", "", false),
                  buildTextField("آدرس", "", false, multiLine: true),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      ColorPallet.colorPalletBlueGam),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.symmetric(
                                      horizontal: 50)),
                              elevation: MaterialStateProperty.resolveWith(
                                  (states) => 2),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          child: const Text(
                            "ذخیره",
                            style: TextStyle(
                                fontFamily: 'Sahel',
                                fontSize: 16,
                                letterSpacing: 1.2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.resolveWith((states) =>
                                const BorderSide(
                                    width: 2.0, color: Colors.white)),
                            padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    const EdgeInsets.symmetric(horizontal: 50)),
                            shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("لغو",
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
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField,
      {bool multiLine = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        minLines: 1,
        keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
        maxLines: multiLine ? 10 : 1,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white, style: BorderStyle.solid),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlue, style: BorderStyle.solid),
            ),
            border: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white, style: BorderStyle.solid),
            ),
            suffixIcon: isPasswordTextField
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
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 19,
              color: Colors.white70,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
            )),
      ),
    );
  }
}
