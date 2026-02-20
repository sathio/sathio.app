import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/service_model.dart';

class ServicesState {
  final List<ServiceModel> allServices;
  final List<ServiceModel> filteredServices;
  final ServiceCategory selectedCategory;
  final String searchQuery;

  ServicesState({
    required this.allServices,
    required this.filteredServices,
    this.selectedCategory = ServiceCategory.all,
    this.searchQuery = '',
  });

  ServicesState copyWith({
    List<ServiceModel>? allServices,
    List<ServiceModel>? filteredServices,
    ServiceCategory? selectedCategory,
    String? searchQuery,
  }) {
    return ServicesState(
      allServices: allServices ?? this.allServices,
      filteredServices: filteredServices ?? this.filteredServices,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ServicesController extends Notifier<ServicesState> {
  @override
  ServicesState build() {
    final services = _getHardcodedServices();
    return ServicesState(allServices: services, filteredServices: services);
  }

  void selectCategory(ServiceCategory category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    List<ServiceModel> filtered = state.allServices;

    // 1. Filter by Category
    if (state.selectedCategory != ServiceCategory.all) {
      filtered = filtered
          .where((s) => s.category == state.selectedCategory)
          .toList();
    }

    // 2. Filter by Search Query
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((s) {
        return s.title.toLowerCase().contains(query) ||
            s.description.toLowerCase().contains(query);
      }).toList();
    }

    state = state.copyWith(filteredServices: filtered);
  }

  List<ServiceModel> _getHardcodedServices() {
    return [
      const ServiceModel(
        id: 'aadhaar_download',
        title: 'Aadhaar Download',
        description: 'Download e-Aadhaar PDF from UIDAI',
        iconData: Icons.fingerprint,
        category: ServiceCategory.identity,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'aadhaar_update',
        title: 'Aadhaar Update',
        description: 'Update address or details online',
        iconData: Icons.edit_document,
        category: ServiceCategory.identity,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'pm_kisan_reg',
        title: 'PM-Kisan Registration',
        description: 'Register for PM-Kisan Samman Nidhi',
        iconData: Icons.agriculture,
        category: ServiceCategory.subsidies,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'pm_kisan_status',
        title: 'PM-Kisan Status',
        description: 'Check your payment status',
        iconData: Icons.attach_money,
        category: ServiceCategory.subsidies,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'pan_apply',
        title: 'Apply PAN Card',
        description: 'New PAN application (Form 49A)',
        iconData: Icons.credit_card,
        category: ServiceCategory.identity,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'ration_card',
        title: 'Ration Card Apply',
        description: 'Apply for new Ration Card',
        iconData: Icons.fastfood,
        category: ServiceCategory.subsidies,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'ayushman_bharat',
        title: 'Ayushman Bharat Card',
        description: 'Download Golden Card for health',
        iconData: Icons.health_and_safety,
        category: ServiceCategory.healthcare,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'pension_check',
        title: 'Check Pension Status',
        description: 'Old age / Widow pension status',
        iconData: Icons.elderly,
        category: ServiceCategory.subsidies,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'electricity_bill',
        title: 'Pay Electricity Bill',
        description: 'Pay state electricity board bills',
        iconData: Icons.lightbulb,
        category: ServiceCategory.utilities,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'mobile_recharge',
        title: 'Mobile Recharge',
        description: 'Prepaid recharge for any operator',
        iconData: Icons.smartphone,
        category: ServiceCategory.utilities,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'gas_booking',
        title: 'Book Gas Cylinder',
        description: 'HP, Indane, Bharat Gas booking',
        iconData: Icons.propane_tank,
        category: ServiceCategory.utilities,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'train_booking',
        title: 'Book Train Ticket',
        description: 'IRCTC train ticket booking',
        iconData: Icons.train,
        category: ServiceCategory.travel,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'water_bill',
        title: 'Pay Water Bill',
        description: 'Municipal water bill payment',
        iconData: Icons.water_drop,
        category: ServiceCategory.utilities,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'voter_id',
        title: 'Voter ID Apply',
        description: 'New Voter ID registration (Form 6)',
        iconData: Icons.how_to_vote,
        category: ServiceCategory.identity,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'passport_apply',
        title: 'Passport Application',
        description: 'New Passport application',
        iconData: Icons.book, // Passport kind of look
        category: ServiceCategory.travel,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'driving_license',
        title: 'Driving License',
        description: 'Apply for Learners/Driving License',
        iconData: Icons.directions_car,
        category: ServiceCategory.travel,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'certificates',
        title: 'Caste/Income Certificate',
        description: 'Apply for e-District certificates',
        iconData: Icons.card_membership,
        category: ServiceCategory
            .identity, // Or Other? usually needed for identity/proof
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'scholarship',
        title: 'Scholarship Apply',
        description: 'National Scholarship Portal',
        iconData: Icons.school,
        category: ServiceCategory.education,
        isAutomated: true,
      ),
      const ServiceModel(
        id: 'online_shopping',
        title: 'Online Shopping',
        description: 'Order from Amazon/Flipkart/JioMart',
        iconData: Icons.shopping_cart,
        category: ServiceCategory.shopping,
        isAutomated: true,
      ),
    ];
  }
}

final servicesProvider = NotifierProvider<ServicesController, ServicesState>(
  ServicesController.new,
);
