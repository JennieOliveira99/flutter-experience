sealed class Result<T> {}

class Unit {}

class Sucess<T> extends Result<T> {
  final T value;
  Sucess(this.value);
}

class Failure<T> extends Result<T> {
  final Exception error;
  final Object? value;

  Failure(this.error, [this.value]);
}

Result<Unit> sucessOfUnit() => Sucess(Unit());
