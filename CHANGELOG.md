# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


- Added 新添加的功能。
- Changed 对现有功能的变更。
- Deprecated 已经不建议使用，准备很快移除的功能。
- Removed 已经移除的功能。
- Fixed 对bug的修复
- Security 对安全的改进


## [Unreleased]


## [1.0.1]
### Fixed
- Fixed an issue where it was not possible to restart listening after stopping listening.
- 修复停止监听后，无法重新开始监听的问题

## [1.1.1]
### Addeds
- add typescript declare
- 添加`ts`声明文件
- IOS support (currently only the network speed of the entire device can be obtained)
- 支持IOS (目前只能获取整个设备的上传下载，单个`app`的速度只能自己去计算)

## [1.1.2]
### Fixed
- Fixed ios network speed conversion time is not correct
- 修复`IOS`网速换算时间不在正确的问题
