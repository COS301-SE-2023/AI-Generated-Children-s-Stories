package com.fullstackfox.controllers;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.Set;

import com.fullstackfox.services.BookService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.config.Task;
import org.springframework.web.bind.annotation.*;

import com.fullstackfox.entities.Book;
import com.fullstackfox.entities.UserBook;
import com.fullstackfox.requests.BookTask;
import com.fullstackfox.requests.UserBookTask;
import com.fullstackfox.services.BookService;

@RestController
@RequestMapping("/book")
public class BookController {
    public BookService bookService;

    public BookController(BookService bookService){
        this.bookService = bookService;
    }

    // @PostMapping("")
    // public ResponseEntity<Book> uploadBook(@RequestBody UserBookTask bookTask){

    //     Book bookCreated = bookService.create(bookTask.register());

    //     return new ResponseEntity<>(bookCreated, HttpStatus.CREATED);
    // }

    @PostMapping("")
    public ResponseEntity<Book> uploadBook(@RequestBody BookTask bookTask){
        Book bookCreated = bookService.create(bookTask.register());

        return new ResponseEntity<>(bookCreated, HttpStatus.CREATED);
    }

    @GetMapping("")
    public ResponseEntity<List<Book>> getRandomBooks() {
        List<Book> allBooks = bookService.findAll(); // Retrieve all books from your data source
        
        // Check if the number of available books is less than 10
        if (allBooks.size() <= 10) {
            return ResponseEntity.ok(allBooks); // Return all available books
        }
        
        // Select 10 random books
        Random random = new Random();
        List<Book> randomBooks = new ArrayList<>();
        Set<Integer> selectedIndices = new HashSet<>();
        
        while (randomBooks.size() < 10) {
            int randomIndex = random.nextInt(allBooks.size());
            
            // Ensure the same book is not selected multiple times
            if (!selectedIndices.contains(randomIndex)) {
                selectedIndices.add(randomIndex);
                randomBooks.add(allBooks.get(randomIndex));
            }
        }
        
        return ResponseEntity.ok(randomBooks);
    }

    @GetMapping("{id}")
    public ResponseEntity<Book> getBookById(@PathVariable(required = false) int id) {
        Optional<Book> optionalTask = bookService.findById(id);
        
        if (optionalTask.isPresent()) {
            return new ResponseEntity<>(optionalTask.get(), HttpStatus.OK);
        }

        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @GetMapping("/{userId}")
    public ResponseEntity<List<Book>> getBooksByUserId(@PathVariable int userId) {
        List<Book> books = bookService.getBooksByUserId(userId);
        if (books.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(books);
    }


}
