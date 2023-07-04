package com.fullstackfox.entities;

import jakarta.persistence.*;

@Table(name = "pages")
@Entity
public class Page {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private Integer pageId;

    @Column()
    private String image;
    
    @Column()
    private String text;

    @Column()
    private Integer pageNumber;

    @ManyToOne
    @JoinColumn(name="book_id")
    private Book book;

}
