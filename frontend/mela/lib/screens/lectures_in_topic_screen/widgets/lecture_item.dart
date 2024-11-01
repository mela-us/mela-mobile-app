// import 'package:flutter/material.dart';
// import 'package:mela/models/lecture.dart';

// import '../../../constants/global.dart';

// class LectureItem extends StatelessWidget {
//   final Lecture lecture;

//   const LectureItem({
//     super.key,
//     required this.lecture,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Global.buttonYesColor2, // Replace with your desired background color
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Text(
//                 lecture.lectureId.toString(),
//                 style: Global.normalText,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     lecture.lectureName,
//                     style: Global.subTitle,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     lecture.lectureDescription,
//                     style: Global.normalText,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             const Icon(Icons.play_arrow), // Replace with your desired icon
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';

import '../../../constants/global.dart';

class LectureItem extends StatelessWidget {
  final Lecture lecture;

  const LectureItem({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Global.buttonYesColor2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Circular progress indicator around the lectureId
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: lecture
                        .progress, // Set progress value here (from 0.0 to 1.0)
                    strokeWidth: 3,
                    color: Global.buttonYesColor1,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Text(
                    lecture.lectureId.toString(),
                    style: Global.normalText,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lecture.lectureName,
                    style: Global.subTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lecture.lectureDescription,
                    style: Global.normalText,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            
            //Button to play the lecture
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Global.buttonYesColor1,
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 20,
                  color: Global.buttonYesColor2,
                )), // Play icon
          ],
        ),
      ),
    );
  }
}
