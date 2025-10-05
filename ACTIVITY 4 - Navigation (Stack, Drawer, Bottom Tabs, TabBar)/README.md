# TicketMaster Live - Online Ticketing & Reservation System

A comprehensive Flutter-based mobile application for event ticket reservation and payment processing. Built with a clean architecture using the MVC pattern with organized folders for views, models, widgets, and services.

## 🎯 Project Overview

TicketMaster Live is a digital platform that allows users to select, book, and pay for events online, automating the reservation process and providing instant confirmations and e-tickets. The app features a modern blue and beige color palette with enhanced typography using Google Fonts.

## 📁 Project Structure

\`\`\`
lib/
├── main.dart                          # App entry point with routing
├── models/                            # Data models
│   └── reservation.dart               # Reservation data model
├── views/                             # UI screens
│   ├── splash_screen.dart            # App splash screen with branding
│   ├── login_screen.dart             # User authentication
│   ├── registration_screen.dart      # New user registration
│   ├── reservation_screen.dart       # Event booking form
│   └── payment_screen.dart           # Payment processing
├── widgets/                           # Reusable UI components
│   ├── reservation_card.dart         # Display reservation details
│   └── payment_summary_card.dart     # Payment summary display
└── services/                          # Business logic
    └── reservation_service.dart      # Reservation management service
\`\`\`

## 🎨 Design System

### Color Palette
- **Primary Blue**: `#2196F3` - Main brand color for buttons and accents
- **Beige**: `#F5F5DC` - Background and secondary elements
- **Dark Blue**: `#1976D2` - Headers and emphasis
- **Light Beige**: `#FAFAF0` - Card backgrounds

### Typography
- **Headings**: Montserrat (Bold, SemiBold)
- **Body Text**: Poppins (Regular, Medium)
- **Enhanced readability** with proper font weights and sizes

## 🌳 Widget Tree Structure

\`\`\`
MaterialApp
└── SplashScreen (Initial Route)
    └── AnimatedOpacity + FadeTransition
        └── Column
            ├── Icon (Confirmation Circle)
            └── Text (App Name)
    
    ↓ (After 3 seconds, navigates to)
    
    LoginScreen
    └── Scaffold
        └── Form (GlobalKey<FormState>)
            ├── TextFormField (Email) [COMPONENT 2, 3, 4]
            ├── TextFormField (Password) [COMPONENT 2, 3, 4]
            └── ElevatedButton (Login)
                └── Navigation to ReservationScreen
    
    ↓ (Or navigate to)
    
    RegistrationScreen
    └── Scaffold
        └── Form (GlobalKey<FormState>)
            ├── TextFormField (Name) [COMPONENT 6]
            ├── TextFormField (Email) [COMPONENT 6]
            ├── TextFormField (Password) [COMPONENT 6]
            ├── TextFormField (Confirm Password) [COMPONENT 6]
            ├── DropdownButtonFormField (Role) [COMPONENT 7]
            │   └── Options: Customer, Event Organizer, Vendor, VIP Member, Corporate Client
            └── ElevatedButton (Register)
    
    ↓ (After login/registration)
    
    ReservationScreen
    └── Scaffold
        └── Column
            ├── Form (GlobalKey<FormState>)
            │   ├── TextFormField (Username) [COMPONENT 1]
            │   ├── TextFormField (Event Name) [COMPONENT 9 with controller]
            │   ├── TextFormField (Event Type)
            │   ├── DropdownButtonFormField (Event Category)
            │   │   └── Options: Concert, Sports Event, Theater Show, Conference, Festival, Comedy Show, Exhibition, Workshop
            │   ├── TextField (Number of Tickets) [COMPONENT 5]
            │   ├── Row
            │   │   ├── Checkbox (VIP Seating) [COMPONENT 5]
            │   │   └── Switch (Newsletter) [COMPONENT 5]
            │   ├── InkWell → DatePicker [COMPONENT 8]
            │   ├── InkWell → TimePicker [COMPONENT 8]
            │   └── ElevatedButton (Reserve & Pay)
            │       └── Saves to ReservationService [COMPONENT 10]
            │       └── Navigates to PaymentScreen
            │
            └── ListView (Submitted Reservations) [COMPONENT 10]
                └── ReservationCard (Custom Widget)
                    └── Displays all reservation details
    
    ↓ (After reservation)
    
    PaymentScreen
    └── Scaffold
        └── Column
            ├── PaymentSummaryCard (Custom Widget)
            │   └── Displays reservation summary
            ├── Form
            │   ├── TextFormField (Card Number)
            │   ├── Row
            │   │   ├── TextFormField (Expiry Date)
            │   │   └── TextFormField (CVV)
            │   └── TextFormField (Cardholder Name)
            └── ElevatedButton (Complete Payment)
                └── Shows success dialog
                └── Navigates back to ReservationScreen
\`\`\`

## ✅ Required Components Implementation

All 10 required form components are implemented and clearly marked with comments:

1. **Simple Username Form** - `reservation_screen.dart` (Line ~80)
2. **Login Form (Email + Password)** - `login_screen.dart` (Line ~50)
3. **Form Validation** - `login_screen.dart` (Line ~60-75)
4. **GlobalKey<FormState>** - Used in all forms for validation
5. **Different Input Types** - `reservation_screen.dart` (TextField, Checkbox, Switch)
6. **Registration Form** - `registration_screen.dart` (Name, Email, Password, Confirm)
7. **Dropdown Menu (Role)** - `registration_screen.dart` (Line ~120)
8. **Date & Time Picker** - `reservation_screen.dart` (Line ~200-250)
9. **Controller with Display** - `reservation_screen.dart` (Event Name field)
10. **Local List Storage** - `reservation_screen.dart` + `reservation_service.dart` (Displays below form)

## 🚀 Features

### User Authentication
- Login with email and password validation
- Registration with role selection (Customer, Event Organizer, Vendor, VIP Member, Corporate Client)
- Form validation with error messages

### Event Reservation
- Event name and type input
- Event category dropdown (8 event types)
- Ticket quantity selection
- VIP seating checkbox option
- Newsletter subscription toggle
- Date and time picker for event selection
- Real-time form validation

### Payment Processing
- Secure payment form
- Card number, expiry, CVV, and cardholder name fields
- Payment summary display
- Confirmation dialog with success message

### Data Management
- Local storage using ReservationService
- Display all submitted reservations
- Reservation cards with complete details

## 🎭 User Flow

1. **Splash Screen** → App launches with animated logo and name
2. **Login/Registration** → User authenticates or creates account
3. **Reservation** → User fills out event booking form with all details
4. **Payment** → User enters payment information
5. **Confirmation** → Success message and return to reservations list

## 📱 Screens Description

### Splash Screen
- Animated fade-in effect
- TicketMaster Live branding
- 3-second display before navigation
- Blue and beige color scheme

### Login Screen
- Email and password fields with validation
- Link to registration screen
- Form submission with GlobalKey

### Registration Screen
- Complete user registration form
- Role selection dropdown
- Password confirmation validation
- Navigate to login after registration

### Reservation Screen
- Comprehensive booking form with all 10 components
- Event category dropdown selection
- Date and time pickers
- Local storage of reservations
- Display list of all submitted bookings below form

### Payment Screen
- Payment summary card
- Credit card information form
- Complete payment button
- Success confirmation dialog

## 🛠️ Technologies Used

- **Flutter SDK** - Cross-platform mobile development
- **Dart** - Programming language
- **Google Fonts** - Montserrat & Poppins typography
- **Material Design** - UI components and design system
- **Intl Package** - Date and time formatting

## 📦 Dependencies

\`\`\`yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
  intl: ^0.19.0
\`\`\`

## 🎨 Color Scheme

The app uses a professional blue and beige palette:
- Primary actions and headers: Blue tones
- Backgrounds and cards: Beige tones
- Text: Dark blue for contrast
- Accents: Light beige for subtle highlights

## 📝 Development Notes

- **Architecture**: MVC pattern with clear separation of concerns
- **State Management**: StatefulWidget with local state and service layer
- **Navigation**: Named routes with MaterialPageRoute
- **Validation**: Form validation using GlobalKey<FormState>
- **Data Persistence**: In-memory storage via ReservationService (can be extended to database)
- **Responsive Design**: Adapts to different screen sizes with SingleChildScrollView

## 🔄 Future Enhancements

- Backend API integration for real payment processing
- Database integration (SQLite/Firebase) for persistent storage
- User authentication with JWT tokens
- QR code generation for e-tickets
- Push notifications for event reminders
- Payment gateway integration (Stripe, PayPal)
- Email confirmation system

## 👨‍💻 Development Environment

This app is designed to be developed in **FlutLab.io**, an online Flutter IDE that supports:
- Real-time preview
- Hot reload
- Dart file editing
- Package management

## 📄 License

TicketMaster Live - Educational Project

---

**Built with ❤️ using Flutter**
