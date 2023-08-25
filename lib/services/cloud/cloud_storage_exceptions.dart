/// Exception class for Cloud Storage related errors.
class CloudStorageException implements Exception {
  const CloudStorageException();
}

/// Exception thrown when creating a note in Cloud Storage fails.
class CouldNotCreateNoteException extends CloudStorageException {}

/// Exception thrown when retrieving all notes from Cloud Storage fails.
class CouldNotGetAllNotesException extends CloudStorageException {}

/// Exception thrown when updating a note in Cloud Storage fails.
class CouldNotUpdateNoteException extends CloudStorageException {}

/// Exception thrown when deleting a specific note from Cloud Storage fails.
class CouldNotDeleteNoteException extends CloudStorageException {}

/// Exception thrown when deleting all notes from Cloud Storage fails.
class CouldNotDeleteAllNotesException extends CloudStorageException {}
