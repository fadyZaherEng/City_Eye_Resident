import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_edit_mobile_number.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/edit_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/validate_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/verify_otp_request.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/entities/register/edit_mobile_number.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';

abstract class RegisterRepository {
  Future<DataState<OTP>> register(
      RegisterRequest registerRequest, int userId);

  Future<DataState> validateMobileNumber(
      ValidateMobileNumberRequest validateMobileNumberRequest);

  Future<DataState<OTP>> requestOTP(RequestOTPRequest requestOTPRequest,int compoundId);

  Future<DataState<User>> verifyOTP(VerifyOTPRequest verifyOTPRequest,int userId);

  Future<DataState<List<CityCompound>>> getCityCompounds();

  Future<DataState<List<CompoundUnit>>> getCompoundUnits(
      CompoundUnitsRequest compoundUnitsRequest,int userId);

  Future<DataState<EditMobileNumber>> editMobileNumber(
      EditMobileNumberRequest editMobileNumberRequest);
}
