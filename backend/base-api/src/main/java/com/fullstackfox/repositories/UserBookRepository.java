package com.fullstackfox.repositories;

import org.springframework.data.repository.CrudRepository;

import com.fullstackfox.entities.UserBook;

public interface UserBookRepository extends CrudRepository<UserBook, Integer>  {
    
}
