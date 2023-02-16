abstract class NewsStates {}

class NewsInit extends NewsStates {}

class NewsNavigation extends NewsStates {}

class NewsGetTeslaSLoading extends NewsStates {}

class NewsGetTeslaSuccess extends NewsStates {}

class NewsGetTeslaError extends NewsStates {
  final String error;

  NewsGetTeslaError(this.error) {}
}
class NewsGetFordLoading extends NewsStates {}

class NewsGetFordSuccess extends NewsStates {}

class NewsGetFordError extends NewsStates {
  final String error;

  NewsGetFordError(this.error) {}
}
class NewsGetJaguarLoading extends NewsStates {}

class NewsGetJaguarSuccess extends NewsStates {}

class NewsGetJaguarError extends NewsStates {
  final String error;

  NewsGetJaguarError(this.error) {}
}
class NewsGetSearchLoading extends NewsStates {}

class NewsGetSearchSuccess extends NewsStates {}

class NewsGetSearchError extends NewsStates {
  final String error;

  NewsGetSearchError(this.error) {}
}
