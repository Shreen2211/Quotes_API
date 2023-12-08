part of 'qoutes_cubit.dart';

@immutable
abstract class QoutesState {}

class QoutesInitial extends QoutesState {}

class getQuotesLoading extends QoutesState {}

class getQuotesSuccess extends QoutesState {}

class getQuotesError extends QoutesState {}

class FavQuotesLoading extends QoutesState {}

class FavQuotesSuccess extends QoutesState {}

class FavQuotesError extends QoutesState {}

class unFavQuotesLoading extends QoutesState {}

class unFavQuotesSuccess extends QoutesState {}

class unFavQuotesError extends QoutesState {}
