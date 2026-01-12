import 'package:untitled/pages/Auth/domain/repositories/auth_repository.dart';

import '../../../../models/user_model.dart';
import '../auth_data_source.dart';

class RemoteAuthRepository extends AuthRepository{
  final AuthDataSource dataSource;

  RemoteAuthRepository(this.dataSource);

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<void> register(
    String email,
    String password,
    String confirmPassword,
  ) {
    return dataSource.register(
      email,
      password,
      confirmPassword,
    );
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<void> forgotPassword(String email) {
    return dataSource.forgotPassword(email);
  }
}
