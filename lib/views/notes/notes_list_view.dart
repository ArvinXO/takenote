import 'package:flutter/material.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/utilities/dialogs/delete_dialog.dart';

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
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        //wrap with dismissible to allow swipe to delete
        return Dismissible(
          key: Key(note.documentId),
          onDismissed: (direction) {
            onDeleteNote(note);
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

          child: ListTile(
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
        );
      },
    );
  }
}
