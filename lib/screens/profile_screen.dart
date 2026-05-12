import 'dart:math';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scannerController;

  @override
  void initState() {
    super.initState();
    // Creates a continuous looping rotation for the biometric ring
    _scannerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operator Identity', style: TextStyle(letterSpacing: 2)),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. The Biometric Avatar Hero
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating Scanner Ring
                  AnimatedBuilder(
                    animation: _scannerController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _scannerController.value * 2 * pi,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 2),
                            gradient: SweepGradient(
                              colors: [Colors.transparent, Colors.cyanAccent.withOpacity(0.8), Colors.transparent],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // The Hero Avatar
                  Hero(
                    tag: 'profile-avatar',
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0xFF6C63FF).withOpacity(0.5), blurRadius: 20, spreadRadius: 5)],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Color(0xFF0F0C29),
                        child: Icon(Icons.person_outline, size: 60, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              // 2. Identification Block
              Text('SYS_ADMIN // 0x7A9B', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 2)),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pinkAccent),
                ),
                child: Text('CLEARANCE: OMEGA LEVEL', style: TextStyle(color: Colors.pinkAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),

              SizedBox(height: 40),
              
              // 3. Neural Synchronization Stats
              Align(
                alignment: Alignment.centerLeft,
                child: Text("NEURAL SYNCHRONIZATION", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
              SizedBox(height: 15),
              _buildSyncBar("Cognitive Uplink", 0.94, Colors.cyanAccent),
              _buildSyncBar("Data Throughput", 0.78, Color(0xFF6C63FF)),
              _buildSyncBar("Firewall Integrity", 0.99, Colors.tealAccent),
              _buildSyncBar("Emotional Variance", 0.35, Colors.orangeAccent),

              SizedBox(height: 40),

              // 4. Secure Activity Feed
              Align(
                alignment: Alignment.centerLeft,
                child: Text("RECENT DECRYPTIONS", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
              SizedBox(height: 15),
              _buildActivityNode("Mainframe Accessed", "Sector 7G Node", "02:14 AM", Icons.login, Colors.cyanAccent),
              _buildActivityNode("Protocol Override", "Security Layer 4", "01:45 AM", Icons.warning_amber_rounded, Colors.pinkAccent),
              _buildActivityNode("Data Sync Complete", "Remote Server Beta", "11:30 PM", Icons.sync, Colors.tealAccent),
              
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Animated Linear Bar for Stats
  Widget _buildSyncBar(String label, double targetValue, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              Text("${(targetValue * 100).toInt()}%", style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: targetValue),
            duration: Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, double val, child) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width * val * 0.85, // 0.85 accounts for padding
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 6)],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Futuristic Timeline Node
  Widget _buildActivityNode(String title, String subtitle, String time, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
        ],
      ),
    );
  }
}