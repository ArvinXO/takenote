import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    Key? key,
    required this.child,
    required this.item,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        onDismissed: onDismissed,
        child: child,
      );

  Widget buildSwipeActionLeft() {
    return Container(
      color: Colors.red,
      child: const ListTile(
        trailing: //delete button
            Icon(
          Icons.delete,
          color: Colors.white,
        ),
        title: Text(
          'Deleting...',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildSwipeActionRight() => Container(
        color: const Color.fromARGB(255, 18, 161, 23),
        child: const ListTile(
          trailing: //share button
              Icon(
            Icons.share,
            color: Colors.white,
          ),
          title: Text(
            'Sharing...',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
