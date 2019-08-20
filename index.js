
import { NativeModules, DeviceEventEmitter, Platform, NativeEventEmitter } from 'react-native';

const { RNNetworkSpeed } = NativeModules;


let defualtCallback = null
let eventEmitter = null

class NetworkSpeed {
    static startListenNetworkSpeed(callback) {
            // 判断是否已经有监听
            if(!callback || typeof callback !== 'function') {throw new Error("callback need a function")}
            if(eventEmitter && eventEmitter instanceof NativeEventEmitter) return
            if(defualtCallback && typeof defualtCallback == 'function') return
            
            // 初始化监听器
            eventEmitter = new NativeEventEmitter(RNNetworkSpeed);
            
            // 初始化监听 调用原生代码开启定时器、监听
            RNNetworkSpeed.startListenNetworkSpeed()
            defualtCallback = callback
            eventEmitter.addListener("onSpeedUpdate", defualtCallback)
    }

    static stopListenNetworkSpeed() {
        if(!defualtCallback && typeof defualtCallback !== 'function') return
        if(eventEmitter && eventEmitter instanceof NativeEventEmitter) {
            RNNetworkSpeed.stopListenNetworkSpeed()
            eventEmitter.removeListener("onSpeedUpdate", defualtCallback)
            defualtCallback = null
            eventEmitter = null
        }
    }
}

export default NetworkSpeed;
