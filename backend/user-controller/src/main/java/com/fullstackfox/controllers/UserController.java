package com.fullstackfox.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @PostMapping("/register")
    public ResponseEntity<User> registerUser(@RequestBody UserTask userTask){
        User userCreated = userService.create(userTask.register());

        return new ResponseEntity<>(userCreated, HttpStatus.CREATED);
    }

    
}
