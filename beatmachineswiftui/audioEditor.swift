//
//  audioEditor.swift
//  beatmachineswiftui
//
//  Created by Henry on 4/6/20.
//  Copyright © 2020 Tavo. All rights reserved.
//

import SwiftUI
import AudioKitUI
import AudioKit
import RangeSeekSlider
struct audioEditor: View {
    @Binding var ezfile:EZAudioFile!
    @Binding var padplay:AKPlayer!
    @Binding var starttime:Double
    @Binding var endtime:Double
    @State var applesliderValuestart:Double = 0 //apple slider
    @State var applesliderValueend:Double = 0 //apple slider
    @State var rangeselectstart:CGFloat = 0 //range slider
    @State var rangeselectend:CGFloat = 0 //range slider
    @State var initstart:Double = 0
    @State var initend:Double = 0
    
    var body: some View {
 
       ZStack
            {
               
                
            VStack
                {
                    sliderEdit(padplay: self.$padplay, selectMin: self.$rangeselectstart, selectMax: self.$rangeselectend).frame(height:100)
                       
                    GeometryReader{
                        geometry in
                        plotWaveform(audioFile: self.$ezfile)
                        .frame(width: geometry.size.width - 30, height: 150.0)

                    }.frame(height: 150.0)
                    
                    

                    HStack
                        {
                            Text("Start")
                            Slider(value: Binding(get: {
                                          self.applesliderValuestart
                              
                                          }, set: { (newVal) in
                                          self.applesliderValuestart = newVal
                                            
                                         self.rangeselectstart = CGFloat(self.applesliderValuestart * self.padplay.duration)
                                            self.padplay.startTime = self.applesliderValuestart * self.padplay.duration
                                            self.starttime = self.applesliderValuestart * self.padplay.duration
                                         
                                            
                                         
                            })).frame(width: 200, height: 150.0)
                    }
                    
                    HStack
                        {
                        Text("End")
                        Slider(value: Binding(get: {
                               self.applesliderValueend
                               }, set: { (newVal) in
                                
                                self.applesliderValueend = newVal
                                self.rangeselectend = CGFloat(self.padplay.duration-self.applesliderValueend*self.padplay.duration)
                                self.padplay.endTime = self.padplay.duration-self.applesliderValueend*self.padplay.duration
                                self.endtime = self.padplay.duration-self.applesliderValueend*self.padplay.duration
                               
                              
                        })).frame(width: 200, height: 150.0)
                       
                    }
                    
                    HStack
                    {
                        Button(action: {
                            self.padplay.play()
                      
                        }){
                            Image("playbutton")
                        }
                       
                    }
                  
                    
            
            }
        }.onAppear(perform: {
            self.setRangeInit()
        })
        
    }
    func setRangeInit()
    {
        rangeselectstart = 0
        rangeselectend = CGFloat(self.padplay.duration)
    }

    
}
//
//
//
//struct audioEditor_Previews: PreviewProvider {
//
//    static var previews: some View {
//        return audioEditor()
//    }
//}
