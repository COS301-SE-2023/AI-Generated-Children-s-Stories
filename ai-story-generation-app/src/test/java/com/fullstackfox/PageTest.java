package com.fullstackfox;

import org.junit.Test;

import static org.junit.jupiter.api.Assertions.*;

public class PageTest {
    @Test
    public void testPageContentAndImageUrl() {
        String content = "Test Content";
        String imageUrl = "https://example.com/image.jpg";
        Page page = new Page(content, imageUrl);

        // Test getContent() method
        assertEquals(content, page.getContent());

        // Test getImageUrl() method
        assertEquals(imageUrl, page.getImageUrl());
    }

}