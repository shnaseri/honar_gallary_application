import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v14/api.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../const/color_const.dart';
import '../../logic/general_values.dart';
import '../../state_managment/create_edit_art_piece/edit_art_piece_cubit.dart';
import '../video_music_palyer/player_content.dart';
import 'image_list_view.dart';

class ProfileListItems extends StatefulWidget {
  final Function changeState;
  final ArtPiece artPiece;

  const ProfileListItems(
      {Key? key, required this.changeState, required this.artPiece})
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

  // String? _description;
  ScrollController scrollController = ScrollController();

  // final networkHandler = NetworkHandler();
  bool circular = false;

  // PickedFile _imageFile;
  // final _globalkey = GlobalKey<FormState>();

  // Initial Selected Value
  late String dropDownValue;
  int? dropDownValueCategory;

  // List of items in our dropdown menu
  var items = [
    'عکس',
    'فیلم',
    'موسیقی',
  ];
  late Map<String, List<String>> dataExtensions;
  late TextEditingController _name;
  late TextEditingController _profession;
  late TextEditingController _dob;

  late TextEditingController _title;
  late TextEditingController _about;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataExtensions = {
      items[0]: ['bmp', 'jpg', 'png'],
      items[1]: ['mp4', 'mkv', 'avi'],
      items[2]: ['mp3', 'flac']
    };
    _title = TextEditingController(text: widget.artPiece.title);
    _dob = TextEditingController(text: widget.artPiece.price.toString());
    _about = TextEditingController(text: widget.artPiece.description);

    selected = true;
    dropDownValue = getContentType(widget.artPiece.type);
    dropDownValueCategory =
        widget.artPiece.category == null ? null : widget.artPiece.category.id;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Form(
        key: _formKey,
        child: Padding(
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
                // onChanged: (String? newValue) {
                //   if (dropDownValue == newValue) {
                //     return;
                //   }
                //   setState(() {
                //     dropDownValue = newValue!;
                //     selected = false;
                //     fileSelected = null;
                //   });
                // },
                onChanged: null,
              ),
              20.height,
              DropdownButtonFormField<int>(
                hint: Text("دسته بندی خود را انتخاب کنید..."),
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
                  widget.changeState();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: selected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayerContentPage(
                                            type: widget.artPiece.type,
                                            content: widget.artPiece.type ==
                                                    "picture"
                                                ? widget.artPiece.cover.image
                                                : widget.artPiece.url,
                                          )));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith(
                                    (states) => ColorPallet.colorPalletDark),
                                padding: MaterialStateProperty.resolveWith(
                                    (states) => const EdgeInsets.symmetric(
                                        horizontal: 50)),
                                elevation: MaterialStateProperty.resolveWith(
                                    (states) => 2),
                                shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            child: Text(
                              " مشاهده " + dropDownValue,
                              style: TextStyle(
                                  fontFamily: 'Sahel',
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                  color: Colors.white),
                            ),
                          )
                          // Expanded(
                          //   flex: 4,
                          //   child: Text(
                          //     basename(fileSelected!.path),
                          //     style: TextStyle(
                          //       color: ColorPallet.colorPalletDark,
                          //       fontWeight: FontWeight.w900,
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //     flex: 2,
                          //     child: TextButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           selected = false;
                          //           fileSelected = null;
                          //         });
                          //       },
                          //       child: const Text('حذف'),
                          //       style: ButtonStyle(foregroundColor:
                          //           MaterialStateProperty.resolveWith((states) {
                          //         return ColorPallet.colorPalletSambucus;
                          //       }), textStyle:
                          //           MaterialStateProperty.resolveWith((states) {
                          //         return TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: ColorPallet.colorPalletDark,
                          //           fontFamily: 'Sahel',
                          //         );
                          //       })),
                          //     ))
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions:
                                      dataExtensions[dropDownValue]);

                          if (result != null) {
                            print(result);
                            fileSelected = File(result.files.single.path!);
                            setState(() {
                              selected = true;
                            });
                          } else {
                            // User canceled the picker
                            setState(() {
                              selected = false;
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => ColorPallet.colorPalletDark),
                            padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    const EdgeInsets.symmetric(horizontal: 50)),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 2),
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
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
                Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<EditArtPieceCubit, EditArtPieceState>(
                          builder: (context, state) {
                            print("---- current state -----");
                            print(state);
                            if (state is EditArtPieceSuccessfully) {
                              // showSnackBar(context, "با موفقیت انجام شد");
                              // BlocProvider.of<EditArtPieceCubit>(context)
                              //     .emit(EditArtPieceInitial());
                            }
                            return SizedBox(
                              height: 280,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    if (state is EditArtPieceInitial) {
                                      return SizedBox(
                                        width: 300,
                                        child:
                                            AddImageWidget(onChanged: (file) {
                                          setState(() {
                                            imageSliderFiles.add(file);
                                          });
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
                                    setState(() {
                                      imageSliderFiles.removeAt(index - 1);
                                    });
                                  }).paddingSymmetric(horizontal: 15);
                                },
                                itemCount: (imageSliderFiles.length) + 1,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(14),
                      color: Colors.black26,
                      height: 280,
                      width: context.width(),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            "امکان ویرایش این بخش وجود ندارد",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              const SizedBox(
                height: 50,
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
                      // if (fileSelected == null ||
                      //     (imageSliderFiles.isEmpty &&
                      //         dropDownValue != items[0])) {
                      //   return;
                      // }
                      bool status =
                          await BlocProvider.of<EditArtPieceCubit>(context)
                              .flowOfEditArtPiece(
                                  widget.artPiece.id,
                                  dropDownValue,
                                  _title.text,
                                  _about.text,
                                  imageSliderFiles,
                                  dropDownValueCategory!,
                                  price: _dob.text.toInt());

                      imageSliderFiles = [];
                      _title.text = "";
                      _dob.text = "";
                      _about.text = "";
                      fileSelected = null;
                      selected = false;
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: context.width() * 0.7,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.teal,
                            Colors.teal.shade200,
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
              70.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
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

  String getContentType(String type) {
    print(type);
    if (type == "picture") {
      return items[0];
    }
    if (type == "video") {
      return items[1];
    }
    return items[2];
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
