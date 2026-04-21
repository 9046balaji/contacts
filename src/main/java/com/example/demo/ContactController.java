package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ContactController {

    private final ContactProperty contactProperty;

    public ContactController(ContactProperty contactProperty) {
        this.contactProperty = contactProperty;
    }

    @GetMapping("/contact")
    public Contact getContact() {
        return new Contact(contactProperty.getPhone(), contactProperty.getEmail());
    }
}
