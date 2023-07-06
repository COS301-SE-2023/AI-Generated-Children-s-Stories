package com.fullstackfox.requests;

import java.util.Set;

import com.fullstackfox.entities.User;
import com.fullstackfox.entities.UserBook;
import com.fullstackfox.entities.Book;
import com.fullstackfox.entities.Page;

public record UserBookTask(Integer userId, Integer bookId, Boolean favourite, Integer currentPage) {
    public UserBook createRelation(Book book, User user){
        UserBook ubRelation = new UserBook();

        ubRelation.setBook(book);
        ubRelation.setUser(user);
        ubRelation.setCurrentPage(currentPage);
        ubRelation.setFavorite(favourite);

        return ubRelation;
    }
}
