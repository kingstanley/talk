class User {
  late String phoneNumber;
  late String username;
  late String email;
  late String about;
  late String profilePix;
  late String pin;
  late String encryptionKey;

  User(this.phoneNumber, this.username, this.email, this.about, this.profilePix,
      this.pin, this.encryptionKey);
  toMap(user) {}
  fromMap(user) {}
}
