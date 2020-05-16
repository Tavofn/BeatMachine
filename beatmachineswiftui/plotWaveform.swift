//
//  EZAudioplot.swift
//  beatmachineswiftui
//
//  Created by Henry on 4/6/20.
//  Copyright © 2020 Tavo. All rights reserved.
//

import SwiftUI
import AudioKitUI
import AudioKit
struct plotWaveform: UIViewRepresentable {
    @Binding var audioFile:EZAudioFile!
    func makeUIView(context: Context) -> EZAudioPlot {
         let plot = EZAudioPlot()
      
                  plot.plotType = .buffer
                  plot.shouldFill = true
                  plot.shouldMirror = true
                  plot.color = UIColor.blue
                  if let data = audioFile?.getWaveformData() {
                  plot.updateBuffer(data.buffers[0], withBufferSize: data.bufferSize)
              }
        return plot
      }

      func updateUIView(_ view: EZAudioPlot, context: Context){
        let plot = EZAudioPlot()
        
                    plot.plotType = .buffer
                    plot.shouldFill = true
                    plot.shouldMirror = true
                    plot.color = UIColor.red
                    if let data = audioFile?.getWaveformData() {
                    plot.updateBuffer(data.buffers[0], withBufferSize: data.bufferSize)
                }
      }
    
}



