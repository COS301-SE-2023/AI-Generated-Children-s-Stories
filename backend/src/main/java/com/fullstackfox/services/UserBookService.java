package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


import org.springframework.stereotype.Service;

import com.fullstackfox.entities.User;
import com.fullstackfox.entities.UserBook;
import com.fullstackfox.repositories.BookRepository;
import com.fullstackfox.repositories.UserBookRepository;
import com.fullstackfox.repositories.UserRepository;

@Service
public class UserBookService {

    private final UserBookRepository userbookRepository;
    private final UserRepository userRepository;

    public UserBookService(UserBookRepository userbookRepository, UserRepository userRepository) {
        this.userbookRepository = userbookRepository;
        this.userRepository = userRepository;
    }

    public List<UserBook> getUserBookByUserId(int userId) {
        // Implementation to retrieve UserBook from the data source based on userId
        Optional<User> user = userRepository.findById(userId);
        if(!user.isEmpty()){
            return null;
        }
        List<UserBook> userBooks = userbookRepository.findByUser(user);
        if (userBooks.isEmpty()){
            return null;
        }
        return userBooks;
    }

    public UserBook create(UserBook task) {
        return userbookRepository.save(task);
    }

    public void delete(int id){
        userbookRepository.deleteById(id);
    }
    
}
