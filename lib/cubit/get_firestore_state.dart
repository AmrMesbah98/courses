part of 'get_firestore_cubit.dart';

@immutable
abstract class GetFirestoreState {}

class GetFirestoreInitial extends GetFirestoreState {}

class GetFirestoreLoading extends GetFirestoreState {}
class GetFirestoreSuccess extends GetFirestoreState {}
class GetFirestoreError extends GetFirestoreState {}
