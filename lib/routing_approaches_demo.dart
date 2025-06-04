import 'package:flutter/material.dart';

class RoutingApproachesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Routing Approaches'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildHeaderCard(),
          SizedBox(height: 16),
          _buildApproachCard(
            '1. Navigator.push/pop',
            'Basic imperative navigation',
            'Simple but limited scalability',
            Colors.red.shade50,
            _getNavigatorPushExample(),
          ),
          _buildApproachCard(
            '2. Named Routes',
            'Route-based navigation with string names',
            'Better organization, still imperative',
            Colors.orange.shade50,
            _getNamedRoutesExample(),
          ),
          _buildApproachCard(
            '3. Generated Routes',
            'Dynamic route generation with onGenerateRoute',
            'Flexible but requires manual setup',
            Colors.yellow.shade50,
            _getGeneratedRoutesExample(),
          ),
          _buildApproachCard(
            '4. go_router ⭐',
            'Declarative routing with URL support',
            'Best for modern apps, web-ready',
            Colors.green.shade50,
            _getGoRouterExample(),
          ),
          _buildApproachCard(
            '5. auto_route',
            'Code generation based routing',
            'Type-safe but requires build_runner',
            Colors.blue.shade50,
            _getAutoRouteExample(),
          ),
          SizedBox(height: 16),
          SizedBox(height: 16),
          _buildBestPracticeCard(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 6,
      color: Colors.indigo.shade50,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: Colors.indigo, size: 32),
                SizedBox(width: 12),
                Text(
                  'Flutter Routing Approaches',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Explore different ways to handle navigation and routing in Flutter applications.',
              style: TextStyle(fontSize: 16, color: Colors.indigo.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApproachCard(String title, String subtitle, String description, Color color, String codeExample) {
    return Card(
      color: color,
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Example:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    codeExample,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildBestPracticeCard() {
    return Card(
      elevation: 6,
      color: Colors.green.shade50,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 12),
                Text(
                  'Best Approach: go_router',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Why go_router is the best choice:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildAdvantage('🌐', 'Web-Ready', 'Perfect URL handling and deep linking'),
            _buildAdvantage('🎯', 'Declarative', 'Matches modern Flutter philosophy'),
            _buildAdvantage('🔒', 'Type-Safe', 'Compile-time route validation'),
            _buildAdvantage('🏗️', 'Nested Routes', 'Complex navigation patterns'),
            _buildAdvantage('🛡️', 'Guards', 'Built-in authentication protection'),
            _buildAdvantage('🚀', 'Performance', 'Optimized for large applications'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvantage(String emoji, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getNavigatorPushExample() {
    return '''// Basic navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(),
  ),
);

// Go back
Navigator.pop(context);

// Pros: Simple, quick to implement
// Cons: No URL support, hard to manage at scale''';
  }

  String _getNamedRoutesExample() {
    return '''// Define routes in MaterialApp
MaterialApp(
  routes: {
    '/': (context) => HomeScreen(),
    '/details': (context) => DetailScreen(),
    '/profile': (context) => ProfileScreen(),
  },
);

// Navigate using names
Navigator.pushNamed(context, '/details');

// Pros: Better organization, route names
// Cons: Still imperative, limited parameter passing''';
  }

  String _getGeneratedRoutesExample() {
    return '''// Dynamic route generation
MaterialApp(
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/details':
        return MaterialPageRoute(
          builder: (context) => DetailScreen(
            id: settings.arguments as String,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => NotFoundScreen(),
        );
    }
  },
);

// Pros: Flexible, parameter support
// Cons: Manual setup, no type safety''';
  }

  String _getGoRouterExample() {
    return '''// Declarative routing with go_router
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: '/details/:id',
          builder: (context, state) => DetailScreen(
            id: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);

// Navigate
context.go('/details/123');

// Pros: URL support, type-safe, declarative
// Cons: Learning curve for complex scenarios''';
  }

  String _getAutoRouteExample() {
    return '''// Code generation approach
@AutoRouterConfig()
class AppRouter extends _\$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: DetailRoute.page,
      path: '/details/:id',
    ),
  ];
}

// Navigate
context.pushRoute(DetailRoute(id: '123'));

// Pros: Type-safe, code generation
// Cons: Complex setup, build_runner dependency''';
  }
} 