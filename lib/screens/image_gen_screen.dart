import 'package:flutter/material.dart';

class ImageGenScreen extends StatefulWidget {
  @override
  _ImageGenScreenState createState() => _ImageGenScreenState();
}

class _ImageGenScreenState extends State<ImageGenScreen> {
  String _selectedStyle = "Cyberpunk";
  bool _isGenerating = false;
  bool _isDone = false;

  void _generate() {
    setState(() { _isGenerating = true; _isDone = false; });
    Future.delayed(Duration(seconds: 3), () => setState(() { _isGenerating = false; _isDone = true; }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vision Synthesizer')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0F0C29), Color(0xFF302B63)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Aesthetic", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ["Cyberpunk", "Hyper-Realistic", "Anime", "Surreal"].map((style) {
                  return ChoiceChip(
                    label: Text(style, style: TextStyle(color: _selectedStyle == style ? Colors.white : Colors.white54)),
                    selected: _selectedStyle == style,
                    selectedColor: Color(0xFF6C63FF),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    onSelected: (selected) => setState(() => _selectedStyle = style),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _isDone ? Colors.pinkAccent : Color(0xFF6C63FF).withOpacity(0.5), width: 2),
                      boxShadow: _isDone ? [BoxShadow(color: Colors.pinkAccent.withOpacity(0.4), blurRadius: 20)] : [],
                    ),
                    child: _isGenerating 
                        ? Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
                        : _isDone 
                            ? ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network("https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?auto=format&fit=crop&w=500&q=80", fit: BoxFit.cover)) // Free futuristic unsplash image
                            : Center(child: Icon(Icons.image_search, size: 80, color: Colors.white24)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Describe your vision...',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.auto_awesome, color: Colors.pinkAccent),
                    onPressed: _generate,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}