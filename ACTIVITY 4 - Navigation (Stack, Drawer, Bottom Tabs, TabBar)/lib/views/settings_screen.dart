import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Settings',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              SwitchListTile(
                title:
                    Text('Enable Notifications', style: GoogleFonts.poppins()),
                subtitle: Text('Receive updates about your bookings',
                    style: GoogleFonts.poppins(fontSize: 12)),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value
                            ? 'Notifications enabled'
                            : 'Notifications disabled',
                        style: GoogleFonts.poppins(),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                activeColor: const Color(0xFF2196F3),
              ),
              const Divider(),
              SwitchListTile(
                title: Text('Dark Mode', style: GoogleFonts.poppins()),
                subtitle: Text('Switch to dark theme',
                    style: GoogleFonts.poppins(fontSize: 12)),
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value
                            ? 'Dark mode enabled (restart app to apply)'
                            : 'Dark mode disabled',
                        style: GoogleFonts.poppins(),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                activeColor: const Color(0xFF2196F3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language, color: Color(0xFF2196F3)),
                title: Text('Language', style: GoogleFonts.poppins()),
                subtitle: Text(_selectedLanguage,
                    style: GoogleFonts.poppins(fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showLanguageDialog();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.security, color: Color(0xFF2196F3)),
                title: Text('Privacy & Security', style: GoogleFonts.poppins()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showPrivacyDialog();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help, color: Color(0xFF2196F3)),
                title: Text('Help & Support', style: GoogleFonts.poppins()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showHelpDialog();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English'),
            _buildLanguageOption('Filipino'),
            _buildLanguageOption('Spanish'),
            _buildLanguageOption('Chinese'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: const Color(0xFF2196F3))),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language, style: GoogleFonts.poppins()),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Language changed to $value',
              style: GoogleFonts.poppins(),
            ),
          ),
        );
      },
      activeColor: const Color(0xFF2196F3),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy & Security',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Privacy Settings',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('• Your data is encrypted and secure',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• We never share your information',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• You can delete your account anytime',
                  style: GoogleFonts.poppins(fontSize: 12)),
              const SizedBox(height: 16),
              Text('Security Features',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('• Two-factor authentication available',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• Secure payment processing',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• Regular security updates',
                  style: GoogleFonts.poppins(fontSize: 12)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close',
                style: GoogleFonts.poppins(color: const Color(0xFF2196F3))),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help & Support',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Contact Us',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Email: support@ticketmaster.com',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('Phone: +63 123 456 7890',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('Hours: 24/7 Support',
                  style: GoogleFonts.poppins(fontSize: 12)),
              const SizedBox(height: 16),
              Text('FAQs',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('• How to make a reservation?',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• Payment methods accepted',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• Refund and cancellation policy',
                  style: GoogleFonts.poppins(fontSize: 12)),
              Text('• How to contact event organizers',
                  style: GoogleFonts.poppins(fontSize: 12)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening support chat...',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              );
            },
            child: Text('Chat with Us',
                style: GoogleFonts.poppins(color: const Color(0xFF2196F3))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('Close', style: GoogleFonts.poppins(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
