import 'package:animation_list/animation_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductReviewsScreen extends StatefulWidget {
  final String productId;
  ProductReviewsScreen({required this.productId});

  @override
  _ProductReviewsScreenState createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 5;

  void _submitReview() async {
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.review_snackbar),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance.collection('reviews').add({
        'productId': widget.productId,
        'userId': user.uid,
        'review': _reviewController.text,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _reviewController.clear();
      setState(() {});
    }
  }

  Future<double> _calculateAverageRating() async {
    QuerySnapshot reviewsSnapshot =
        await FirebaseFirestore.instance
            .collection('reviews')
            .where('productId', isEqualTo: widget.productId)
            .get();
    if (reviewsSnapshot.docs.isEmpty) return 0.0;
    double totalRating = 0;
    for (var doc in reviewsSnapshot.docs) {
      totalRating += doc['rating'];
    }
    return totalRating / reviewsSnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.rating_reviews,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<double>(
            future: _calculateAverageRating(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SpinKitCircle(color: Colors.black, size: 40);
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  AppLocalizations.of(context)!.customer_review +
                      snapshot.data!.toStringAsFixed(1) +
                      " ⭐",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance
                      .collection('reviews')
                      .where('productId', isEqualTo: widget.productId)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: SpinKitCircle(color: Colors.black, size: 40),);
                }
                return AnimationList(
                  animationDirection: AnimationDirection.vertical,
                  duration: 1000,
                  reBounceDepth: 10.0,
                  children:
                      snapshot.data!.docs.map((doc) {
                        return _buildTile(
                          doc['review'],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              doc['rating'],
                              (index) => Icon(Icons.star, color: Colors.amber),
                            ),
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextField(
                    controller: _reviewController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: AppLocalizations.of(context)!.write_a_review,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppLocalizations.of(context)!.rating),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(color: Colors.black),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String title, Widget row) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            row,
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
