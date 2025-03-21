import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class gamepageProvider extends ChangeNotifier{
     final Dio _dio= Dio();
     final int maxQuestions =10;
     List? questions;

     BuildContext context;
     gamepageProvider({required this.context}) {
       _dio.options.baseUrl = "https://opentdb.com/api.php";
       fetchQuestions();
     }
       Future<void> fetchQuestions()async{
         var _response = await _dio.get('',
         queryParameters: {
           "amount":10,
           "type":"boolean",
           "difficulty":"easy",
         }
         );
         var _data = jsonDecode(_response.toString());
         print(_data);
         questions = _data["results"];
       }

}

