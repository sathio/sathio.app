import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'services_provider.dart';
import 'models/service_model.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesState = ref.watch(servicesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _buildSearchBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildCategoryList(servicesState.selectedCategory),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: _buildServiceList(servicesState.filteredServices),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Sarkari Seva',
        style: GoogleFonts.outfit(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.mic, color: Color(0xFFF58220)),
          onPressed: () {
            // Trigger voice search handling (future)
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          ref.read(servicesProvider.notifier).search(value);
        },
        decoration: InputDecoration(
          hintText: 'Ya bolein jo dhundna hai...',
          hintStyle: GoogleFonts.inter(color: Colors.grey.shade400),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFF58220)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildCategoryList(ServiceCategory selected) {
    final categories = ServiceCategory.values;
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                _formatCategory(cat),
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  ref.read(servicesProvider.notifier).selectCategory(cat);
                }
              },
              selectedColor: const Color(0xFFF58220),
              backgroundColor: Colors.white,
              side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey.shade300,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              showCheckmark: false,
            ),
          );
        },
      ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.2, end: 0),
    );
  }

  Widget _buildServiceList(List<ServiceModel> services) {
    if (services.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  'Koi seva nahi mili',
                  style: GoogleFonts.inter(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final service = services[index];
        return _buildServiceCard(context, service)
            .animate(delay: Duration(milliseconds: 50 * index))
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.1, end: 0);
      }, childCount: services.length),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceModel service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: InkWell(
        onTap: () => _showAgentStartDialog(context, service),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0E0), // Light orange bg
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  service.iconData,
                  color: const Color(0xFFF58220),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.bolt, size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            'Automated by Sathio',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCategory(ServiceCategory cat) {
    final s = cat.toString().split('.').last;
    return s[0].toUpperCase() + s.substring(1);
  }

  void _showAgentStartDialog(BuildContext context, ServiceModel service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Start Agent?',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Sathio will autonomously handle "${service.title}" for you. Do you want to proceed?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Trigger actual agent flow
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Starting agent for ${service.title}...'),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF58220),
            ),
            child: const Text('Start Agent'),
          ),
        ],
      ),
    );
  }
}
