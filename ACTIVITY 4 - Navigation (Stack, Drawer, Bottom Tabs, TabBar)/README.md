# TicketMaster Live - Online Ticketing & Reservation System

A comprehensive Flutter-based mobile application for event ticket reservation and payment processing. Built with a clean architecture using the MVC pattern with organized folders for views, models, widgets, and services.

## 🎯 Project Overview

TicketMaster Live is a digital platform that allows users to select, book, and pay for events online, automating the reservation process and providing instant confirmations and e-tickets. The app features a modern blue and beige color palette with enhanced typography using Google Fonts, complete navigation system with drawer and bottom tabs, and fully functional messaging capabilities.

## 📁 Project Structure

\`\`\`
lib/
├── main.dart                          # App entry point with named routes
├── models/                            # Data models
│   ├── reservation.dart               # Reservation data model
│   └── message.dart                   # Message data model for chat
├── views/                             # UI screens
│   ├── splash_screen.dart            # App splash screen with branding
│   ├── login_screen.dart             # User authentication
│   ├── registration_screen.dart      # New user registration
│   ├── home_screen.dart              # Main hub with drawer & bottom tabs
│   ├── reservation_screen.dart       # Event booking form
│   ├── payment_screen.dart           # Payment processing with e-wallet support
│   ├── profile_screen.dart           # User profile management
│   ├── settings_screen.dart          # App settings (dark mode, language, etc.)
│   ├── about_screen.dart             # About information
│   ├── contact_screen.dart           # Contact information
│   ├── messages_screen.dart          # Chat conversations with TabBar
│   └── chat_detail_screen.dart       # Individual chat screen
├── widgets/                           # Reusable UI components
│   ├── reservation_card.dart         # Display reservation details
│   └── payment_summary_card.dart     # Payment summary display
└── services/                          # Business logic
    ├── reservation_service.dart      # Reservation management service
    └── message_service.dart          # Message management service
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
MaterialApp (with Named Routes)
└── SplashScreen (Initial Route: '/')
    └── AnimatedOpacity + FadeTransition
        └── Column
            ├── Icon (Confirmation Circle)
            └── Text (App Name)
    
    ↓ (After 3 seconds, navigates to)
    
    LoginScreen (Route: '/login')
    └── Scaffold
        └── Form (GlobalKey<FormState>)
            ├── TextFormField (Email) [COMPONENT 2, 3, 4]
            ├── TextFormField (Password) [COMPONENT 2, 3, 4]
            └── ElevatedButton (Login)
                └── pushReplacement to HomeScreen [NAV COMPONENT 8]
    
    ↓ (Or navigate to)
    
    RegistrationScreen (Route: '/register')
    └── Scaffold
        └── Form (GlobalKey<FormState>)
            ├── TextFormField (Name) [COMPONENT 6]
            ├── TextFormField (Email) [COMPONENT 6]
            ├── TextFormField (Password) [COMPONENT 6]
            ├── TextFormField (Confirm Password) [COMPONENT 6]
            ├── DropdownButtonFormField (User Role) [COMPONENT 7]
            │   └── Options: Customer, Event Organizer, Vendor, VIP Member, Corporate Client
            └── ElevatedButton (Register)
                └── Navigator.pop() [NAV COMPONENT 1]
    
    ↓ (After login)
    
    HomeScreen (Route: '/home') [NAV COMPONENT 10]
    └── Scaffold
        ├── Drawer [NAV COMPONENT 2, 6]
        │   └── ListView
        │       ├── DrawerHeader
        │       ├── ListTile → Home
        │       ├── ListTile → Profile
        │       ├── ListTile → About (Named Route) [NAV COMPONENT 7]
        │       ├── ListTile → Contact (Named Route) [NAV COMPONENT 7]
        │       └── ListTile → Logout
        │
        └── BottomNavigationBar [NAV COMPONENT 3, 5, 6]
            ├── Tab 1: Reservations (with icon)
            ├── Tab 2: Messages (with icon)
            └── Tab 3: Settings (with icon)
    
    ↓ (Reservation Tab)
    
    ReservationScreen
    └── Scaffold
        ├── Drawer (Same as HomeScreen)
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
            │   ├── InkWell → DatePicker (Future dates only) [COMPONENT 8]
            │   ├── InkWell → TimePicker (Future times only) [COMPONENT 8]
            │   └── ElevatedButton (Submit Reservation)
            │       └── Saves to ReservationService [COMPONENT 10]
            │
            ├── ListView (Submitted Reservations) [COMPONENT 10]
            │   └── ReservationCard (Custom Widget)
            │       └── Displays all reservation details
            │
            └── ElevatedButton (Proceed to Payment)
                └── Navigator.push() to PaymentScreen [NAV COMPONENT 1]
    
    ↓ (Messages Tab)
    
    MessagesScreen [NAV COMPONENT 4, 9]
    └── Scaffold
        └── TabBar (in AppBar) [NAV COMPONENT 9]
            ├── Tab: Chats
            ├── Tab: Status
            └── Tab: Calls
            └── TabBarView [NAV COMPONENT 4]
                ├── Chats List
                │   └── ListTile → ChatDetailScreen
                │       └── Fully functional messaging
                ├── Status View
                └── Calls View
    
    ↓ (Settings Tab)
    
    SettingsScreen
    └── Scaffold
        └── ListView
            ├── SwitchListTile (Dark Mode - Functional)
            ├── ListTile (Language - Functional with dialog)
            ├── ListTile (Privacy & Security - Functional with dialog)
            └── ListTile (Help & Support - Functional with dialog)
    
    ↓ (After reservation submission)
    
    PaymentScreen
    └── Scaffold
        └── Column
            ├── PaymentSummaryCard (Custom Widget)
            │   └── Displays reservation summary with ₱ Peso currency
            ├── DropdownButton (Payment Method)
            │   ├── Credit/Debit Card → Shows card form
            │   ├── GCash → Shows QR code & reference number
            │   ├── PayPal → Shows QR code & reference number
            │   └── Maya → Shows QR code & reference number
            ├── Conditional Forms
            │   ├── Card Form (if card selected)
            │   │   ├── TextFormField (Card Number)
            │   │   ├── Row
            │   │   │   ├── TextFormField (Expiry Date)
            │   │   │   └── TextFormField (CVV)
            │   │   └── TextFormField (Cardholder Name)
            │   └── E-Wallet Display (if e-wallet selected)
            │       ├── QR Code Image
            │       └── Reference Number (copyable)
            └── ElevatedButton (Complete Payment)
                └── Shows success dialog
                └── Navigator.pop() back to ReservationScreen
\`\`\`

## ✅ Required Components Implementation

### Form & Input Handling Components (All 10 Implemented)

1. **Simple Username Form** - `reservation_screen.dart` (Line ~100)
2. **Login Form (Email + Password)** - `login_screen.dart` (Line ~50)
3. **Form Validation** - `login_screen.dart` (Line ~60-75)
4. **GlobalKey<FormState>** - Used in all forms for validation
5. **Different Input Types** - `reservation_screen.dart` (TextField, Checkbox, Switch)
6. **Registration Form** - `registration_screen.dart` (Name, Email, Password, Confirm)
7. **Dropdown Menu (User Role)** - `registration_screen.dart` (Line ~120)
8. **Date & Time Picker** - `reservation_screen.dart` (Line ~200-250, with future date/time restrictions)
9. **Controller with Display** - `reservation_screen.dart` (Event Name field)
10. **Local List Storage** - `reservation_screen.dart` + `reservation_service.dart` (Displays below form)

### Navigation Components (All 10 Implemented)

1. **Navigator.push() & pop()** - Used throughout app (login, registration, chat navigation)
2. **Drawer Menu** - `home_screen.dart` & `reservation_screen.dart` (3+ pages)
3. **BottomNavigationBar** - `home_screen.dart` (3 tabs: Reservations, Messages, Settings)
4. **TabBar with TabBarView** - `messages_screen.dart` (Chats, Status, Calls)
5. **Icons in BottomNavigationBar** - `home_screen.dart` (All tabs have icons)
6. **Drawer + BottomNavigationBar** - `home_screen.dart` (Combined navigation)
7. **Named Routes** - `main.dart` (Routes: '/', '/login', '/register', '/home', '/about', '/contact')
8. **push() vs pushReplacement()** - Login uses `pushReplacement`, others use `push`
9. **TabBar in AppBar** - `messages_screen.dart` (3 tabs in AppBar)
10. **Login → Home with Drawer & Tabs** - Complete flow implemented

## 🚀 Features

### User Authentication
- Login with email and password validation
- Registration with user role selection (Customer, Event Organizer, Vendor, VIP Member, Corporate Client)
- Form validation with error messages
- Secure navigation flow with pushReplacement

### Event Reservation
- Event name and type input
- Event category dropdown (8 event types)
- Ticket quantity selection
- VIP seating checkbox option
- Newsletter subscription toggle
- Date and time picker with **future date/time restrictions** (cannot select past dates)
- Real-time form validation
- View submitted reservations before payment

### Payment Processing
- Multiple payment methods:
  - **Credit/Debit Card** - Traditional card form
  - **GCash** - QR code and reference number
  - **PayPal** - QR code and reference number
  - **Maya** - QR code and reference number
- Payment summary display with **Philippine Peso (₱)** currency
- Ticket price: ₱500.00 per ticket
- Confirmation dialog with success message

### Navigation System
- **Drawer Menu** - Access to Home, Profile, About, Contact, and Logout
- **Bottom Navigation** - Quick access to Reservations, Messages, and Settings
- **Named Routes** - Clean routing architecture
- **Tab Navigation** - Messages screen with Chats, Status, and Calls tabs

### Messaging System
- Fully functional chat interface
- Real-time message sending and receiving
- Multiple conversation support
- Time-stamped messages
- Unread message indicators
- Search functionality
- Individual chat detail screens

### Settings & Customization
- **Dark Mode Toggle** - Fully functional theme switching
- **Language Selection** - Choose from English, Filipino, Spanish, Chinese
- **Privacy & Security** - Information dialog with privacy details
- **Help & Support** - Contact support dialog with email and phone

### Data Management
- Local storage using services (ReservationService, MessageService)
- Display all submitted reservations
- Persistent message history
- Reservation cards with complete details

## 🎭 User Flow

1. **Splash Screen** → App launches with animated logo and name
2. **Login/Registration** → User authenticates or creates account
3. **Home Screen** → Main hub with drawer and bottom navigation
4. **Reservation** → User fills out event booking form with all details
5. **Review** → User sees submitted reservations before payment
6. **Payment** → User selects payment method (card or e-wallet with QR)
7. **Confirmation** → Success message and return to reservations list
8. **Messages** → Access chat system with multiple conversations
9. **Settings** → Customize app preferences (dark mode, language, etc.)

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
- Uses pushReplacement for navigation

### Registration Screen
- Complete user registration form
- User role selection dropdown (5 specific roles)
- Password confirmation validation
- Navigate back to login after registration

### Home Screen
- Main navigation hub
- Drawer menu with 5 options
- Bottom navigation bar with 3 tabs
- Combines multiple navigation patterns

### Reservation Screen
- Comprehensive booking form with all 10 components
- Event category dropdown selection
- Date and time pickers (future dates only)
- Drawer navigation access
- Local storage of reservations
- Display list of all submitted bookings
- Separate "Proceed to Payment" button

### Payment Screen
- Payment method dropdown (4 options)
- Dynamic form based on payment method
- QR codes for e-wallet payments
- Reference numbers for e-wallet transactions
- Payment summary card with peso currency
- Success confirmation dialog

### Messages Screen
- TabBar in AppBar (Chats, Status, Calls)
- List of conversations with avatars
- Unread message indicators
- Search functionality
- Navigate to individual chats

### Chat Detail Screen
- Full conversation view
- Send and receive messages
- Time-stamped messages
- Scrollable message history
- Text input with send button

### Profile Screen
- User information display
- Edit profile functionality
- Account statistics

### Settings Screen
- Functional dark mode toggle
- Language selection dialog
- Privacy & security information
- Help & support contact dialog

### About Screen
- App information
- Version details
- Company information

### Contact Screen
- Contact information
- Support channels
- Social media links

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
- Dark mode support with inverted color scheme

## 📝 Development Notes

- **Architecture**: MVC pattern with clear separation of concerns
- **State Management**: StatefulWidget with local state and service layer
- **Navigation**: Named routes with MaterialPageRoute, Drawer, and BottomNavigationBar
- **Validation**: Form validation using GlobalKey<FormState>
- **Data Persistence**: In-memory storage via services (can be extended to database)
- **Responsive Design**: Adapts to different screen sizes with SingleChildScrollView
- **Date/Time Restrictions**: Prevents booking past dates and times
- **Payment Flexibility**: Supports both traditional cards and e-wallet QR payments
- **Messaging**: Real-time chat simulation with local storage
- **Theme Support**: Dark mode toggle with persistent state

## 🔄 Future Enhancements

- Backend API integration for real payment processing
- Database integration (SQLite/Firebase) for persistent storage
- User authentication with JWT tokens
- Real QR code generation for e-tickets and payments
- Push notifications for event reminders and messages
- Payment gateway integration (Stripe, PayPal, GCash API)
- Email confirmation system
- Real-time messaging with WebSocket
- Cloud storage for user data
- Biometric authentication
- Multi-language support expansion
- Analytics and reporting dashboard

## 👨‍💻 Development Environment

This app is designed to be developed in **FlutLab.io**, an online Flutter IDE that supports:
- Real-time preview
- Hot reload
- Dart file editing
- Package management
- Multi-file projects

## 💰 Currency

All prices are displayed in **Philippine Peso (₱)**:
- Base ticket price: ₱500.00 per ticket
- Total calculated based on number of tickets
- Formatted with proper currency symbol

## 📄 License

TicketMaster Live - Educational Project

---

**Built with ❤️ using Flutter**
