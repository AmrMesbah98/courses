part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class UploadImageLoading extends ImageState {}
class UploadImageSuccess extends ImageState {}
class UploadImageError extends ImageState {}



class SaveImageLoading extends ImageState {}
class SaveImageSuccess extends ImageState {}
class SaveImageSuccessTime extends ImageState {}
class SaveImageSuccessUploadTask extends ImageState {}
class SaveImageError extends ImageState {}



class LinkLoadingFireStore extends ImageState {}
class LinkSuccessFireStore extends ImageState {}
class LinkErrorFireStore extends ImageState {}



