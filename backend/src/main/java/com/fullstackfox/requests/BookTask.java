package com.fullstackfox.requests;



import java.util.Set;

import com.fullstackfox.entities.Book;
import com.fullstackfox.entities.Page;


public record BookTask(String title, Integer size, String trailer, Set<Page> pages) {

    public Book register(){
        Book book = new Book();

        book.setTitle(title);
        if(pages.size() == 0){
            book.setPages(null);
        }
        else {
            book.setPages(pages);
        }
        
        book.setSize(size);
        book.setTrailer(trailer);
        

        return book;
    }
}
