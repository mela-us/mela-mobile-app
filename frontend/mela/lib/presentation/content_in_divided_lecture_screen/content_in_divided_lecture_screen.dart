import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class ContentInDividedLectureScreen extends StatelessWidget {
//   final DividedLecture currentDividedLecture;
//   const ContentInDividedLectureScreen(
//       {super.key, required this.currentDividedLecture});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           currentDividedLecture.dividedLectureName,
//           style: Theme.of(context)
//               .textTheme
//               .heading
//               .copyWith(color: Theme.of(context).colorScheme.primary),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: SfPdfViewer.network(
//         "https://mela-storage-dev.s3.ap-southeast-1.amazonaws.com/lectures/pdfs/CD1.I.1Quy_lu%E1%BA%ADt_d%C3%A3y_s%E1%BB%91_timo1.pdf",
//         canShowScrollHead: true,
//         enableDoubleTapZooming: true,
//       ),
//       ),
//     );
//   }
// }

class ContentInDividedLectureScreen extends StatefulWidget {
  final DividedLecture currentDividedLecture;

  const ContentInDividedLectureScreen(
      {super.key, required this.currentDividedLecture});

  @override
  State<ContentInDividedLectureScreen> createState() =>
      _ContentInDividedLectureScreenState();
}

class _ContentInDividedLectureScreenState
    extends State<ContentInDividedLectureScreen> {
  late PdfViewerController _pdfViewerController;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _showPageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedPage = _pdfViewerController.pageNumber;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Đi đến trang',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Trang từ (1-$_totalPages)',
                  labelStyle: Theme.of(context).textTheme.subHeading.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    selectedPage = int.parse(value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy',
                  style: Theme.of(context)
                      .textTheme
                      .subHeading
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
            ),
            GestureDetector(
              onTap: () {
                if (selectedPage >= 1 && selectedPage <= _totalPages) {
                  _pdfViewerController.jumpToPage(selectedPage);
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Đi',
                    style: Theme.of(context).textTheme.subHeading.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currentDividedLecture.dividedLectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: _showPageSelectionDialog,
            icon: Icon(
              Icons.plagiarism_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SfPdfViewer.network(
          "https://mela-storage-dev.s3.ap-southeast-1.amazonaws.com/lectures/pdfs/CD1.I.1Quy_lu%E1%BA%ADt_d%C3%A3y_s%E1%BB%91_timo1.pdf",
          controller: _pdfViewerController,
          canShowScrollHead: false,
          enableDoubleTapZooming: true,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            _totalPages = details.document.pages.count;
          },
        ),
      ),
    );
  }
}
