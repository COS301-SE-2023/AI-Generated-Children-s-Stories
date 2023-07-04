package com.fullstackfox.repositories;

import org.springframework.data.repository.CrudRepository;

import com.fullstackfox.entities.User;

public interface UserRepository extends CrudRepository<User,Integer>  {


}
