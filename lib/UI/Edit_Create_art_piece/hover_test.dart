//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _demonstrateIcon = 0;
//   int _exitCounter = 0;
//   double x = 0.0;
//   double y = 0.0;
//
//   void _showIcon(PointerEvent details) {
//     setState(() {
//       _demonstrateIcon = 1;
//     });
//   }
//
//   void _hideIcon(PointerEvent details) {
//     setState(() {
//       _demonstrateIcon = 0;
//     });
//   }
//
//   void _updateLocation(PointerEvent details) {
//     setState(() {
//       x = details.position.dx;
//       y = details.position.dy;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints.tight(const Size(300.0, 200.0)),
//       child: MouseRegion(
//         onEnter: _showIcon,
//         // onHover: _updateLocation,
//         onExit: _hideIcon,
//         child: Container(
//           color: Colors.lightBlueAccent,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                   'You have entered or exited this box this many times:'),
//               Text(
//                 '$_enterCounter Entries\n$_exitCounter Exits',
//                 style: Theme.of(context).textTheme.headline4,
//               ),
//               Text(
//                 'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }