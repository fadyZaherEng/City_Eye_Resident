import 'package:city_eye/src/domain/entities/delegated/user.dart';

class GetOwnerInformationUseCase {
  User call() {
    return TestData().getTestData();
  }
}

class TestData {
  User getTestData() {
    return User(
        name: "Abaza",
        id: 0,
        phoneNumber: "012355",
        unitNumber: "U/V10",
        unitType: "Compound");
  }
}
