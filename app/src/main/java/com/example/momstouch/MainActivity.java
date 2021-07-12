package com.example.momstouch;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.StaggeredGridLayoutManager;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.text.Html;
import android.text.Layout;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.io.ByteArrayOutputStream;
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

public class MainActivity extends AppCompatActivity {
    List<TradeVO> array;
    TradeAdapter adapter;
    StaggeredGridLayoutManager layoutManager;
    RecyclerView list;
    Retrofit retrofit;
    Remote remote;
    int page=1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getSupportActionBar().setTitle("중고거래");

        retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        remote = retrofit.create(Remote.class);

        array = new ArrayList<>();

        readList();

        adapter = new TradeAdapter();
        list = findViewById(R.id.list);
        layoutManager = new StaggeredGridLayoutManager(1, LinearLayout.VERTICAL);
        list.setAdapter(adapter);
        list.setLayoutManager(layoutManager);
    }

    //데이터목록
    public void readList(){
        Call<List<TradeVO>> call = remote.list(page);
        call.enqueue(new Callback<List<TradeVO>>() {
            @Override
            public void onResponse(Call<List<TradeVO>> call, Response<List<TradeVO>> response) {
                if(response.isSuccessful()) {
                    array = response.body();
                    //Log.d("TEST","성공성공");
                    //Log.d("TEST", array.get(0).getTrade_title());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onFailure(Call<List<TradeVO>> call, Throwable t) {
                t.printStackTrace();
            }
        });
    }

    class TradeAdapter extends RecyclerView.Adapter<TradeAdapter.ViewHolder>{
        @NonNull
        @Override
        public TradeAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(MainActivity.this).inflate(R.layout.item_trade, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
            TradeVO vo = array.get(position);
            try {
                holder.title.setText(vo.getTrade_title());
                holder.category.setText("[" + vo.getTrade_category() + "]");
                holder.category.setTextColor(Color.parseColor("#0080FF"));
                holder.writer.setText(vo.getTrade_writer());
                DecimalFormat df = new DecimalFormat("#,###원");
                int price = Integer.parseInt(vo.getTrade_price());
                if(price != 0){
                    holder.price.setText(df.format(price));
                }else{
                    holder.price.setText("무료");
                }
                holder.price.setTextColor(Color.parseColor("#8E35EF"));
                holder.regdate.setText(vo.getTrade_regdate());
                if (!vo.getTrade_image().equals("") && vo.getTrade_image() != null) {
                    Picasso.with(MainActivity.this)
                            .load(BASE_URL + "trade/img/" + vo.getTrade_image())
                            .error(R.mipmap.ic_launcher_round)
                            .into(holder.image);
                } else {
                    holder.image.setImageDrawable(null);
                }
            }catch (Exception e){
                System.out.println("오류:" + e.toString());
            }


            //데이터 송신 Main->Read
            holder.item.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(getApplicationContext(), ReadActivity.class);
                    intent.putExtra("trade_bno", vo.getTrade_bno());
                    intent.putExtra("trade_title",vo.getTrade_title());
                    intent.putExtra("trade_content",vo.getTrade_content());
                    intent.putExtra("trade_writer",vo.getTrade_writer());
                    intent.putExtra("trade_price",vo.getTrade_price());
                    intent.putExtra("trade_regdate",vo.getTrade_regdate());
                    intent.putExtra("trade_category", vo.getTrade_category());

                    //이미지
                    intent.putExtra("trade_image",vo.getTrade_image());

                    ((Activity)MainActivity.this).startActivityForResult(intent,200);
                    System.out.println(vo.toString());
                }
            });
        }

        @Override
        public int getItemCount() {
            return array.size();
        }

        public class ViewHolder extends RecyclerView.ViewHolder {
            TextView title, category, writer, price, regdate;
            CircleImageView image;
            CardView item;
            public ViewHolder(@NonNull View itemView) {
                super(itemView);
                title = itemView.findViewById(R.id.title);
                category = itemView.findViewById(R.id.category);
                writer = itemView.findViewById(R.id.writer);
                price = itemView.findViewById(R.id.price);
                regdate = itemView.findViewById(R.id.regdate);
                image = itemView.findViewById(R.id.image);
                item=itemView.findViewById(R.id.item);
            }
        }
    }
}