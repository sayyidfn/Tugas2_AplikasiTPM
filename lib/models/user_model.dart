class UserModel {
  final String username;
  final String nama;
  final String nim;

  UserModel({required this.nama, required this.nim, required this.username});

  static List<UserModel> groupData = [
    UserModel(nama: 'Sayyid Fakhri N', nim: '123230172', username: 'Fakhri'),
    UserModel(nama: 'Nama Anggota 2', nim: '123230XXX', username: 'User2'),
  ];
}
