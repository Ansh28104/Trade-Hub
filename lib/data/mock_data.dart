import '../models/models.dart';

class MockData {
  static const String currentUserId = 'user_001';
  static const String currentUserName = 'Alex Johnson';

  static final AppUser currentUser = AppUser(
    id: currentUserId,
    name: currentUserName,
    email: 'alex@tradehub.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    rating: 4.8,
    totalReviews: 47,
    totalSales: 32,
    memberSince: 'Jan 2024',
  );

  static final List<Product> products = [
    Product(
      id: 'p001',
      title: 'iPhone 14 Pro Max – 256GB',
      description:
          'Excellent condition, barely used. Comes with original box, charger, and case. No scratches or dents. Battery health at 98%.',
      price: 850.00,
      category: 'Electronics',
      sellerId: 'user_002',
      sellerName: 'Sarah Mitchell',
      sellerRating: 4.9,
      sellerReviews: 83,
      imageUrls: [
        'https://images.unsplash.com/photo-1677443099247-8bb5e83dd78f?w=800',
        'https://images.unsplash.com/photo-1698426988694-60007eab1f85?w=800',
      ],
      location: 'New York, NY',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      condition: 'Like New',
    ),
    Product(
      id: 'p002',
      title: 'Vintage Leather Jacket',
      description:
          'Genuine leather jacket from the 90s. Size M. Brown color with beautiful worn-in patina. A true classic.',
      price: 120.00,
      category: 'Fashion',
      sellerId: 'user_003',
      sellerName: 'Marcus Chen',
      sellerRating: 4.7,
      sellerReviews: 41,
      imageUrls: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800',
        'https://images.unsplash.com/photo-1602810316693-3667c854239a?w=800',
      ],
      location: 'Los Angeles, CA',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      condition: 'Good',
    ),
    Product(
      id: 'p003',
      title: 'Sony WH-1000XM5 Headphones',
      description:
          'Industry-leading noise cancelling. Pristine condition with all accessories. Purchased 3 months ago.',
      price: 280.00,
      category: 'Electronics',
      sellerId: 'user_004',
      sellerName: 'Priya Sharma',
      sellerRating: 5.0,
      sellerReviews: 112,
      imageUrls: [
        'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=800',
      ],
      location: 'Chicago, IL',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      condition: 'Like New',
    ),
    Product(
      id: 'p004',
      title: 'Mountain Bike – Trek FX3',
      description:
          'Trek FX3 hybrid bike, size M. Perfect for city commuting. Recently serviced with new tires. Minor frame scratches.',
      price: 450.00,
      category: 'Sports',
      sellerId: 'user_005',
      sellerName: 'Jake Williams',
      sellerRating: 4.6,
      sellerReviews: 29,
      imageUrls: [
        'https://images.unsplash.com/photo-1558981852-426c349c87e2?w=800',
      ],
      location: 'Seattle, WA',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      condition: 'Good',
    ),
    Product(
      id: 'p005',
      title: 'IKEA Standing Desk',
      description:
          'Electric height-adjustable desk. Sits 2–5 ft. White color. Minor surface marks. Includes cable tray.',
      price: 200.00,
      category: 'Furniture',
      sellerId: 'user_006',
      sellerName: 'Emma Davis',
      sellerRating: 4.8,
      sellerReviews: 67,
      imageUrls: [
        'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=800',
      ],
      location: 'Austin, TX',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      condition: 'Good',
    ),
    Product(
      id: 'p006',
      title: 'MacBook Pro 14" M3',
      description:
          'M3 chip, 16GB RAM, 512GB SSD. AppleCare+ until 2026. Comes with charger. Perfect for developers and creatives.',
      price: 1600.00,
      category: 'Electronics',
      sellerId: 'user_007',
      sellerName: 'Nathan Lee',
      sellerRating: 4.9,
      sellerReviews: 95,
      imageUrls: [
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
      ],
      location: 'San Francisco, CA',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      condition: 'Excellent',
    ),
    Product(
      id: 'p007',
      title: 'Canon EOS R6 Camera',
      description:
          'Full-frame mirrorless. Includes 24-105mm lens, 2 batteries, charger, and camera bag. Shutter count: 8,200.',
      price: 1900.00,
      category: 'Electronics',
      sellerId: 'user_008',
      sellerName: 'Olivia Brown',
      sellerRating: 4.7,
      sellerReviews: 58,
      imageUrls: [
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800',
      ],
      location: 'Miami, FL',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      condition: 'Good',
    ),
    Product(
      id: 'p008',
      title: 'Yoga Mat – Manduka PRO',
      description:
          'Premium yoga mat in deep blue. 6mm thick, non-slip surface. Used for 6 months. Perfect condition.',
      price: 55.00,
      category: 'Sports',
      sellerId: 'user_009',
      sellerName: 'Zoe Martinez',
      sellerRating: 4.5,
      sellerReviews: 23,
      imageUrls: [
        'https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?w=800',
      ],
      location: 'Denver, CO',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      condition: 'Good',
    ),
  ];

  static final List<Review> reviews = [
    Review(
      id: 'r001',
      reviewerId: 'user_002',
      reviewerName: 'Sarah Mitchell',
      productId: 'p001',
      rating: 5.0,
      comment:
          'Excellent seller! Product was exactly as described. Fast shipping and great communication.',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Review(
      id: 'r002',
      reviewerId: 'user_003',
      reviewerName: 'Marcus Chen',
      productId: 'p001',
      rating: 4.5,
      comment:
          'Great deal! The item was in perfect condition. Would definitely buy from this seller again.',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Review(
      id: 'r003',
      reviewerId: 'user_004',
      reviewerName: 'Priya Sharma',
      productId: 'p002',
      rating: 5.0,
      comment:
          'Absolutely love this! The quality is outstanding and the seller was very responsive.',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Review(
      id: 'r004',
      reviewerId: 'user_005',
      reviewerName: 'Jake Williams',
      productId: 'p003',
      rating: 4.0,
      comment: 'Good product, minor issue with packaging but item was fine.',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  static final List<ChatRoom> chatRooms = [
    ChatRoom(
      id: 'chat_001',
      productId: 'p001',
      productTitle: 'iPhone 14 Pro Max',
      buyerId: currentUserId,
      buyerName: currentUserName,
      sellerId: 'user_002',
      sellerName: 'Sarah Mitchell',
      lastMessage: 'Is the price negotiable?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 2,
    ),
    ChatRoom(
      id: 'chat_002',
      productId: 'p003',
      productTitle: 'Sony WH-1000XM5',
      buyerId: currentUserId,
      buyerName: currentUserName,
      sellerId: 'user_004',
      sellerName: 'Priya Sharma',
      lastMessage: 'I can ship it tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
    ChatRoom(
      id: 'chat_003',
      productId: 'p006',
      productTitle: 'MacBook Pro 14" M3',
      buyerId: currentUserId,
      buyerName: currentUserName,
      sellerId: 'user_007',
      sellerName: 'Nathan Lee',
      lastMessage: 'Does it come with the charger?',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
  ];

  static final List<Map<String, ChatMessage>> chatMessages = [
    {
      'msg1': ChatMessage(
        id: 'msg_001',
        senderId: currentUserId,
        receiverId: 'user_002',
        content: 'Hi! Is this still available?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 45)),
        isRead: true,
      ),
      'msg2': ChatMessage(
        id: 'msg_002',
        senderId: 'user_002',
        receiverId: currentUserId,
        content: 'Yes, it is! Are you interested?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 40)),
        isRead: true,
      ),
      'msg3': ChatMessage(
        id: 'msg_003',
        senderId: currentUserId,
        receiverId: 'user_002',
        content: 'Is the price negotiable?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
      ),
    },
  ];

  static final List<Order> orders = [
    Order(
      id: 'ord_001',
      productId: 'p003',
      productTitle: 'Sony WH-1000XM5 Headphones',
      productImage:
          'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=800',
      amount: 280.00,
      buyerId: currentUserId,
      sellerId: 'user_004',
      sellerName: 'Priya Sharma',
      status: 'In Transit',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      trackingStep: 'shipped',
    ),
    Order(
      id: 'ord_002',
      productId: 'p008',
      productTitle: 'Yoga Mat – Manduka PRO',
      productImage:
          'https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?w=800',
      amount: 55.00,
      buyerId: currentUserId,
      sellerId: 'user_009',
      sellerName: 'Zoe Martinez',
      status: 'Delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      trackingStep: 'delivered',
    ),
  ];

  static final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Sports',
    'Furniture',
    'Books',
    'Vehicles',
    'Home & Garden',
  ];
}
