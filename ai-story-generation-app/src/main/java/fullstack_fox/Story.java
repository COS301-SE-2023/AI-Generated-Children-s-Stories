package fullstack_fox;

import java.util.ArrayList;

public class Story {

    String title;
    int numPages;
    String trailerUrl;
    ArrayList<Page> pages;


    // Parse in title and trailer image
    public Story() {
        pages = new ArrayList<Page>();
    }

    public void addPage(Page inPage){
        pages.add(inPage);
    }

    public void printPage(int index){
        pages.get(index).print();
    }
}
