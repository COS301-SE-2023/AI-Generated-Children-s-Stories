package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.fullstackfox.entities.Book;
import com.fullstackfox.entities.Page;
import com.fullstackfox.entities.UserBook;
import com.fullstackfox.repositories.BookRepository;
import com.fullstackfox.repositories.PageRepository;
import com.fullstackfox.repositories.UserBookRepository;

@Service
public class PageService {

    private final PageRepository pageRepository;


    public PageService(PageRepository pageRepository) {
        this.pageRepository = pageRepository;
    }

    public Page create(Page task) {
        return pageRepository.save(task);
    }

    //  public List<Book> findAll() {
    //     List<Page> books = new ArrayList<>();
    //     pageRepository.findAll().forEach(books::add);

    //     return books;
    // }

    // public Optional<Book> findById(int id){
    //     return bookRepository.findById(id);
    // }

    // public void delete(int id){
    //     bookRepository.deleteById(id);
    // }

    // public List<Book> getBooksByUserId(int userId) {
    //     List<UserBook> userBooks = userService.getUserBookByUserId(userId);
    //     return userBooks.stream()
    //             .map(UserBook::getBook)
    //             .collect(Collectors.toList());
    // }
    
}
