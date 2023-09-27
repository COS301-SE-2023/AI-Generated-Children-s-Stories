package fullstack_fox.DTOs;

import fullstack_fox.Entities.Page;

public class PagesDTO {
    long id;

    String text;

    String image;

    public PagesDTO(Page page) {
        this.id = page.getId();
        this.text = page.getText();
        this.image = page.getImage();
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
