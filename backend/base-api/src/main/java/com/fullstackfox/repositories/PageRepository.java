package com.fullstackfox.repositories;

import org.springframework.data.repository.CrudRepository;

import com.fullstackfox.entities.Page;

public interface PageRepository extends CrudRepository<Page, Integer>  {
    
}
