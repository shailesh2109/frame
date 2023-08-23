part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class LoadImageWithFilter extends ImageEvent {
  final Frame filter;

  LoadImageWithFilter({required this.filter});
}
