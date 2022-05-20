class MyUser {
  late String id;
  late String username;
  late String phone;
  late String email;
  late String country;
  late DateTime dateTime;

  MyUser({
    required this.id,
    required this.email,
    this.username = "",
    this.phone = "",
    this.country = "",
  });

  MyUser.Edit({
    this.username = "",
    this.country = "",
    this.phone = "",
  });
}
