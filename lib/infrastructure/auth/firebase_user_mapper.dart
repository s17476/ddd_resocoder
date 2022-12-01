import 'package:ddd_resocoder/domain/auth/user.dart' as user;
import 'package:ddd_resocoder/domain/core/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserDomainX on User {
  user.User toDomain() {
    return user.User(id: UniqueId.fromUniqueString(uid));
  }
}
