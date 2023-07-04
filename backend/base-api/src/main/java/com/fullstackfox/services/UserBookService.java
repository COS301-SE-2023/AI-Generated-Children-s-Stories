package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


import org.springframework.stereotype.Service;

import com.fullstackfox.entities.UserBook;
import com.fullstackfox.repositories.BookRepository;
import com.fullstackfox.repositories.UserBookRepository;

@Service
public class UserBookService {

    private final UserBookRepository userbookRepository;

    public UserBookService(UserBookRepository userbookRepository) {
        this.userbookRepository = userbookRepository;
    }

    public UserBook create(UserBook task) {
        return userbookRepository.save(task);
    }

    public void delete(int id){
        userbookRepository.deleteById(id);
    }
    
}
