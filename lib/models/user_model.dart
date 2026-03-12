class UserModel {
  final String username;
  final String name;
  final String nim;

  UserModel({required this.name, required this.nim, required this.username});

  static List<UserModel> groupData = [
    UserModel(name: 'Sayyid Fakhri N', nim: '123230172', username: 'Fakhri'),
    UserModel(name: 'Aziz Surya Pradana', nim: '123230171', username: 'Aziz'),
    UserModel(
      name: 'Dhani Kartika Prihantyo',
      nim: '123230181',
      username: 'Dhani',
    ),
  ];
}
