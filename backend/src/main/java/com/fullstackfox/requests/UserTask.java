package com.fullstackfox.requests;



import com.fullstackfox.entities.User;


public record UserTask(String email, String username, Integer age) {

    public User register(){
        User user = new User();

        user.setEmail(email);
        user.setAge(age);
        user.setUsername(username);

        return user;
    }
}
