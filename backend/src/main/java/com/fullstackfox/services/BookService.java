package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.fullstackfox.entities.Book;
import com.fullstackfox.entities.UserBook;
import com.fullstackfox.repositories.BookRepository;
import com.fullstackfox.repositories.PageRepository;
import com.fullstackfox.repositories.UserBookRepository;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final PageService pageService;
    private final UserBookService userService;

    public BookService(BookRepository bookRepository, PageService  pageService, UserBookService userService) {
        this.bookRepository = bookRepository;
        this. pageService= pageService;
        this.userService = userService;
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

    public List<Book> getBooksByUserId(int userId) {
        List<UserBook> userBooks = userService.getUserBookByUserId(userId);
        if (userBooks.isEmpty()) {
            return null;
        }
        return userBooks.stream()
                .map(UserBook::getBook)
                .collect(Collectors.toList());
    }
    
}
