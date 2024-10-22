//
//  CustomPickerView.swift
//  Custom Picker
//
//  Created by Stewart Lynch on 2020-08-17.
//

import SwiftUI

struct CustomPickerView: View {
    var items: [Country]
    @State private var filteredItems: [Country] = []
    @State private var filterString: String = ""
    @State private var frameHeight: CGFloat = 400
    @FocusState private var inFocus: Bool?
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    var isCountryCode: Bool
    
    var body: some View {
        let filterBinding = Binding<String> (
            get: { filterString },
            set: {
                filterString = $0
                if filterString != "" {
                    filteredItems = items.filter{$0.name!.lowercased().contains(filterString.lowercased())}
                } else {
                    filteredItems = items
                }
                setHeight()
            }
        )
        return ZStack {
            Color.black.opacity(0.4)
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                presentPicker = false
                            }
                        }) {
                            Text("Cancel")
                        }
                        .padding(10)
                    }
                    .background(Color(UIColor.darkGray))
                    .foregroundColor(.white)
                    Text("Tap an entry to select it, or type in a new entry.")
                        .font(.caption)
                        .padding(.leading,10)
                    TextField("Filter by entering text", text: filterBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($inFocus, equals: true)
                        .padding()
                    List {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                pickerField = (isCountryCode ? item.countryCode : item.phoneCountryCode)!
                                withAnimation {
                                    presentPicker = false
                                }
                            }) {
                                if(isCountryCode){
                                    Text("\(item.name!) (\(item.countryCode!))")
                                } else {
                                    Text("\(item.name!) (\(item.phoneCountryCode!))")
                                }
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(maxWidth: 400)
                .padding(.horizontal,10)
                .frame(height: frameHeight)
                .padding(.top, 40)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .task {
            try? await Task.sleep(nanoseconds: 250_000_000)
            inFocus = true
            filteredItems = items
            setHeight()
        }
    }
    
    fileprivate func setHeight() {
        withAnimation {
            if filteredItems.count > 5 {
                frameHeight = 400
            } else if filteredItems.count == 0 {
                frameHeight = 130
            } else {
                frameHeight = CGFloat(filteredItems.count * 45 + 130)
            }
        }
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static let sampleData = [
        Country(name: "Bangladesh", countryCode: "BD", phoneCountryCode: "880"),
        Country(name: "Bangladesh", countryCode: "BD", phoneCountryCode: "880"),
        Country(name: "Bangladesh", countryCode: "BD", phoneCountryCode: "880")
    ]
    static var previews: some View {
        CustomPickerView(items: sampleData, pickerField: .constant(""), presentPicker: .constant(true), isCountryCode: true)
    }
}
