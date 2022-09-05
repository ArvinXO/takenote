import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/views/notes/animated_scroll_view_item.dart';

import '../../services/cloud/firebase_cloud_storage.dart';
import '../../utilities/color_pallette.dart';
import '../../utilities/dialogs/delete_dialog.dart';
import '../../utilities/note_colours.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesListView extends StatefulWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onNoteTap;
  final FirebaseCloudStorage _notesService;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onNoteTap,
    required FirebaseCloudStorage notesService,
  })  : _notesService = notesService,
        super(key: key);

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  CloudNote? _note;

  late final FirebaseCloudStorage _notesService;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    await _notesService.updateNoteColor(
      documentId: note.documentId,
      color: note.noteColor,
      archived: 0,
      title: '',
      text: '',
      date: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollViewItem(
      child: SafeArea(
        bottom: false,
        child: ListView.builder(
          cacheExtent: 0,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          //refresh the list when the user scrolls to the top
          itemCount: widget.notes.length,
          itemBuilder: (context, index) {
            final note = widget.notes.elementAt(index);
            //wrap with dismissible to allow swipe to delete
            return AnimatedScrollViewItem(
              child: Dismissible(
                key: Key(note.documentId),
                onDismissed: (direction) {
                  widget.onDeleteNote(note);
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
                  color: NoteColor.getColor(note.noteColor),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 14,
                      child: Text(
                        // note index + 1 to start at 1 instead of 0
                        '${index + 1}',
                      ),
                    ),

                    //onlongpress to share
                    onLongPress: () {
                      _showOptionsSheet(context, note);
                    },
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(78),
                    ),
                    title: Text(
                      note.noteTitle,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      note.noteText,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final shouldDelete = await showDeleteDialog(context);
                        if (shouldDelete) {
                          widget.onDeleteNote(note);
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.grey),
                    ),
                    onTap: () {
                      widget.onNoteTap(note);
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

  void _showOptionsSheet(BuildContext context, CloudNote note) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        constraints: const BoxConstraints(),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SizedBox(
                height: 420,
                child: Container(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          // Edit Note Function
                          widget.onNoteTap(note);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.edit_2),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Edit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        // onTap: () {
                        //   Navigator.pop(context);
                        //   _showColorPalette(context, _note);
                        // },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.color_swatch),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Color Palette'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              ColorPaletteButton(
                                color: NoteColor.getColor(0),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 0,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 0,
                              ),
                              ColorPaletteButton(
                                color: NoteColor.getColor(1),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 1,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 1,
                              ),
                              ColorPaletteButton(
                                color: NoteColor.getColor(2),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 2,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 2,
                              ),
                              ColorPaletteButton(
                                color: NoteColor.getColor(3),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 3,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 3,
                              ),
                              ColorPaletteButton(
                                color: NoteColor.getColor(4),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 4,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 4,
                              ),
                              ColorPaletteButton(
                                color: NoteColor.getColor(5),
                                onTap: () {
                                  _notesService.updateNoteColor(
                                      documentId: note.documentId,
                                      color: 5,
                                      archived: note.noteArchived,
                                      date: note.noteDate,
                                      text: note.noteText,
                                      title: note.noteTitle);
                                  Navigator.pop(context);
                                },
                                isSelected: note.noteColor == 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: note.noteArchived == 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Iconsax.archive_add),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Archive'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: note.noteArchived == 1,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Iconsax.archive_minus),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Unarchive'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          // Delete Note Function
                          showDeleteDialog(context).then((result) {
                            if (result) {
                              widget.onDeleteNote.call(note);
                            }
                            //pop
                            Navigator.pop(context);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.note_remove),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.close_circle),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
