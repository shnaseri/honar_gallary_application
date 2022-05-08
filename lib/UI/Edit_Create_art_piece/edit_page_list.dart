import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../const/color_const.dart';
import '../Art_piece/art_piece_model.dart';
// import 'edit_page_list_item2.dart';
// import 'hover_test.dart';
// import 'image_card.dart';
import 'image_list_view.dart';

class ProfileListItems extends StatefulWidget {
  final Function changeState;

  const ProfileListItems({Key? key, required this.changeState})
      : super(key: key);

  @override
  State<ProfileListItems> createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  static List<ArtPiece> artPieces = [
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
    ArtPiece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),
  ];

  // Initial Selected Value
  String dropDownValue = 'عکس';

  // List of items in our dropdown menu
  var items = [
    'عکس',
    'فیلم',
    'موسیقی',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(),
      width: context.width(),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
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
                setState(() {
                  dropDownValue = newValue!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),

            aboutTextField(),
            Column(
              children: [
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ImageSlider();
                    },
                    itemCount: artPieces.length,
                  ),
                ),
              ],
            ),

            // _buildCategoryField(),
            // _buildImageUrlField(),

            GestureDetector(
              // onTap: () {},
              onTap: () => {
                if (!_formKey.currentState!.validate()) {},
                _formKey.currentState!.save()
              },
              child: Container(
                width: 40,
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
                child: const Center(
                  child: Text(
                    'ذخیره',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
