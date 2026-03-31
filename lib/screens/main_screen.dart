import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'chat_list_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'package:tradehub/models/models.dart';
import 'package:tradehub/services/database_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    ChatListScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.search_rounded, 'Explore'),
              _buildAddButton(),
              _buildNavItem(2, Icons.chat_bubble_outline_rounded, 'Chat', badge: 3),
              _buildNavItem(4, Icons.person_outline_rounded, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, {int badge = 0}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppTheme.primary.withOpacity(0.15)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                ),
                if (badge > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppTheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          badge.toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppTheme.primary : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => _showAddListingSheet(),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primary, Color(0xFF9C88FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.35),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  void _showAddListingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddListingSheet(),
    );
  }
}

class _AddListingSheet extends StatefulWidget {
  const _AddListingSheet();

  @override
  State<_AddListingSheet> createState() => _AddListingSheetState();
}

class _AddListingSheetState extends State<_AddListingSheet> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Electronics';
  String _selectedCondition = 'Like New';
  bool _isLoading = false;

  final List<String> _categories = [
    'Electronics',
    'Fashion',
    'Sports',
    'Furniture',
    'Books',
    'Vehicles',
  ];

  final List<String> _conditions = [
    'Like New',
    'Excellent',
    'Good',
    'Fair',
    'Parts Only',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      maxChildSize: 0.97,
      minChildSize: 0.5,
      builder:
          (context, scrollController) => Container(
            decoration: const BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    // Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Row(
                        children: [
                          const Text(
                            'New Listing',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Form
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Upload Area
                            GestureDetector(
                              onTap: () => _showSnack('Image picker coming soon!'),
                              child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppTheme.primary.withOpacity(0.4),
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                  color: AppTheme.primary.withOpacity(0.05),
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 48,
                                        color: AppTheme.primary,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Add Photos',
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        'Tap to upload up to 10 images',
                                        style: TextStyle(
                                          color: AppTheme.textMuted,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Title
                            _buildLabel('Title'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _titleController,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontFamily: 'Inter',
                              ),
                              decoration: const InputDecoration(
                                hintText: 'What are you selling?',
                                prefixIcon: Icon(
                                  Icons.title_rounded,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Price
                            _buildLabel('Price (USD)'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontFamily: 'Inter',
                              ),
                              decoration: const InputDecoration(
                                hintText: '0.00',
                                prefixIcon: Icon(
                                  Icons.attach_money_rounded,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Category
                            _buildLabel('Category'),
                            const SizedBox(height: 8),
                            _buildDropdown(
                              _selectedCategory,
                              _categories,
                              (v) => setState(() => _selectedCategory = v!),
                            ),
                            const SizedBox(height: 16),
                            // Condition
                            _buildLabel('Condition'),
                            const SizedBox(height: 8),
                            _buildDropdown(
                              _selectedCondition,
                              _conditions,
                              (v) => setState(() => _selectedCondition = v!),
                            ),
                            const SizedBox(height: 16),
                            // Description
                            _buildLabel('Description'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _descController,
                              maxLines: 4,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontFamily: 'Inter',
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Describe your item in detail...',
                                alignLabelWithHint: true,
                              ),
                            ),
                            const SizedBox(height: 28),
                            // Submit
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _submitListing,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: EdgeInsets.zero,
                                ).copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.transparent),
                                  shadowColor:
                                      WidgetStateProperty.all(Colors.transparent),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: _isLoading 
                                      ? LinearGradient(colors: [AppTheme.bgDark, AppTheme.bgDark.withOpacity(0.5)])
                                      : AppTheme.primaryGradient,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: _isLoading 
                                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                      : const Text(
                                          'Post Listing',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black26,
                      child: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                    ),
                  ),
              ],
            ),
          ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.textSecondary,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
          dropdownColor: AppTheme.bgCard,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppTheme.textMuted,
          ),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  void _submitListing() async {
    if (_titleController.text.isEmpty || _priceController.text.isEmpty) {
      _showSnack('Please fill in all required fields');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final product = Product(
        id: '', // Firestore will generate this
        title: _titleController.text,
        description: _descController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        category: _selectedCategory,
        sellerId: 'user_live_01', 
        sellerName: 'Demo User',
        sellerRating: 4.8,
        sellerReviews: 12,
        imageUrls: ['https://images.unsplash.com/photo-1542291026-7eec264c27ff'], // Default image
        location: 'New York, US',
        condition: _selectedCondition,
        createdAt: DateTime.now(),
      );

      await DatabaseService().addProduct(product);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              '🎉 Listing posted successfully!',
              style: TextStyle(fontFamily: 'Inter'),
            ),
            backgroundColor: AppTheme.accent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) _showSnack('Error posting listing: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'Inter')),
        backgroundColor: AppTheme.bgElevated,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
