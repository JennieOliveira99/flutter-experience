import 'package:cinebox/core/result/result.dart' show Unit, Result;

abstract interface class LocalStorageService {
  Future<Result<Unit>> saveToken(String token);
  Future<Result<String>> getIdToken();
  Future<Result<Unit>> removeIdToken();
}
