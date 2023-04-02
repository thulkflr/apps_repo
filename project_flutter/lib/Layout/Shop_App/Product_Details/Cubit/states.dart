

abstract class ProductDetailsStates {}

class InitialProductDetailsState extends ProductDetailsStates {}

class SuccessProductDetailsState extends ProductDetailsStates {}

class LoadingProductDetailsState extends ProductDetailsStates {}

class ErrorProductDetailsState extends ProductDetailsStates {
  final String error;

  ErrorProductDetailsState(this.error);
}
