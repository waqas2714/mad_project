import 'package:flutter/material.dart';

class PromptAlchemistScreen extends StatefulWidget {
  @override
  _PromptAlchemistScreenState createState() => _PromptAlchemistScreenState();
}

class _PromptAlchemistScreenState extends State<PromptAlchemistScreen> {
  List<String> _selectedModifiers = [];
  
  final Map<String, List<String>> _modifiers = {
    "Lighting": ["Volumetric", "Cinematic", "Neon Glow", "Bioluminescent"],
    "Camera": ["8k Resolution", "Drone Shot", "Macro Lens", "Fisheye"],
    "Vibe": ["Dystopian", "Ethereal", "Grimdark", "Utopian"],
  };

  void _toggleModifier(String mod) {
    setState(() {
      _selectedModifiers.contains(mod) ? _selectedModifiers.remove(mod) : _selectedModifiers.add(mod);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate prompt strength (maxes out around 8 modifiers)
    double strength = (_selectedModifiers.length / 8).clamp(0.0, 1.0);
    Color strengthColor = strength < 0.4 ? Colors.cyanAccent : (strength < 0.8 ? Colors.pinkAccent : Colors.orangeAccent);

    return Scaffold(
      appBar: AppBar(title: Text('Prompt Alchemist')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0F0C29), Color(0xFF302B63)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            // The Prompt Strength Gauge
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.black45, border: Border(bottom: BorderSide(color: Colors.white10))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Prompt Complexity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("${(strength * 100).toInt()}%", style: TextStyle(color: strengthColor, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 15),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: strength),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    builder: (context, double val, child) {
                      return LinearProgressIndicator(
                        value: val,
                        backgroundColor: Colors.white10,
                        color: strengthColor,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Live Prompt Preview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: strengthColor.withOpacity(0.5)),
              ),
              child: Text(
                _selectedModifiers.isEmpty ? "Awaiting input parameters..." : _selectedModifiers.join(", ") + "...",
                style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ),

            // Selectable Modifier Chips
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: _modifiers.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: entry.value.map((mod) {
                          bool isSelected = _selectedModifiers.contains(mod);
                          return GestureDetector(
                            onTap: () => _toggleModifier(mod),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Color(0xFF6C63FF) : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isSelected ? Colors.white : Colors.transparent),
                                boxShadow: isSelected ? [BoxShadow(color: Color(0xFF6C63FF).withOpacity(0.5), blurRadius: 10)] : [],
                              ),
                              child: Text(mod, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: FontWeight.bold)),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}