package com.fullstackfox.entities;

import java.util.Set;

import jakarta.persistence.*;
import jakarta.persistence.Id;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

@Table(name = "users")
@Entity

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(nullable = false)
    private Integer userId;

    @OneToMany(mappedBy = "user")
    Set<UserBook> personalLibary;

    @Getter @Setter
    @Column(unique = true, length = 200, nullable = true)
    private String username;

    @Getter @Setter
    @Column(unique = true, length = 200, nullable = false)
    private String email;

    @Getter @Setter
    @Column(unique = false, nullable = true)
    private Integer age;

}
