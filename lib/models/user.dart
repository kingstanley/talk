class UserModel {
  late final String phoneNumber;
  late final String username;
  late final String email;
  late final String about;
  late final String profilePix;
  late final String pin;
  late final String encryptionKey;
  late final String id;
  late final List<dynamic> devices;
  late final String socketId;
  UserModel(
      this.phoneNumber,
      this.username,
      this.email,
      this.about,
      this.profilePix,
      this.pin,
      this.encryptionKey,
      this.devices,
      this.socketId);

  toMap() {
    return {
      "phoneNumber": this.phoneNumber,
      "username": this.username,
      "email": this.email,
      "about": this.about,
      "profilePix": this.profilePix,
      "pin": this.pin,
      "encryptionKey": this.encryptionKey,
      "devices": this.devices,
      "socketId": this.socketId
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return UserModel(
        map['phoneNumber'],
        map['username'],
        map['email'],
        map['about'],
        map['profilePix'],
        map['pin'],
        map['encryptionKey'],
        map['devices'],
        map['socketId']);
  }
}

// +234 811 181 2501