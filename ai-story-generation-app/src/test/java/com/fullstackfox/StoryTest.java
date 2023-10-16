package com.fullstackfox;

import org.junit.Before;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class StoryTest {

        private Story story;

        @Before
        public void setUp() {
            // Initialize a new Story object before each test case
            story = new Story();
            // Reset static variables for each test
            Story.setInstance(null);
            Story.setTitle(null);
            Story.setTrailer(null);
            Story.getPages().clear();
            Story.setNumPages(0);
        }

        @Test
        public void testGetInstance() {
            Story instance1 = Story.getInstance();
            Story instance2 = Story.getInstance();
            assertSame(instance1, instance2);
        }

        @Test
        public void testSetTitle() {
            Story.setTitle("Test Title");
            assertEquals("Test Title", Story.getTitle());
        }

        @Test
        public void testSetTrailer() {
            Story.setTrailer("Test Trailer");
            assertEquals("Test Trailer", Story.getTrailer());
        }

        @Test
        public void testAddPage() {
            Page page = new Page("Test Content", "img Url");
            Story.addPage(page);
            assertEquals(1, Story.getNumPages());
            assertEquals(page, Story.getPages().get(0));
        }

}