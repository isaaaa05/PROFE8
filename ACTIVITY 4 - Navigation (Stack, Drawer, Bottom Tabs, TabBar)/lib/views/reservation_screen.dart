import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reservation.dart';
import '../widgets/reservation_card.dart';
import 'payment_screen.dart';

// COMPONENT 1: TextFormField for entering username
// COMPONENT 5: Form with different input types (TextField, Checkbox, Switch)
// COMPONENT 8: Date picker and time picker input
// COMPONENT 9: Controller to capture and display text
// COMPONENT 10: Form that saves data into local list and displays below
// NAVIGATION COMPONENT 6: Drawer combined with BottomNavigationBar

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();

  // COMPONENT 1 & 9: Controllers to capture text
  final _usernameController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _ticketCountController = TextEditingController();

  String _selectedEventType = 'Concert';
  final List<String> _eventTypes = [
    'Concert',
    'Sports Event',
    'Theater Show',
    'Conference',
    'Festival',
    'Comedy Show',
    'Exhibition',
    'Workshop'
  ];

  // COMPONENT 8: Date and time variables
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // COMPONENT 5: Checkbox and Switch states
  bool _agreeToTerms = false;
  bool _receiveNotifications = false;

  // COMPONENT 10: Local list to store reservations
  final List<Reservation> _reservations = [];

  @override
  void dispose() {
    _usernameController.dispose();
    _eventNameController.dispose();
    _ticketCountController.dispose();
    super.dispose();
  }

  // COMPONENT 8: Date picker - Disabled past dates
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Cannot select past dates
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2196F3),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // COMPONENT 8: Time picker - Validates against past time if today is selected
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2196F3),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (_selectedDate != null) {
        final DateTime selectedDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          picked.hour,
          picked.minute,
        );

        if (selectedDateTime.isBefore(DateTime.now())) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Cannot select past time',
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      }

      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // COMPONENT 10: Save reservation to local list
  void _submitReservation() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select date and time',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please agree to terms and conditions',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final reservation = Reservation(
        username: _usernameController.text,
        eventName: _eventNameController.text,
        eventType: _selectedEventType,
        ticketCount: int.parse(_ticketCountController.text),
        date: _selectedDate!,
        time: _selectedTime!,
        receiveNotifications: _receiveNotifications,
      );

      setState(() {
        _reservations.add(reservation);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reservation submitted successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Clear form
      _usernameController.clear();
      _eventNameController.clear();
      _ticketCountController.clear();
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _agreeToTerms = false;
        _receiveNotifications = false;
        _selectedEventType = 'Concert';
      });
    }
  }

  void _proceedToPayment() {
    if (_reservations.isEmpty) return;

    final latestReservation = _reservations.last;

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PaymentScreen(reservation: latestReservation),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Reservation',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFF5F5DC),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.confirmation_number,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TicketMaster Live',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Your Event Companion',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFF2196F3)),
                title: Text('Home', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF2196F3)),
                title: Text('About', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.contact_mail, color: Color(0xFF2196F3)),
                title: Text('Contact', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reserve Your Tickets',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in the details below to reserve your event tickets',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // COMPONENT 1: Username field
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 5: Event name TextField
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      labelStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.event),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter event name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedEventType,
                    decoration: InputDecoration(
                      labelText: 'Event Type',
                      labelStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _eventTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedEventType = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ticketCountController,
                    decoration: InputDecoration(
                      labelText: 'Number of Tickets',
                      labelStyle: GoogleFonts.poppins(),
                      prefixIcon: const Icon(Icons.confirmation_number),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of tickets';
                      }
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 8: Date picker
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Event Date',
                        labelStyle: GoogleFonts.poppins(),
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      child: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: GoogleFonts.poppins(
                          color: _selectedDate == null
                              ? Colors.black54
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 8: Time picker
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Event Time',
                        labelStyle: GoogleFonts.poppins(),
                        prefixIcon: const Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      child: Text(
                        _selectedTime == null
                            ? 'Select Time'
                            : _selectedTime!.format(context),
                        style: GoogleFonts.poppins(
                          color: _selectedTime == null
                              ? Colors.black54
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 5: Checkbox
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        'I agree to terms and conditions',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value!;
                        });
                      },
                      activeColor: const Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // COMPONENT 5: Switch
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SwitchListTile(
                      title: Text(
                        'Receive event notifications',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      value: _receiveNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          _receiveNotifications = value;
                        });
                      },
                      activeColor: const Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitReservation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Submit Reservation',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // COMPONENT 10: Display submitted reservations below the form
            if (_reservations.isNotEmpty) ...[
              Text(
                'Your Reservations',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reservations.length,
                itemBuilder: (context, index) {
                  return ReservationCard(
                    reservation: _reservations[index],
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A574),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.payment),
                label: Text(
                  'Proceed to Payment',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
