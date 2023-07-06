package com.fullstackfox.repositories;

import org.springframework.data.repository.CrudRepository;

import com.fullstackfox.entities.Book;

public interface BookRepository extends CrudRepository<Book, Integer>  {
    
}
