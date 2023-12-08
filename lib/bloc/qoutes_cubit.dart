import 'package:all_quotes/constant/Constant.dart';
import 'package:all_quotes/data/Network/endPoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../Model/QuotesModel.dart';
import '../data/Network/DioHelper.dart';

part 'qoutes_state.dart';

class QoutesCubit extends Cubit<QoutesState> {
  QoutesCubit() : super(QoutesInitial());

  static QoutesCubit get(context) => BlocProvider.of<QoutesCubit>(context);
  List<Quote> quotes = [];
  TextEditingController SearchController = TextEditingController();

  Future<void> QuotesGet() async {
    emit(getQuotesLoading());
    await dioHelper.get(
        endpoint: End_Piont.endPoint,
        token: Constant.token,
        params: {
          if (SearchController.text.isNotEmpty) 'filter': SearchController.text,
        }).then((value) {
      quotes.clear();
      if (value.data['quotes'] != null) {
        for (var item in value.data['quotes']) {
          quotes.add(Quote.fromJson(item));
        }
        print(quotes.length);
      }
      emit(getQuotesSuccess());
    }).catchError((error) {
      print(error);
      emit(getQuotesError());
    });
  }
  Future<void> PutFav(int Q_ID) async {
    emit(FavQuotesLoading());
    await dioHelper.put(
        endpoint: '${End_Piont.endPoint}/$Q_ID/${End_Piont.fav}',token: Constant.token).then((value) {
      print(value?.data);
      quotes.where((element) => element.id==Q_ID).first.isFav=true;
      quotes.where((element) => element.id==Q_ID).first.color=Colors.pink;
      quotes.where((element) => element.id==Q_ID).first.icon=Icon(Icons.favorite);
      emit(FavQuotesSuccess());
    }).catchError((e) {
      print(e);
      emit(FavQuotesError());
    });
  }

  Future<void> PutunFav(int Q_ID) async {
    emit(unFavQuotesLoading());
    await dioHelper.put(
        endpoint: '${End_Piont.endPoint}/$Q_ID/${End_Piont.unFav}',token: Constant.token).then((value) {
      print(value?.data);
      quotes.where((element) => element.id==Q_ID).first.isFav=false;
      quotes.where((element) => element.id==Q_ID).first.color=Colors.black;
      quotes.where((element) => element.id==Q_ID).first.icon=Icon(Icons.favorite_border_outlined);
      emit(unFavQuotesSuccess());
    }).catchError((e) {
      print(e);
      emit(unFavQuotesError());
    });
  }


}
