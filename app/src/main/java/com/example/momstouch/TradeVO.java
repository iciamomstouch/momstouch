package com.example.momstouch;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.Date;

public class TradeVO {
    @SerializedName("trade_bno")
    private int trade_bno;
    @SerializedName("trade_title")
    private String trade_title;
    @SerializedName("trade_category")
    private String trade_category;
    @SerializedName("trade_content")
    private String trade_content;
    @SerializedName("trade_writer")
    private String trade_writer;
    @SerializedName("trade_image")
    private String trade_image;
    @SerializedName("trade_price")
    private String trade_price;
    @SerializedName("trade_regdate")
    private String trade_regdate;
    @SerializedName("trade_updatedate")
    private String trade_updatedate;
    @SerializedName("trade_viewcnt")
    private int trade_viewcnt;
    @SerializedName("images")
    private ArrayList<String> images;

    public int getTrade_bno() {
        return trade_bno;
    }

    public void setTrade_bno(int trade_bno) {
        this.trade_bno = trade_bno;
    }

    public String getTrade_title() {
        return trade_title;
    }

    public void setTrade_title(String trade_title) {
        this.trade_title = trade_title;
    }

    public String getTrade_category() {
        return trade_category;
    }

    public void setTrade_category(String trade_category) {
        this.trade_category = trade_category;
    }

    public String getTrade_content() {
        return trade_content;
    }

    public void setTrade_content(String trade_content) {
        this.trade_content = trade_content;
    }

    public String getTrade_writer() {
        return trade_writer;
    }

    public void setTrade_writer(String trade_writer) {
        this.trade_writer = trade_writer;
    }

    public String getTrade_image() {
        return trade_image;
    }

    public void setTrade_image(String trade_image) {
        this.trade_image = trade_image;
    }

    public String getTrade_price() {
        return trade_price;
    }

    public void setTrade_price(String trade_price) {
        this.trade_price = trade_price;
    }

    public String getTrade_regdate() {
        return trade_regdate;
    }

    public void setTrade_regdate(String trade_regdate) {
        this.trade_regdate = trade_regdate;
    }

    public String getTrade_updatedate() {
        return trade_updatedate;
    }

    public void setTrade_updatedate(String trade_updatedate) {
        this.trade_updatedate = trade_updatedate;
    }

    public int getTrade_viewcnt() {
        return trade_viewcnt;
    }

    public void setTrade_viewcnt(int trade_viewcnt) {
        this.trade_viewcnt = trade_viewcnt;
    }

    public ArrayList<String> getImages() {
        return images;
    }

    public void setImages(ArrayList<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "TradeVO{" +
                "trade_bno=" + trade_bno +
                ", trade_title='" + trade_title + '\'' +
                ", trade_category='" + trade_category + '\'' +
                ", trade_content='" + trade_content + '\'' +
                ", trade_writer='" + trade_writer + '\'' +
                ", trade_image='" + trade_image + '\'' +
                ", trade_price='" + trade_price + '\'' +
                ", trade_regdate='" + trade_regdate + '\'' +
                ", trade_updatedate='" + trade_updatedate + '\'' +
                ", trade_viewcnt=" + trade_viewcnt +
                ", images=" + images +
                '}';
    }
}
