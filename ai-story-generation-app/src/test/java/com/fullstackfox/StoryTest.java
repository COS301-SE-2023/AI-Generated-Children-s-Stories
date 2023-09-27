package com.fullstackfox;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class StoryTest {

    @Test
    void getInstance() {
        Story instance1 = Story.getInstance();
        Story instance2 = Story.getInstance();

        assertSame(instance1, instance2);
    }

    @Test
    void getTitle() {
        Story.setTitle("Test Title");
        assertEquals("Test Title", Story.getTitle());
    }

    @Test
    void setTitle() {
        Story.setTitle("Test Title");
        assertEquals("Test Title", Story.getTitle());
    }

    @Test
    void getTrailer() {
        Story.setTrailer("Test Trailer");
        assertEquals("Test Trailer", Story.getTrailer());
    }

    @Test
    void setTrailer() {
        Story.setTrailer("Test Trailer");
        assertEquals("Test Trailer", Story.getTrailer());
    }

    @Test
    void getPages() {
        Page page = new Page("content", "url");
        Story.addPage(page);

        ArrayList<Page> pages = Story.getPages();
        assertEquals(1, Story.getNumPages());
        assertEquals(page, pages.get(0));
    }

    @Test
    void getNumPages() {
        Page page = new Page("content", "url");
        Story.addPage(page);

        ArrayList<Page> pages = Story.getPages();
        assertEquals(1, Story.getNumPages());
        assertEquals(page, pages.get(0));
    }

    @Test
    void addPage() {
        Page page = new Page("content", "url");
        Story.addPage(page);

        ArrayList<Page> pages = Story.getPages();
        assertEquals(1, Story.getNumPages());
        assertEquals(page, pages.get(0));
    }
}