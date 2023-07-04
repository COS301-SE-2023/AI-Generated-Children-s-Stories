package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


import org.springframework.stereotype.Service;

import com.fullstackfox.entities.Book;
import com.fullstackfox.repositories.BookRepository;
import com.fullstackfox.repositories.PageRepository;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final PageRepository pageRepository;

    public BookService(BookRepository bookRepository, PageRepository pageRepository) {
        this.bookRepository = bookRepository;
        this.pageRepository = pageRepository;
    }

    public Book create(Book task) {
        return bookRepository.save(task);
    }

     public List<Book> findAll() {
        List<Book> books = new ArrayList<>();
        bookRepository.findAll().forEach(books::add);

        return books;
    }

    public Optional<Book> findById(int id){
        return bookRepository.findById(id);
    }

    public void delete(int id){
        bookRepository.deleteById(id);
    }
    
}
