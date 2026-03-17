import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/domain/repository/interface/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  final FirebaseAuth instance;

  AccountRepository(this.instance);

  @override
  Future signOut() async {
    return await instance.signOut();
  }
}