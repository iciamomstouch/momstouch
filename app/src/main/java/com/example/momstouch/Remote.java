package com.example.momstouch;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface Remote {
    public static final String BASE_URL="http://192.168.0.8:8088/";

    @GET("trade/alist.json")
    Call<List<TradeVO>> list(@Query("page") int page);

    @GET("trade/agetAttach.json")
    Call<List<Trade_attachVO>> getAttach(@Query("trade_bno") int trade_bno);
}
