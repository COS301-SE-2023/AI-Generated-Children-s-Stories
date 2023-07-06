package com.fullstackfox.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.fullstackfox.entities.User;
import com.fullstackfox.entities.UserBook;

public interface UserBookRepository extends CrudRepository<UserBook, Integer>  {
    List<UserBook> findByUser(Optional<User> user);
}
