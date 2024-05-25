import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/utilities/dialogs/delete_dialog.dart';
import 'package:takenote/views/notes/archived_notes_grid_view.dart';

import '../color_pallette.dart';
import '../note_colours.dart';

class OptionsSheetService {
  final BuildContext context;
  final Iterable<CloudNote> notes;
  final FirebaseCloudStorage _notesService;
  final NoteCallBack onDeleteNote;

  OptionsSheetService({
    required this.context,
    required this.notes,
    required this.onDeleteNote,
    required FirebaseCloudStorage notesService,
  }) : _notesService = notesService;

  void showOptionsSheet(BuildContext context, CloudNote note) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        constraints: const BoxConstraints(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        // Unarchive Note Function
                        _notesService.archiveNote(
                          documentId: note.documentId,
                          archived: 0,
                        );
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
                    //share note
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        // Share Note Function
                        final text = note.noteText;
                        final title = note.noteTitle;

                        await Share.share('$title\n$text');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Iconsax.share),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Share'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        // Delete Note Function
                        showDeleteDialog(context).then(
                          (result) {
                            if (result) {
                              _notesService.deleteNote(
                                documentId: note.documentId,
                              );
                              onDeleteNote(
                                  note); // Notify parent about the deletion
                              Navigator.pop(context);
                            }
                          },
                        );
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
                          shrinkWrap: false,
                          children: [
                            ColorPaletteButton(
                              color: NoteColor.getColor(0),
                              onTap: () {
                                _notesService.updateNoteColor(
                                  documentId: note.documentId,
                                  color: 0,
                                );
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
                                );
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
                                );
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
                                );
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
                                );
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
                                );
                                Navigator.pop(context);
                              },
                              isSelected: note.noteColor == 5,
                            ),
                            ColorPaletteButton(
                              color: NoteColor.getColor(6),
                              onTap: () {
                                _notesService.updateNoteColor(
                                  documentId: note.documentId,
                                  color: 6,
                                );
                                Navigator.pop(context);
                              },
                              isSelected: note.noteColor == 6,
                            ),
                            ColorPaletteButton(
                              color: NoteColor.getColor(7),
                              onTap: () {
                                _notesService.updateNoteColor(
                                  documentId: note.documentId,
                                  color: 7,
                                );
                                Navigator.pop(context);
                              },
                              isSelected: note.noteColor == 7,
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
              );
            },
          );
        });
  }
}
