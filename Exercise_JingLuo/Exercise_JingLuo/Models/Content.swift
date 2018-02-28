//
//	Content.swift
//
//	Create by Jing Luo on 28/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Content: NSObject, NSCoding, Mappable{

	var rows : [Row]?
	var title : String?


	class func newInstance(map: Map) -> Mappable?{
		return Content()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		rows <- map["rows"]
		title <- map["title"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         rows = aDecoder.decodeObject(forKey: "rows") as? [Row]
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if rows != nil{
			aCoder.encode(rows, forKey: "rows")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
