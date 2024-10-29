extension DoubleUtils on double {
  double getSmaller(double other) => (this > other) ? other : this;
}