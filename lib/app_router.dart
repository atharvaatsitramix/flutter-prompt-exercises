import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'list_view_examples.dart';
import 'best_approach_demo.dart';
import 'routing_approaches_demo.dart';
import 'widgets/labeled_text_field.dart';

// Define route paths as constants for type safety
class AppRoutes {
  static const String home = '/';
  static const String listViewExamples = '/listview-examples';
  static const String bestApproach = '/best-approach';
  static const String routingApproaches = '/routing-approaches';
  static const String textFieldDemo = '/textfield-demo';
  static const String about = '/about';
  static const String settings = '/settings';
}

// Create the router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Shell route to maintain the navigation drawer across all pages
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.listViewExamples,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ListViewExamples(),
          ),
        ),
        GoRoute(
          path: AppRoutes.bestApproach,
          pageBuilder: (context, state) => NoTransitionPage(
            child: BestApproachDemo(),
          ),
        ),
        GoRoute(
          path: AppRoutes.routingApproaches,
          pageBuilder: (context, state) => NoTransitionPage(
            child: RoutingApproachesDemo(),
          ),
        ),
        GoRoute(
          path: AppRoutes.textFieldDemo,
          pageBuilder: (context, state) => NoTransitionPage(
            child: TextFieldDemoScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.about,
          pageBuilder: (context, state) => NoTransitionPage(
            child: AboutScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
  // Error handling
  errorBuilder: (context, state) => NotFoundScreen(error: state.error),
);

// Main layout with navigation drawer
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Navigation Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: NavigationDrawer(),
      body: child,
    );
  }
}

// Custom Navigation Drawer
class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.flutter_dash,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Flutter Demo App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Navigation & ListView Examples',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          _buildNavigationSection(
            context,
            'Main Features',
            [
              NavigationItem(
                icon: Icons.home,
                title: 'Home',
                route: AppRoutes.home,
                currentLocation: currentLocation,
              ),
              NavigationItem(
                icon: Icons.list,
                title: 'ListView Examples',
                route: AppRoutes.listViewExamples,
                currentLocation: currentLocation,
              ),
              NavigationItem(
                icon: Icons.star,
                title: 'Best Approach Demo',
                route: AppRoutes.bestApproach,
                currentLocation: currentLocation,
              ),
            ],
          ),

          Divider(),

          _buildNavigationSection(
            context,
            'Technical Deep Dive',
            [
              NavigationItem(
                icon: Icons.route,
                title: 'Routing Approaches',
                route: AppRoutes.routingApproaches,
                currentLocation: currentLocation,
              ),
              NavigationItem(
                icon: Icons.text_fields,
                title: 'Text Field Demo',
                route: AppRoutes.textFieldDemo,
                currentLocation: currentLocation,
              ),
            ],
          ),

          Divider(),

          _buildNavigationSection(
            context,
            'App Info',
            [
              NavigationItem(
                icon: Icons.info,
                title: 'About',
                route: AppRoutes.about,
                currentLocation: currentLocation,
              ),
              NavigationItem(
                icon: Icons.settings,
                title: 'Settings',
                route: AppRoutes.settings,
                currentLocation: currentLocation,
              ),
            ],
          ),

          SizedBox(height: 20),

          // Footer
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Built with ❤️ using Flutter & go_router',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationSection(BuildContext context, String title, List<NavigationItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        ...items.map((item) => _buildNavigationTile(context, item)),
      ],
    );
  }

  Widget _buildNavigationTile(BuildContext context, NavigationItem item) {
    final isSelected = item.currentLocation == item.route;

    return ListTile(
      leading: Icon(
        item.icon,
        color: isSelected ? Colors.deepPurple : Colors.grey.shade600,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.deepPurple : Colors.black87,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.deepPurple.shade50,
      onTap: () {
        context.go(item.route);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}

// Navigation item model
class NavigationItem {
  final IconData icon;
  final String title;
  final String route;
  final String currentLocation;

  NavigationItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.currentLocation,
  });
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 6,
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flutter_dash, color: Colors.deepPurple, size: 32),
                      SizedBox(width: 12),
                      Text(
                        'Welcome to Flutter Demo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This app demonstrates different approaches to ListView implementation and navigation patterns in Flutter.',
                    style: TextStyle(fontSize: 16, color: Colors.deepPurple.shade600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Quick Navigation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildQuickNavCard(
                  context,
                  'ListView Examples',
                  'Explore 6 different approaches',
                  Icons.list,
                  Colors.blue,
                  AppRoutes.listViewExamples,
                ),
                _buildQuickNavCard(
                  context,
                  'Best Approach',
                  'ListView.builder in action',
                  Icons.star,
                  Colors.orange,
                  AppRoutes.bestApproach,
                ),
                _buildQuickNavCard(
                  context,
                  'Routing Approaches',
                  'Navigation patterns comparison',
                  Icons.route,
                  Colors.green,
                  AppRoutes.routingApproaches,
                ),
                _buildQuickNavCard(
                  context,
                  'Text Field Demo',
                  'Input field examples',
                  Icons.text_fields,
                  Colors.red,
                  AppRoutes.textFieldDemo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickNavCard(BuildContext context, String title, String subtitle, 
      IconData icon, Color color, String route) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => context.go(route),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Text Field Demo Screen
class TextFieldDemoScreen extends StatefulWidget {
  @override
  _TextFieldDemoScreenState createState() => _TextFieldDemoScreenState();
}

class _TextFieldDemoScreenState extends State<TextFieldDemoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Field Examples',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          LabeledTextField(
            controller: _nameController,
            label: 'Your Name',
            hintText: 'Enter your full name',
          ),
          SizedBox(height: 16),
          LabeledTextField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'Enter your email',
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'This demonstrates the LabeledTextField widget from the original app.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

// About Screen
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Navigation Demo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text('Version: 1.0.0'),
                  SizedBox(height: 8),
                  Text('This app demonstrates:'),
                  SizedBox(height: 8),
                  Text('• Multiple ListView implementation approaches'),
                  Text('• Modern navigation with go_router'),
                  Text('• Navigation drawer patterns'),
                  Text('• Responsive UI design'),
                  Text('• Best practices for Flutter development'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Enable dark theme'),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                Divider(),
                SwitchListTile(
                  title: Text('Notifications'),
                  subtitle: Text('Receive app notifications'),
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Not Found Screen
class NotFoundScreen extends StatelessWidget {
  final Exception? error;

  const NotFoundScreen({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('The requested page could not be found.'),
            if (error != null) ...[
              SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
            ],
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
} 