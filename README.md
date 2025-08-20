# allanPlayer

An iOS application for RTSP streaming and local video playback, built with VLCKit framework.

## Features

- **Dual Interface Design**: Tab-based navigation with two main functionalities
- **Local Video Playback**: Play embedded video files with easy switching controls
- **RTSP Stream Support**: Real-time streaming protocol support with custom URL input
- **VLCKit Integration**: Leverages VLC's powerful media playback capabilities

## Project Structure

- `rtspStream/`: Main application source code
- `rtspStreamTests/`: Unit tests
- `rtspStreamUITests/`: UI automation tests

## Setup Instructions

1. Open `rtspStream.xcworkspace` in Xcode
2. Build and run the project

## Usage

### Local Video Tab
- Plays pre-bundled video files (airplanelanding.mp4, bubble.mp4)
- Switch between videos using the top navigation buttons

### RTSP Stream Tab
- Input custom RTSP URLs for live streaming
- Default test stream available
- Sample URL: `http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4`

## Technical Details

- **Platform**: iOS
- **Framework**: VLCKit for media playback
- **Architecture**: Tab-based view controllers

## Acknowledgments

- [VLC Media Player](https://www.videolan.org/vlc/index.zh-TW.html) - For their powerful media library
- [Pexels](https://videos.pexels.com/) - For providing sample video content