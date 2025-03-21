import 'package:flutter/material.dart';
import 'package:frivia/provider/gamepageProvider.dart';
import 'package:provider/provider.dart';

class gamePage extends StatelessWidget {
  double? height , width;
 gamepageProvider?   _pageProvider;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(create:(_context) => gamepageProvider(context: context)  ,
      child: _buildUi()
    );
  }

  Widget _buildUi(){
    return Builder(
      builder: (_context) {
        _pageProvider = _context.watch<gamepageProvider>();
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(child: Container(
            child:_gameUi() ,
          )),
        );
      }
    );
  }

  Widget _gameUi(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _question(),
          Column(
            children: [
              _trueButton(),
              SizedBox(height: height!*0.03,),
              _false(),
            ],
          ),

        ],
      ),
    );
  }
  Widget _question(){
    return Text("Test Question no 1 are you Racist?",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: width!*0.07,
    ),);
  }

  Widget _trueButton(){
    return MaterialButton(onPressed: (){},
      color: Colors.green,
      minWidth: width!*0.80,
      height: height!*0.10,
    child: Text("TRUE",
    style: TextStyle(
      color: Colors.white,
      fontSize: width!*0.05,
    ),),);
  }

  Widget _false(){
    return MaterialButton(
      onPressed: (){},
      color: Colors.red,
      minWidth: width!*0.80,
      height: height!*0.10,
    child: Text("FALSE",
    style: TextStyle(
      color: Colors.white,
      fontSize: width!*0.05,
    ),),);
  }


}
