package com.fullstackfox.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
public class UserBook {
    @EmbeddedId
    UserBookKey id;

    @Getter @Setter
    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name="user_id")
    User user;

    @Getter @Setter
    @ManyToOne
    @MapsId("bookId")
    @JoinColumn(name="book_id")
    Book book;

    @Getter @Setter
    boolean favorite;

    @Getter @Setter
    Integer currentPage;
}
