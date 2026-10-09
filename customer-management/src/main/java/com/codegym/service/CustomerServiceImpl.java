package com.codegym.service;

import com.codegym.model.Customer;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Kho dữ liệu khách hàng giả lập bằng Map trong bộ nhớ.
 * Dữ liệu sẽ được khởi tạo lại khi máy chủ khởi động lại.
 */
public class CustomerServiceImpl implements CustomerService {
    private static final Map<Integer, Customer> CUSTOMERS = new ConcurrentHashMap<>();
    private static final AtomicInteger NEXT_ID = new AtomicInteger(5);

    static {
        CUSTOMERS.put(1, new Customer(1, "John", "john@codegym.vn", "Hanoi"));
        CUSTOMERS.put(2, new Customer(2, "Bill", "bill@codegym.vn", "Danang"));
        CUSTOMERS.put(3, new Customer(3, "Alex", "alex@codegym.vn", "Saigon"));
        CUSTOMERS.put(4, new Customer(4, "Adam", "adam@codegym.vn", "Beijing"));
        CUSTOMERS.put(5, new Customer(5, "Sophia", "sophia@codegym.vn", "Miami"));
    }

    @Override
    public List<Customer> findAll() {
        List<Customer> result = new ArrayList<>(CUSTOMERS.values());
        result.sort(Comparator.comparingInt(Customer::getId));
        return result;
    }

    @Override
    public void save(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Khách hàng không hợp lệ.");
        }
        if (customer.getId() <= 0) {
            customer.setId(NEXT_ID.incrementAndGet());
        }
        CUSTOMERS.put(customer.getId(), customer);
    }

    @Override
    public Customer findById(int id) {
        return CUSTOMERS.get(id);
    }

    @Override
    public void update(int id, Customer customer) {
        if (customer == null || !CUSTOMERS.containsKey(id)) {
            throw new IllegalArgumentException("Không tìm thấy khách hàng.");
        }
        CUSTOMERS.put(id, new Customer(id, customer.getName(), customer.getEmail(), customer.getAddress()));
    }

    @Override
    public void remove(int id) {
        CUSTOMERS.remove(id);
    }
}
