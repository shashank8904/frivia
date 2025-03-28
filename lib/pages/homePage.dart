import 'package:flutter/material.dart';
import 'package:frivia/pages/gamePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _currentDifficultyLevel = 0;
  final List<String> difficultyLevels = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                SizedBox(height: size.height * 0.1),
                _buildTitle(size),
                _buildSlider(size),
                _buildStartButton(context, size),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Size size) {
    return Column(
      children: [
        Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: size.width * 0.12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                blurRadius: 15,
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Text(
            difficultyLevels[_currentDifficultyLevel.toInt()],
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(Size size) {
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(20),
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
      child: Column(
        children: [
          Text(
            'DIFFICULTY',
            style: TextStyle(
              color: Colors.white70,
              fontSize: size.width * 0.04,
              letterSpacing: 1.5,
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
              activeTrackColor: Colors.cyanAccent,
              inactiveTrackColor: Colors.grey[800],
              thumbColor: Colors.cyanAccent,
              overlayColor: Colors.cyanAccent.withOpacity(0.2),
            ),
            child: Slider(
              min: 0,
              max: 2,
              divisions: 2,
              value: _currentDifficultyLevel,
              onChanged: (value) {
                setState(() {
                  _currentDifficultyLevel = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, Size size) {
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                difficultyLevel: difficultyLevels[_currentDifficultyLevel.toInt()].toLowerCase(),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'START',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}