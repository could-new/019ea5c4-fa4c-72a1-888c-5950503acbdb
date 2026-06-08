import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    final List<Lead> mockLeads = [
      Lead(id: '1', name: 'John Doe', email: 'john@example.com', company: 'Tech Corp', status: 'New', source: 'Website', estimatedValue: 5000),
      Lead(id: '2', name: 'Jane Smith', email: 'jane@example.com', company: 'Design Co', status: 'Contacted', source: 'Referral', estimatedValue: 12000),
      Lead(id: '3', name: 'Bob Johnson', email: 'bob@example.com', company: 'Global Inc', status: 'Proposal', source: 'n8n', estimatedValue: 25000),
      Lead(id: '4', name: 'Alice Brown', email: 'alice@example.com', company: 'Local Shop', status: 'Won', source: 'Direct', estimatedValue: 3000),
      Lead(id: '5', name: 'Charlie Davis', email: 'charlie@example.com', company: 'Startup LLC', status: 'Lost', source: 'Website', estimatedValue: 8000),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Leads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          if (!isMobile) _buildSideNav(context),
          Expanded(
            child: isMobile 
              ? ListView.builder(
                  itemCount: mockLeads.length,
                  itemBuilder: (context, index) {
                    final lead = mockLeads[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(lead.name),
                        subtitle: Text('${lead.company} • ${lead.status}'),
                        trailing: Text('\$${lead.estimatedValue.toStringAsFixed(0)}'),
                      ),
                    );
                  },
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Company')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Source')),
                          DataColumn(label: Text('Value')),
                        ],
                        rows: mockLeads.map((lead) => DataRow(
                          cells: [
                            DataCell(Text(lead.name)),
                            DataCell(Text(lead.company)),
                            DataCell(Text(lead.email)),
                            DataCell(Chip(
                              label: Text(lead.status, style: const TextStyle(fontSize: 12)),
                              padding: EdgeInsets.zero,
                            )),
                            DataCell(Text(lead.source)),
                            DataCell(Text('\$${lead.estimatedValue.toStringAsFixed(0)}')),
                          ],
                        )).toList(),
                      ),
                    ),
                  ),
                ),
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
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_kanban),
            title: const Text('Pipeline'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pipeline');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('All Leads'),
            selected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
