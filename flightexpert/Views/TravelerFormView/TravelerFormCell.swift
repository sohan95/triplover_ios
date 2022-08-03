//
//  TravelerFormCell.swift
//  flightexpert
//
//  Created by sohan on 6/10/22.
//

import SwiftUI

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
//    var name: String
//    var countryCode: String
//    var phoneCountryCode: String
////    let flag: String
//
//    static func == (lhs: Country, rhs: Country) -> Bool {
//        lhs.name == rhs.name
//    }

    
    var name: String?
    var countryCode: String?
//    var currencyCode: String?
//    var currencySymbol: String?
//    var flag: String?
    var phoneCountryCode: String?
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.name == rhs.name
    }
}

//MARK: Find the Country Code
extension NSLocale {
    func extensionCode(countryCode : String?) -> String? {
        let prefixCodes = ["AC" : "247", "AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263", "AQ" : "672", "AX" : "358", "BQ" : "599", "BV": "55"]
        
        let countryDialingCode = prefixCodes[countryCode ?? "IN"] ?? nil
        return countryDialingCode
    }
}

class CountryViewModel: NSObject, ObservableObject {
    @Published var countries = [Country]()

    var countryNamesArray:[String] {
        countries.map{"\($0.name ?? "") /(\($0.countryCode ?? "")/)"}.sorted()
    }
    
    var phoneCountryCodeArray:[String] {
        countries.map{"\($0.name ?? "")/(\($0.phoneCountryCode ?? "")/)"}.sorted()
    }
    
    override init() {
//        countries = [
//        Country(name: "Bangladesh", countryCode: "BD", phoneCountryCode: "+880"),
//        Country(name: "India", countryCode: "IND", phoneCountryCode: "+899"),
//        Country(name: "Japan", countryCode: "JP", phoneCountryCode: "+220"),
//        Country(name: "China", countryCode: "CN", phoneCountryCode: "+110")
//        ]
        super.init()
        configuration()
    }
    
    func configuration() {
            for code in NSLocale.isoCountryCodes  {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id)
                
                let locale = NSLocale.init(localeIdentifier: id)
                
                let countryCode = locale.object(forKey: NSLocale.Key.countryCode)
//                let currencyCode = locale.object(forKey: NSLocale.Key.currencyCode)
//                let currencySymbol = locale.object(forKey: NSLocale.Key.currencySymbol)
                
                if name != nil {
                    var model = Country()
                    model.name = name
                    model.countryCode = (countryCode as! String)
//                    model.currencyCode = currencyCode as! String
//                    model.currencySymbol = currencySymbol as! String
                    //model.flag = String.flag(for: code)
                    model.phoneCountryCode = NSLocale().extensionCode(countryCode: model.countryCode)
                    countries.append(model)
                }
            }
        }
}

struct TravelerFormCell: View {
    @Binding var userData: UserData
    var isDomestic: Bool
    
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
                        Text(userData.userType)
                            .font(.system(size: 20, weight:.regular, design: .rounded))
                            .foregroundColor(.red.opacity(0.7))
                            .padding()
                        
                        Spacer()
                    }
                    .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                    .background(.gray.opacity(0.2))
                    
                    
                    VStack(alignment: .leading, spacing: 10){
                        HStack {//Row-1
//                            VStack(alignment: .leading) {
//                                Text("Title")
//                                DropDownView(value:$userData.title, placeholder: "Select title", dropDownList: ["MR", "MRS"])
//                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("First Name")
                                TextField("First Name", text: $userData.firstName)
//                                    .frame(height: 50)
//                                    .textFieldStyle(.roundedBorder)
                                    .padding([.horizontal], 10)
                                    .frame(height: 35)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                    
                                    
//                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                            }
//                            .padding(.horizontal, 10)
                        }
                        HStack {//Row-2
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                TextField("Last Name", text: $userData.lastName)
                                    .padding([.horizontal], 10)
                                    .frame(height: 35)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                            }
                        }
                        HStack {//Row-3
                            VStack(alignment: .leading) {
                                Text("Date of Birth")
                                ZStack {
                                    Text("\(userData.dateOfBirth.formatted(date: .long, time: .omitted))")
                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                                        .foregroundColor(.black)
                                    DatePicker("", selection: $userData.dateOfBirth, in: Date()..., displayedComponents: .date)
                                        .labelsHidden()
                                        .background(.white)
                                        .opacity(0.05)
                                }
                                .padding([.horizontal], 10)
                                .frame(height: 35)
                                .frame(maxWidth:.infinity)
                                .textFieldStyle(PlainTextFieldStyle())
                                .cornerRadius(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Gender")
                                DropDownView(value: $userData.gender, placeholder: "Female", dropDownList: ["Male", "Female"])
                            }
                        }
                        if isDomestic == false {
                            HStack {//Row-4
                                VStack(alignment: .leading) {
                                    Text("Document Type")
                                    DropDownView(value: $userData.documentType, placeholder: "passport", dropDownList: ["passport"])
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Nationality")
    //                                DropDownView(value:$userData.nationality, placeholder: "Nationality", dropDownList: ["BD", "IND"])
                                    CustomPickerTextView(presentPicker: $presentPicker,
                                                         fieldString: $userData.nationality,
                                                         placeholder: "Nationality",
                                                         tag: $tag,
                                                         selectedTag: 1)
                                }
                            }
                            HStack {//Row-5
                                VStack(alignment: .leading) {
                                    Text("Passport Number*")
                                    TextField("AAA123456", text: $userData.documentNumber)
    //                                    .padding(7)
    //                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
                                        .padding([.horizontal], 10)
                                        .frame(height: 35)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                }

                                
                            }
                            HStack {//Row-6
                                VStack(alignment: .leading) {
                                    Text("Issued In")
                                    TextField("Dhaka", text: $userData.issuingCountry)
                                        .padding([.horizontal], 10)
                                        .frame(height: 35)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Expires No*")
                                    ZStack {
                                        Text("\(userData.expireDate.formatted(date: .long, time: .omitted))")
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundColor(.black)
                                        DatePicker("", selection: $userData.expireDate, in: Date()..., displayedComponents: .date)
                                            .labelsHidden()
                                            .background(.white)
                                            .opacity(0.05)
                                    }
                                    .padding([.horizontal], 10)
                                    .frame(height: 35)
                                    .frame(maxWidth:.infinity)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                    
    //                                DatePicker("", selection: $userData.expireDate, in: Date()..., displayedComponents: .date)
    //                                    .frame(maxWidth:.infinity)
    ////                                    .accentColor(.orange)
    ////                                    .background(Color.gray.opacity(0.3).cornerRadius(5))
    //                                    .labelsHidden()
    //                                    .padding([.horizontal], 10)
    //                                    .frame(height: 35)
    //                                    .textFieldStyle(PlainTextFieldStyle())
    //                                    .cornerRadius(5)
    //                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                }
                            }
                        }
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.gray.opacity(0.02))
                    .padding(.horizontal,10)
                    
                    
                    HStack(alignment: .center) {
                        Text("contact".uppercased())
                            .font(.system(size: 16, weight:.semibold, design: .rounded))
                            .foregroundColor(.black.opacity(0.7))
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height: 40.0)
                    .background(.gray.opacity(0.3))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {//Row-1
                            VStack(alignment: .leading) {
                                Text("Email")
                                TextField("Email", text: $userData.email)
                                    .padding([.horizontal], 10)
                                    .frame(height: 35)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                            }
                        }
                        
                        if isDomestic == false {
                            HStack {//Row-2
                                VStack(alignment: .leading) {
                                    Text("City Name")
                                    TextField("Dhaka", text: $userData.cityName)
                                        .padding([.horizontal], 10)
                                        .frame(height: 35)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                }

                                VStack(alignment: .leading) {
                                    Text("Country Code")
                                    TextField("BD", text: $userData.countryCode)
                                        .padding([.horizontal], 10)
                                        .frame(height: 35)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                                }
                            }
                        }
                        
                        HStack {//Row-3
                            VStack(alignment: .leading) {
                                Text("Phone Code")
                                CustomPickerTextView(presentPicker: $presentPicker,
                                                     fieldString: $userData.phoneCountryCode,
                                                     placeholder: "phoneCountryCode",
                                                     tag: $tag,
                                                     selectedTag: 2)
                            }
                            VStack(alignment: .leading) {
                                Text("Phone")
                                TextField("Phone", text: $userData.phone)
                                    .padding([.horizontal], 10)
                                    .frame(height: 35)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5)))
                            }
                            
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.gray.opacity(0.02))
                    .padding(.horizontal,10)
                    
                }
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            
            if presentPicker {
                if tag == 1 {
                    CustomPickerView(items: countriesVM.countries,
                                     pickerField: $userData.nationality,
                                     presentPicker: $presentPicker,
                    isCountryCode: true)
                        .zIndex(1.0)
                }
                if tag == 2 {
                    CustomPickerView(items: countriesVM.countries,
                                     pickerField: $userData.phoneCountryCode,
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

struct TravelerFormCell_Previews: PreviewProvider {
    static var previews: some View {
        TravelerFormCell(userData: .constant(UserData()), isDomestic: false)
    }
}
