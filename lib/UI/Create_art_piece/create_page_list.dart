import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v17/api.dart';
import 'package:honar_gallary/UI/utils/auto_text_direction.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';

import '../../const/color_const.dart';
import '../../state_managment/create_edit_art_piece/edit_art_piece_cubit.dart';
// import 'edit_page_list_item2.dart';
// import 'hover_test.dart';
// import 'image_card.dart';
import '../Art_piece/components/arc_banner_image.dart';
import 'image_list_view.dart';

class ProfileListItems extends StatefulWidget {
  final Function changeState;

  const ProfileListItems({Key? key, required this.changeState})
      : super(key: key);

  @override
  State<ProfileListItems> createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {
  // String? _fileName;
  // String? _saveAsFileName;
  // List<PlatformFile>? _paths;
  // String? _directoryPath;
  // String? _extension;
  // bool _isLoading = false;
  // bool _userAborted = false;
  // bool _multiPick = false;
  late bool selected;
  File? fileSelected;
  List<File> imageSliderFiles = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool uploading;

  // String? _description;
  ScrollController scrollController = ScrollController();

  // final networkHandler = NetworkHandler();
  bool circular = false;

  // PickedFile _imageFile;
  // final _globalkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _profession = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _about = TextEditingController();

  // Initial Selected Value
  String dropDownValue = 'عکس';
  int? dropDownValueCategory;

  // List of items in our dropdown menu
  var items = [
    'عکس',
    'فیلم',
    'موسیقی',
  ];
  late Map<String, List<String>> dataExtensions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataExtensions = {
      items[0]: ['bmp', 'jpg', 'png'],
      items[1]: ['mp4', 'mkv', 'avi'],
      items[2]: ['mp3', 'flac']
    };
    selected = false;
    dropDownValueCategory = null;
    uploading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: ArcBannerImage("assets/images/sample1.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      25.height,
                      titleTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _dob,
                        validator: (value) {
                          // if (value.isEmpty) return "DOB can't be empty";

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ColorPallet.colorPalletSambucus,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ColorPallet.colorPalletSambucus,
                            width: 2,
                          )),
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: ColorPallet.colorPalletNightFog,
                          ),

                          labelText: "قیمت",
                          // helperText: "Provide DOB on dd/mm/yyyy",
                          // hintText: "01/01/2020",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        // Initial Value
                        value: dropDownValue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        elevation: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          if (dropDownValue == newValue) {
                            return;
                          }
                          dropDownValue = newValue!;
                          selected = false;
                          fileSelected = null;
                          widget.changeState();
                        },
                      ),
                      20.height,
                      DropdownButtonFormField<int>(
                        hint: const Text("دسته بندی خود را انتخاب کنید..."),
                        // Initial Value
                        value: dropDownValueCategory,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: ConfigGeneralValues.getInstance()
                            .getCategories()
                            .sublist(1)
                            .map<DropdownMenuItem<int>>((Category items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.name),
                          );
                        }).toList(),
                        elevation: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (int? newValue) {
                          if (dropDownValueCategory == newValue) {
                            return;
                          }
                          dropDownValueCategory = newValue!;
                          selected = false;
                          fileSelected = null;
                          widget.changeState();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: selected && fileSelected != null
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      basename(fileSelected!.path),
                                      style: TextStyle(
                                        color: ColorPallet.colorPalletDark,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: TextButton(
                                        onPressed: () {
                                          selected = false;
                                          fileSelected = null;
                                          widget.changeState();
                                        },
                                        child: const Text('حذف'),
                                        style: ButtonStyle(foregroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return ColorPallet
                                              .colorPalletSambucus;
                                        }), textStyle:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorPallet.colorPalletDark,
                                            fontFamily: 'Sahel',
                                          );
                                        })),
                                      ))
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions:
                                              dataExtensions[dropDownValue]);

                                  if (result != null) {
                                    print(result);
                                    fileSelected =
                                        File(result.files.single.path!);
                                    selected = true;
                                    widget.changeState();
                                  } else {
                                    // User canceled the picker
                                    selected = false;
                                    widget.changeState();
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                ColorPallet.colorPalletDark),
                                    padding: MaterialStateProperty.resolveWith(
                                        (states) => const EdgeInsets.symmetric(
                                            horizontal: 50)),
                                    elevation: MaterialStateProperty.resolveWith(
                                        (states) => 2),
                                    shape: MaterialStateProperty.resolveWith(
                                        (states) => RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)))),
                                child: const Text(
                                  "آپلود فایل",
                                  style: TextStyle(
                                      fontFamily: 'Sahel',
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      color: Colors.white),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      aboutTextField(),
                      if (dropDownValue != items[0])
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<EditArtPieceCubit, EditArtPieceState>(
                              builder: (context, state) {
                                print("---- current state -----");
                                print(state);
                                if (state is EditArtPieceSuccessfully) {}
                                return SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        if (state is EditArtPieceInitial) {
                                          return SizedBox(
                                            width: 300,
                                            child: AddImageWidget(
                                                onChanged: (file) {
                                              imageSliderFiles.add(file);
                                              widget.changeState();
                                              print(imageSliderFiles.length);
                                              print(imageSliderFiles);
                                            }),
                                          );
                                        }
                                        return Container();
                                      }
                                      return ImageSliderTile(
                                          imageSliderFiles[index - 1],
                                          onRemove: () {
                                        imageSliderFiles.removeAt(index - 1);
                                        widget.changeState();
                                      }).paddingSymmetric(horizontal: 15);
                                    },
                                    itemCount: (imageSliderFiles.length) + 1,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      if (dropDownValue != items[0])
                        const SizedBox(
                          height: 10,
                        ),
                      if (dropDownValue == items[0])
                        const SizedBox(
                          height: 30,
                        ),
                      BlocBuilder<EditArtPieceCubit, EditArtPieceState>(
                        builder: (context, state) {
                          // if (state is EditArtPieceSuccessfully) {
                          //   imageSliderFiles = [];
                          //   _title.text = "";
                          //   _dob.text = "";
                          //   _about.text = "";
                          //   fileSelected = null;
                          //   selected = false;
                          //
                          //   BlocProvider.of<EditArtPieceCubit>(context).resetState();
                          // }
                          return GestureDetector(
                            // onTap: () {},
                            onTap: () async {
                              if (state is! EditArtPieceInitial) {
                                return;
                              }
                              if (fileSelected == null ||
                                  dropDownValueCategory == null ||
                                  (imageSliderFiles.isEmpty &&
                                      dropDownValue != items[0])) {
                                return;
                              }
                              setState(() {
                                uploading = true;
                              });
                              bool status =
                                  await BlocProvider.of<EditArtPieceCubit>(
                                          context)
                                      .flowOfCreateArtPiece(
                                          fileSelected!,
                                          dropDownValue,
                                          _title.text,
                                          _about.text,
                                          imageSliderFiles,
                                          dropDownValueCategory!,
                                          price: _dob.text.toInt());
                              await Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  uploading = false;
                                });
                              });
                              imageSliderFiles = [];
                              _title.text = "";
                              _dob.text = "";
                              _about.text = "";
                              fileSelected = null;
                              selected = false;
                              BlocProvider.of<EditArtPieceCubit>(context)
                                  .resetState();
                              widget.changeState();
                            },
                            child: Container(
                              width: context.width() * 0.7,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorPallet.colorPalletBlueGam,
                                    ColorPallet.colorPalletNightFog,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: state is EditArtPieceInitial ||
                                      state is EditArtPieceSuccessfully
                                  ? const Center(
                                      child: Text(
                                        'ذخیره',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (uploading)
              Container(
                width: context.width(),
                height: context.height(),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                ),
                child: BlocBuilder<EditArtPieceCubit, EditArtPieceState>(
                  builder: (context, state) {
                    print(state);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.width() * 0.8,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                if (state is! EditArtPieceSuccessfully)
                                  Column(
                                    children: [
                                      const MoreLoadingGif(
                                          type: MoreLoadingGifType.doubleRing),
                                      Text(
                                        "در حال آپلود ...",
                                        style: TextStyle(
                                            color:
                                                ColorPallet.colorPalletBlueGam,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                if (state is EditArtPieceSuccessfully)
                                  Column(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 70,
                                        ),
                                      ),
                                      Text(
                                        "با موفقیت انجام شد",
                                        style: TextStyle(
                                            color:
                                                ColorPallet.colorPalletBlueGam,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                if (state is EditArtPieceError)
                                  Column(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.error_rounded,
                                          color: Colors.red,
                                          size: 70,
                                        ),
                                      ),
                                      Text(
                                        "با موفقیت انجام شد",
                                        style: TextStyle(
                                            color:
                                                ColorPallet.colorPalletBlueGam,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (dropDownValue == "عکس" &&
                                    state is! EditArtPieceError)
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: const [
                                                Text("1-"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(" تصویر"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state is EditArtPieceInitial ||
                                                        state
                                                            is EditArtPieceUploadingCover ||
                                                        state
                                                            is EditArtPieceSendingCover)
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: const [
                                                Text("2-"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("اطلاعات"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state is EditArtPieceInitial ||
                                                        state
                                                            is EditArtPieceUploadingCover ||
                                                        state
                                                            is EditArtPieceSendingCover ||
                                                        state
                                                            is EditArtPieceSendingInformation)
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (dropDownValue != "عکس" &&
                                    state is! EditArtPieceError)
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: const [
                                                Text("1-"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("کاور اثر هنری"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state is EditArtPieceInitial ||
                                                        state
                                                            is EditArtPieceUploadingCover ||
                                                        state
                                                            is EditArtPieceSendingCover)
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: const [
                                                Text("2-"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("عکس ها"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state is EditArtPieceInitial ||
                                                        state
                                                            is EditArtPieceUploadingCover ||
                                                        state
                                                            is EditArtPieceSendingCover ||
                                                        state
                                                            is EditArtPieceUploadingImages
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      )))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: const [
                                                Text("3-"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("اطلاعات"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state is EditArtPieceInitial ||
                                                        state
                                                            is EditArtPieceUploadingCover ||
                                                        state
                                                            is EditArtPieceSendingCover ||
                                                        state
                                                            is EditArtPieceUploadingImages ||
                                                        state
                                                            is EditArtPieceSendingInformation)
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text("4-"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    "اثر هنری ($dropDownValue)"),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: (state
                                                        is! EditArtPieceSuccessfully
                                                    ? CircularProgressIndicator()
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      )))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget nameTextField() {
    return AutoDirection(
      text: _name.text,
      child: TextFormField(
        controller: _name,
        validator: (value) {
          // if (value.isEmpty) return "Name can't be empty";

          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "نام",
          // helperText: "این بخش نمی تواند خالی بماند!",
          // hintText: "بابک بهکام کیا",
        ),
      ),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      controller: _profession,
      validator: (value) {
        // if (value.isEmpty) return "Profession can't be empty";

        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "نام خانوادگی",
        // helperText: "Profession can't be empty",
        // hintText: "Full Stack Developer",
      ),
    );
  }

  Widget dobField(String time) {
    return TextFormField(
      controller: _dob,
      validator: (value) {
        // if (value.isEmpty) return "DOB can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.date_range_rounded,
          color: ColorPallet.colorPalletNightFog,
        ),

        labelText: "تاریخ " + time,
        // helperText: "Provide DOB on dd/mm/yyyy",
        // hintText: "01/01/2020",
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        // if (value.isEmpty) return "Title can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.title,
          color: ColorPallet.colorPalletBlueGam,
        ),
        labelText: "عنوان",
        // helperText: "It can't be empty",
        // hintText: "Flutter Developer",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        // if (value.isEmpty) return "About can't be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorPallet.colorPalletSambucus,
          width: 2,
        )),

        labelText: "درباره اثر",
        // helperText: "Write about yourself",
        // hintText: "I am Dev Stack",
      ),
    );
  }
}

Widget buildCoverImage() => Container(
      decoration: BoxDecoration(
          color: ColorPallet.colorPalletPurpleRain,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/photo2.jpeg"),
          )),
    );

Widget buildProfileImage(double profileHeight) {
  return CircleAvatar(
    radius: 35,
    backgroundColor: ColorPallet.colorPalletPurpleRain,
    backgroundImage: const AssetImage("assets/images/sample1.jpg"),
  );
}
