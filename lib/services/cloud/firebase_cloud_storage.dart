import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:takenote/services/cloud/cloud_note.dart';
import 'package:takenote/services/cloud/cloud_storage_constants.dart';
import 'package:takenote/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  //Grabbing all the notes from the collection
  final notes = FirebaseFirestore.instance.collection('notes');

//If you want to grab a stream of data you can use the following
  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) =>
              note.ownerUserId == ownerUserId &&
              note.noteArchived == 0 &&
              note.noteDeleted == 0));

  //List of notes
  Future<Iterable<CloudNote>> allNotesList(
      {required String ownerUserId}) async {
    final snapshot = await notes.get();
    return snapshot.docs.map((doc) => CloudNote.fromSnapshot(doc)).where(
        (note) =>
            note.ownerUserId == ownerUserId &&
            note.noteArchived == 0 &&
            note.noteDeleted == 0);
  }

  //grab archived notes
  Stream<Iterable<CloudNote>> archivedNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) =>
              note.ownerUserId == ownerUserId && note.noteArchived == 1));

  //List of archived notes
  Future<Iterable<CloudNote>> archivedNotesList(
      {required String ownerUserId}) async {
    final snapshot = await notes.get();
    return snapshot.docs.map((doc) => CloudNote.fromSnapshot(doc)).where(
        (note) => note.ownerUserId == ownerUserId && note.noteArchived == 1);
  }

  //Deleted Notes
  Stream<Iterable<CloudNote>> deletedNotes({required String ownerUserId}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where((note) =>
              note.ownerUserId == ownerUserId && note.noteDeleted == 1));
  //List of deleted notes
  Future<Iterable<CloudNote>> deletedNotesList(
      {required String ownerUserId}) async {
    final snapshot = await notes.get();
    return snapshot.docs.map((doc) => CloudNote.fromSnapshot(doc)).where(
        (note) => note.ownerUserId == ownerUserId && note.noteDeleted == 1);
  }

//C-
  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      dateFieldName: '',
      titleFieldName: '',
      archivedFieldName: 0,
      colorFieldName: 0,
      deletedFieldName: 0,
      firstNameFieldName: '',
      lastNameFieldName: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      document.id,
      ownerUserId,
      fetchedNote.data()![textFieldName] as String,
      fetchedNote.data()![dateFieldName] as String,
      fetchedNote.data()![titleFieldName] as String,
      fetchedNote.data()![archivedFieldName] as int,
      fetchedNote.data()![deletedFieldName] as int,
      fetchedNote.data()![colorFieldName] as int,
    );
  }

  //List of notes create
  Future<CloudNote> createNewNotesList({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      dateFieldName: '',
      titleFieldName: '',
      archivedFieldName: 0,
      colorFieldName: 0,
      deletedFieldName: 0,
      firstNameFieldName: '',
      lastNameFieldName: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      document.id,
      ownerUserId,
      fetchedNote.data()![textFieldName] as String,
      fetchedNote.data()![dateFieldName] as String,
      fetchedNote.data()![titleFieldName] as String,
      fetchedNote.data()![archivedFieldName] as int,
      fetchedNote.data()![deletedFieldName] as int,
      fetchedNote.data()![colorFieldName] as int,
    );
  }

  Future<CloudNote> createNewArchiveNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      dateFieldName: '',
      titleFieldName: '',
      archivedFieldName: 1,
      colorFieldName: 0,
      deletedFieldName: 0,
      firstNameFieldName: '',
      lastNameFieldName: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      document.id,
      ownerUserId,
      fetchedNote.data()![textFieldName] as String,
      fetchedNote.data()![dateFieldName] as String,
      fetchedNote.data()![titleFieldName] as String,
      fetchedNote.data()![archivedFieldName] as int,
      fetchedNote.data()![deletedFieldName] as int,
      fetchedNote.data()![colorFieldName] as int,
    );
  }

//R-
  // Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
  //   try {
  //     return await notes
  //         .where(
  //           ownerUserIdFieldName,
  //           isEqualTo: ownerUserId,
  //         )
  //         .get()
  //         .then(
  //           (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)),
  //           // (doc) {
  //           //   return CloudNote(
  //           //     documentId: doc.id,
  //           //     ownerUserId: doc.data()[ownerUserIDFieldName] as String,
  //           //     text: doc.data()[textFieldName] as String,
  //           //   );
  //           // },
  //         );
  //   } catch (e) {
  //     throw (CouldNotGetAllNotesException());
  //   }
  // }
  // void add field to all collection in document firstName and lastName
  void addNoteCreationDate({required String noteCreationDateFieldName}) async {
    try {
      await notes.get().then((value) => value.docs.forEach((doc) {
            doc.reference.set({
              noteCreationDateFieldName: 'Note Creation Date',
            }, SetOptions(merge: true));
          }));
    } catch (e) {
      throw (CouldNotGetAllNotesException());
    }
  }
  //Call method on tap to add firstName and lastName
  // _notesService.addFirstNameLastName(
  // firstName: 'first', lastName: 'last');

//U-
  Future<void> updateNote({
    required String documentId,
    required String text,
    required String date,
    required String title,
    required int archived,
    required int deleted,
    required int color,
  }) async {
    try {
      await notes.doc(documentId).update({
        textFieldName: text,
        titleFieldName: title,
        // date is now a string format dd/mm/yyyy hh:mm
        // date is now a string format MONTH, DAT, YEAR HH:MM
        dateFieldName:
            DateFormat('MMM dd, yyyy HH:MM a').format(DateTime.now()),
        deletedFieldName: deleted,
        archivedFieldName: archived,
        colorFieldName: color,
        noteCreationDateFieldName: //date and time  jm format
            DateFormat('MMM dd, yyyy HH:MM a').format(DateTime.now()),
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> updateNoteColor({
    required String documentId,
    required int color,
  }) async {
    try {
      await notes.doc(documentId).update({
        colorFieldName: color,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> updateArchiveStatus({
    required String documentId,
    required int archived,
  }) async {
    try {
      await notes.doc(documentId).update({
        archivedFieldName: archived,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> updateColor(String documentId, int noteColor) async {
    try {
      await notes.doc(documentId).update({
        colorFieldName: noteColor,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // Archive note
  Future<void> archiveNote({
    required String documentId,
    required int archived,
  }) async {
    try {
      await notes.doc(documentId).update({
        archivedFieldName: archived,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // Unarchive note
  Future<void> unarchiveNote({
    required String documentId,
    required int archived,
  }) async {
    try {
      await notes.doc(documentId).update({
        archivedFieldName: archived,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // Soft Delete note
  Future<void> softDeleteNote({
    required String documentId,
    required int deleted,
  }) async {
    try {
      await notes.doc(documentId).update({
        deletedFieldName: 1,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // Delete All Notes WHERE DELETED = 1
  Future<void> deleteAllNotes({
    required String ownerUserId,
    required int deleted,
  }) async {
    try {
      await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .where(
            deletedFieldName,
            isEqualTo: 1,
          )
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));
    } catch (e) {
      throw CouldNotDeleteAllNotesException();
    }
  }

  //Delete field from all collection in document firstName and lastName
  void deleteFirstNameLastName() async {
    try {
      await notes.get().then((value) => value.docs.forEach((doc) {
            doc.reference.update({
              firstNameFieldName: FieldValue.delete(),
              lastNameFieldName: FieldValue.delete(),
            });
          }));
    } catch (e) {
      throw (CouldNotGetAllNotesException());
    }
  }

  //Update fieldName from all collection in document firstName and lastName to First Name and Last Name
  void updateFirstNameLastName() async {
    try {
      await notes.get().then((value) => value.docs.forEach((doc) {
            doc.reference.update({
              firstNameFieldName: 'First Name',
              lastNameFieldName: 'Last Name',
            });
          }));
    } catch (e) {
      throw (CouldNotGetAllNotesException());
    }
  }

  // Restore note
  Future<void> restoreNote({
    required String documentId,
    required int deleted,
  }) async {
    try {
      await notes.doc(documentId).update({
        deletedFieldName: 0,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  // //Duplicate note
  // Future<void> duplicateNote({
  //   required String documentId,
  //   required String ownerUserId,
  //   required String text,
  //   required String date,
  //   required String title,
  //   required int archived,
  //   required int deleted,
  //   required int color,
  // }) async {
  //   try {
  //     await notes.add({
  //       ownerUserIdFieldName: ownerUserId,
  //       textFieldName: text,
  //       titleFieldName: title,
  //       dateFieldName: date,
  //       deletedFieldName: deleted,
  //       archivedFieldName: archived,
  //       colorFieldName: color,
  //     });
  //   } catch (e) {
  //     throw CouldNotUpdateNoteException();
  //   }
  // }

//D-
  Future<void> deleteNote({
    required String documentId,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  //Private constructor
  FirebaseCloudStorage._sharedInstance();
  //Factory constructor to return the same instance
  factory FirebaseCloudStorage() => _shared;
}
