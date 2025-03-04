package com.example.lap_5_5;

import android.content.Context;
import android.media.MediaPlayer;
import android.widget.ProgressBar;

import java.util.List;
import java.util.concurrent.TimeUnit;

import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.disposables.Disposable;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class MusicPlayerManager {
    private Context context;
    private List<Integer> songList;
    private MediaPlayer mediaPlayer;
    private int currentSongIndex;
    private ProgressBar progressBar;
    private Disposable progressDisposable;

    public MusicPlayerManager(Context context, List<Integer> songList, int startIndex, ProgressBar progressBar) {
        this.context = context;
        this.songList = songList;
        this.currentSongIndex = startIndex;
        this.progressBar = progressBar;
    }

    public void playSong() {
        if (mediaPlayer != null) {
            mediaPlayer.release();
        }
        mediaPlayer = MediaPlayer.create(context, songList.get(currentSongIndex));
        mediaPlayer.start();
        progressBar.setMax(mediaPlayer.getDuration());

        mediaPlayer.setOnCompletionListener(mp -> playNextSong());

        startProgressUpdates();
    }

    private void startProgressUpdates() {
        // Kiểm tra và hủy subscription cũ, nếu nó khác null và chưa bị hủy
        if (progressDisposable != null && !progressDisposable.isDisposed()) {
            progressDisposable.dispose();
        }

        progressDisposable = Observable.interval(1, TimeUnit.SECONDS)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeOn(Schedulers.io())
                .subscribe(aLong -> {
                    if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                        int progress = mediaPlayer.getCurrentPosition();
                        progressBar.setProgress(progress);
                    }
                });
    }

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
            startProgressUpdates();
        }
    }

    public void stopMusic() {
        if (mediaPlayer != null) {
            mediaPlayer.release();
            mediaPlayer = null;
        }
        if (progressDisposable != null && !progressDisposable.isDisposed()) {
            progressDisposable.dispose();
        }
    }
}
