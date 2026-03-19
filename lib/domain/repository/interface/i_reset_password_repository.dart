abstract interface class IResetPasswordRepository {
  Future<void> sendLink(String email);
}