import 'package:flutter/material.dart';
import '../models/lead.dart';

class PipelineScreen extends StatelessWidget {
  const PipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    final List<Lead> mockLeads = [
      Lead(id: '1', name: 'John Doe', email: 'john@example.com', company: 'Tech Corp', status: 'New', source: 'Website', estimatedValue: 5000),
      Lead(id: '2', name: 'Jane Smith', email: 'jane@example.com', company: 'Design Co', status: 'Contacted', source: 'Referral', estimatedValue: 12000),
      Lead(id: '3', name: 'Bob Johnson', email: 'bob@example.com', company: 'Global Inc', status: 'Proposal', source: 'n8n', estimatedValue: 25000),
    ];

    final stages = ['New', 'Contacted', 'Proposal', 'Won'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pipeline'),
      ),
      body: Row(
        children: [
          if (!isMobile) _buildSideNav(context),
          Expanded(
            child: isMobile
                ? _buildMobilePipeline(stages, mockLeads)
                : _buildDesktopPipeline(stages, mockLeads),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePipeline(List<String> stages, List<Lead> leads) {
    return DefaultTabController(
      length: stages.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: stages.map((s) => Tab(text: s)).toList(),
            labelColor: Colors.deepOrange,
          ),
          Expanded(
            child: TabBarView(
              children: stages.map((stage) {
                final stageLeads = leads.where((l) => l.status == stage).toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: stageLeads.length,
                  itemBuilder: (context, index) {
                    return _buildLeadCard(stageLeads[index]);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopPipeline(List<String> stages, List<Lead> leads) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stages.map((stage) {
          final stageLeads = leads.where((l) => l.status == stage).toList();
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stage,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          stageLeads.length.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: stageLeads.length,
                    itemBuilder: (context, index) {
                      return _buildLeadCard(stageLeads[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeadCard(Lead lead) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lead.company,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(lead.name),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${lead.estimatedValue.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                ),
                Icon(
                  lead.source == 'n8n' ? Icons.api : Icons.web,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
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
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_kanban),
            title: const Text('Pipeline'),
            selected: true,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('All Leads'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/leads');
            },
          ),
        ],
      ),
    );
  }
}
