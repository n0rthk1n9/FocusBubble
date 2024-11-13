//
//  AudioManager.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import AVFoundation

@Observable
class AudioManager {
    private var audioPlayer: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "bubblePop", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }

        if audioPlayer?.isPlaying == true {
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            audioPlayer?.play()
        } catch {
            print("Audio playback error: \(error.localizedDescription)")
        }
    }
}
