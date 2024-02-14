//
//  SplashScreen.swift
//  SplashScreen
//
//  Created by Macbook on 06/02/2024.
//

import SwiftUI

struct SplashScreen <Content: View, Background:  View>: View {
    @Binding private var isActive     : Bool
    private var scale                 : CGFloat
    private var delay                 : CGFloat
    private var animation             : SplashScreenAnimation
    private var background            : () -> (Background)
    private var content               : () -> (Content)
    private var animationDuration     : CGFloat
    private var animationValue        : CGFloat
    
    @State private var shouldAnimate  = false
    @State private var pulstate       = true
    @State private var shouldClose    = false
    @State private var animationState = true
    
    init(isActive: Binding<Bool>,
        scale                         : CGFloat               = 20,
        delay                         : CGFloat               = 0.4,
        animation                     : SplashScreenAnimation = .scale,
        animationDuration             : CGFloat               = 1,
        animationValue                : CGFloat               = 0.85,
        @ViewBuilder content          : @escaping () -> Content,
        @ViewBuilder background       : @escaping () -> Background){
        
        self._isActive                = isActive
        self.scale                    = scale
        self.delay                    = delay
        self.animation                = animation
        self.animationValue           = animationValue
        self.animationDuration        = animationDuration
        self.content                  = content
        self.background               = background
         
    }
    
    var body: some View{
       
        ZStack{
            background().ignoresSafeArea()
            content()
                .scaleEffect(shouldClose ? scale : 1)
                .if(animation == .scale, transform: { view in
                    view.scaleEffect(animationState ? animationValue : 1)
                })
            
                .if(animation == .fadeInOut, transform: { view in
                    view.opacity(animationState ? Double(animationValue) : 1)
                })
                .if(animation == .wiggle, transform: { view in
                    view.rotationEffect(Angle(degrees: Double(animationState ? animationValue : -animationValue)))
                })
                .if(animation == .moveHorizontally, transform: { view in
                    view.offset(x: animationState ? animationValue : -animationValue)
                })
                .if(animation == .moveVertically, transform: { view in
                     view.offset(y: animationState ? animationValue : -animationValue)
                })
            
                .onChange(of: isActive){
                    if !isActive {
                        DispatchQueue.main.async {
                            pulstate = false
                            withAnimation {
                                shouldAnimate = true
                            }// end of withAnimation
                            
                        }// end of async
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay*10))) {
                            withAnimation{
                                shouldClose = true
                                
                            }
                            
                        }
                        
                    }// end of with isActive
                    
                }// end of onChange
            
        }// end of zstack
        .opacity(shouldClose ? 0 : 1)
        .onAppear{
            pulsate()
            
        }// end of onAppear
        
    }// end of body view
    private func pulsate(){
        withAnimation(.easeInOut(duration: Double(animationDuration)).repeatForever(while: $pulstate)){
            animationState.toggle()
            
        }
        
    }
    
    
}// end of struct

enum SplashScreenAnimation {
    
    case none, moveHorizontally, moveVertically, wiggle, fadeInOut, scale
}
