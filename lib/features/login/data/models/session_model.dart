import 'package:libreria/features/login/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({required String id, required String name, required String token})
      : super(id: id, name: name, token: token);

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SessionModel(
      id: data['id'],
      name: data['name'],
      token: data['token'],
    );
  }
}