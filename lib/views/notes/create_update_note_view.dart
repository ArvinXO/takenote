import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:takenote/components/fade_animation.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/cloud/firebase_cloud_storage.dart';
import 'package:takenote/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:takenote/utilities/generics/get_arguments.dart';
import 'package:takenote/services/cloud/cloud_note.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final text = _contentController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
      date: note.noteDate,
      title: note.noteTitle,
      archived: note.noteArchived,
      deleted: note.noteDeleted,
      color: note.noteColor,
    );
  }

  void _titleControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final text = _contentController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
      date: note.noteDate,
      title: note.noteTitle,
      archived: note.noteArchived,
      deleted: note.noteDeleted,
      color: note.noteColor,
    );
  }

  void _setupTextControllerListener() {
    _titleController.addListener(_textControllerListener);
    _titleController.removeListener(_textControllerListener);
    _contentController.addListener(_textControllerListener);
    _contentController.removeListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _titleController.text = widgetNote.noteTitle;
      _contentController.text = widgetNote.noteText;
      // archived = 1
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_contentController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextIsNotEmpty() async {
    final note = _note;
    final content = _contentController.text;
    final title = _titleController.text;
    if (note != null && content.isNotEmpty) {
      await _notesService.updateNote(
        documentId: note.documentId,
        text: content,
        date: note.noteDate,
        title: title,
        archived: note.noteArchived,
        deleted: note.noteDeleted,
        color: note.noteColor,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextIsNotEmpty();
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: // noteColor from swatch
          context.getArgument<CloudNote>() == null
              ? kJungleGreen
              : kBdazalledBlue,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: context.getArgument<CloudNote>() == null
            ? kJungleGreen
            : kBdazalledBlue,
        title: // WidgetNote is not null if we are updating an existing note
            context.getArgument<CloudNote>() == null
                ? const Text('Create a new note')
                : const Text('Update your note'),
        actions: [
          //Save
          IconButton(
            onPressed: () {
              _saveNoteIfTextIsNotEmpty();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
          // Archive
          IconButton(
            onPressed: () async {
              final text = _contentController.text;
              final title = _titleController.text;
              if (_note == null || text.isEmpty) {
                await showCannotShareEmptyNoteDialog(context);
              } else {
                await Share.share('$title\n$text');
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: FadeAnimation(
        delay: 0.2,
        child: Container(
          child: FutureBuilder(
            future: createOrGetExistingNote(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _setupTextControllerListener();
                  return ListView(
                    children: [
                      Column(
                        children: [
                          k24SizedBox,
                          TextField(
                            style: // noteColor from swatch
                                const TextStyle(
                              // title font size
                              fontSize: 20,
                            ),
                            cursorColor: kPlatinum,
                            controller: _titleController,
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: const TextStyle(
                                color: kPlatinum,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                              // label: Text('Title'),
                              // isCollapsed: true,
                              fillColor: Colors.transparent,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelText:
                                  //Existing note is not null and text is not empty then show text else show placeholder
                                  _note != null &&
                                          _titleController.text.isNotEmpty
                                      ? 'Edit title'
                                      : 'Title',
                              floatingLabelStyle: const TextStyle(
                                color: kPlatinum,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          k24SizedBox,
                          TextField(
                            controller: _contentController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Content',
                              hintStyle: const TextStyle(
                                color: kPlatinum,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              // label: Text('Title'),
                              // isCollapsed: true,
                              fillColor: Colors.transparent,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelText:
                                  //Existing note is not null and text is not empty then show text else show placeholder
                                  _note != null &&
                                          _contentController.text.isNotEmpty
                                      ? 'Edit content'
                                      : 'Content',
                              floatingLabelStyle: const TextStyle(
                                color: kPlatinum,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );

                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
