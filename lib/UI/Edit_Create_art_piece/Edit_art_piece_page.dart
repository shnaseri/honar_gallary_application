
import 'package:flutter/material.dart';
// import 'package:honar_gallary/UI/Edit_Create_art_piece/image_card.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Edit_page_list.dart';

// import 'package:image_picker/image_picker.dart';

class Edit_art_piece extends StatefulWidget {
  const Edit_art_piece({Key? key}) : super(key: key);

  @override
  _Edit_art_pieceState createState() => _Edit_art_pieceState();
}

class _Edit_art_pieceState extends State<Edit_art_piece> {
  // String? _name;
  // String? _description;
  ScrollController scrollController = ScrollController();


  // final networkHandler = NetworkHandler();
  bool circular = false;

  // PickedFile _imageFile;
  // final _globalkey = GlobalKey<FormState>();
  // TextEditingController _name = TextEditingController();
  // TextEditingController _profession = TextEditingController();
  // TextEditingController _dob = TextEditingController();
  // TextEditingController _title = TextEditingController();
  // TextEditingController _about = TextEditingController();

  // final ImagePicker _picker = ImagePicker();

  String sagImage = 'https://hips.hearstapps.com/ghk.h-cdn.co/assets/17/30/2560x1280/landscape-1500925839-golden-retriever-puppy.jpg?resize=480:*';

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double coverHeight = context.height() * 0.27;
    double profileHeight = context.height() * 0.2;
    final top = coverHeight - profileHeight / 4;
    final bottom = profileHeight / 2;

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              title: SizedBox(
                width: context.width() * 0.4,
                child: Text(
                  'حسین',
                  style: boldTextStyle(color: Colors.white, size: 19),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              centerTitle: false,
              background: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: bottom),
                      child: buildCoverImage(coverHeight)),
                  Positioned(
                    right: 50,
                    top: top,
                    child: buildProfileImage(profileHeight),
                  ),
                  Positioned(
                    left: 40,
                    bottom: 10,
                    child: Container(
                      width: context.width() * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.width() * 0.4,
                            child: Row(
                              children: [],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "نام کاربری : ",
                                style: primaryTextStyle(
                                    color: Colors.white, size: 15),
                              ),
                              SizedBox(
                                width: context.width() * 0.12,
                                child: Text(
                                  'bbkbe',
                                  style: primaryTextStyle(
                                      color: Colors.white, size: 15),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              return ProfileListItems(
                changeState: () {
                  print('1');
                  setState(() {});
                },
              );
            }, childCount: 1),
          ),
        ],
      ),
    );


    // return Scaffold(
    //   body: Container(
    //     height: context.height(),
    //     width: context.width(),
    //     margin: const EdgeInsets.all(24),
    //     child: Form(
    //       key: _formKey,
    //       child: ListView(
    //         padding: EdgeInsets.zero,
    //         physics: const ClampingScrollPhysics(),
    //         controller: scrollController,
    //         children: [
    //           titleTextField(),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           // nameTextField(),
    //           // const SizedBox(
    //           //   height: 20,
    //           // ),
    //           // professionTextField(),
    //           // const SizedBox(
    //           //   height: 20,
    //           // ),
    //           dobField('شروع'),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           dobField('پایان'),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           aboutTextField(),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           // _buildNameField(),
    //           // _buildDescriptionField(),
    //           Container(
    //                   margin: const EdgeInsets.symmetric(vertical: 20.0),
    //                   height: 300,
    //                   child: ListView.builder(
    //                     scrollDirection: Axis.horizontal,
    //                     itemBuilder: (BuildContext context, int index) {
    //                       return ImageCardWidget(
    //                           ap: Art_pieces[index]);
    //                     },
    //                     itemCount: Art_pieces.length,
    //                   ),
    //                 ),
    //
    //           // _buildCategoryField(),
    //           // _buildImageUrlField(),
    //
    //           const SizedBox(
    //             height: 100,
    //           ),
    //           RaisedButton(
    //             child: const Text(
    //               'Submit',
    //               style: TextStyle(
    //                 color: Colors.blue,
    //                 fontSize: 16,
    //               ),
    //             ),
    //             onPressed: () => {
    //               if (!_formKey.currentState!.validate()) {},
    //               _formKey.currentState!.save()
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }


// Widget imageProfile() {
//   return Center(
//     child: Stack(children: <Widget>[
//       CircleAvatar(
//         radius: 80.0,
//         backgroundImage: _imageFile == null
//             ? AssetImage("assets/images/sample1.jpg")
//             : FileImage(File(_imageFile.path)),
//       ),
//       Positioned(
//         bottom: 20.0,
//         right: 20.0,
//         child: InkWell(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               builder: ((builder) => bottomSheet()),
//             );
//           },
//           child: Icon(
//             Icons.camera_alt,
//             color: Colors.teal,
//             size: 28.0,
//           ),
//         ),
//       ),
//     ]),
//   );
// }

// Widget bottomSheet() {
//   return Container(
//     height: 100.0,
//     width: MediaQuery.of(context).size.width,
//     margin: EdgeInsets.symmetric(
//       horizontal: 20,
//       vertical: 20,
//     ),
//     child: Column(
//       children: <Widget>[
//         Text(
//           "Choose Profile photo",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.camera),
//             onPressed: () {
//               takePhoto(ImageSource.camera);
//             },
//             label: Text("Camera"),
//           ),
//           FlatButton.icon(
//             icon: Icon(Icons.image),
//             onPressed: () {
//               takePhoto(ImageSource.gallery);
//             },
//             label: Text("Gallery"),
//           ),
//         ])
//       ],
//     ),
//   );
// }

// void takePhoto(ImageSource source) async {
//   final pickedFile = await _picker.getImage(
//     source: source,
//   );
//   setState(() {
//     _imageFile = pickedFile;
//   });
// }

}
