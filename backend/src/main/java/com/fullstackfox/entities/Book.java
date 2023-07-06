package com.fullstackfox.entities;
import java.util.Set;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Table(name = "books")
@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private Integer bookId;

    @OneToMany(mappedBy = "book")
    Set<UserBook> personalLibary;

    @Getter @Setter
    @Column(unique = true, nullable = false)
    private String title;

    @Getter @Setter
    @Column(unique = false, nullable = false)
    private int size;

    @Getter @Setter
    @Column()
    private String trailer;

    @Getter @Setter
    @OneToMany(mappedBy = "book")
    private Set<Page> pages;
}
