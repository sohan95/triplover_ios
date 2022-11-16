//
//  CustomRangeSlider.swift
//  flightexpert
//
//  Created by sohan on 7/23/22.
//

import SwiftUI
import Combine

//SliderValue to restrict double range: 0.0 to 1.0
@propertyWrapper
struct SliderValue {
    var value: Double
    
    init(wrappedValue: Double) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Double {
        get { value }
        set { value = min(max(0.0, newValue), 1.0) }
    }
}

class SliderHandle: ObservableObject {
    
    //Slider Size
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Slider Range
    let sliderValueStart: Double
    let sliderValueRange: Double
    
    //Slider Handle
    var diameter: CGFloat = 40
    var startLocation: CGPoint
    
    //Current Value
    @Published var currentPercentage: SliderValue
    
    //Slider Button Location
    @Published var onDrag: Bool
    @Published var currentLocation: CGPoint
        
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, sliderValueStart: Double, sliderValueEnd: Double, startPercentage: SliderValue) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.sliderValueStart = sliderValueStart
        self.sliderValueRange = sliderValueEnd - sliderValueStart
        
        let startLocation = CGPoint(x: (CGFloat(startPercentage.wrappedValue)/1.0)*sliderWidth, y: sliderHeight/2)
        
        self.startLocation = startLocation
        self.currentLocation = startLocation
        self.currentPercentage = startPercentage
        
        self.onDrag = false
    }
    
    lazy var sliderDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>  = DragGesture()
        .onChanged { value in
            self.onDrag = true
            
            let dragLocation = value.location
            
            //Restrict possible drag area
            self.restrictSliderBtnLocation(dragLocation)
            
            //Get current value
            self.currentPercentage.wrappedValue = Double(self.currentLocation.x / self.sliderWidth)
            
        }.onEnded { _ in
            self.onDrag = false
        }
    
    private func restrictSliderBtnLocation(_ dragLocation: CGPoint) {
        //On Slider Width
        if dragLocation.x > CGPoint.zero.x && dragLocation.x < sliderWidth {
            calcSliderBtnLocation(dragLocation)
        }
    }
    
    private func calcSliderBtnLocation(_ dragLocation: CGPoint) {
        if dragLocation.y != sliderHeight/2 {
            currentLocation = CGPoint(x: dragLocation.x, y: sliderHeight/2)
        } else {
            currentLocation = dragLocation
        }
    }
    
    //Current Value
    var currentValue: Double {
        return sliderValueStart + currentPercentage.wrappedValue * sliderValueRange
    }
}

class CustomSlider: ObservableObject {
    
    //Slider Size
    final let width: CGFloat = 300
    final let lineWidth: CGFloat = 4
    
    //Slider value range from valueStart to valueEnd
    var valueStart: Double
    var valueEnd: Double
    var currentMinValue: Double
    var currentMaxValue: Double
    
    //Slider Handle
    @Published var highHandle: SliderHandle
    @Published var lowHandle: SliderHandle
    
    //Handle start percentage (also for starting point)
    @SliderValue var highHandleStartPercentage = 1.0
    @SliderValue var lowHandleStartPercentage = 0.0

    final var anyCancellableHigh: AnyCancellable?
    final var anyCancellableLow: AnyCancellable?
    
    init(start: Double, end: Double, currentMin: Double,  currentMax: Double) {
        valueStart = start
        valueEnd = end
        currentMinValue = currentMin
        currentMaxValue = currentMax
        
        let sliderValueRange = valueEnd - valueStart
        highHandleStartPercentage = (currentMaxValue - start) / sliderValueRange
        lowHandleStartPercentage = (currentMinValue - start) / sliderValueRange
        
        highHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _highHandleStartPercentage
                                )
        
        lowHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _lowHandleStartPercentage
                                )
        
        anyCancellableHigh = highHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        anyCancellableLow = lowHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }
    
    //Percentages between high and low handle
    var percentagesBetween: String {
        return String(format: "%.2f", highHandle.currentPercentage.wrappedValue - lowHandle.currentPercentage.wrappedValue)
    }
    
    //Value between high and low handle
    var valueBetween: String {
        return String(format: "%.2f", highHandle.currentValue - lowHandle.currentValue)
    }
}


struct SliderView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth/2)
            .fill(Color.gray.opacity(0.05))
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    
                    //Path between both handles
                    SliderPathBetweenView(slider: slider)
                        
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle, noteColor: Color.yellow)
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle, noteColor: Color.orange)
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                }
            )
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    var noteColor: Color
    
    var body: some View {
        Circle()
            .frame(width: handle.diameter, height: handle.diameter)
            .foregroundColor(noteColor)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 0)
            .scaleEffect(handle.onDrag ? 0.8 : 0.6)
            .contentShape(Rectangle())
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y)
    }
}

struct SliderPathBetweenView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        Path { path in
            path.move(to: slider.lowHandle.currentLocation)
            path.addLine(to: slider.highHandle.currentLocation)
        }
        .stroke(Color.green, lineWidth: slider.lineWidth)
    }
}

//struct RangeSliderView: View {
//    @ObservedObject var slider:CustomSlider
//
//    var body: some View {
//        VStack {
//            HStack{
//                Text("\(slider.highHandle.currentValue)")
//                SliderView(slider: slider)
//                Text("\(slider.lowHandle.currentValue)")
//            }.padding(.trailing,10)
//
//        }
//        .onAppear() {
//
//        }
//    }
//}
//
//struct RangeSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        RangeSliderView(slider: CustomSlider(start: 300, end: 400))
//    }
//}


//struct CustomRangeSlider: View {
//    @ObservedObject var slider = CustomSlider(start: 3000, end: 60000)
//    
//    var body: some View {
//        VStack {
//            Text("Value: " + slider.valueBetween)
//            Text("Percentages: " + slider.percentagesBetween)
//            
//            Text("High Value: \(slider.highHandle.currentValue)")
//            Text("Low Value: \(slider.lowHandle.currentValue)")
//            
//            //Slider
//            SliderView(slider: slider)
//        }
//    }
//}
//
//struct CustomRangeSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomRangeSlider()
//    }
//}
