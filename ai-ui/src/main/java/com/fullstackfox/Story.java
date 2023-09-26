package com.fullstackfox;

import java.util.ArrayList;

public class Story {

    private static Story instance;
    private static String title;
    private static String trailer;
    private static ArrayList<Page> pages;
    private static int numPages;

    public Story() {
    }

    public static Story getInstance() {
        if (instance == null) {
            instance = new Story();
        }
        return instance;
    }

    public static void setInstance(Story instance) {
        Story.instance = instance;
    }

    public static String getTitle() {
        return title;
    }

    public static void setTitle(String title) {
        Story.title = title;
    }

    public static String getTrailer() {
        return trailer;
    }

    public static void setTrailer(String trailer) {
        Story.trailer = trailer;
    }

    public static ArrayList<Page> getPages() {
        return pages;
    }

    public static void setPages(ArrayList<Page> pages) {
        Story.pages = pages;
    }

    public static int getNumPages() {
        return numPages;
    }

    public static void setNumPages(int numPages) {
        Story.numPages = numPages;
    }

    public static void addPage(Page inPage) {
        pages.add(inPage);
        numPages++;
    }
}
