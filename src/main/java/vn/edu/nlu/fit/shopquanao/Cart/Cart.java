package vn.edu.nlu.fit.shopquanao.Cart;

import vn.edu.nlu.fit.shopquanao.model.Product;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
    Map<Integer, CartItem> data;
    private User user;

    public Cart() {
        data = new HashMap<>();
    }

    public void addItem(Product product, int quantity){
        if(quantity <= 0){quantity=1;}
        if(get(product.getId())!=null)
            data.get(product.getId()).updateQuantity(quantity);
        else
            data.put(product.getId(), new CartItem(quantity, product.getPrice(), product));
    }

    public boolean updateItem(int productId, int quantity){
        if(get(productId)==null) return false;
        if(quantity <= 0) quantity = 1;
        data.get(productId).setQuantity(quantity);
        return true;
    }

    public CartItem removeItem(int productId){
        if(get(productId)==null) return null;
        return data.remove(productId);
    }

    public List<CartItem> removeAllItems(){
        ArrayList<CartItem> cartItems = new ArrayList<>();
        data.clear();
        return cartItems;
    }

    public  List<CartItem> getItems(){
        return new  ArrayList<>(data.values());
    }

    public CartItem get(int id) {
        return data.get(id);
    }

    public int getTotalQuantity(){
        AtomicInteger total = new AtomicInteger();
        getItems().forEach(item->{
            total.addAndGet(item.getQuantity());});
        return total.get();
    }

    public double total() {
        AtomicReference<Double> total = new AtomicReference<>((double) 0);
        getItems().forEach(item->{
            total.updateAndGet(v -> v.doubleValue() + (item.getPrice()*item.getQuantity()));
        });
        return total.get();
    }

    public void updateCustomer(User user){
        this.user = user;
    }

}