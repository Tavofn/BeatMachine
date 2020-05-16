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
  
   @State private var showDocumentPicker = false
   @State private var showAudioEditor = false
   @State var padfiles:[AKAudioFile] = try! [AKAudioFile](repeating: AKAudioFile(), count: 12)
   @State var padplayers:[AKPlayer] = [AKPlayer](repeating: AKPlayer(), count: 12)
   @State var audiourls:[URL] = [URL](repeating: URL(fileURLWithPath: ""), count: 12)
   @State var selectedaudiourl:URL = URL(fileURLWithPath: "")
   @State var selectPadBool:[Bool] = [Bool](repeating: false, count: 12)
   @State private var modes = 1
   @State var modeImage:String = "neutral"
   @State private var showModes = false
   @State private var currentezfile:EZAudioFile!
   @State private var currentakfile:AKAudioFile!
   @State private var currentakplayer:AKPlayer!
   @State private var currentakplayerNUM:Int = 0
   @State private var padplaytoEdit:AKPlayer!
    
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
                             //self.showDocumentPicker = true
                            self.modes = self.modes + 1
                            self.padInit()
                            if(self.modes == 2) //PLAYMODE
                            {
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
                                
                            } else if(self.modes == 1) //CHANGE AUDIO MODE
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
    func padActions(_ num:Int) //when pads are pressed
 {
    if(modes == 2) //play
    {
        for x in 0...8
        {
            if(x==num)
            {
            padplayers[x].play()
                print("pressed duration:\(padplayers[x].duration)")
            }
        }
        
     
    
    }else if(modes == 0) //edit the file
    {
        for x in 0...8
        {
            if(x==num)
            {
                padplaytoEdit = padplayers[x]
                currentezfile = EZAudioFile(url: audiourls[x])
                currentakfile = try! AKAudioFile(forReading: audiourls[x])
                currentakplayer = padplayers[x]
                currentakplayerNUM = num
                
            }
        }
         self.showModes = true
        print("editmode pad")
       
        
    }else if(modes == 1) //change the file
    {
        for x in 0...8
        {
            if(selectPadBool[x])
            {
                selectPadBool[x] = false
            }
            
            if(x == num)
            {
                selectPadBool[x] = true
          
                print(selectPadBool)
            }

        }
        
          
          self.showModes = true
       
   
 
        
        print("documentmode pad")
         self.showModes = true
     
    }
 }

    func filepickerreturn() -> FilePickerController
    {
        for x in 0...8
        {
            if(selectPadBool[x])
            {
             print("THE FILE WAS ABLE TO BE TRANSFERED TO AUDIOURL[X]")
                
                return FilePickerController(urlaudio: $audiourls[x])
               
                
            }
        }
        return FilePickerController(urlaudio:  $audiourls[6])
        
    }
    func audioeditorreturn() -> audioEditor
    {
        print("audioedit returned....or not")
        return audioEditor(ezfile: $currentezfile, padplay: $currentakplayer)
    }
    
    
    
    
    
    
    
    func padInit() //used when top right action button is pressed
    {
        if(self.modes == 2)
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
            
            
            for x in 0...self.selectPadBool.count-1
            {
                self.padplayers[x] = AKPlayer(audioFile: self.padfiles[x])
                self.padplayers[x].buffering = .always
                print(self.padplayers[x].duration)
                
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
      
    }
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    
        return ContentView()
    }
}

