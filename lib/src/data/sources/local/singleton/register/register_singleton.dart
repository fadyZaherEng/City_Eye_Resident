import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/register_type.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:flutter/material.dart';


class RegisterSingleton {
  RegisterSingleton._();

  static final RegisterSingleton _instance = RegisterSingleton._();

  factory RegisterSingleton() => _instance;
  Compound _compound = Compound();
  CompoundUnit _unit = CompoundUnit(id: 0, name: '', units: []);
  int _userTypeID = -1;
  String _fullName = '';
  String _emailAddress = '';
  String _mobileNumber = '';
  String _countryCode = GetCurrentCountryCodeUseCase(injector())();
  List<PageField> _documents = [];

  void setCompound(Compound compound) {
    _compound = compound;
  }

  Compound getCompound() {
    return _compound;
  }

  void setUnit(CompoundUnit unit) {
    _unit = unit;
  }

  CompoundUnit getUnit() {
    return _unit;
  }

  void setRegisterType(int userTypeID) {
    _userTypeID = userTypeID;
  }

  int getRegisterType() {
    return _userTypeID;
  }

  void setFullName(String fullName) {
    _fullName = fullName;
  }

  String getFullName() {
    return _fullName;
  }

  void setEmailAddress(String emailAddress) {
    _emailAddress = emailAddress;
  }

  String getEmailAddress() {
    return _emailAddress;
  }

  void setMobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
  }

  String getMobileNumber() {
    return _mobileNumber;
  }

  void setCountryCode(String countryCode) {
    _countryCode = countryCode;
  }

  String getCountryCode() {
    return _countryCode;
  }

  void setDocuments(List<PageField> documents) {
    _documents = documents;
  }

  List<PageField> getDocuments() {
    return _documents;
  }

  void clearAllData() {
    _compound = Compound();
    _unit = CompoundUnit(id: 0, name: '', units: []);
    _userTypeID = -1;
    _fullName = '';
    _emailAddress = '';
    _mobileNumber = '';
    _documents = [];
  }
}
