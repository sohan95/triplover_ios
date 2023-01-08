/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Cnn : Codable {
	let discountPrice : Double?
	let ait : Double?
	let totalPrice : Double?
	let basePrice : Double?
	let equivalentBasePrice : Double?
	let taxes : Double?
	let serviceCharge : Double?
	let taxesBreakdown : [TaxesBreakdown]?

	enum CodingKeys: String, CodingKey {

		case discountPrice = "discountPrice"
		case ait = "ait"
		case totalPrice = "totalPrice"
		case basePrice = "basePrice"
		case equivalentBasePrice = "equivalentBasePrice"
		case taxes = "taxes"
		case serviceCharge = "serviceCharge"
		case taxesBreakdown = "taxesBreakdown"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		discountPrice = try values.decodeIfPresent(Double.self, forKey: .discountPrice)
		ait = try values.decodeIfPresent(Double.self, forKey: .ait)
		totalPrice = try values.decodeIfPresent(Double.self, forKey: .totalPrice)
		basePrice = try values.decodeIfPresent(Double.self, forKey: .basePrice)
		equivalentBasePrice = try values.decodeIfPresent(Double.self, forKey: .equivalentBasePrice)
		taxes = try values.decodeIfPresent(Double.self, forKey: .taxes)
		serviceCharge = try values.decodeIfPresent(Double.self, forKey: .serviceCharge)
		taxesBreakdown = try values.decodeIfPresent([TaxesBreakdown].self, forKey: .taxesBreakdown)
	}

}