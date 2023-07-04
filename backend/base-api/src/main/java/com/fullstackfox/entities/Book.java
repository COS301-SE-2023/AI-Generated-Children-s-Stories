package com.fullstackfox.entities;
import java.util.Set;

import jakarta.persistence.*;


@Table(name = "books")
@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private Integer bookId;

    @OneToMany(mappedBy = "book")
    Set<UserBook> personalLibary;

    @Column(unique = true, nullable = false)
    private String title;

    @Column(unique = false, nullable = false)
    private int size;

    @Column()
    private String trailer;

    @OneToMany(mappedBy = "book")
    private Set<Page> pages;
}
