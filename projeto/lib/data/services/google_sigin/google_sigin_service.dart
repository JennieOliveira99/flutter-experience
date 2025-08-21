import '../../../core/result/result.dart';

abstract interface class GoogleSinginService {
  Future<Result<String>> signIn();
  Future<Result<String>> signOut();
  Future<Result<String>> isSignedIn();
}
