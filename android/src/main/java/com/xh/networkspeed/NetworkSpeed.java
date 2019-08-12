package com.xh.networkspeed;

import android.net.TrafficStats;

public class NetworkSpeed {
    private static final String TAG = NetworkSpeed.class.getSimpleName();
    private long lastTotalRxBytes = 0;
    private long lastTimeStamp = 0;

    private long lastDownLoadBytes = 0;
    private long lastUpLoadBytes = 0;
    private long lastDownLoadBytesUid = 0;
    private long lastUpLoadBytesUid = 0;

    private long lastDownLoadTimeStamp = 0;
    private long lastUpLoadTimeStamp = 0;
    private long lastUpLoadTimeStampUid = 0;
    private long lastDownLoadTimeStampUid = 0;

    public NetSpeedResult getNetSpeed(int uid) {
        long downLoadSpeed = getTotalRxBytes();
        long upLoadSpeed = getTotalTxBytes();
        long downLoadSpeedUid = getTotalRxBytesByUid(uid);
        long upLoadSpeedUid = getTotalTxBytesByUid(uid);
        NetSpeedResult result = new NetSpeedResult();
        result.setDownLoadSpeed(String.valueOf(downLoadSpeed));
        result.setDownLoadSpeedUid(String.valueOf(downLoadSpeedUid));
        result.setUpLoadSpeed(String.valueOf(upLoadSpeed));
        result.setUpLoadSpeedUid(String.valueOf(upLoadSpeedUid));

        return result;
    }


    // 获取手机所有接收流量
    public long getTotalRxBytes() {
        long nowTimeStamp = System.currentTimeMillis();
        long nowTotalRxBytes = TrafficStats.getTotalRxBytes() == TrafficStats.UNSUPPORTED ? 0 : (TrafficStats.getTotalRxBytes() / 1024);//转为KB
        long speed = ((nowTotalRxBytes - lastDownLoadBytes) * 1000 / (nowTimeStamp - lastDownLoadTimeStamp));//毫秒转换
        lastDownLoadTimeStamp = nowTimeStamp;
        lastDownLoadBytes = nowTotalRxBytes;
        return speed;
    }

    // 获取手机指定进程的接收流量
    public long getTotalRxBytesByUid(int uid) {
        long nowTimeStamp = System.currentTimeMillis();
        long nowTotalRxBytes = TrafficStats.getUidRxBytes(uid) == TrafficStats.UNSUPPORTED ? 0 : (TrafficStats.getUidRxBytes(uid) / 1024);//转为KB
        long speed = ((nowTotalRxBytes - lastDownLoadBytesUid) * 1000 / (nowTimeStamp - lastDownLoadTimeStampUid));//毫秒转换
        lastDownLoadTimeStampUid = nowTimeStamp;
        lastDownLoadBytesUid = nowTotalRxBytes;
        return speed;

    }

    // 获取指定进程的发送流量
    public long getTotalTxBytesByUid(int uid) {
        long nowTimeStamp = System.currentTimeMillis();
        long nowTotalTxBytes = TrafficStats.getUidTxBytes(uid) == TrafficStats.UNSUPPORTED ? 0 : (TrafficStats.getUidTxBytes(uid) / 1024);//转为KB
        long speed = ((nowTotalTxBytes - lastUpLoadBytesUid) * 1000 / (nowTimeStamp - lastUpLoadTimeStampUid));//毫秒转换
        lastUpLoadTimeStampUid = nowTimeStamp;
        lastUpLoadBytesUid = nowTotalTxBytes;
        return speed;
    }

    // 获取手机所有的发送流量
    public long getTotalTxBytes() {
        long nowTimeStamp = System.currentTimeMillis();
        long nowTotalTxBytes = TrafficStats.getTotalTxBytes() == TrafficStats.UNSUPPORTED ? 0 : (TrafficStats.getTotalTxBytes() / 1024);//转为KB
        long speed = ((nowTotalTxBytes - lastUpLoadBytes) * 1000 / (nowTimeStamp - lastUpLoadTimeStamp));//毫秒转换
        lastUpLoadTimeStamp = nowTimeStamp;
        lastUpLoadBytes = nowTotalTxBytes;
        return speed;
    }

    // 结果对象
    public class NetSpeedResult {
        private String downLoadSpeed = "";
        private String upLoadSpeed = "";
        private String downLoadSpeedUid = "";
        private String upLoadSpeedUid = "";

        public void setDownLoadSpeed(String downLoadSpeed) {
            this.downLoadSpeed = downLoadSpeed;
        }

        public void setDownLoadSpeedUid(String downLoadSpeedUid) {
            this.downLoadSpeedUid = downLoadSpeedUid;
        }

        public void setUpLoadSpeed(String upLoadSpeed) {
            this.upLoadSpeed = upLoadSpeed;
        }

        public void setUpLoadSpeedUid(String upLoadSpeedUid) {
            this.upLoadSpeedUid = upLoadSpeedUid;
        }

        public String getDownLoadSpeed() {
            return downLoadSpeed;
        }

        public String getDownLoadSpeedUid() {
            return downLoadSpeedUid;
        }

        public String getUpLoadSpeed() {
            return upLoadSpeed;
        }

        public String getUpLoadSpeedUid() {
            return upLoadSpeedUid;
        }
    }
}
