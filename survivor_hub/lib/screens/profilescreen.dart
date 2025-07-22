import 'package:flutter/material.dart';
import 'available_soon_screen.dart';
import 'my_profile_screen.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';
import 'about_us_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1f1f1f),
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome Back, Survivor Hub',
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
              radius: 18,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ClickableStatCard(title: 'Matches Played', value: '0'),
                _ClickableStatCard(title: 'Total Kills', value: '0'),
                _ClickableStatCard(title: 'PlayCoin Won', value: '0'),
              ],
            ),
            const SizedBox(height: 30),
            const _MenuItem(title: 'My Profile', icon: Icons.person),
            const _MenuItem(title: 'My Wallet', icon: Icons.account_balance_wallet),
            const _MenuItem(title: 'My Statistics', icon: Icons.bar_chart),
            const _MenuItem(title: 'Top Players', icon: Icons.leaderboard),
            const _MenuItem(title: 'Notifications', icon: Icons.notifications),
            const _MenuItem(title: 'Contact Us', icon: Icons.support_agent),
            _MenuItemWithToggle(title: 'Important Notice', icon: Icons.info_outline),
            const _MenuItem(title: 'FAQ', icon: Icons.help_outline),
            const _MenuItem(title: 'About Us', icon: Icons.info),
            const _MenuItem(title: 'Privacy Policy', icon: Icons.privacy_tip),
            const _MenuItem(title: 'Terms & Conditions', icon: Icons.article),
            const _MenuItem(title: 'Logout', icon: Icons.logout, isLogout: true),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'App Version: v1',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClickableStatCard extends StatelessWidget {
  final String title;
  final String value;

  const _ClickableStatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AvailableSoonScreen(),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF1f1f1f),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 100,
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isLogout;

  const _MenuItem({
    required this.title,
    required this.icon,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.orangeAccent),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      onTap: () {
        if (isLogout) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else if (title == 'My Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyProfileScreen(),
            ),
          );
        } else if (title == 'Terms & Conditions') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditionsScreen(),
            ),
          );
        } else if (title == 'Privacy Policy') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicyScreen(),
            ),
          );
        } else if (title == 'About Us') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutUsScreen(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AvailableSoonScreen(),
            ),
          );
        }
      },
    );
  }
}

class _MenuItemWithToggle extends StatefulWidget {
  final String title;
  final IconData icon;

  const _MenuItemWithToggle({required this.title, required this.icon});

  @override
  State<_MenuItemWithToggle> createState() => _MenuItemWithToggleState();
}

class _MenuItemWithToggleState extends State<_MenuItemWithToggle> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Icon(widget.icon, color: Colors.orangeAccent),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: _isToggled,
        onChanged: (value) {
          setState(() {
            _isToggled = value;
          });
        },
        activeColor: Colors.orangeAccent,
      ),
    );
  }
}
