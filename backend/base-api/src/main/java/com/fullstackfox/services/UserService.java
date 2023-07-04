package com.fullstackfox.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fullstackfox.entities.User;
import com.fullstackfox.repositories.UserRepository;

@Service
public class UserService {
    @Autowired
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User create(User task) {
        return userRepository.save(task);
    }

    public Optional<User> findById(int id){
        return userRepository.findById(id);
    }

    public void delete(int id){
        userRepository.deleteById(id);
    }
    
}
