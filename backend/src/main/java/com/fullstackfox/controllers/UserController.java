package com.fullstackfox.controllers;

import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.config.Task;
import org.springframework.web.bind.annotation.*;

import com.fullstackfox.entities.User;
import com.fullstackfox.requests.UserTask;

import com.fullstackfox.services.UserService;

@RestController
@RequestMapping("/user")
public class UserController {
    public UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

    @PostMapping("")
    public ResponseEntity<User> registerUser(@RequestBody UserTask userTask){
        User userCreated = userService.create(userTask.register());

        return new ResponseEntity<>(userCreated, HttpStatus.CREATED);
    }

    @GetMapping("{id}")
    public ResponseEntity<User> getUser(@PathVariable int id) {
        Optional<User> optionalTask = userService.findById(id);
        
        if (optionalTask.isPresent()) {
            return new ResponseEntity<>(optionalTask.get(), HttpStatus.OK);
        }

        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
    
    
}
