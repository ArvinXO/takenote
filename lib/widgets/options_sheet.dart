// // class for options sheet
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// import '../services/cloud/cloud_note.dart';
// import '../services/cloud/firebase_cloud_storage.dart';
// import '../utilities/color_pallette.dart';
// import '../utilities/dialogs/delete_dialog.dart';
// import '../utilities/note_colours.dart';
// import '../views/notes/notes_grid_view.dart';

// class OptionsSheet extends StatefulWidget {
//   final Iterable<CloudNote> notes;
//   final FirebaseCloudStorage _notesService;
//   final NoteCallBack onDeleteNote;
//   final NoteCallBack onNoteTap;

//   const OptionsSheet({
//     Key? key,
//     required this.notes,
//     required FirebaseCloudStorage notesService,
//     required this.onDeleteNote,
//     required this.onNoteTap,
//   })  : _notesService = notesService,
//         super(key: key);

//   @override
//   State<OptionsSheet> createState() => _OptionsSheetState();
// }

// class _OptionsSheetState extends State<OptionsSheet> {
//   CloudNote? _note;

//   late final FirebaseCloudStorage _notesService;

//   @override
//   void initState() {
//     _notesService = FirebaseCloudStorage();
//     super.initState();
//   }

//   void _textControllerListener() async {
//     final note = _note;
//     if (note == null) {
//       return;
//     }

//     await _notesService.updateNoteColor(
//       documentId: note.documentId,
//       color: note.noteColor,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 420,
//       child: Container(
//         child: Column(
//           // mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             InkWell(
//               borderRadius: BorderRadius.circular(15),
//               onTap: () {
//                 // Edit Note Function
//                 widget.onNoteTap(note);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: const <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(Iconsax.edit_2),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Edit'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(15),
//               // onTap: () {
//               //   Navigator.pop(context);
//               //   _showColorPalette(context, _note);
//               // },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: const <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(Iconsax.color_swatch),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Color Palette'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 height: 60,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   children: [
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(0),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 0,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 0,
//                     ),
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(1),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 1,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 1,
//                     ),
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(2),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 2,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 2,
//                     ),
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(3),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 3,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 3,
//                     ),
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(4),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 4,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 4,
//                     ),
//                     ColorPaletteButton(
//                       color: NoteColor.getColor(5),
//                       onTap: () {
//                         _notesService.updateNoteColor(
//                           documentId: note.documentId,
//                           color: 5,
//                         );
//                         Navigator.pop(context);
//                       },
//                       isSelected: note.noteColor == 5,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: note.noteArchived == 0,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(15),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(Iconsax.archive_add),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text('Archive'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: note.noteArchived == 1,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(15),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: const <Widget>[
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(Iconsax.archive_minus),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text('Unarchive'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               splashColor: Colors.red,
//               borderRadius: BorderRadius.circular(15),
//               onTap: () {
//                 // Delete Note Function
//                 showDeleteDialog(context).then((result) {
//                   if (result) {
//                     widget.onDeleteNote.call(note);
//                   }
//                   //pop
//                   Navigator.pop(context);
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: const <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(Iconsax.note_remove),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Delete'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(15),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: const <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(Iconsax.close_circle),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Cancel'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
