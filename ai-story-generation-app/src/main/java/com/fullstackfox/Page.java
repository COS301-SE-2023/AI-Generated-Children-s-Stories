package com.fullstackfox;

public class Page {
    String content;
    String imageUrl;

    public Page(String inContent, String inImageUrl) {
        content = inContent;
        imageUrl = inImageUrl;
    }

    public String getContent() {
        return content;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void print() {
        String toRet = "----------\n";
        toRet += "Image URL:\n";
        toRet += imageUrl + "\n\n";
        toRet += "Paragraph:\n";
        toRet += content;
        toRet += "\n----------\n";
        System.out.println(toRet);
    }
}
