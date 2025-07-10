class FirebaseExceptionHandler implements Exception {
  final String code;

  FirebaseExceptionHandler(this.code);

  String get message {
    String errorMessage = 'Firebase operation failed';

    switch (code) {
      // Firebase Authentication errors
      case 'invalid-email':
        errorMessage = 'Invalid email address';
        break;
      case 'user-disabled':
        errorMessage = 'User account has been disabled';
        break;
      case 'user-not-found':
        errorMessage = 'User not found';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password';
        break;
      case 'email-already-in-use':
        errorMessage = 'Email already in use';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Operation not allowed';
        break;
      case 'weak-password':
        errorMessage = 'Weak password';
        break;
      case 'provider-already-linked':
        errorMessage = 'User is already linked to the given provider';
        break;
      case 'credential-already-in-use':
        errorMessage = 'This credential is already associated with a different user account';
        break;
      case 'invalid-credential':
        errorMessage = 'The supplied auth credential is malformed or has expired';
        break;
      case 'invalid-verification-code':
        errorMessage = 'The verification code is invalid';
        break;
      case 'invalid-verification-id':
        errorMessage = 'The verification ID is invalid';
        break;
      case 'session-expired':
        errorMessage = 'The SMS code has expired. Please resend the verification code to try again';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Please try again later';
        break;
      case 'network-request-failed':
        errorMessage = 'A network error occurred. Please check your internet connection';
        break;
      // Firestore errors
      case 'cancelled':
        errorMessage = 'The operation was cancelled';
        break;
      case 'deadline-exceeded':
        errorMessage = 'Deadline expired before operation could complete';
        break;
      case 'already-exists':
        errorMessage = 'Some document that we attempted to create already exists';
        break;
      case 'permission-denied':
        errorMessage = 'The caller does not have permission to execute the specified operation';
        break;
      case 'not-found':
        errorMessage = 'Some document that we attempted to read was not found';
        break;
      case 'aborted':
        errorMessage = 'The operation was aborted';
        break;
      case 'out-of-range':
        errorMessage = 'The operation was attempted past the valid range';
        break;
      case 'unauthenticated':
        errorMessage = 'The request does not have valid authentication credentials';
        break;
      case 'resource-exhausted':
        errorMessage = 'Some resource has been exhausted';
        break;
      case 'invalid-argument':
        errorMessage = 'Client specified an invalid argument';
        break;
      case 'internal':
        errorMessage = 'Internal error occurred';
        break;
      // Cloud Storage errors
      case 'bucket-not-found':
        errorMessage = 'The specified Cloud Storage bucket does not exist';
        break;
      case 'object-not-found':
        errorMessage = 'The specified object does not exist';
        break;
      case 'project-not-found':
        errorMessage = 'No project is associated with this Firebase project';
        break;
      case 'quota-exceeded':
        errorMessage = 'The bucket has exceeded its storage quota';
        break;
      case 'unauthorized':
        errorMessage = 'User does not have permission to access this object';
        break;
      case 'retry-limit-exceeded':
        errorMessage = 'Max retries has been exceeded';
        break;
      case 'non-matching-checksum':
        errorMessage = 'Uploaded data does not match checksum';
        break;
      case 'invalid-checksum':
        errorMessage = 'Invalid checksum';
        break;
      case 'unimplemented':
        errorMessage = 'The operation is not implemented';
        break;
      // FCM Token errors
      case 'registration-token-not-registered':
        errorMessage = 'The registration token is not registered';
        break;
      case 'invalid-registration-token':
        errorMessage = 'The provided registration token is not valid';
        break;
      case 'mismatched-credential':
        errorMessage = 'FCM server and client app do not belong to the same Firebase project';
        break;
      case 'invalid-package-name':
        errorMessage = 'Client app\'s package name does not match the registered package name';
        break;
      case 'authentication-error':
        errorMessage = 'Error authenticating the sender account';
        break;
      case 'server-unavailable':
        errorMessage = 'FCM server is temporarily unavailable';
        break;
      case 'unknown-error':
        errorMessage = 'An unknown error occurred while processing the request';
        break;

      default:
        errorMessage = 'Firebase operation failed';
        break;
    }
    return errorMessage;
  }
}
