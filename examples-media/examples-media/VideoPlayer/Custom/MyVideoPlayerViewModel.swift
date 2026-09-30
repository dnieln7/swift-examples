//
//  MyVideoPlayerViewModel.swift
//  examples-media
//
//  Created by Daniel Nolasco on 08/05/25.
//

import AVFoundation
import Observation
import SwiftUI

class VideoPlayerData {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var previewLayer: AVPlayerLayer?
    var playerItemStatusObserver: NSKeyValueObservation?

//    func observePlayerItemUpdates() {
//        playerItemStatusObserver = playerItem?.observe(
//            \.status,
//            options: .new,
//            changeHandler: { playerItem, newStatus in
//                debugPrint("newStatus: \(newStatus)")
//
//                if playerItem.status == .readyToPlay {
//                    self.player?.play()
//                }
//            }
//        )
//    }
}

@Observable
class MyVideoPlayerViewModel: @unchecked Sendable {
    var myVideoPreview: MyVideoPreview!

    var playing: Bool = false
    var progress: CGFloat = 0
    var currentTime: CMTime = .zero
    var seconds: Double = 0

    @ObservationIgnored let videoPlayerData: VideoPlayerData

    init() {
        videoPlayerData = VideoPlayerData()

        let localVideoURL = Bundle.main.url(forResource: "local", withExtension: "mp4")!
        let localVideoAsset = AVURLAsset(url: localVideoURL)

        videoPlayerData.playerItem = AVPlayerItem(asset: localVideoAsset)
        videoPlayerData.player = AVPlayer(playerItem: videoPlayerData.playerItem)

        Task {
            await MainActor.run {
                myVideoPreview = MyVideoPreview()

                videoPlayerData.previewLayer = myVideoPreview.uiView.layer as? AVPlayerLayer
                videoPlayerData.previewLayer?.player = videoPlayerData.player
//                videoPlayerData.observePlayerItemUpdates()
            }

            let interval = CMTime(value: 1, timescale: 2)

            videoPlayerData.player?.addPeriodicTimeObserver(
                forInterval: interval,
                queue: DispatchQueue.main,
                using: { currentTime in
                    self.currentTime = currentTime
                    self.seconds = currentTime.seconds
                    
                    guard let duration = self.videoPlayerData.playerItem?.duration else { return }

                    let position = currentTime.seconds / duration.seconds

                    self.progress = CGFloat(position)
                }
            )
        }
    }

    func rewind() async {
        let notificationCenter = NotificationCenter.default
        let notificationName = AVPlayerItem.didPlayToEndTimeNotification

        for await _ in notificationCenter.notifications(named: notificationName) {
            // first seekResult checks that the operation was successful
            // second seekResult checks that isFinishedPlaying is actually true
            if let seekResult = await videoPlayerData.playerItem?.seek(to: CMTime.zero), seekResult {
                await MainActor.run {
                    playing = false
                    progress = 0
                    seconds = .zero
                }
            }
        }
    }

    func play() {
        guard videoPlayerData.playerItem?.status == .readyToPlay else { return }

        videoPlayerData.player?.play()
        playing = true
    }

    func pause() {
        guard videoPlayerData.playerItem?.status == .readyToPlay else { return }

        videoPlayerData.player?.pause()
        playing = false
    }
    
    func backward() {
        guard videoPlayerData.playerItem?.status == .readyToPlay else { return }
        
        Task { @MainActor in
            let newTime = currentTime - CMTime(seconds: 2, preferredTimescale: currentTime.timescale)
            
            debugPrint("b currentTime: \(currentTime.seconds)")
            debugPrint("b newTime: \(newTime.seconds)")
            
            await videoPlayerData.playerItem?.seek(to: newTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    func forward() {
        guard videoPlayerData.playerItem?.status == .readyToPlay else { return }
        
        Task { @MainActor in
            let newTime = currentTime + CMTime(seconds: 2, preferredTimescale: currentTime.timescale)
            
            debugPrint("f currentTime: \(currentTime.seconds)")
            debugPrint("f newTime: \(newTime.seconds)")
            
            await videoPlayerData.playerItem?.seek(to: newTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
}
