import 'package:flutter/material.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PostReadDocumentScreen extends StatefulWidget {
  final String src;
  final String name;
  const PostReadDocumentScreen({Key? key, required this.src, required this.name}) : super(key: key);

  @override
  State<PostReadDocumentScreen> createState() => _PostReadDocumentScreenState();
}

class _PostReadDocumentScreenState extends State<PostReadDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         widget.name,
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: SfPdfViewer.network(widget.src),
      ),
    );
  }
}
