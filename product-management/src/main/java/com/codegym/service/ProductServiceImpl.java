package com.codegym.service;

import com.codegym.model.Product;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * Cài đặt Service lưu dữ liệu mẫu trên Map (không dùng CSDL).
 * Dữ liệu được khởi tạo lại khi ứng dụng khởi động lại.
 */
public class ProductServiceImpl implements ProductService {
    private static final Map<Integer, Product> PRODUCTS = new ConcurrentHashMap<>();
    private static final AtomicInteger NEXT_ID = new AtomicInteger(5);

    static {
        PRODUCTS.put(1, new Product(1, "Laptop Dell Inspiron", new BigDecimal("15990000"), "Laptop phục vụ học tập và làm việc", "Dell"));
        PRODUCTS.put(2, new Product(2, "Chuột Logitech M331", new BigDecimal("320000"), "Chuột không dây yên tĩnh", "Logitech"));
        PRODUCTS.put(3, new Product(3, "Bàn phím cơ AKKO", new BigDecimal("1290000"), "Bàn phím cơ cho lập trình", "AKKO"));
        PRODUCTS.put(4, new Product(4, "Màn hình Samsung 24 inch", new BigDecimal("2890000"), "Màn hình Full HD", "Samsung"));
        PRODUCTS.put(5, new Product(5, "Tai nghe Sony", new BigDecimal("790000"), "Tai nghe chụp tai", "Sony"));
    }

    private Product copy(Product product) {
        return new Product(product.getId(), product.getName(), product.getPrice(),
                product.getDescription(), product.getManufacturer());
    }

    @Override
    public List<Product> findAll() {
        List<Product> result = new ArrayList<>();
        for (Product product : PRODUCTS.values()) {
            result.add(copy(product));
        }
        result.sort(Comparator.comparingInt(Product::getId));
        return result;
    }

    @Override
    public List<Product> searchByName(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return findAll();
        }
        String query = keyword.strip().toLowerCase(Locale.ROOT);
        return findAll().stream()
                .filter(p -> p.getName().toLowerCase(Locale.ROOT).contains(query))
                .collect(Collectors.toList());
    }

    @Override
    public Product findById(int id) {
        Product product = PRODUCTS.get(id);
        return product == null ? null : copy(product);
    }

    @Override
    public Product save(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Sản phẩm không hợp lệ.");
        }
        int id = NEXT_ID.incrementAndGet();
        Product saved = new Product(id, product.getName(), product.getPrice(),
                product.getDescription(), product.getManufacturer());
        PRODUCTS.put(id, saved);
        return copy(saved);
    }

    @Override
    public boolean update(int id, Product product) {
        if (product == null || id <= 0) {
            return false;
        }
        Product replacement = new Product(id, product.getName(), product.getPrice(),
                product.getDescription(), product.getManufacturer());
        return PRODUCTS.replace(id, replacement) != null;
    }

    @Override
    public boolean remove(int id) {
        return PRODUCTS.remove(id) != null;
    }
}
