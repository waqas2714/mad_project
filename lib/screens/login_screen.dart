import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  double _opacity = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () => setState(() => _opacity = 1.0));
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      FocusScope.of(context).unfocus(); // Dismiss keyboard
      
      // Fake API call
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0F0C29), Color(0xFF302B63)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _opacity,
              child: Form(
                key: _formKey, // Attach form key
                child: Column(
                  children: [
                    Icon(Icons.lock_person_rounded, size: 80, color: Color(0xFF6C63FF)),
                    SizedBox(height: 40),
                    Text("Secure Portal", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Email', Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Operator email required';
                        if (!value.contains('@')) return 'Invalid network credentials';
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Passcode', Icons.lock),
                      validator: (value) {
                        if (value == null || value.length < 6) return 'Passcode must be at least 6 characters';
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: _isLoading 
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Initialize Session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      errorStyle: TextStyle(color: Colors.pinkAccent),
    );
  }
}