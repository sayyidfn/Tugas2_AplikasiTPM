class UserModel {
  final String username;
  final String name;
  final String nim;

  UserModel({required this.name, required this.nim, required this.username});

  static List<UserModel> groupData = [
    UserModel(name: 'Sayyid Fakhri N', nim: '123230172', username: 'Fakhri'),
    UserModel(name: 'Nama Anggota 2', nim: '123230XXX', username: 'User2'),
  ];
}
