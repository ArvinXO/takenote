import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/views/notes/animated_scroll_view_item.dart';

import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesGridView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onNoteTap;

  const NotesGridView({
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
          child: GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(2, 1),
                const QuiltedGridTile(1, 1),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final note = notes.elementAt(index);

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

                    child: Card(
                      color: Colors.teal[50 * (index % 10)],
                      margin: const EdgeInsets.all(6),
                      elevation: 3,
                      child: ListTile(
                        trailing: IconButton(
                          alignment: Alignment.bottomRight,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            //show delete dialog
                            showDeleteDialog(context).then((result) {
                              if (result) {
                                onDeleteNote.call(note);
                              }
                            });
                          },
                        ),

                        //onlongpress to share
                        onLongPress: () {
                          Share.share(note.text);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),

                        title: Text(
                          note.text,
                          maxLines: 10,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),

                        onTap: () {
                          onNoteTap(note);
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: notes.length,
              addAutomaticKeepAlives: true,
            ),
          )),
    );
  }
}
