import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const AdStacksApp());
}

class AdStacksApp extends StatelessWidget {
  const AdStacksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdStacks Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedWorkspace = 'Adstacks';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 600 && size.width <= 1024;
    final isMobile = size.width <= 600;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      drawer: !isDesktop ? _buildDrawer() : null,
      body: Row(
        children: [
          if (isDesktop) _buildDrawer(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(isDesktop, isMobile),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.all(isMobile ? 12 : (isTablet ? 16 : 24)),
                    child: isDesktop
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hero banner spans both main area and right sidebar on desktop
                              _buildHeroBanner(isMobile),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    // don't render the hero again inside main content
                                    child: _buildMainContent(
                                        isDesktop, isTablet, isMobile,
                                        showHero: false),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 3,
                                    child: _buildRightSidebar(isMobile),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildMainContent(isDesktop, isTablet, isMobile),
                              const SizedBox(height: 16),
                              _buildRightSidebar(isMobile),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      width: 280,
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
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'AS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'AdStacks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Profile Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mayank Gupta',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Navigation Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMenuItem(Icons.home, 'Home', true),
                _buildMenuItem(Icons.people_outline, 'Employees', false),
                _buildMenuItem(Icons.calendar_today, 'Attendance', false),
                _buildMenuItem(Icons.insert_chart_outlined, 'Summary', false),
                _buildMenuItem(Icons.info_outline, 'Information', false),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WORKSPACES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Icon(Icons.add, size: 20, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 12),
                _buildWorkspaceItem('Adstacks', true),
                _buildWorkspaceItem('Finance', false),
              ],
            ),
          ),

          // Bottom Menu
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildMenuItem(Icons.settings_outlined, 'Setting', false),
                _buildMenuItem(Icons.logout, 'Logout', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildWorkspaceItem(String name, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF1F2937)
                  : const Color(0xFF6B7280),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool isDesktop, bool isMobile) {
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
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
            _buildIconButton(Icons.calendar_today_outlined),
            const SizedBox(width: 8),
          ],
          _buildIconButton(Icons.notifications_outlined),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            _buildIconButton(Icons.share_outlined),
            const SizedBox(width: 8),
            _buildIconButton(Icons.power_settings_new),
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

  Widget _buildIconButton(IconData icon) {
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

  Widget _buildMainContent(bool isDesktop, bool isTablet, bool isMobile,
      {bool showHero = true}) {
    return Column(
      children: [
        // Hero Banner with 3D blocks
        if (showHero) _buildHeroBanner(isMobile),
        SizedBox(height: isMobile ? 16 : 24),

        // Projects and Top Creators Row
        isDesktop || isTablet
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildAllProjects(isMobile)),
                  SizedBox(width: isMobile ? 12 : 24),
                  Expanded(child: _buildTopCreators(isMobile)),
                ],
              )
            : Column(
                children: [
                  _buildAllProjects(isMobile),
                  const SizedBox(height: 16),
                  _buildTopCreators(isMobile),
                ],
              ),
        SizedBox(height: isMobile ? 16 : 24),

        // Performance Chart
        _buildPerformanceChart(isMobile),
      ],
    );
  }

  Widget _buildHeroBanner(bool isMobile) {
    // Make banner taller on larger screens to avoid vertical overflow
    final bannerHeight = isMobile ? 280.0 : 340.0;

    return Container(
      height: bannerHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -50,
            top: -30,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // 3D Blocks - Right side
          Positioned(
            right: isMobile ? 20 : 60,
            top: isMobile ? 30 : 40,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                width: isMobile ? 80 : 120,
                height: isMobile ? 80 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.withOpacity(0.8),
                      Colors.purple.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: isMobile ? 80 : 140,
            top: isMobile ? 80 : 100,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: isMobile ? 60 : 90,
                height: isMobile ? 60 : 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pink.withOpacity(0.8),
                      Colors.orange.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(8, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sphere
          Positioned(
            right: isMobile ? 30 : 50,
            bottom: isMobile ? 40 : 50,
            child: Container(
              width: isMobile ? 70 : 100,
              height: isMobile ? 70 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade600,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
            ),
          ),
          // Cone/Triangle
          Positioned(
            right: isMobile ? 120 : 180,
            bottom: isMobile ? 60 : 70,
            child: CustomPaint(
              size: Size(isMobile ? 50 : 70, isMobile ? 50 : 70),
              painter: ConePainter(),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ETHEREUM 3.0',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Top Rating\nProject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Trending project and high rating\nProject Created by team.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: isMobile ? 12 : 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllProjects(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Projects',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 20),
          _buildProjectCard(
              'Technology behind the Blockchain',
              'Project #1 • See project details',
              const Color(0xFFEF4444),
              isMobile),
          SizedBox(height: isMobile ? 8 : 12),
          _buildProjectCard(
              'Technology behind the Blockchain',
              'Project #2 • See project details',
              const Color(0xFF374151),
              isMobile),
          SizedBox(height: isMobile ? 8 : 12),
          _buildProjectCard(
              'Technology behind the Blockchain',
              'Project #3 • See project details',
              const Color(0xFF1E3A8A),
              isMobile),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      String title, String subtitle, Color color, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 40 : 50,
            height: isMobile ? 40 : 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Icon(Icons.code, color: Colors.white, size: isMobile ? 20 : 24),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 12 : 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: isMobile ? 10 : 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.edit,
              color: Colors.white.withOpacity(0.7), size: isMobile ? 18 : 20),
        ],
      ),
    );
  }

  Widget _buildTopCreators(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Top Creators',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'See All',
                  style: TextStyle(
                      color: Colors.white70, fontSize: isMobile ? 10 : 12),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: isMobile ? 10 : 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Artworks',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: isMobile ? 10 : 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Rating',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: isMobile ? 10 : 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildCreatorItem('@madebyoli_ui', 9870, 95, isMobile),
          _buildCreatorItem('@bluefish2', 9022, 92, isMobile),
          _buildCreatorItem('@madebyoli_ui', 8870, 88, isMobile),
          _buildCreatorItem('@madebyoli_ui', 8870, 85, isMobile),
        ],
      ),
    );
  }

  Widget _buildCreatorItem(
      String name, int artworks, int rating, bool isMobile) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      child: Row(
        children: [
          Container(
            width: isMobile ? 30 : 40,
            height: isMobile ? 30 : 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: isMobile ? 11 : 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              artworks.toString(),
              style: TextStyle(
                  color: Colors.white70, fontSize: isMobile ? 11 : 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 60),
                    height: isMobile ? 6 : 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: rating / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Over All Performance',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                'The Years',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildLegend(Colors.pink[300]!, 'Pending Done', isMobile),
                  _buildLegend(
                      const Color(0xFF8B5CF6), 'Project Done', isMobile),
                ],
              ),
            ],
          ),
          SizedBox(height: isMobile ? 20 : 32),
          SizedBox(
            height: isMobile ? 200 : 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[200]!,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: isMobile ? 10 : 12,
                          ),
                        );
                      },
                      reservedSize: isMobile ? 30 : 40,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const years = [
                          '2015',
                          '2016',
                          '2017',
                          '2018',
                          '2019',
                          '2020'
                        ];
                        if (value.toInt() < years.length) {
                          return Text(
                            years[value.toInt()],
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: isMobile ? 10 : 12,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 50,
                lineBarsData: [
                  // Pink Line (Pending Done)
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 20),
                      const FlSpot(1, 25),
                      const FlSpot(2, 35),
                      const FlSpot(3, 30),
                      const FlSpot(4, 40),
                      const FlSpot(5, 35),
                    ],
                    isCurved: true,
                    color: Colors.pink[300],
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.pink[300]!.withOpacity(0.1),
                    ),
                  ),
                  // Purple Line (Project Done)
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 15),
                      const FlSpot(1, 20),
                      const FlSpot(2, 30),
                      const FlSpot(3, 45),
                      const FlSpot(4, 40),
                      const FlSpot(5, 43),
                    ],
                    isCurved: true,
                    color: const Color(0xFF8B5CF6),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (index == 3) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: const Color(0xFF8B5CF6),
                            strokeWidth: 3,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 0,
                          color: Colors.transparent,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF8B5CF6).withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        if (spot.spotIndex == 3 && spot.barIndex == 1) {
                          return LineTooltipItem(
                            '% 55',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return null;
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 10 : 12,
          height: isMobile ? 10 : 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: isMobile ? 6 : 8),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 11 : 12,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSidebar(bool isMobile) {
    return Column(
      children: [
        // Calendar Card
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GENERAL 10:00 AM TO 7:00 PM',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isMobile ? 9 : 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Container(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text('OCT',
                              style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: isMobile ? 12 : 14)),
                        ),
                        Text(
                          '2025',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 16),
                        ),
                        Icon(Icons.chevron_right,
                            color: const Color(0xFF9CA3AF),
                            size: isMobile ? 18 : 20),
                      ],
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'].map((day) {
                        return Text(
                          day,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: isMobile ? 10 : 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    _buildCalendarGrid(isMobile),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),

        // Today Birthday Card
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '✨',
                    style: TextStyle(fontSize: isMobile ? 18 : 20),
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    'Today Birthday',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '✨',
                    style: TextStyle(fontSize: isMobile ? 18 : 20),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvatarCircle(const Color(0xFF8B5CF6), isMobile),
                  SizedBox(width: isMobile ? 6 : 8),
                  _buildAvatarCircle(const Color(0xFFEC4899), isMobile),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 6 : 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 24,
                      vertical: isMobile ? 10 : 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.cake,
                    color: Colors.white, size: isMobile ? 16 : 18),
                label: Text(
                  'Birthday Wishing',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 12 : 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),

        // Anniversary Card
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '✨',
                    style: TextStyle(fontSize: isMobile ? 18 : 20),
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    'Anniversary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '✨',
                    style: TextStyle(fontSize: isMobile ? 18 : 20),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvatarCircle(const Color(0xFF10B981), isMobile),
                  SizedBox(width: isMobile ? 6 : 8),
                  _buildAvatarCircle(const Color(0xFFF59E0B), isMobile),
                  SizedBox(width: isMobile ? 6 : 8),
                  _buildAvatarCircle(const Color(0xFF3B82F6), isMobile),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 6 : 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 24,
                      vertical: isMobile ? 10 : 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.celebration,
                    color: Colors.white, size: isMobile ? 16 : 18),
                label: Text(
                  'Anniversary Wishing',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 12 : 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(bool isMobile) {
    final days = [
      '',
      '',
      '',
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: isMobile ? 6 : 8,
        crossAxisSpacing: isMobile ? 6 : 8,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        if (day.isEmpty) return const SizedBox();

        final isToday = day == '21';
        final isHighlighted = day == '22' || day == '23';

        return Container(
          decoration: BoxDecoration(
            color: isToday
                ? const Color(0xFF8B5CF6)
                : isHighlighted
                    ? const Color(0xFF3B82F6)
                    : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: isToday || isHighlighted
                    ? Colors.white
                    : const Color(0xFF1F2937),
                fontSize: isMobile ? 11 : 13,
                fontWeight: isToday || isHighlighted
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarCircle(Color color, bool isMobile) {
    return Container(
      width: isMobile ? 35 : 45,
      height: isMobile ? 35 : 45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
    );
  }
}

// Custom painter for the cone/pyramid shape in hero banner
class ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.teal.withOpacity(0.8),
          Colors.cyan.withOpacity(0.6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Shadow path
    final shadowPath = Path()
      ..moveTo(size.width * 0.5 + 5, 5)
      ..lineTo(size.width + 5, size.height + 5)
      ..lineTo(5, size.height + 5)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Main triangle path
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
