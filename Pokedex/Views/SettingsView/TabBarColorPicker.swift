//
//  TabBarColorPicker.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import SwiftUI

struct TabBarColorPicker: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("tabBarColor") var tabBarColor: Color = .orange
    @State var selectedColor: Color
    @State var originalColor: Color

    init(selectedColor: Color) {
        _selectedColor = State(initialValue: selectedColor)
        _originalColor = State(initialValue: .black)
    }
    
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.4).ignoresSafeArea()
            VStack {
                colorPicker()
            }
            VStack(alignment: .center) {
                header()
                    .padding(.top, 20)
                Spacer()
                footer()
            }
            .padding(.horizontal, 10)
        }
        .onAppear {
            selectedColor = tabBarColor
            originalColor = tabBarColor
        }
    }
}

extension TabBarColorPicker {
    @ViewBuilder
    func colorPicker() -> some View {
        selectedColor
            .frame(width: 40, height: 40, alignment: .center)
            .cornerRadius(10.0)
            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.white, style: StrokeStyle(lineWidth: 5)))
            .padding(10)
            .background(AngularGradient(gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]), center:.center).cornerRadius(20.0))
            .overlay(ColorPicker("", selection: $selectedColor).labelsHidden().opacity(0.015))
            .shadow(radius: 5.0)
    }
    
    @ViewBuilder
    func header() -> some View {
        Text("Bar Button Color")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    func footer() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
                    .modifier(ButtonModifier())
            })
            Button(action: {
                tabBarColor = selectedColor
                dismiss()
            }, label: {
                Text("Select")
                    .modifier(ButtonModifier())
            })
            .disabled(selectedColor == originalColor)
        }
    }
}

#Preview {
    TabBarColorPicker(selectedColor: .orange)
}
