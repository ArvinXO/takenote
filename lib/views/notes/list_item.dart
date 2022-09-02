import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.title,
  }) : super(key: key);

  //final string title can be null

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
          color: Colors.transparent,
          child: const ListTile(
            title: Text(
              'Title',
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          )),
    );
  }
}
