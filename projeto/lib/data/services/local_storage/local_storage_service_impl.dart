import 'package:cinebox/core/result/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  LocalStorageServiceImpl({required FlutterSecureStorage flutterSecureStorage})
    : _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<Result<String>> getIdToken() async {
    final token = await _flutterSecureStorage.read(key: 'id_token');
    if (token != null) {
      return Sucess(token);
    }
    return Failure(Exception('Token não encontrado'));
  }

  @override
  Future<Result<Unit>> removeIdToken() async {
    await _flutterSecureStorage.delete(key: 'id_token');
    return sucessOfUnit();
  }

  @override
  Future<Result<Unit>> saveToken(String token) async {
    await _flutterSecureStorage.write(key: 'id_token', value: token);
    return sucessOfUnit();
  }
}
