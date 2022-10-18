// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:takenote/utilities/generics/get_arguments.dart';

// import '../constants/k_constants.dart';
// import '../services/auth/auth_service.dart';
// import '../services/cloud/cloud_note.dart';
// import '../services/cloud/firebase_cloud_storage.dart';
// import '../utilities/dialogs/cannot_share_empty_note_dialog.dart';

// class CreateNoteAppBarr extends StatefulWidget {
//   const CreateNoteAppBarr({super.key});

//   @override
//   State<CreateNoteAppBarr> createState() => _CreateNoteAppBarrState();
// }

// class _CreateNoteAppBarrState extends State<CreateNoteAppBarr> {
//   CloudNote? _note;
//   late final FirebaseCloudStorage _notesService;
//   late final TextEditingController _titleController;
//   late final TextEditingController _contentController;

//   @override
//   void initState() {
//     _titleController = TextEditingController();
//     _contentController = TextEditingController();
//     _notesService = FirebaseCloudStorage();
//     super.initState();
//   }

//   void _textControllerListener() async {
//     final note = _note;
//     if (note == null) {
//       return;
//     }

//     final text = _contentController.text;
//     await _notesService.updateNote(
//       documentId: note.documentId,
//       text: text,
//       date: note.noteDate,
//       title: note.noteTitle,
//       archived: note.noteArchived,
//       deleted: note.noteDeleted,
//       color: note.noteColor,
//     );
//   }

//   void _titleControllerListener() async {
//     final note = _note;
//     if (note == null) {
//       return;
//     }

//     final text = _contentController.text;
//     await _notesService.updateNote(
//       documentId: note.documentId,
//       text: text,
//       date: note.noteDate,
//       title: note.noteTitle,
//       archived: note.noteArchived,
//       deleted: note.noteDeleted,
//       color: note.noteColor,
//     );
//   }

//   void _setupTextControllerListener() {
//     _titleController.addListener(_textControllerListener);
//     _titleController.removeListener(_textControllerListener);
//     _contentController.addListener(_textControllerListener);
//     _contentController.removeListener(_textControllerListener);
//   }

//   Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
//     final widgetNote = context.getArgument<CloudNote>();
//     if (widgetNote != null) {
//       _note = widgetNote;
//       _titleController.text = widgetNote.noteTitle;
//       _contentController.text = widgetNote.noteText;
//       // archived = 1
//       return widgetNote;
//     }
//     final existingNote = _note;
//     if (existingNote != null) {
//       return existingNote;
//     }
//     final currentUser = AuthService.firebase().currentUser!;
//     final userId = currentUser.id;
//     final newNote = await _notesService.createNewNote(ownerUserId: userId);
//     _note = newNote;
//     return newNote;
//   }

//   void _deleteNoteIfTextIsEmpty() {
//     final note = _note;
//     if (_contentController.text.isEmpty && note != null) {
//       _notesService.deleteNote(documentId: note.documentId);
//     }
//   }

//   void _saveNoteIfTextIsNotEmpty() async {
//     final note = _note;
//     final content = _contentController.text;
//     final title = _titleController.text;
//     if (note != null && content.isNotEmpty) {
//       await _notesService.updateNote(
//         documentId: note.documentId,
//         text: content,
//         date: note.noteDate,
//         title: title,
//         archived: note.noteArchived,
//         deleted: note.noteDeleted,
//         color: note.noteColor,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _deleteNoteIfTextIsEmpty();
//     _saveNoteIfTextIsNotEmpty();
//     _contentController.dispose();
//     _titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: // noteColor from swatch
//             context.getArgument<CloudNote>() == null
//                 ? kJungleGreen
//                 : kBdazalledBlue,
//         appBar: AppBar(
//           elevation: 0.2,
//           backgroundColor: context.getArgument<CloudNote>() == null
//               ? kJungleGreen
//               : kBdazalledBlue,
//           title: // WidgetNote is not null if we are updating an existing note
//               context.getArgument<CloudNote>() == null
//                   ? const Text('Create a new note')
//                   : const Text('Update your note'),
//           actions: [
//             //Save
//             IconButton(
//               onPressed: () {
//                 _saveNoteIfTextIsNotEmpty();
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.save),
//             ),
//             // Archive
//             IconButton(
//               onPressed: () async {
//                 final text = _contentController.text;
//                 final title = _titleController.text;
//                 if (_note == null || text.isEmpty) {
//                   await showCannotShareEmptyNoteDialog(context);
//                 } else {
//                   await Share.share('$title\n$text');
//                 }
//               },
//               icon: const Icon(Icons.share),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
