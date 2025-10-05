// Service layer for handling reservation business logic
// This can be extended to include API calls, database operations, etc.

import '../models/reservation.dart';

class ReservationService {
  // Simulate calculating total price
  static double calculateTotalPrice(int ticketCount, double pricePerTicket) {
    return ticketCount * pricePerTicket;
  }

  // Simulate processing payment
  static Future<bool> processPayment({
    required Reservation reservation,
    required String paymentMethod,
    required String cardNumber,
  }) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, this would call a payment gateway API
    return true;
  }

  // Simulate sending confirmation email
  static Future<void> sendConfirmationEmail(Reservation reservation) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would call an email service API
  }

  // Validate reservation data
  static bool validateReservation(Reservation reservation) {
    if (reservation.username.isEmpty) return false;
    if (reservation.eventName.isEmpty) return false;
    if (reservation.ticketCount <= 0) return false;
    return true;
  }
}
