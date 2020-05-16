//
//  sliderEdit.swift
//  beatmachineswiftui
//
//  Created by Henry on 4/8/20.
//  Copyright © 2020 Tavo. All rights reserved.
//

import SwiftUI
import RangeSeekSlider
import AudioKit
//THIS ONLY AFFECTS THE RANGE SLIDER, NOT THE TIME/DURATION OF AUDIO FILE
struct sliderEdit: UIViewRepresentable {
    @Binding var padplay:AKPlayer!
    @Binding var selectMin:CGFloat
     @Binding var selectMax:CGFloat
    func makeUIView(context: Context) -> RangeSeekSlider {
        print("DURATION IN SLIDEREDIT: \(padplay.duration)")
            return RangeSeekSlider()
        
     
    }
    
    func updateUIView(_ uiView: RangeSeekSlider, context: Context) {
         
               uiView.numberFormatter.maximumFractionDigits = 2
               uiView.minValue = 0
               uiView.maxValue = CGFloat(padplay.duration)
               uiView.selectedMinValue = selectMin
               uiView.selectedMaxValue = selectMax
        
          
        
        
    }
    
    
    
}

