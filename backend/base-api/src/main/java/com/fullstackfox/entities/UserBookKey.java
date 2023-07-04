package com.fullstackfox.entities;

import java.io.Serializable;

import jakarta.persistence.*;

@Embeddable
public class UserBookKey  implements Serializable{
    @Column(name = "user_id")
    Integer userId;

    @Column(name = "book_id")
    Integer bookId;
}
