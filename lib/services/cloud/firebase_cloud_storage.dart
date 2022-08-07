import 'package:cloud_firestore/cloud_firestore.dart';
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
          .where((note) => note.ownerUserId == ownerUserId));

//C-
  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

//R-
  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)),
            // (doc) {
            //   return CloudNote(
            //     documentId: doc.id,
            //     ownerUserId: doc.data()[ownerUserIDFieldName] as String,
            //     text: doc.data()[textFieldName] as String,
            //   );
            // },
          );
    } catch (e) {
      throw (CouldNotGetAllNotesException());
    }
  }

//U-
  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

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
