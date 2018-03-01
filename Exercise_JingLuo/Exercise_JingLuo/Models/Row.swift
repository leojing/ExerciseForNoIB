//
//	Row.swift
//
//	Create by Jing Luo on 28/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Row : NSObject, NSCoding, Mappable{

	var descriptionField : String?
	var imageHref : AnyObject?
	var title : String?


	class func newInstance(map: Map) -> Mappable?{
		return Row()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		descriptionField <- map["description"]
		imageHref <- map["imageHref"]
		title <- map["title"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         imageHref = aDecoder.decodeObject(forKey: "imageHref") as? AnyObject
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if imageHref != nil{
			aCoder.encode(imageHref, forKey: "imageHref")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
