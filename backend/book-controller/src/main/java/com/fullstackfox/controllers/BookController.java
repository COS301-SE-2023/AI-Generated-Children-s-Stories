package com.fullstackfox.controllers;

import com.fullstackfox.services.BookService;
import org.springframework.web.bind.annotation.RestController;

public class BookController {
    public BookService bookService;

    public BookController(BookService bookService){
        this.bookService = bookService;
    }
}
