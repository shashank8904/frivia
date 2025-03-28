import 'package:flutter/material.dart';
import 'package:frivia/provider/gamepageProvider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String? difficultyLevel;

  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => gamepageProvider(context: context, difficultyLevel: difficultyLevel),
      child: Builder(
        builder: (context) {
          final provider = context.watch<gamepageProvider>();
          return Scaffold(
            body: provider.questions == null
                ? _buildLoading()
                : _buildGameUI(context, size, provider),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[900]!, Colors.grey[850]!],
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildGameUI(BuildContext context, Size size, gamepageProvider provider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[900]!, Colors.black87],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuestion(size, provider),
              _buildAnswerButtons(context, size, provider),
              _buildBottomBar(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(Size size, gamepageProvider provider) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            offset: Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        provider.getcurrentQuestionText(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(0.95),
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          shadows: [
            Shadow(
              color: Colors.cyanAccent.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButtons(BuildContext context, Size size, gamepageProvider provider) {
    return Column(
      children: [
        _buildButton(
          text: 'TRUE',
          color: Colors.greenAccent.withOpacity(0.9),
          onPressed: () => provider.answerQuestion("True"),
          size: size,
        ),
        SizedBox(height: size.height * 0.025),
        _buildButton(
          text: 'FALSE',
          color: Colors.redAccent.withOpacity(0.9),
          onPressed: () => provider.answerQuestion("False"),
          size: size,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    required Size size,
  }) {
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.12,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[850],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(Size size) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.timer, color: Colors.cyanAccent, size: size.width * 0.06),
          Icon(Icons.score, color: Colors.cyanAccent, size: size.width * 0.06),
          Icon(Icons.settings, color: Colors.cyanAccent, size: size.width * 0.06),
        ],
      ),
    );
  }
}