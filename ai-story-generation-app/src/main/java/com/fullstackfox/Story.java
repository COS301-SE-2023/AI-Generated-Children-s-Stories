package com.fullstackfox;

import java.util.ArrayList;

public class Story {

    private static Story instance;
    private static String title;
    private static String trailer;
    private static ArrayList<Page> pages;
    private static int numPages;

    public Story() {
        pages = new ArrayList<>();
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
        output(title);
        Story.title = title;
    }

    public static String getTrailer() {
        return trailer;
    }

    public static void setTrailer(String trailer) {
        output(trailer);
        Story.trailer = trailer;
    }

    public static ArrayList<Page> getPages() {
        return pages;
    }

    public static int getNumPages() {
        return numPages;
    }

    public static void addPage(Page inPage) {
        inPage.print();
        pages = new ArrayList<>();
        pages.add(inPage);
        numPages++;
    }

    public static void setNumPages(int pages) {
        numPages = pages;
    }

    public static void output(String inString) {
        System.out.println("Received " + inString);
    }

    public static void printStory(){
        for(Page page : pages){
            page.print();
            System.out.println("Next Page -----------------");
        }
    }
}
