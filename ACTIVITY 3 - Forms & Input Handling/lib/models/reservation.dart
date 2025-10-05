import 'package:flutter/material.dart';

class Reservation {
  final String username;
  final String eventName;
  final String eventType;
  final int ticketCount;
  final DateTime date;
  final TimeOfDay time;
  final bool receiveNotifications;

  Reservation({
    required this.username,
    required this.eventName,
    required this.eventType,
    required this.ticketCount,
    required this.date,
    required this.time,
    required this.receiveNotifications,
  });
}
