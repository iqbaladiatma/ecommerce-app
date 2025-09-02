import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4C53A5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 15),
          
          // Welcome Text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang di',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Iqbal Store',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Notification Badge
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(5),
            ),
            badgeContent: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            position: badges.BadgePosition.topEnd(top: -8, end: -8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
