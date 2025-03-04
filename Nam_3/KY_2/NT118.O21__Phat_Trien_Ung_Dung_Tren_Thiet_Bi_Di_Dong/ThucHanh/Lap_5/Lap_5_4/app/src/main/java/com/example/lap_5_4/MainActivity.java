package com.example.lap_5_4;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.ProgressBar;
import androidx.appcompat.app.AppCompatActivity;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private MusicPlayerTask musicPlayerTask;
    private Button buttonPlayPause;
    private boolean isPlaying = false;
    private List<Integer> songList;
    private int currentSongIndex = 0;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ListView listViewSongs = findViewById(R.id.listView_songs);
        Button buttonPrev = findViewById(R.id.button_prev);
        buttonPlayPause = findViewById(R.id.button_play_pause);
        Button buttonNext = findViewById(R.id.button_next);
        progressBar = findViewById(R.id.progressBar);

        // Initialize the song list with the raw resource IDs
        songList = new ArrayList<>();
        songList.add(R.raw.song1); // Ensure these files exist in res/raw
        songList.add(R.raw.song2);
        songList.add(R.raw.song3);

        // Set up the ListView with song titles
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, new String[]{"Song 1", "Song 2", "Song 3"});
        listViewSongs.setAdapter(adapter);

        listViewSongs.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                currentSongIndex = position;
                playSong();
            }
        });

        buttonPlayPause.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isPlaying) {
                    musicPlayerTask.togglePlayPause();
                    buttonPlayPause.setText("Play");
                } else {
                    playSong();
                }
                isPlaying = !isPlaying;
            }
        });

        buttonPrev.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (musicPlayerTask != null) {
                    musicPlayerTask.playPrevSong();
                }
            }
        });

        buttonNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (musicPlayerTask != null) {
                    musicPlayerTask.playNextSong();
                }
            }
        });
    }

    private void playSong() {
        if (musicPlayerTask != null) {
            musicPlayerTask.stopMusic();
        }
        musicPlayerTask = new MusicPlayerTask(this, songList, currentSongIndex, progressBar);
        musicPlayerTask.execute();
        buttonPlayPause.setText("Pause");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (musicPlayerTask != null) {
            musicPlayerTask.stopMusic();
        }
    }
}
