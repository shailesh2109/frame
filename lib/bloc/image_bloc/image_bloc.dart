import 'package:bloc/bloc.dart';
import 'package:celebrare_assignment/helpers/image_helper.dart';
import 'package:celebrare_assignment/models/frame_types.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<LoadImageWithFilter>(_loadImageFilter);
  }

  void _loadImageFilter(
      LoadImageWithFilter event, Emitter<ImageState> emit) async {
    emit(ImageLoading());
    CustomClipper<Path>? filter = ImageHelper.getImageFrame(event.filter);

    emit(ImageLoaded(filter: filter));
  }
}
