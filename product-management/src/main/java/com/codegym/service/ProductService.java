package com.codegym.service;

import com.codegym.model.Product;
import java.util.List;

/** Giao dien cho viec quan ly va tra cuu san pham. */
public interface ProductService {
    List<Product> findAll();
    List<Product> searchByName(String keyword);
    Product findById(int id);
    Product save(Product product);
    boolean update(int id, Product product);
    boolean remove(int id);
}
