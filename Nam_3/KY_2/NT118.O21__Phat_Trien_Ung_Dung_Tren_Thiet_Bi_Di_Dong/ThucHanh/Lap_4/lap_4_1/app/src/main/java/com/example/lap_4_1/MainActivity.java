package com.example.lap_4_1;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.Bundle;
import android.telephony.SmsMessage;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    private BroadcastReceiver broadcastReceiver;
    private IntentFilter filter;
    public void processReceive (Context context, Intent intent) {
        Toast.makeText(context, getString(R.string.you_have_a_new_message), Toast.LENGTH_SHORT).show();
        TextView tvContent = findViewById(R.id.tv_content);
        final String SMS_EXTRA = "pdus";
        Bundle bundle = intent.getExtras();

        Object[] messages = (Object[]) bundle.get(SMS_EXTRA);
        String sms = "";

        SmsMessage smsMsg;
        for (int i = 0; i < messages.length; i++) {
            smsMsg = SmsMessage.createFromPdu((byte[]) messages[i], "3gpp");
            if(smsMsg!=null){
                // Get message body
                String msgBody = smsMsg.getMessageBody();
                // Get source address of message
                String address = smsMsg.getDisplayOriginatingAddress();
                sms += address + "\n" + msgBody + "\n";
            }
        }
        tvContent.setText(sms);
    }

    private void initBroadcastReceiver() {
        filter = new IntentFilter("android.provider.Telephony.SMS_RECEIVED");
        broadcastReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                Log.d("SMSReceiver", "Received a new SMS");
                processReceive(context, intent);
            }
        };
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
        initBroadcastReceiver();
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (broadcastReceiver == null) {
            initBroadcastReceiver();
        }
        registerReceiver(broadcastReceiver, filter);
    }

    @Override
    protected void onStop() {
        super.onStop();
        unregisterReceiver(broadcastReceiver);
    }
}