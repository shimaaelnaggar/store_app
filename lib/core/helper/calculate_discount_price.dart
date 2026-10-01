double calculateDiscountedPrice({
  required double price,
  required int discountPercentage,
}) {
  return price * (1 - discountPercentage / 100);
}