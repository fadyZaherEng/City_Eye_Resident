import 'package:city_eye/src/domain/entities/sign_in/user.dart';

class SelectCompoundUseCase {
  User call({required User user, required int id}) {
    // for (var compound in user.compounds) {
    //   if (compound.id == id) {
    //     compound.isSelected = true;
    //   } else {
    //     compound.isSelected = false;
    //   }
    // }
    return user;
  }
}
