//
//  ContentView.swift
//  beatmachineswiftui
//
//  Created by Henry on 4/5/20.
//  Copyright © 2020 Tavo. All rights reserved.
//

import SwiftUI
import AudioKit
struct ContentView: View {
  
   @State var padfiles:[AKAudioFile] = try! [AKAudioFile](repeating: AKAudioFile(), count: 12)
   @State var padplayers:[AKPlayer] = [AKPlayer](repeating: AKPlayer(), count: 12)
   @State var audiourls:[URL] = [URL](repeating: URL(fileURLWithPath: ""), count: 12)
   @State var selectedaudiourl:URL = URL(fileURLWithPath: "")
   @State var selectPadBool:[Bool] = [Bool](repeating: false, count: 12)
   @State private var modes = 1
   @State var starttime:[Double] = [Double](repeating: 0, count: 9)
   @State var endtime:[Double] = [Double](repeating: 0, count: 9)
   @State var currentPad:Int = 0
    //mode 0 = change audio
    //mode 1 = play audio
    //mode 2 = edit audio
   @State var modeImage:String = "neutral"
   @State private var showModes = false
   @State private var currentezfile:EZAudioFile!
   @State private var currentakplayer:AKPlayer!
    
    var body: some View {
        ZStack{
            Color.gray
                .edgesIgnoringSafeArea(.all)
            VStack
                   {
//COMPONENTS (RECORD, PLAY,ETC)
                       HStack
                       {
                           
                         Button(action: {
      
                         }){
                           Image("record")
                           
                           }.padding(10)
                           
                           
                           
                           
                           
                           Button(action: {
       
                           }){
                             Image("playbutton")
                             
                             }.padding(10)
                           
                           
                           
                           
                           
                           Button(action: {
           
                            
                           }){
                             Image("stopbutton")
                             
                             }.padding(10)
                           
                           
                           
                           
                           
                           Button(action: {
                            self.modes = self.modes + 1
                            
                            if(self.modes == 1) //CHANGE AUDIO MODE
                            {
                                if(AudioKit.engine.isRunning)
                                     {
                                        for x in 0...self.selectPadBool.count-1
                                           {
                                            if(self.padplayers[x].duration > 0)
                                         {
                                            self.padplayers[x].stop()
                                         }
                                     }
                                        
                                         try! AudioKit.stop()
                                         print("stopped the engine for CHANGE mode")
                                     }
                                      self.modeImage = "neutral"
                                      print("switched change audio")
                                 print(self.modes)
                               
                            }
                            else if(self.modes == 2) //PLAYMODE
                            {
                                self.padInit()
                                self.modeImage = "playmodebutton"
                         
                                      
                            } else if(self.modes == 3) //EDIT AUDIO MODE
                            {
                                if(AudioKit.engine.isRunning)
                                     {
                                         for x in 0...8
                                                {
                                                    if(self.padplayers[x].duration > 0)
                                         {
                                            self.padplayers[x].stop()
                                         }
                                     }
                                        
                                        // try! AudioKit.stop()
                                         print("stopped the engine for edit mode")
                                     }
                                      self.modeImage = "editmodebutton"
                                      print("switched to edit audio")
                                self.modes = 0
                                 print(self.modes)
                                
                            }
                           
                              
                           }){
                               Image(modeImage).resizable().frame(width:50,height:50)
                               
                             
                             }.padding(10)
                           
                           
                           
                           
                       }
//ALL PADS
                       HStack
                       {
                           //PAD 1
                        ForEach(0..<3)
                        { index in
                         Button(action: {
                            self.padActions(index)
                            
                           }){
                           Image("button").resizable().frame(width:100, height:100)
                           
                            }.padding(10)
                        }
    
                       }
                       
                       
                       
                       HStack
                       {
                        ForEach(0..<3)
                        { index in
                         Button(action: {
                            self.padActions(index+3)
                           
                         }){
                           Image("button").resizable().frame(width:100, height:100)
                           
                            }.padding(10)
                        }
                        
                           
                           
                       }
                       
                       
                       
                       
                       HStack
                       {
                       ForEach(0..<3)
                        { index in
                         Button(action: {
                                self.padActions(index+6)
                         }){
                           Image("button").resizable().frame(width:100, height:100)
                           
                           }.padding(10)
                        
                           
                        }
                          
                           
                       

                     
                   }.sheet(isPresented: $showModes,  content: {
                       if self.modes == 1
                       {
                            
                        self.filepickerreturn()
                        
                     
                       } else if self.modes == 0 {
                    
                             self.audioeditorreturn()
                        
                            
                       }
                   })
        }
       
        
        
        
        }
    }
    func padActions(_ padnum:Int) //when pads are pressed
 {
   if(modes == 1) //change audio
    {
       
        for x in 0...8
        {
         
            selectPadBool[x] = false   //Resets pad selects
        }
         
            selectPadBool[padnum] = true
          
            print(selectPadBool)
    
          
                
       
        self.showModes = true
        print("editmode pad")
       
        
    }else if(modes == 2) //play
    {
        self.showModes = false
        padplayers[padnum].play()
        print("WE ARE IN")
        
            

        }
    else if(modes == 0) //edit audio
       {
        if(padplayers[padnum].duration != 0)
        {
          currentezfile = EZAudioFile(url: audiourls[padnum])
          currentakplayer = padplayers[padnum]
          self.showModes = true
            
       }else
        {
             self.showModes = false
        }
        
      currentPad = padnum
       
    }
 
    }
    func filepickerreturn() -> FilePickerController
    {
        for x in 0...8
        {
            if(selectPadBool[x])
            {
     
                
                return FilePickerController(urlaudio: $audiourls[x])
               
                
            }
        }
        print("on file")
        return FilePickerController(urlaudio:  $audiourls[6])
        
    }
    func audioeditorreturn() -> audioEditor
    {
        return audioEditor(ezfile: $currentezfile, padplay: $currentakplayer, starttime: $starttime[currentPad] ,endtime: $endtime[currentPad])
        
       
    }
    
    
    
    
    
    
    
    func padInit() //PLAY MODE INITIALIZATION
    {
       
            do
            {
                for x in 0...8
                {
                    self.padfiles[x] = try AKAudioFile(forReading: self.audiourls[x])
                    
                    
                }
            }catch{
                print("nothing loaded")
            }
            
            
            for x in 0...8
            {
                self.padplayers[x] = AKPlayer(audioFile: self.padfiles[x])
                self.padplayers[x].buffering = .always
    
                print(self.padplayers[x].duration)
                
                if(endtime[x] != 0)
                {
                    self.padplayers[x].startTime = starttime[x]
                    self.padplayers[x].endTime = endtime[x]
                    print("active on \(x)")
                }
                
            }
            AudioKit.output = AKMixer(self.padplayers)
            do
            {
                try AudioKit.start()
            }catch{
                print("couldn't start audio")
            }
        }
        
            
        
      
    }
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    
        return ContentView()
    }
}

