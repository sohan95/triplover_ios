//
//  UserFormView.swift
//  flightexpert
//
//  Created by sohan on 6/10/22.
//

import SwiftUI
//struct ContactInfo : Codable {
//    var email: String = ""
//    var phone: String = ""
//    var phoneCountryCode: String  = ""
//    var countryCode: String = ""
//    var cityName: String = ""
//}
//
//struct DocumentInfo : Codable {
//    var documentType: String = ""
//    var documentNumber: String = ""
//    var expireDate: Date = Date()
//    var frequentFlyerNumber: String = ""
//    var issuingCountry: String = ""
//    var nationality: String = ""
//}
//
//struct NameElement : Codable {
//    var title : String = ""
//    var firstName : String = ""
//    var lastName : String = ""
//    var middleName : String = ""
//}
//
//struct PassengerInfo : Codable {
//    var nameElement : NameElement?
//    var contactInfo : ContactInfo?
//    var documentInfo : DocumentInfo?
//    var passengerType : String = ""
//    var gender : String = ""
//    var dateOfBirth : String = ""
//    var passengerKey : String = ""
//    var isLeadPassenger : Bool = true
//    var meal : String = ""
//}

struct UserData: Encodable {
    //passengerInfoes:
    //nameElement
    var userType: String = "Adult"
    var title: String = "Mr"
    var firstName: String = ""
    var lastName: String = ""
    var middleName: String = ""
    //contactInfo
    var email: String = ""
    var phone: String = ""
    var phoneCountryCode: String  = "+880"
    var countryCode: String = "BD"
    var cityName: String = "Dhaka"
    //documentInfo
    var documentType: String = ""
    var documentNumber: String = ""
    var expireDate: Date = Date()
    var frequentFlyerNumber: String = ""
    var issuingCountry: String = "BD"
    var nationality: String = "BD"

    var passengerType: String = "ADT"
    var gender: String = "Male"
    var dateOfBirth: Date = Date()
    var passengerKey: String = "0"
    var isLeadPassenger: Bool = true
//    var meal: String = ""
}

struct Country: Hashable, Identifiable, Codable {
    var id: UUID? = UUID()
    let name: String
    let countryCode: String
    let phoneCountryCode: String
    //let flag: String
    //let appStore: Bool
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name
    }
}

class CountryViewModel: NSObject, ObservableObject {
    @Published var countries = [Country]()

    var countryNamesArray:[String] {
        countries.map{"\($0.name) /(\($0.countryCode)/)"}.sorted()
    }
    
    var phoneCountryCodeArray:[String] {
        countries.map{"\($0.name)/(\($0.phoneCountryCode)/)"}.sorted()
    }
    
    override init() {
        countries = [
        Country(name: "Bangladesh", countryCode: "BD", phoneCountryCode: "+880"),
        Country(name: "India", countryCode: "IND", phoneCountryCode: "+899"),
        Country(name: "Japan", countryCode: "JP", phoneCountryCode: "+220"),
        Country(name: "China", countryCode: "CN", phoneCountryCode: "+110")
        ]
    }
}

class UserDataModel: ObservableObject {
    @Published var userData: UserData = UserData()
    
    init() {
        //
    }
}

struct UserFormView: View {
    //var userTitle: String = "ADULT # 1"
    @Binding var passengerInfo: UserData
    
    //For CountryCode Picker
    @State private var phoneCountryCode = ""
    @State private var countryCode = ""
    @State private var presentPicker = false
    @State private var tag: Int = 1
    @StateObject private var countriesVM = CountryViewModel()
    
    var body: some View {
        ZStack {
            Color.white

            VStack {
                ScrollView {
                    HStack {
                        Text(passengerInfo.userType)
                            .font(.system(size: 20, weight:.bold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer()
                    }
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(.black)
                    
                    
                    VStack{
                        HStack {//Row-1
                            VStack(alignment: .leading) {
                                Text("Title")
                                DropDownView(value:$passengerInfo.title, placeholder: "Select title", dropDownList: ["MR", "MRS"])
                            }
                            
                            VStack(alignment: .leading) {
                                Text("First Name")
                                TextField("First Name", text: $passengerInfo.firstName)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                        }
                        HStack {//Row-2
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                TextField("Last Name", text: $passengerInfo.lastName)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                            VStack(alignment: .leading) {
                                Text("Date of Birth")
                                DatePicker("", selection: $passengerInfo.dateOfBirth, in: ...Date(), displayedComponents: .date)
                                    .frame(maxWidth:.infinity)
                                    .accentColor(.orange)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                                    .labelsHidden()
                                    .foregroundColor(.red)
                            }
                        }
                        HStack {//Row-3
                            VStack(alignment: .leading) {
                                Text("Nationality")
//                                DropDownView(value:$passengerInfo.nationality, placeholder: "Nationality", dropDownList: ["BD", "IND"])
                                CustomPickerTextView(presentPicker: $presentPicker,
                                                     fieldString: $passengerInfo.nationality,
                                                     placeholder: "Nationality",
                                                     tag: $tag,
                                                     selectedTag: 1)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Document Type")
                                DropDownView(value: $passengerInfo.documentType, placeholder: "passport", dropDownList: ["passport"])
                            }
                        }
                        HStack {//Row-4
                            VStack(alignment: .leading) {
                                Text("Document Number*")
                                TextField("AAA123456", text: $passengerInfo.documentNumber)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Issued In")
                                TextField("Dhaka", text: $passengerInfo.issuingCountry)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                        }
                        HStack {//Row-5
                            VStack(alignment: .leading) {
                                Text("Expires No*")
                                DatePicker("", selection: $passengerInfo.expireDate, in: Date()..., displayedComponents: .date)
                                    .frame(maxWidth:.infinity)
                                    .accentColor(.orange)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                                    .labelsHidden()
                                    .foregroundColor(.red)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Gender")
                                DropDownView(value: $passengerInfo.gender, placeholder: "Female", dropDownList: ["Male", "Female"])
                            }
                        }
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.gray.opacity(0.02))
                    .padding(.horizontal,10)
                    
                    
                    HStack(alignment: .center) {
                        Text("contact".uppercased())
                            .font(.system(size: 16, weight:.bold, design: .monospaced))
                            .foregroundColor(.black)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: 40.0)
                    .background(.gray.opacity(0.3))
                    
                    VStack {
                        HStack {//Row-1
                            VStack(alignment: .leading) {
                                Text("Email")
                                TextField("Email", text: $passengerInfo.email)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Phone")
                                TextField("Phone", text: $passengerInfo.phone)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                        }
                        HStack {//Row-2
                            VStack(alignment: .leading) {
                                Text("Phone Code")
                                CustomPickerTextView(presentPicker: $presentPicker,
                                                     fieldString: $passengerInfo.phoneCountryCode,
                                                     placeholder: "phoneCountryCode",
                                                     tag: $tag,
                                                     selectedTag: 2)
                            }
                            VStack(alignment: .leading) {
                                Text("Country Code")
                                TextField("BD", text: $passengerInfo.countryCode)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("City Name")
                                TextField("Dhaka", text: $passengerInfo.cityName)
                                    .padding(7)
                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.gray.opacity(0.02))
                    .padding(.horizontal,10)
                    
                }
            }
            
            if presentPicker {
                if tag == 1 {
                    CustomPickerView(items: countriesVM.countries,
                                     pickerField: $passengerInfo.nationality,
                                     presentPicker: $presentPicker,
                    isCountryCode: true)
                        .zIndex(1.0)
                }
                if tag == 2 {
                    CustomPickerView(items: countriesVM.countries,
                                     pickerField: $passengerInfo.phoneCountryCode,
                                     presentPicker: $presentPicker,
                                     isCountryCode: false)
                        .zIndex(1.0)
                }
            }
        }
    }
}

//struct DropDownView2: View {
//    @Binding var value: String
//    var placeholder = "Select title"
//    var dropDownList = ["MR", "MRS"]
//
////    typealias Action = (String) -> Void
////    var action: Action?
//
//    var body: some View {
//        Menu {
//            ForEach(dropDownList, id: \.self){ client in
//                Button(client) {
//                    self.value = client
//                }
//            }
//        } label: {
//            VStack(spacing: 5){
//                HStack{
//                    Text(value.isEmpty ? placeholder : value)
//                        .foregroundColor(value.isEmpty ? .gray : .black)
//                    Spacer()
//                    Image(systemName: "chevron.down")
//                        .foregroundColor(Color.gray.opacity(0.5))
//                        .font(Font.system(size: 15, weight: .bold))
//                }
//                .padding(7)
//                .background(Color.gray.opacity(0.3).cornerRadius(5))
////                .padding(.horizontal)
////                Rectangle()
////                    .fill(Color.orange)
////                    .frame(height: 2)
//            }
//        }
//    }
//}

struct UserFormView_Previews: PreviewProvider {
    static var previews: some View {
        let u = UserData()
        UserFormView(passengerInfo: .constant(u))
    }
}
