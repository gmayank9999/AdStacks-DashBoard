import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDesktop;
  final bool isMobile;

  const TopBar({
    Key? key,
    required this.scaffoldKey,
    required this.isDesktop,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : (isDesktop ? 24 : 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          if (!isDesktop) const SizedBox(width: 12),
          const Text(
            'Home',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const Spacer(),
          if (isDesktop)
            Container(
              width: 300,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
                ],
              ),
            ),
          if (isDesktop) const SizedBox(width: 12),
          if (!isMobile) ...[
            _IconCircle(icon: Icons.calendar_today_outlined),
            const SizedBox(width: 8),
          ],
          _IconCircle(icon: Icons.notifications_outlined),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            _IconCircle(icon: Icons.share_outlined),
            const SizedBox(width: 8),
            _IconCircle(icon: Icons.power_settings_new),
          ],
          const SizedBox(width: 8),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final IconData icon;
  const _IconCircle({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
    );
  }
}
