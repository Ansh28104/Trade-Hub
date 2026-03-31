
// ─────────────────────────────────────────
// Product Model
// ─────────────────────────────────────────
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final int sellerReviews;
  final List<String> imageUrls;
  final String location;
  final bool isAvailable;
  final DateTime createdAt;
  final String condition;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.sellerId,
    required this.sellerName,
    required this.sellerRating,
    required this.sellerReviews,
    required this.imageUrls,
    required this.location,
    this.isAvailable = true,
    required this.createdAt,
    required this.condition,
  });
}

// ─────────────────────────────────────────
// Review Model
// ─────────────────────────────────────────
class Review {
  final String id;
  final String reviewerId;
  final String reviewerName;
  final String productId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.reviewerId,
    required this.reviewerName,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

// ─────────────────────────────────────────
// Message Model
// ─────────────────────────────────────────
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentAt,
    this.isRead = false,
  });
}

// ─────────────────────────────────────────
// Chat Room Model
// ─────────────────────────────────────────
class ChatRoom {
  final String id;
  final String productId;
  final String productTitle;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String sellerName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatRoom({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    required this.sellerName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });
}

// ─────────────────────────────────────────
// Order Model
// ─────────────────────────────────────────
class Order {
  final String id;
  final String productId;
  final String productTitle;
  final String productImage;
  final double amount;
  final String buyerId;
  final String sellerId;
  final String sellerName;
  final String status;
  final DateTime createdAt;
  final String trackingStep;

  const Order({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.amount,
    required this.buyerId,
    required this.sellerId,
    required this.sellerName,
    required this.status,
    required this.createdAt,
    required this.trackingStep,
  });
}

// ─────────────────────────────────────────
// User Model
// ─────────────────────────────────────────
class AppUser {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final double rating;
  final int totalReviews;
  final int totalSales;
  final String memberSince;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.rating,
    required this.totalReviews,
    required this.totalSales,
    required this.memberSince,
  });
}
