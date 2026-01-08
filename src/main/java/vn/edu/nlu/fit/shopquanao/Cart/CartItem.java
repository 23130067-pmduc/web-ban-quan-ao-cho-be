package vn.edu.nlu.fit.shopquanao.Cart;

import vn.edu.nlu.fit.shopquanao.model.Product;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int Quantity;
    private double price;
    private Product product;

    public CartItem(int Quantity, double price, Product product) {
        this.Quantity = Quantity;
        this.price = price;
        this.product = product;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int quantity) {
        Quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public CartItem(){

    }
    public void updateQuantity(int Quantity){
        this.Quantity += Quantity;
    }
}