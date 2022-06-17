import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honar_api_v11/api.dart';
import 'package:honar_gallary/UI/Art_piece/components/arc_banner_image.dart';
import 'package:honar_gallary/const/color_const.dart';
// import 'package:honar_gallary/UI/Create_art_piece/image_card.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../state_managment/create_edit_art_piece/edit_art_piece_cubit.dart';
import 'edit_page_list.dart';

// import 'package:image_picker/image_picker.dart';

class EditArtPiece extends StatefulWidget {
  final ArtPiece artPiece;

  const EditArtPiece({Key? key, required this.artPiece}) : super(key: key);

  @override
  _EditArtPieceState createState() => _EditArtPieceState();
}

class _EditArtPieceState extends State<EditArtPiece> {
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

  String sagImage =
      'https://hips.hearstapps.com/ghk.h-cdn.co/assets/17/30/2560x1280/landscape-1500925839-golden-retriever-puppy.jpg?resize=480:*';

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditArtPieceCubit>(
      create: (context) => EditArtPieceCubit(),
      child: Scaffold(
        body: Theme(
            data: ThemeData(
                primaryColor: ColorPallet.colorPalletDark,
                primarySwatch: MaterialColor(0xff181830, color),
                fontFamily: 'Sahel'),
            child: Container(
              width: context.width(),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 1.0),
                    child: ArcBannerImage("assets/images/sample1.jpg"),
                  ),
                  ProfileListItems(
                    changeState: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            )),
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
