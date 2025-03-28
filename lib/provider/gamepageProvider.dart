import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class gamepageProvider extends ChangeNotifier{
     final Dio _dio= Dio();
     final int maxQuestions =10;
     List? questions;
     int _currentQuestionCount=0;

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
         notifyListeners();
       }

       String getcurrentQuestionText(){
       return questions![_currentQuestionCount]['question'];
       }

     void answerQuestion(String _answer)async {
      bool isCorrect = questions![_currentQuestionCount]['correct_answer'] == _answer;
      _currentQuestionCount++;
      print(isCorrect ? 'correct' : 'incorrect');
      showDialog(
          context: context,
          builder: (BuildContext _context){
            return AlertDialog(
             backgroundColor: isCorrect? Colors.green : Colors.red,
              title: Icon(isCorrect? Icons.check_box :Icons.cancel,
              color: Colors.white,),
            );
          }
      );
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context);
      if(_currentQuestionCount == maxQuestions){
        endGame();
      }
      else {
        notifyListeners();
      }
     }

     Future<void> endGame()async{
        showDialog(
           context: context,
           builder: (BuildContext _context) {
         return AlertDialog(
           backgroundColor: Colors.blue,
           title: Text("End Game!"),
           content: Text("score 0/0"),
         );
         }
        );
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);
     }
}

