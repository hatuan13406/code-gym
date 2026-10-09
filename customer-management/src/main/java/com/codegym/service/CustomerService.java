package com.codegym.service;

import com.codegym.model.Customer;
import java.util.List;

/** Định nghĩa các thao tác quản lý thông tin khách hàng. */
public interface CustomerService {
    List<Customer> findAll();
    void save(Customer customer);
    Customer findById(int id);
    void update(int id, Customer customer);
    void remove(int id);
}
