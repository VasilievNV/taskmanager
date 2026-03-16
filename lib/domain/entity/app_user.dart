class AppUser {
  final String? uid;
  final String? email;
  final bool emailVerified;

  AppUser({
    this.uid,
    this.email,
    this.emailVerified = false
  });
}