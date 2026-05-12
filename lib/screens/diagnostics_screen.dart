import 'package:flutter/material.dart';

class DiagnosticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Diagnostics')),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63)], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pulsing Core Status Indicator
              _buildCoreStatus(),
              SizedBox(height: 40),
              
              // The main large dial
              _buildDial("Mainframe Core Temp", 0.78, Colors.orangeAccent, size: 200),
              SizedBox(height: 40),
              
              // Two smaller sub-dials
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDial("VRAM Usage", 0.92, Colors.pinkAccent, size: 120),
                  _buildDial("GPU Load", 0.45, Colors.cyanAccent, size: 120),
                ],
              ),
              SizedBox(height: 50),

              // Server Rack Visualizer
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Active Server Arrays", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15),
              _buildServerArray("Array Alpha (US-East)", 0.85, Colors.teal),
              _buildServerArray("Array Beta (EU-West)", 0.60, Colors.cyan),
              _buildServerArray("Array Gamma (AP-South)", 0.95, Colors.pinkAccent),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // A widget that pulses to simulate a "live" heartbeat of the AI
  Widget _buildCoreStatus() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, double val, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.teal.withOpacity(val)),
            boxShadow: [BoxShadow(color: Colors.teal.withOpacity(val * 0.4), blurRadius: 15 * val)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.teal, size: 24),
              SizedBox(width: 10),
              Text("SYSTEM STABLE & SECURE", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDial(String label, double value, Color color, {double size = 180}) {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: Duration(seconds: 2),
          curve: Curves.easeOutCubic,
          builder: (context, double val, child) {
            return SizedBox(
              width: size, height: size,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(value: val, color: color, backgroundColor: Colors.white10, strokeWidth: 12),
                  Center(child: Text("${(val * 100).toInt()}%", style: TextStyle(color: Colors.white, fontSize: size * 0.22, fontWeight: FontWeight.bold))),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 15),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // A sleek horizontal progress bar for server load
  Widget _buildServerArray(String label, double fill, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text("${(fill * 100).toInt()}% LOAD", style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: fill),
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeOut,
            builder: (context, double val, child) {
              return Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(5)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: val,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 5)],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}