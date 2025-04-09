import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Order Shipped',
        'body': 'Your order #2345 has been shipped!',
        'time': 'Just now',
        'icon': Icons.local_shipping_outlined,
      },
      {
        'title': 'New Offer 🎉',
        'body': 'Get 20% off on your next booking!',
        'time': '2 hrs ago',
        'icon': Icons.local_offer_outlined,
      },
      {
        'title': 'Account Alert',
        'body': 'New login detected on your account.',
        'time': 'Yesterday',
        'icon': Icons.security_outlined,
      },
      {
        'title': 'Booking Reminder',
        'body': 'You have a service scheduled for tomorrow.',
        'time': '1 day ago',
        'icon': Icons.calendar_today_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _notificationCard(
            title: item['title'] as String,
            body: item['body'] as String,
            time: item['time'] as String,
            icon: item['icon'] as IconData,
          );
        },
      ),
    );
  }

  Widget _notificationCard({
    required String title,
    required String body,
    required String time,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.purple.withOpacity(0.1),
          child: Icon(icon, color: Colors.purple),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(body),
        trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
