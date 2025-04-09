import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  String subject = '', message = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpCard(Icons.question_answer_outlined, "FAQs", () {
              // Navigate to FAQs
            }),
            _buildHelpCard(Icons.email_outlined, "Email Us", () {
              // Trigger email
            }),
            _buildHelpCard(Icons.phone_outlined, "Call Support", () {
              // Trigger call
            }),
            const SizedBox(height: 24),
            const Text("Send Us a Message", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _inputField("Subject", (val) => subject = val),
                  const SizedBox(height: 12),
                  _inputField("Message", (val) => message = val, minLines: 4),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _submitSupport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Submit", style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hint, Function(String) onChanged, {int minLines = 1}) {
    return TextFormField(
      minLines: minLines,
      maxLines: minLines + 2,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      onChanged: onChanged,
    );
  }

  Widget _buildHelpCard(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  void _submitSupport() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Message sent to support")),
    );

    setState(() {
      subject = '';
      message = '';
    });

    Navigator.pop(context); // Or reset form if staying
  }
}
