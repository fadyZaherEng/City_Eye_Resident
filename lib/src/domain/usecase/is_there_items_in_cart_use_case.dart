class IsThereItemsInCartUseCase {
  bool call(double totalPrice) {
    return totalPrice > 0;
  }
}
