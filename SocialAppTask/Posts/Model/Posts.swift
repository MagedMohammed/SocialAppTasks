/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Posts: Mappable {
	var userId : Int?
	var id : Int?
	var title : String?
	var body : String?

    init(){}
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		userId <- map["userId"]
		id <- map["id"]
		title <- map["title"]
		body <- map["body"]
	}

}
