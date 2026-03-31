import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─────────────────────────────────────────
  // PRODUCT OPERATIONS
  // ─────────────────────────────────────────

  // Get all products (stream)
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => _productFromFirestore(doc)).toList();
    });
  }

  // Create a new listing
  Future<void> addProduct(Product product) async {
    await _db.collection('products').add({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'category': product.category,
      'sellerId': product.sellerId,
      'sellerName': product.sellerName,
      'sellerRating': product.sellerRating,
      'sellerReviews': product.sellerReviews,
      'imageUrls': product.imageUrls,
      'location': product.location,
      'condition': product.condition,
      'createdAt': FieldValue.serverTimestamp(),
      'isAvailable': true,
    });
  }

  // ─────────────────────────────────────────
  // CHAT OPERATIONS
  // ─────────────────────────────────────────

  // Get chat rooms for current user
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _db
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => _chatRoomFromFirestore(doc)).toList();
    });
  }

  // Sending a message
  Future<void> sendMessage(String chatId, ChatMessage message) async {
    await _db.collection('chats').doc(chatId).collection('messages').add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'content': message.content,
      'sentAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // Update last message in chat room
    await _db.collection('chats').doc(chatId).update({
      'lastMessage': message.content,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }

  // ─────────────────────────────────────────
  // MAPPING METHODS
  // ─────────────────────────────────────────

  Product _productFromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final rawImageUrls = data['imageUrls'];
    List<String> imageUrls = [];
    if (rawImageUrls is List) {
      imageUrls = List<String>.from(rawImageUrls);
    } else if (rawImageUrls is String) {
      imageUrls = [rawImageUrls];
    }
    
    return Product(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      category: data['category'] ?? '',
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      sellerRating: (data['sellerRating'] ?? 0.0).toDouble(),
      sellerReviews: data['sellerReviews'] ?? 0,
      imageUrls: imageUrls,
      location: data['location'] ?? '',
      condition: data['condition'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  ChatRoom _chatRoomFromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      productId: data['productId'] ?? '',
      productTitle: data['productTitle'] ?? '',
      buyerId: data['buyerId'] ?? '',
      buyerName: data['buyerName'] ?? '',
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
