import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PersonaBuilderScreen extends StatefulWidget {
  @override
  _PersonaBuilderScreenState createState() => _PersonaBuilderScreenState();
}

class _PersonaBuilderScreenState extends State<PersonaBuilderScreen> {
  // AI Personality Traits (0.0 to 10.0)
  double _logic = 8.0;
  double _creativity = 5.0;
  double _empathy = 4.0;
  double _humor = 6.0;
  double _directness = 7.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neural Persona Matrix')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("AI Cognitive Tuning", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
            
            // The Shape-Shifting Radar Chart
            Container(
              height: 300,
              padding: EdgeInsets.all(20),
              child: RadarChart(
                RadarChartData(
                  tickCount: 3,
                  ticksTextStyle: TextStyle(color: Colors.transparent),
                  gridBorderData: BorderSide(color: Colors.white10, width: 2),
                  radarBorderData: BorderSide(color: Colors.cyanAccent.withOpacity(0.5), width: 2),
                  titlePositionPercentageOffset: 0.2,
                  // FIXED: The text style is now defined globally here!
                  titleTextStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  getTitle: (index, angle) {
                    final titles = ['Logic', 'Creativity', 'Empathy', 'Humor', 'Directness'];
                    return RadarChartTitle(text: titles[index], angle: 0); // Removed textStyle from here
                  },
                  dataSets: [
                    RadarDataSet(
                      fillColor: Color(0xFF6C63FF).withOpacity(0.4),
                      borderColor: Color(0xFF6C63FF),
                      entryRadius: 4,
                      dataEntries: [
                        RadarEntry(value: _logic),
                        RadarEntry(value: _creativity),
                        RadarEntry(value: _empathy),
                        RadarEntry(value: _humor),
                        RadarEntry(value: _directness),
                      ],
                    ),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 400), 
                swapAnimationCurve: Curves.easeOutQuart,
              ),
            ),
            
            // The Sliders
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  border: Border(top: BorderSide(color: Color(0xFF6C63FF).withOpacity(0.5), width: 2)),
                ),
                child: ListView(
                  children: [
                    _buildSlider("Logic Parameters", _logic, Colors.cyanAccent, (val) => setState(() => _logic = val)),
                    _buildSlider("Creative Variance", _creativity, Colors.pinkAccent, (val) => setState(() => _creativity = val)),
                    _buildSlider("Empathy Engines", _empathy, Colors.tealAccent, (val) => setState(() => _empathy = val)),
                    _buildSlider("Humor Subroutines", _humor, Colors.orangeAccent, (val) => setState(() => _humor = val)),
                    _buildSlider("Directness Output", _directness, Colors.redAccent, (val) => setState(() => _directness = val)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6C63FF),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Persona Profile Saved Locally', style: TextStyle(color: Colors.white)), backgroundColor: Colors.teal));
                      },
                      child: Text("LOCK MATRIX", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Color color, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              Text("${(value * 10).toInt()}%", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: Colors.white10,
              thumbColor: Colors.white,
              overlayColor: color.withOpacity(0.2),
              trackHeight: 4.0,
            ),
            child: Slider(value: value, min: 0, max: 10, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}