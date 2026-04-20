package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ContactProperty {

    @Value("${contact.name}")
    private String name;

    @Value("${contact.email}")
    private String email;

    @Value("${contact.phone}")
    private String phone;

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }
}

