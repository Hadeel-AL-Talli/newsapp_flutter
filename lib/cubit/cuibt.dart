import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/newsApp/moduels/business/business_screen.dart';
import 'package:news_app/newsApp/moduels/science/science_screen.dart';
import 'package:news_app/newsApp/moduels/sports/sports_screen.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<dynamic> business = [];
  int currentIndex = 0;
  List<dynamic> science = [];
  List<Widget> screens = [
    Business(),
    Sports(),
    Science(),
  ];
  List<dynamic> sports = [];
 

  static NewsCubit get(context) => BlocProvider.of(context);

  void changeBottomNavBar(int index) {
    if (index == 1) getSports();
    if (index == 2) getScience();
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '89d27f0266e94ba2886ed9742cd89a09'
    }).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetBusinessLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '89d27f0266e94ba2886ed9742cd89a09'
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '89d27f0266e94ba2886ed9742cd89a09'
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

   List<dynamic> search = [];
    void getSearch(String value) {
      emit(NewsGetScienceLoadingState());
     
        DioHelper.getData(url: 'v2/everything', query: {
          'q': '$value',
          'apiKey': '89d27f0266e94ba2886ed9742cd89a09'
        }).then((value) {
          //print(value.data['articles'][0]['title']);
          search = value.data['articles'];
          print(search[0]['title']);

          emit(NewsGetSearchSucessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSearchErrorState(error.toString()));
        });
     
    }
  }

