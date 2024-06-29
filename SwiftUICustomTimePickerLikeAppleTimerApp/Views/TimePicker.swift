//
//  TimePicker.swift
//  SwiftUICustomTimePickerLikeAppleTimerApp
//
//  Created by Ramill Ibragimov on 6/29/24.
//

import SwiftUI

struct TimePicker: View {
    
    var style: AnyShapeStyle = .init(.bar)
    
    @Binding var hour: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        HStack(spacing: 0) {
            CustomView("hours", 0...24, $hour)
            CustomView("minutes", 0...60, $minutes)
            CustomView("seconds", 0...60, $seconds)
        }
        .offset(x: -25)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(style)
                .frame(height: 35)
        }
    }
    
    @ViewBuilder
    private func CustomView(_ title: String, _ range: ClosedRange<Int>, _ selection: Binding<Int>) -> some View {
        PickerViewWithoutIndicators(selection: selection) {
            ForEach(range, id: \.self) { value in
                Text("\(value)")
                    .frame(width: 35, alignment: .trailing)
                    .tag(value)
            }
        }
        .overlay {
            Text(title)
                .font(.callout.bold())
                .frame(width: 50, alignment: .leading)
                .lineLimit(1)
                .offset(x: 50)
        }
    }
}

#Preview {
    ContentView()
}

struct PickerViewWithoutIndicators<Content: View, Selection: Hashable>: View {
    @Binding var selection: Selection
    @ViewBuilder var content: Content
    @State private var isHidden: Bool = false
    
    var body: some View {
        Picker("", selection: $selection) {
            if !isHidden {
                RemovePickerIndicator {
                    isHidden = true
                }
            } else {
                content
            }
        }
        .pickerStyle(.wheel)
    }
}

fileprivate
struct RemovePickerIndicator: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let pickerView = view.pickerView {
                if pickerView.subviews.count >= 2 {
                    pickerView.subviews[1].backgroundColor = .clear
                }
                result()
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

fileprivate
extension UIView {
    var pickerView: UIPickerView? {
        if let view = superview as? UIPickerView {
            return view
        }
        
        return superview?.pickerView
    }
}
