package fullstack_fox;

import java.util.ArrayList;

public class Story {
    String title;
    int numPages;
    String trailer;
    ArrayList<Page> pages;

    public Story(String inTitle, String inTrailer) {
        title = inTitle;
        trailer = inTrailer;
        pages = new ArrayList<Page>();
        numPages = pages.size();
    }

    public void addPage(Page inPage) {
        pages.add(inPage);
    }

    public void printStory() {
        System.out.println("Title: " + title);
        System.out.println("Number of Pages: " + numPages);
        System.out.println("Trailer URL:\n" + trailer);
        for (Page page : pages) {
            page.print();
        }
    }
}
