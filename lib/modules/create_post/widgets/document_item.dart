import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:social_app1/modules/create_post/widgets/read_document_screen.dart';
import 'package:social_app1/shared/components/widgets.dart';

import '../../../layout/cubit/cubit.dart';

class DocumentItem extends StatelessWidget {
  final PlatformFile? details;
  final File? document;
  DocumentItem({
    Key? key,
    required this.details, this.document
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).backgroundColor,
      title: Text(
        details!.name,
        style: Theme.of(context).textTheme.bodyText1,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Text(
          '${(details!.size / 1024).round()} KB'),
      onTap: () {

        navigateTo(context, ReadDocumentScreen(document: document,details:details,));
      },
      leading: Icon(Icons.picture_as_pdf_outlined,color: Colors.red,),
      trailing: Icon(Icons.arrow_forward_ios),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        //side: BorderSide()
      ),
      enabled: true,
    );
  }
}