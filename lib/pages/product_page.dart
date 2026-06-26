import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';
import '../data/product_data.dart';
import '../widgets/product_card.dart';
import '../widgets/category_button.dart';
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedIndex = 0;
  int currentNavIndex = 0;

  List<CartItem> cartItems = [];
  Set<Product> favorites = {};

  List<Product> get filteredProducts { 
    if(selectedIndex == 1) { 
      return products
      .where((p) => p.category == "Rifles")
      .toList();
    } else if(selectedIndex == 2) {
      return products
      .where((p) => p.category == "Sniper Rifles")
      .toList();
    } else if(selectedIndex == 3) {
      return products
      .where((p) => p.category == "Heavy Weapons")
      .toList();
    } 
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alolod E-Commerse Shop"),
      ),
      body: currentNavIndex == 0 ? buildHome() : (currentNavIndex == 1 ? buildFavorites() : buildCart()), //modified

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavIndex,
        onTap: (index) { 
          setState(() { 
            currentNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart", //di ko kabalo atong mugawas nga number sa icon huhu 
          ),
         
        ],
      ),
    );
  }

    Widget buildHome() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryButton(
              title: "All",
              isSelected: selectedIndex == 0,
              onTap: () { 
                setState((){ 
                  selectedIndex = 0;
                });
              }
            ),

            CategoryButton(
              title: "Rifles",
              isSelected: selectedIndex == 1,
              onTap: () { 
                setState(() { 
                  selectedIndex = 1;
                });
              },
            ),

            CategoryButton(
              title: "Sniper Rifles",
              isSelected: selectedIndex == 2,
              onTap: () { 
                setState(() { 
                  selectedIndex = 2;
                });
              },
            ),
            
             CategoryButton(
              title: "Heavy Weapons",
              isSelected: selectedIndex == 3,
              onTap: () { 
                setState(() { 
                  selectedIndex = 3;
                });
              },
            ),
          ],
        ),

        Expanded( 
          child: GridView.builder(
            itemCount: filteredProducts.length,
            gridDelegate:
               const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            
            itemBuilder: (context, index) { 
              Product product = filteredProducts[index];

              return ProductCard(
                product: product,
                isFavorite: favorites.contains(product),
                onFavorite: () { 
                  setState(() { 
                    if(favorites.contains(product)) { 
                      favorites.remove(product);
                    } else { 
                      favorites.add(product);
                    }
                 });
                },
                //add to cart feature 
                onAddToCart: () {
                  setState(() {
                    final existingItem = cartItems.firstWhere(
                      (item) => item.product.weapon == product.weapon,
                      orElse: () => CartItem(product: product),
                    );
                    if (cartItems.contains(existingItem)) {
                      existingItem.quantity++;
                    } else {
                      cartItems.add(existingItem);
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.weapon} added to cart')),
                  );
                },
              );
            },

          ),
        ),
      ],

    );
  }

  Widget  buildFavorites() { 
    if (favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet'),
      );
    } // Only added this condition so if empty, won't look blank :>

    return GridView.builder( 
      itemCount: favorites.length,
      gridDelegate: 
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, index) { 
        Product product = favorites.elementAt(index);

        return ProductCard(
          product: product,
          isFavorite: true,
          onFavorite: () { 
            setState(() { 
              favorites.remove(product);
            });
          },
        );
      }


    );
  }
  //for cart 
  Widget buildCart() {
    return CartPage(
      cartItems: cartItems,
      onCartUpdated: (updatedCart) {
        setState(() {
          cartItems = updatedCart;
        });
      },
    );
  }

}

