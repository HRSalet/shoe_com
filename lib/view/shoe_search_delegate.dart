// import 'package:flutter/material.dart';
//
// import '../../../../models/shoe_model.dart';
// import '../../../view/detail/detail_screen.dart';
//
// class ShoeSearchDelegate extends SearchDelegate<Product?> {
//   // Combine all shoe lists into one
//   final List<Product> allShoes = [];
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = ''; // Clear the search query
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null); // Close the search
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List<Product> results =
//         allShoes
//             .where(
//               (shoe) =>
//                   shoe.name.toLowerCase().contains(query.toLowerCase()) ||
//                   shoe.model.toLowerCase().contains(query.toLowerCase()),
//             )
//             .toList();
//
//     if (results.isEmpty) {
//       return Center(child: Text("No results found"));
//     }
//
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         Product shoe = results[index];
//         return ListTile(
//           title: Text(shoe.name),
//           subtitle: Text(shoe.model),
//           leading: Image.asset(shoe.imgAddress, width: 50, height: 50),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder:
//                     (ctx) => DetailScreen(
//                       productModel: shoe,
//                       isComeFromMoreSection: false,
//                     ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.isEmpty) {
//       return Center(child: Text("Type to search for shoes..."));
//     }
//     return buildResults(context);
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../models/shoe_model.dart';
import '../../../view/detail/detail_screen.dart';

class ShoeSearchDelegate extends SearchDelegate<Product?> {
  List<Product> allShoes = [];
  bool isLoading = false;
  bool hasError = false;

  List<String> categories = [
    "Nike",
    "Adidas",
    "Bata",
    "Reebok",
    "Puma",
    "Campus",
    "Woodland",
    "Reebok",
  ];

  // ✅ Fetch shoes based on user input (not just category)
  void fetchShoes(String query) async {
    if (query.isEmpty) return; // Avoid unnecessary API calls

    isLoading = true;
    hasError = false; // Force UI update

    final url = Uri.parse(
      "http://192.168.0.103/shoe_hive_db/index.php?query=$query",
    );

    try {
      final response = await http.get(url);
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        allShoes = data.map((json) => Product.fromJson(json)).toList();

        print("Shoes Loaded: ${allShoes.length}");

        isLoading = false;
        hasError = false;
      } else {
        print("Failed to load shoes: ${response.statusCode}");
        hasError = true;
      }
    } catch (e) {
      print("Error fetching shoes: $e");
      hasError = true;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          allShoes.clear();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(child: Text("Failed to load products"));
    }

    if (allShoes.isEmpty) {
      return Center(child: Text("No results found"));
    }

    return ListView.builder(
      itemCount: allShoes.length,
      itemBuilder: (context, index) {
        Product shoe = allShoes[index];
        return ListTile(
          title: Text(shoe.name),
          subtitle: Text(shoe.model),
          leading: Image.network(shoe.imgAddress, width: 50, height: 50),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) => DetailScreen(
                      productModel: shoe,
                      isComeFromMoreSection: false,
                    ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    fetchShoes(query); // ✅ Fetch products based on query
    return buildResults(context);
  }
}
