sealed class Either<L, R> {}

final class Left<L, R> extends Either<L, R> {
  final L _left;

  Left(this._left);

  L get value => _left;
}

final class Right<L, R> extends Either<L, R> {
  final R _right;

  Right(this._right);

  R get value => _right;
}
