


// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../const/color_const.dart';
import '../Art_piece/Art_piece_model.dart';
// import 'Edit_page_list_item.dart';
// import 'hover_test.dart';
// import 'image_card.dart';
import 'image_list_view.dart';

class ProfileListItems extends StatefulWidget {
  Function changeState;

  ProfileListItems({Key? key, required this.changeState}) : super(key: key);

  @override
  State<ProfileListItems> createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? _description;
  ScrollController scrollController = ScrollController();


  // final networkHandler = NetworkHandler();
  bool circular = false;
  // PickedFile _imageFile;
  // final _globalkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();



  static List<Art_piece> artPieces = [
    Art_piece(
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
    Art_piece(
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
    Art_piece(
      id: 1,
      name: 'بازی مافیا',
      description: 'برگزاری بازی مافیا به صورت گروهی به همراه جایزه',
      imageUrl: '',
      discount: 10,
      ownerId: 2,
      startTime: DateTime(2020),
      finishTime: DateTime(2021),
      // comments: [],
    ),];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(),
      width: context.width(),
      margin: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          children: [
            titleTextField(),
            const SizedBox(
              height: 20,
            ),
            // nameTextField(),
            // const SizedBox(
            //   height: 20,
            // ),
            // professionTextField(),
            // const SizedBox(
            //   height: 20,
            // ),
            dobField('شروع'),
            const SizedBox(
              height: 20,
            ),
            dobField('پایان'),
            const SizedBox(
              height: 20,
            ),
            aboutTextField(),
            const SizedBox(
              height: 20,
            ),
            // _buildNameField(),
            // _buildDescriptionField(),
            Column(
              children:[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ImageSlider();
                    },
                    itemCount: artPieces.length,
                  ),
                ),
                GestureDetector(
                  // onTap: () {},
                  onTap: () => {
                    if (!_formKey.currentState!.validate()) {},
                    _formKey.currentState!.save()
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.teal.shade200,
                        ],
                        // begin: Alignment.topLeft,
                        // end: Alignment.bottomRight,
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
                        'اضافه کردن عکس',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // _buildCategoryField(),
            // _buildImageUrlField(),

            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              // onTap: () {},
              onTap: () => {
                if (!_formKey.currentState!.validate()) {},
                _formKey.currentState!.save()
              },
              child: Container(
                width: 40,
                height: 30,
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
                      fontSize: 10,
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
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
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
        labelText: "درباره اثر",
        // helperText: "Write about yourself",
        // hintText: "I am Dev Stack",
      ),
    );
  }
}


Widget buildCoverImage(double coverHeight) => Container(
  color: ColorPallet.colorPalletPurpleRain,
  height: coverHeight,
);

Widget buildProfileImage(double profileHeight) {
  print('doroste');
  return CircleAvatar(
    radius: 40,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: const NetworkImage(
      'https://hips.hearstapps.com/ghk.h-cdn.co/assets/17/30/2560x1280/landscape-1500925839-golden-retriever-puppy.jpg?resize=480:*'
    ),
  );
}



