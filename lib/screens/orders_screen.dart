import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrderList(MockData.orders),
                    _buildOrderList([]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Text(
            'My Orders',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppTheme.primaryGradient,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.textMuted,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Purchases'),
          Tab(text: 'Sales'),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: AppTheme.textMuted.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your orders will appear here',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMuted,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _buildOrderCard(orders[i]),
    );
  }

  Widget _buildOrderCard(Order order) {
    return GestureDetector(
      onTap: () => _showOrderDetail(order),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.network(
                        order.productImage,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: AppTheme.bgSurface,
                              child: const Icon(
                                Icons.image_outlined,
                                color: AppTheme.textMuted,
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.productTitle,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                            fontFamily: 'Inter',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sold by ${order.sellerName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              '\$${order.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.primary,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const Spacer(),
                            _buildStatusBadge(order.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Order tracking progress
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _buildTrackingBar(order.trackingStep),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    Color bg;
    if (status == 'Delivered') {
      color = AppTheme.accent;
      bg = AppTheme.accent.withOpacity(0.15);
    } else if (status == 'In Transit') {
      color = AppTheme.primary;
      bg = AppTheme.primary.withOpacity(0.15);
    } else if (status == 'Cancelled') {
      color = AppTheme.secondary;
      bg = AppTheme.secondary.withOpacity(0.15);
    } else {
      color = AppTheme.gold;
      bg = AppTheme.gold.withOpacity(0.15);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildTrackingBar(String currentStep) {
    final steps = ['ordered', 'confirmed', 'shipped', 'delivered'];
    final stepLabels = ['Ordered', 'Confirmed', 'Shipped', 'Delivered'];
    final stepIcons = [
      Icons.shopping_cart_rounded,
      Icons.check_circle_outline_rounded,
      Icons.local_shipping_outlined,
      Icons.home_rounded,
    ];

    final currentIndex = steps.indexOf(currentStep);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Tracking',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textMuted,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(steps.length * 2 - 1, (i) {
            if (i.isOdd) {
              // Line connector
              final stepIdx = i ~/ 2;
              final isCompleted = stepIdx < currentIndex;
              return Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? AppTheme.primaryGradient
                        : null,
                    color: isCompleted ? null : AppTheme.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }
            // Step bubble
            final stepIdx = i ~/ 2;
            final isCompleted = stepIdx <= currentIndex;
            final isCurrent = stepIdx == currentIndex;
            return Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isCompleted ? AppTheme.primaryGradient : null,
                    color: isCompleted ? null : AppTheme.bgSurface,
                    border: isCurrent
                        ? null
                        : Border.all(
                            color: isCompleted
                                ? Colors.transparent
                                : AppTheme.border,
                            width: 2,
                          ),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.4),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    stepIcons[stepIdx],
                    size: 14,
                    color: isCompleted ? Colors.white : AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stepLabels[stepIdx],
                  style: TextStyle(
                    fontSize: 9,
                    color: isCompleted ? AppTheme.primary : AppTheme.textMuted,
                    fontFamily: 'Inter',
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  void _showOrderDetail(Order order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    _buildStatusBadge(order.status),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Order ID', '#${order.id}'),
                      const Divider(color: AppTheme.border),
                      _buildDetailRow('Product', order.productTitle),
                      const Divider(color: AppTheme.border),
                      _buildDetailRow('Seller', order.sellerName),
                      const Divider(color: AppTheme.border),
                      _buildDetailRow('Amount', '\$${order.amount.toStringAsFixed(2)}'),
                      const Divider(color: AppTheme.border),
                      _buildDetailRow(
                        'Date',
                        '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildTrackingBar(order.trackingStep),
                const SizedBox(height: 24),
                if (order.status == 'Delivered')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.star_rounded),
                      label: const Text('Leave a Review'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textMuted,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textPrimary,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
