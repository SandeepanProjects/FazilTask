/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import UIKit

struct Json4Swift_Base : Codable {
	let bred_for : String?
	let breed_group : String?
	let height : Height?
	let id : Int?
	let image : Image?
	let life_span : String?
	let name : String?
	let origin : String?
	let reference_image_id : String?
	let temperament : String?
	let weight : Weight?

//    var state = PetRecordState.new
//    var imageSet = UIImage(named: "Placeholder")

	enum CodingKeys: String, CodingKey {

		case bred_for = "bred_for"
		case breed_group = "breed_group"
		case height = "height"
		case id = "id"
		case image = "image"
		case life_span = "life_span"
		case name = "name"
		case origin = "origin"
		case reference_image_id = "reference_image_id"
		case temperament = "temperament"
		case weight = "weight"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bred_for = try values.decodeIfPresent(String.self, forKey: .bred_for)
		breed_group = try values.decodeIfPresent(String.self, forKey: .breed_group)
		height = try values.decodeIfPresent(Height.self, forKey: .height)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		image = try values.decodeIfPresent(Image.self, forKey: .image)
		life_span = try values.decodeIfPresent(String.self, forKey: .life_span)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		reference_image_id = try values.decodeIfPresent(String.self, forKey: .reference_image_id)
		temperament = try values.decodeIfPresent(String.self, forKey: .temperament)
		weight = try values.decodeIfPresent(Weight.self, forKey: .weight)
	}

}
