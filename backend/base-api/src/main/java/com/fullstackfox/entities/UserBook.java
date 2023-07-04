package com.fullstackfox.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.*;

@Entity
public class UserBook {
    @EmbeddedId
    UserBookKey id;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name="user_id")
    User user;

    @ManyToOne
    @MapsId("bookId")
    @JoinColumn(name="book_id")
    Book book;

    boolean favorite;

    Integer currentPage;
}
