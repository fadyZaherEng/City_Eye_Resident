class DescribeProblemValidationUseCase {
  bool call(String value, int maxLength) {
    return value.trim().length <= maxLength;
  }
}
