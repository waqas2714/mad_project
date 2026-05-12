import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // Animation 4 (Start): Hero tag connects this avatar to the Profile Screen
              child: Hero(
                tag: 'profile-avatar',
                child: CircleAvatar(
                  backgroundColor: Color(0xFF6C63FF),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Capabilities", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white70)),
            SizedBox(height: 20),
            Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // 2 items per row
                  childAspectRatio: 1.0, // Keeps them square
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _InteractiveCard(title: 'Chat Link', icon: Icons.chat_bubble, route: '/chat', color: Color(0xFF6C63FF)),
                    _InteractiveCard(title: 'Vision Gen', icon: Icons.image_search, route: '/image_gen', color: Colors.pinkAccent),
                    _InteractiveCard(title: 'Data Logs', icon: Icons.analytics, route: '/data_logs', color: Colors.cyanAccent),
                    _InteractiveCard(title: 'Diagnostics', icon: Icons.memory, route: '/diagnostics', color: Colors.orangeAccent),
                    _InteractiveCard(title: 'AI Persona', icon: Icons.psychology, route: '/persona', color: Colors.tealAccent), // NEW
                    _InteractiveCard(title: 'Prompt Lab', icon: Icons.science, route: '/alchemist', color: Colors.amberAccent), // NEW
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String? route;
  final Color color;

  _InteractiveCard({required this.title, required this.icon, this.route, required this.color});

  @override
  __InteractiveCardState createState() => __InteractiveCardState();
}

class __InteractiveCardState extends State<_InteractiveCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.route != null) Navigator.pushNamed(context, widget.route!);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      // Animation 5: AnimatedContainer handles scale and shadow changes automatically
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(_isPressed ? 8.0 : 0.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.color.withOpacity(_isPressed ? 0.8 : 0.2), width: 2),
          boxShadow: _isPressed ? [] : [BoxShadow(color: widget.color.withOpacity(0.2), blurRadius: 15, spreadRadius: 2)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 50, color: widget.color),
            SizedBox(height: 15),
            Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}