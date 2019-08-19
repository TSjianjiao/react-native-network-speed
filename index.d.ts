interface result {
    downLoadSpeed?: string;
    downLoadSpeedCurrent?: string;
    upLoadSpeed?: string;
    upLoadSpeedCurrent?: string;
}

declare class NetworkSpeed {
    /**
     * 启动网络速率监测 默认2s监测一次
     * default detecttion frequency, onece every 2 seconds
     * @param callback 获取监测结果 get result
     */
    static startListenNetworkSpeed(callback: (result: result) => void): void;

    /**
     * 停止监测
     * stop slistening
     */
    static stopListenNetworkSpeed(): void;
}

export default NetworkSpeed;

