import 'package:flutter/material.dart';

// A widget that wraps a child widget with dismissible behavior.
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
        background: buildSwipeActionLeft(), // Left swipe action
        secondaryBackground: buildSwipeActionRight(), // Right swipe action
        onDismissed: onDismissed, // Callback when item is dismissed
        child: child,
      );

  // Build the swipe action for deleting an item
  Widget buildSwipeActionLeft() {
    return Container(
      color: Colors.red,
      child: ListTile(
        trailing: Icon(
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

  // Build the swipe action for sharing an item
  Widget buildSwipeActionRight() {
    return Container(
      color: const Color.fromARGB(255, 18, 161, 23),
      child: ListTile(
        trailing: Icon(
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
}
