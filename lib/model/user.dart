class MyUser {
  late String id;
  late String name;
  late String phone;
  late String email;
  late String country;
  late DateTime dateTime;

  MyUser({
    required this.id,
    required this.email,
    this.name = "",
    this.phone = "",
    this.country = "",
  });
}
