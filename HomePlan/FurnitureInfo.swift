//
//  FurnitureInfo.swift
//  home generator
//
//  Created by 刘炳辰 on 15/5/21.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import Foundation
import UIKit

class FurnitureInfo: NSObject {
    var name:String
    var width:CGFloat
    var height:CGFloat
    
    //构造方法
    init(name:String="",width:CGFloat=0,height:CGFloat=0){
        self.name = name
        self.width = width
        self.height = height
        super.init()
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("Name") as! String
        self.height=aDecoder.decodeObjectForKey("Height") as! CGFloat
        self.width=aDecoder.decodeObjectForKey("Width") as! CGFloat
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"Name")
        aCoder.encodeObject(width,forKey:"Width")
        aCoder.encodeObject(height,forKey:"Height")
    }
}
