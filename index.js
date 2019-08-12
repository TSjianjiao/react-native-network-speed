
import { NativeModules, DeviceEventEmitter } from 'react-native';

const { RNNetworkSpeed } = NativeModules;

let defualtCallback = null
class NetworkSpeed {
    static startListenNetworkSpeed(callback) {
        if(defualtCallback && typeof defualtCallback == 'function') return
        RNNetworkSpeed.startListenNetworkSpeed()
        defualtCallback = callback ? callback :  () => {}
        DeviceEventEmitter.addListener("onSpeedUpdate", defualtCallback)
    }

    static stopListenNetworkSpeed() {
        RNNetworkSpeed.stopListenNetworkSpeed()
        DeviceEventEmitter.removeListener("onSpeedUpdate", defualtCallback)
    }
}

export default NetworkSpeed;
