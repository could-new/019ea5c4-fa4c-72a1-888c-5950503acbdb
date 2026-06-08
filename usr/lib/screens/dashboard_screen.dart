import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: isMobile ? _buildDrawer(context) : null,
      body: Row(
        children: [
          if (!isMobile) _buildSideNav(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 900 ? 2 : 4);
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2.5,
                        children: [
                          _buildMetricCard(context, 'Total Leads', '142', Icons.people, Colors.blue),
                          _buildMetricCard(context, 'Active Pipeline', '\$84,000', Icons.attach_money, Colors.green),
                          _buildMetricCard(context, 'New Today', '12', Icons.fiber_new, Colors.orange),
                          _buildMetricCard(context, 'Conversion Rate', '24%', Icons.percent, Colors.purple),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildActivityList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Text(
              'Lead Automation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.view_kanban),
            title: const Text('Pipeline'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pipeline');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('All Leads'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/leads');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Lead Automation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.view_kanban),
            title: const Text('Pipeline'),
            onTap: () => Navigator.pushNamed(context, '/pipeline'),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('All Leads'),
            onTap: () => Navigator.pushNamed(context, '/leads'),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    final activities = [
      {'title': 'New lead from n8n webhook', 'time': '10 mins ago', 'icon': Icons.api},
      {'title': 'Deal moved to Proposal', 'time': '1 hour ago', 'icon': Icons.swap_horiz},
      {'title': 'Follow-up email sent', 'time': '2 hours ago', 'icon': Icons.email},
      {'title': 'New lead from Website', 'time': '5 hours ago', 'icon': Icons.web},
    ];

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange.withOpacity(0.1),
              child: Icon(activity['icon'] as IconData, color: Colors.deepOrange),
            ),
            title: Text(activity['title'] as String),
            subtitle: Text(activity['time'] as String),
          );
        },
      ),
    );
  }
}
