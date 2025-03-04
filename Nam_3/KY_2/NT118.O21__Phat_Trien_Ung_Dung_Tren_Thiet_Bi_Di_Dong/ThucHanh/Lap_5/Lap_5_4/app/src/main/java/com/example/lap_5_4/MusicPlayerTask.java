package com.example.lap_5_4;
import android.content.Context;
import android.media.MediaPlayer;
import android.os.AsyncTask;
import android.os.Handler;
import android.widget.ProgressBar;
import java.util.List;

public class MusicPlayerTask extends AsyncTask<Void, Integer, Void> {
    private Context context;
    private List<Integer> songList;
    private MediaPlayer mediaPlayer;
    private int currentSongIndex;
    private ProgressBar progressBar;
    private Handler handler;

    public MusicPlayerTask(Context context, List<Integer> songList, int startIndex, ProgressBar progressBar) {
        this.context = context;
        this.songList = songList;
        this.currentSongIndex = startIndex;
        this.progressBar = progressBar;
        this.handler = new Handler();
    }

    @Override
    protected Void doInBackground(Void... voids) {
        playSong();
        return null;
    }

    private void playSong() {
        if (mediaPlayer != null) {
            mediaPlayer.release();
        }
        mediaPlayer = MediaPlayer.create(context, songList.get(currentSongIndex));
        mediaPlayer.start();
        progressBar.setMax(mediaPlayer.getDuration() / 1000);

        mediaPlayer.setOnCompletionListener(mp -> playNextSong());

        handler.post(updateProgressBar);
    }

    private Runnable updateProgressBar = new Runnable() {
        @Override
        public void run() {
            if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                int progress = mediaPlayer.getCurrentPosition() / 1000;
                progressBar.setProgress(progress);
                handler.postDelayed(this, 1000);
            }
        }
    };

    public void playNextSong() {
        currentSongIndex = (currentSongIndex + 1) % songList.size();
        playSong();
    }

    public void playPrevSong() {
        currentSongIndex = (currentSongIndex - 1 + songList.size()) % songList.size();
        playSong();
    }

    public void togglePlayPause() {
        if (mediaPlayer.isPlaying()) {
            mediaPlayer.pause();
        } else {
            mediaPlayer.start();
            handler.post(updateProgressBar);
        }
    }

    public void stopMusic() {
        if (mediaPlayer != null) {
            mediaPlayer.release();
            mediaPlayer = null;
            handler.removeCallbacks(updateProgressBar);
        }
    }
}


