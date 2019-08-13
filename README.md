
# react-native-network-speed
这个模块可以获取当前设备的网络速度，由于我并不是很懂app开发，可能很多bug，暂时还没有时间解决，所以慎用。<br/>
this module can show the network speed. currently only supports android (I am not good at developing apps)

## Getting started

`$ npm install react-native-network-speed --save`

### Mostly automatic installation

`$ react-native link react-native-network-speed`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-network-speed` and add `RNNetworkSpeed.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNNetworkSpeed.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.xh.networkspeed.RNNetworkSpeedPackage;` to the imports at the top of the file
  - Add `new RNNetworkSpeedPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-network-speed'
  	project(':react-native-network-speed').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-network-speed/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-network-speed')
  	```


## Usage
```javascript
import networkSpeed from 'react-native-network-speed';
// start
networkSpeed.startListenNetworkSpeed(({downLoadSpeed,downLoadSpeedCurrent,upLoadSpeed,upLoadSpeedCurrent}) => {
		console.log(downLoadSpeed + 'kb/s') // download speed for the entire device 整个设备的下载速度
		console.log(downLoadSpeedCurrent + 'kb/s') // download speed for the current app 当前app的下载速度
		console.log(upLoadSpeed + 'kb/s') // upload speed for the entire device 整个设备的上传速度
		console.log(upLoadSpeedCurrent + 'kb/s') // upload speed for the current app 当前app的上传速度
	})
// stop
networkSpeed.stopListenNetworkSpeed()
```
  