package com.example.momstouch;

import com.google.gson.annotations.SerializedName;


public class Trade_attachVO {
    @SerializedName("trade_attach_image")
    private String trade_attach_image;
    @SerializedName("trade_bno")
    private int trade_bno;
    @SerializedName("regDate")
    private String regDate;

    public String getTrade_attach_image() {
        return trade_attach_image;
    }

    public void setTrade_attach_image(String trade_attach_image) {
        this.trade_attach_image = trade_attach_image;
    }

    public int getTrade_bno() {
        return trade_bno;
    }

    public void setTrade_bno(int trade_bno) {
        this.trade_bno = trade_bno;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    @Override
    public String toString() {
        return "Trade_attachVO{" +
                "trade_attach_image='" + trade_attach_image + '\'' +
                ", trade_bno=" + trade_bno +
                ", regDate='" + regDate + '\'' +
                '}';
    }
}
