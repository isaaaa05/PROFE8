import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COMPONENT 7: About screen accessible via named route '/about'

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.confirmation_number,
                size: 80,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'About TicketMaster Live',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'TicketMaster Live is a comprehensive online ticketing system that allows users to select, book, and pay for events, services, or travel online.',
              style: GoogleFonts.poppins(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Features',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('Easy event reservation'),
            _buildFeatureItem('Secure payment processing'),
            _buildFeatureItem('Instant confirmations'),
            _buildFeatureItem('Digital e-tickets'),
            _buildFeatureItem('Multiple event types support'),
            const SizedBox(height: 24),
            Text(
              'Version 1.0.0',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2196F3), size: 20),
          const SizedBox(width: 8),
          Text(text, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }
}
