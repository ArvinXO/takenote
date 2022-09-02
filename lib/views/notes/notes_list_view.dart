import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/views/notes/animated_scroll_view_item.dart';

import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onNoteTap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onNoteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollViewItem(
      child: SafeArea(
        bottom: false,
        child: ListView.builder(
          cacheExtent: 0,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          //refresh the list when the user scrolls to the top
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes.elementAt(index);
            //wrap with dismissible to allow swipe to delete
            return AnimatedScrollViewItem(
              child: Dismissible(
                key: Key(note.documentId),
                onDismissed: (direction) {
                  onDeleteNote(note);
                },
                confirmDismiss: (direction) async {
                  final result = await showDeleteDialog(context);
                  return result;
                },
                //Red background when swiped with delete text
                background: Container(
                  color: Colors.red,
                  child: const ListTile(
                    title: Text(
                      'Deleting...',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                child: Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 22,
                      child: Text(
                        // note index + 1 to start at 1 instead of 0
                        '${index + 1}',
                      ),
                    ),

                    //onlongpress to share
                    onLongPress: () {
                      Share.share(note.text);
                    },
                    tileColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78),
                    ),
                    title: Text(
                      note.text,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final shouldDelete = await showDeleteDialog(context);
                        if (shouldDelete) {
                          onDeleteNote(note);
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.grey),
                    ),
                    onTap: () {
                      onNoteTap(note);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
