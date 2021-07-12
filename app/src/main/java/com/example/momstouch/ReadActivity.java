package com.example.momstouch;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.StaggeredGridLayoutManager;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.media.Image;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toolbar;

import com.squareup.picasso.Picasso;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import de.hdodenhof.circleimageview.CircleImageView;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

import static com.example.momstouch.Remote.BASE_URL;

public class ReadActivity extends AppCompatActivity {
    List<Trade_attachVO> array;
    Retrofit retrofit;
    Remote remote;
    Trade_attachVO vo;
    int trade_bno;
    TradeAdapter adapter;
    RecyclerView imageslist;
    StaggeredGridLayoutManager layoutManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_read);

        getSupportActionBar().setTitle("게시글 정보");
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        remote = retrofit.create(Remote.class);

        array = new ArrayList<>();

        readGetAttach();

        adapter = new ReadActivity.TradeAdapter();
        imageslist = findViewById(R.id.imageslist);
        layoutManager = new StaggeredGridLayoutManager(3, LinearLayout.VERTICAL);
        imageslist.setAdapter(adapter);
        imageslist.setLayoutManager(layoutManager);

        ImageView image = (ImageView) findViewById(R.id.image);
        TextView title = findViewById(R.id.title);
        TextView writer = findViewById(R.id.writer);
        TextView regdate = findViewById(R.id.regdate);
        TextView content = findViewById(R.id.content);
        TextView price = findViewById(R.id.price);
        TextView category = findViewById(R.id.category);

        Intent intent = getIntent();
        int trade_bno = intent.getExtras().getInt("trade_bno");

        String trade_image = intent.getExtras().getString("trade_image");
        content.setText(trade_image);
        Picasso.with(ReadActivity.this)
                .load(BASE_URL + "trade/img/" + trade_image)
                .into(image);
        String trade_category = intent.getExtras().getString("trade_category");
        category.setText("[" + trade_category + "]");

        String trade_title = intent.getExtras().getString("trade_title");
        title.setText(trade_title);

        String trade_writer = intent.getExtras().getString("trade_writer");
        writer.setText("작성자 : " + trade_writer);

        String trade_regdate = intent.getExtras().getString("trade_regdate");
        regdate.setText("작성일 : " + trade_regdate);

        String trade_content = intent.getExtras().getString("trade_content");
        content.setText(trade_content);

        String trade_price = intent.getExtras().getString("trade_price");
        DecimalFormat df = new DecimalFormat("#,###원");
        int intPrice = Integer.parseInt(trade_price);
        if(intPrice != 0){
            price.setText(df.format(intPrice));
        }else{
            price.setText("무료");
        }





    }

    //데이터목록
    public void readGetAttach() {
        Intent intent = getIntent();
        int trade_bno = intent.getExtras().getInt("trade_bno");
        Call<List<Trade_attachVO>> call = remote.getAttach(trade_bno);
        call.enqueue(new Callback<List<Trade_attachVO>>() {
            @Override
            public void onResponse(Call<List<Trade_attachVO>> call, Response<List<Trade_attachVO>> response) {
                if (response.isSuccessful()) {
                    array = response.body();
                    //Log.d("TEST","성공성공");
                    //Log.d("TEST", array.get(0).getTrade_attach_image());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onFailure(Call<List<Trade_attachVO>> call, Throwable t) {
                t.printStackTrace();
            }
        });
    }

    public class TradeAdapter extends RecyclerView.Adapter<TradeAdapter.ViewHolder>{
        @NonNull
        @Override
        public ReadActivity.TradeAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(ReadActivity.this).inflate(R.layout.item_read, parent, false);
            return new ReadActivity.TradeAdapter.ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(@NonNull ReadActivity.TradeAdapter.ViewHolder holder, int position) {
            Intent intent = getIntent();
            int trade_bno = intent.getExtras().getInt("trade_bno");
            Trade_attachVO vo = array.get(position);
            Picasso.with(ReadActivity.this)
                    .load(BASE_URL + "trade/img/" + trade_bno + "/" + vo.getTrade_attach_image())
                    .into(holder.images);
            System.out.println(vo.toString());
        }

        @Override
        public int getItemCount() {
            return array.size();
        }

        public class ViewHolder extends RecyclerView.ViewHolder {
            ImageView images;
            CardView item;

            public ViewHolder(@NonNull View itemView) {
                super(itemView);
                images = itemView.findViewById(R.id.images);
                item = itemView.findViewById(R.id.readitem);
            }
        }
    }
    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                finish();
                break;
        }
        return super.onOptionsItemSelected(item);
    }
}