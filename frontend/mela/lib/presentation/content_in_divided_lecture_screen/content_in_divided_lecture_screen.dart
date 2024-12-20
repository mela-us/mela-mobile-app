import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
    print("===============ContentInDividedLectureScreen");
    print(widget.currentDividedLecture.urlContentInDividedLecture);
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
      body: Center(
        child: Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: SfPdfViewerTheme(
            data: SfPdfViewerThemeData(
              backgroundColor: Theme.of(context).colorScheme.surface,
              progressBarColor: Theme.of(context).colorScheme.primary,
            ),
            child: SfPdfViewer.network(
              pageSpacing: 4,
              widget.currentDividedLecture.urlContentInDividedLecture,
              controller: _pdfViewerController,
              canShowScrollHead: false,
              enableDoubleTapZooming: true,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                _totalPages = details.document.pages.count;
              },
            ),
          ),
        ),
      ),
    );
  }
}
