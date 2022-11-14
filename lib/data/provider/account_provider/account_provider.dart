
abstract class AccountProvider {
  Future login({String? email , String? password});

  Future userDetail({String? idUser});

  Future userUpdate({String? idUser, String? userName, String? mailUser, String? phoneNumber});
}
