import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GovIdPdfViewer extends StatefulWidget {
  final String assetPath;
  final String title;

  const GovIdPdfViewer({super.key, required this.assetPath, required this.title});

  @override
  State<GovIdPdfViewer> createState() => _GovIdPdfViewerState();
}

class _GovIdPdfViewerState extends State<GovIdPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _totalPages = 0;
  int _currentPage = 1;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0.5,
        title: Text(widget.title, style: TTextTheme.h8Style(context)),
        leading: const BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'Images/Customers/carRentalAgreement.pdf',
            controller: _pdfViewerController,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _totalPages = details.document.pages.count;
                _isLoading = false;
              });
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
          ),

          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          if (!_isLoading)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "Page $_currentPage / $_totalPages",
                    style: TTextTheme.h8Style(context),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}