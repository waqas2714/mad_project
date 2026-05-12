import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DataLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neural Telemetry')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63)], 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter
          ),
        ),
        // Added a ListView so we can scroll through all these new charts!
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text("Network Load (Tbps)", style: _headerStyle()),
            SizedBox(height: 15),
            _buildChartContainer(
              height: 250,
              color: Colors.cyan,
              child: _buildLineChart(),
            ),
            
            SizedBox(height: 40),
            Text("Threat Nullification frequency", style: _headerStyle()),
            SizedBox(height: 15),
            _buildChartContainer(
              height: 200,
              color: Colors.pinkAccent,
              child: _buildBarChart(),
            ),

            SizedBox(height: 40),
            Text("Global Resource Allocation", style: _headerStyle()),
            SizedBox(height: 15),
            _buildChartContainer(
              height: 250,
              color: Color(0xFF6C63FF),
              child: _buildPieChart(),
            ),

            SizedBox(height: 40),
            Text("Live Terminal Feed", style: _headerStyle()),
            SizedBox(height: 15),
            _buildLogEntry("CRITICAL: Unauthorized access attempt blocked (IP: 192.168.x.x)", "04:22 AM", Colors.pinkAccent),
            _buildLogEntry("Neural weights synchronized successfully across 4 nodes", "04:18 AM", Colors.teal),
            _buildLogEntry("WARNING: Thermal limits approaching in Sector 7", "04:10 AM", Colors.orangeAccent),
            _buildLogEntry("Routine background diagnostic complete. 0 errors.", "03:45 AM", Colors.cyanAccent),
            _buildLogEntry("Model parameters updated via over-the-air protocol", "03:15 AM", Colors.teal),
            _buildLogEntry("Latency spike detected in routing protocol", "01:05 AM", Colors.orangeAccent),
            _buildLogEntry("User session initialized securely", "12:01 AM", Colors.cyanAccent),
            _buildLogEntry("Firewall rules updated. 4302 bad actors blocked.", "11:59 PM", Colors.teal),
            SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }

  TextStyle _headerStyle() => TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2);

  // Reusable glowing container for our charts
  Widget _buildChartContainer({required double height, required Color color, required Widget child}) {
    return Container(
      height: height,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 20, spreadRadius: 5)],
      ),
      child: child,
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false, drawHorizontalLine: true),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0, maxX: 6, minY: 0, maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 5), FlSpot(4, 3.5), FlSpot(5, 4), FlSpot(6, 6)],
            isCurved: true,
            color: Colors.cyanAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.cyanAccent.withOpacity(0.2)),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          _makeBarData(0, 5), _makeBarData(1, 8), _makeBarData(2, 3), 
          _makeBarData(3, 9), _makeBarData(4, 6), _makeBarData(5, 4),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: Colors.pinkAccent, width: 15, borderRadius: BorderRadius.circular(4))
    ]);
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 4,
        centerSpaceRadius: 40, // Makes it a hollow sci-fi ring
        sections: [
          PieChartSectionData(color: Colors.cyanAccent, value: 40, title: '40%', radius: 50, titleStyle: TextStyle(fontWeight: FontWeight.bold)),
          PieChartSectionData(color: Color(0xFF6C63FF), value: 30, title: '30%', radius: 50, titleStyle: TextStyle(fontWeight: FontWeight.bold)),
          PieChartSectionData(color: Colors.pinkAccent, value: 15, title: '15%', radius: 50, titleStyle: TextStyle(fontWeight: FontWeight.bold)),
          PieChartSectionData(color: Colors.orangeAccent, value: 15, title: '15%', radius: 50, titleStyle: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLogEntry(String text, String time, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), 
        borderRadius: BorderRadius.circular(10), 
        border: Border(left: BorderSide(color: color, width: 4))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for long text
        children: [
          Expanded(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 13))),
          SizedBox(width: 10),
          Text(time, style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}