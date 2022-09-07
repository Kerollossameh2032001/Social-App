import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/modules/home/home_widgets/post_read_document_screen.dart';
import 'package:social_app1/shared/components/widgets.dart';

class PostDocItem extends StatelessWidget {
  final String src;
  final String name;
  final int size;

  const PostDocItem({
    Key? key,
    required this.src,
    required this.name,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
             name,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(
                '${(size/ 1024).round()} KB'),
            onTap: () {
              navigateTo(
                  context,
                  PostReadDocumentScreen(
                    src: src,
                    name: name,
                  ));
            },
            leading: const Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.red,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              //side: BorderSide()
            ),
            enabled: true,
          ),
        );
      },
    );
  }
}
