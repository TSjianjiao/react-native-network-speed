package com.xh.networkspeed;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import java.util.Timer;
import java.util.TimerTask;

public class NetworkSpeedTimer {
    private long defaultDelay = 1000;
    private long defaultPeriod = 1000;
    private static final int ERROR_CODE = -101011010;
    private int mMsgWhat = ERROR_CODE;
    private NetworkSpeed mNetSpeed;
    private Handler mHandler;
    private Context mContext;
    private SpeedTimerTask mSpeedTimerTask;

    public static final int NET_SPEED_TIMER_DEFAULT = 101010;

    public NetworkSpeedTimer(Context context, NetworkSpeed netSpeed, Handler handler) {
        this.mContext = context;
        this.mNetSpeed = netSpeed;
        this.mHandler = handler;
    }

    public NetworkSpeedTimer setDelayTime(long delay) {
        this.defaultDelay = delay;
        return this;
    }

    public NetworkSpeedTimer setPeriodTime(long period) {
        this.defaultPeriod = period;
        return this;
    }

    public NetworkSpeedTimer setHanderWhat(int what) {
        this.mMsgWhat = what;
        return this;
    }

    /**
     * 开启获取网速定时器
     */
    public void startSpeedTimer() {
        Timer timer = new Timer();
        mSpeedTimerTask = new SpeedTimerTask(mContext, mNetSpeed, mHandler,
                mMsgWhat);
        timer.schedule(mSpeedTimerTask, defaultDelay, defaultPeriod);
    }

    /**
     * 关闭定时器
     */
    public void stopSpeedTimer() {
        if (null != mSpeedTimerTask) {
            mSpeedTimerTask.cancel();
        }
    }

    /**
     * @author
     * 静态内部类
     */
    private static class SpeedTimerTask extends TimerTask {
        private int mMsgWhat;
        private NetworkSpeed mNetSpeed;
        private Handler mHandler;
        private Context mContext;

        public SpeedTimerTask(Context context, NetworkSpeed netSpeed,
                              Handler handler, int what) {
            this.mContext = context;
            this.mHandler = handler;
            this.mNetSpeed = netSpeed;
            this.mMsgWhat = what;
        }

        @Override
        public void run() {
            // TODO Auto-generated method stub
            if (null != mNetSpeed && null != mHandler) {
                Message obtainMessage = mHandler.obtainMessage();
                if (mMsgWhat != ERROR_CODE) {
                    obtainMessage.what = mMsgWhat;
                } else {
                    obtainMessage.what = NET_SPEED_TIMER_DEFAULT;
                }
                obtainMessage.obj = mNetSpeed.getNetSpeed(mContext
                        .getApplicationInfo().uid);
                mHandler.sendMessage(obtainMessage);
            }
        }
    }
}
