// import 'package:flutter/material.dart';

// import '../../../constants/global.dart';
// import '../../../themes/default/colors_standards.dart';


// class CoverImageWidget extends StatelessWidget {
//   const CoverImageWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // Layer 0:
//         Container(
//           width: 384,
//           height: 290,
//           decoration: BoxDecoration(
//             color: const Color(0xFFE8F1FF),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         // Layer 1: Image
//         Positioned(
//           top: 0,
//           child: Column(
//             children: [
//               Image.asset(
//                 'assets/images/cover.png',
//                 width: 384,
//                 height: 257,
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ),
//         ),
//         // Layer 2: Button "Học toán hàng ngày với Mela"
//         Positioned(
//           bottom: 15,
//           child: SizedBox(
//             width: 250,
//             height: 34,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorsStandards.buttonYesColor1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: EdgeInsets.zero,
//               ),
//               child: const Text(
//                 'Học toán hàng ngày với Mela',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
