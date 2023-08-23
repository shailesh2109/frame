part of 'image_bloc.dart';

@immutable
sealed class ImageState extends Equatable {}

final class ImageInitial extends ImageState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ImageLoading extends ImageState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ImageLoaded extends ImageState {
  final CustomClipper<Path>? filter;

  ImageLoaded({required this.filter});

  @override
  List<Object?> get props => [];
}
