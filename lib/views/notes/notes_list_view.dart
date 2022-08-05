import 'package:flutter/material.dart';
import 'package:takenote/utilities/dialogs/delete_dialog.dart';

import '../../services/crud/notes_service.dart';

typedef DeleteNoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallBack onDeleteNote;
  const NotesListView(
      {Key? key, required this.notes, required this.onDeleteNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(note.text),
          onDismissed: (direction) {
            // Add undo functionality

            // setState(
            //   () {
            //     String deletedItem = note.text;
            //     SnackBar(
            //       content: Text("Deleted \"$deletedItem\""),
            //       action: SnackBarAction(
            //         label: "UNDO",
            //         onPressed: () => setState(
            //           () => _notesService.updateNotes(
            //               note: note, text: deletedItem),
            //         ),
            //       ),
            //     );
            //   },
            // );

            final snackBar = SnackBar(
                content: const Text('Deleted note'),
                backgroundColor: (const Color.fromARGB(205, 212, 8, 8)),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // _notesService.deleteNote(id: note.id);
          },
          background: Container(
            color: Colors.red,
            child: ListTile(
              trailing: IconButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: const Icon(Icons.delete),
              ),
              title: const Text('Note deleted'),
            ),
          ),
          child: ListTile(
            title: Text(note.text,
                maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete, color: Colors.grey),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
