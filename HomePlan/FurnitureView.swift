//
//  FurnitureView.swift
//  home generator
//
//  Created by 刘炳辰 on 15/5/21.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import Foundation
import UIKit

class FurnitureView: UIView{
    
    let dragRec = UIPanGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    let longpressRec = UILongPressGestureRecognizer()
   
    var name:String!
    let furnitureWidth:CGFloat!
    let furnitureHeight:CGFloat!

    var nameLabel:UILabel!
    
    var rotation = CGFloat()
    //check if it is saved
    var status = 0
    var id = 0
    
    func draggedView(sender:UIGestureRecognizer){
        if sender.isKindOfClass(UIPanGestureRecognizer) == true {
            //self.view.bringSubviewToFront(sender.view!)
            var translation = dragRec.translationInView(superview!)
            sender.view?.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
            dragRec.setTranslation(CGPointZero, inView: superview)
        }
    }
    
    func rotatedView(sender:UIRotationGestureRecognizer){
        var lastRotation = CGFloat()
        //self.view.bringSubviewToFront(rotateView)
        if(sender.state == UIGestureRecognizerState.Ended){
            lastRotation = 0.0;
        }
        self.rotation = 0.0 - (lastRotation - sender.rotation / 10)
        //var point = rotateRec.locationInView(rotateView)
        var currentTrans = sender.view?.transform
        var newTrans = CGAffineTransformRotate(currentTrans!, 0)
        
        sender.view?.transform = newTrans
        lastRotation = sender.rotation
        
    }
    
    func tappedView(sender:UITapGestureRecognizer){
        var currentTrans = sender.view?.transform
        var newTrans = CGAffineTransformRotate(currentTrans!, CGFloat(M_PI_2/3))
        sender.view?.transform = newTrans
    }
    
    func longpressedView(sender:UILongPressGestureRecognizer){
        if(sender.state == UIGestureRecognizerState.Began){
            if (self.status == 0){
                let alert = SCLAlertView()
                alert.addButton("保存", action: {
                    var dataModel = DataModel()
                    self.id = dataModel.furnitureList.count
                    dataModel.furnitureList.append(FurnitureInfo(name: self.name, width: self.furnitureWidth, height: self.furnitureHeight))
                    dataModel.saveData()
                    let successAlert = SCLAlertView()
                    successAlert.showSuccess("保存成功", subTitle: "已成功保存在本地", closeButtonTitle: "好的", duration: 3)
                })
                alert.addButton("删除", action: {
                    self.removeFromSuperview()
                })
                alert.showInfo("操作该家具", subTitle: "你可以保存或删除该家具？", closeButtonTitle: "Cancel")
            }else if (self.status == 1){
                let alert = SCLAlertView()
                alert.addButton("OK"){
                    var dataModel = DataModel()
                    for(var i = 0; i < dataModel.furnitureList.count; i++){
                        if(dataModel.furnitureList[i].name == self.name &&
                           dataModel.furnitureList[i].height == self.furnitureHeight &&
                           dataModel.furnitureList[i].width == self.furnitureWidth){
                            dataModel.furnitureList.removeAtIndex(i)
                            break
                        }
                    }
                    dataModel.saveData()
                    self.removeFromSuperview()
                    let successAlert = SCLAlertView()
                    successAlert.showSuccess("删除成功", subTitle: "已成功删除保存在本地的该家具", closeButtonTitle: "好的", duration: 3)
                }
                alert.showNotice("删除该家具", subTitle: "你确定删除该家具嘛？", closeButtonTitle: "Cancel")
            }
        }
    }
    
    init(frame: CGRect, name: String, height: CGFloat, width: CGFloat){
        self.name = name
        self.furnitureWidth = width
        self.furnitureHeight = height
        
        super.init(frame: frame)

        dragRec.addTarget(self, action: "draggedView:")
        rotateRec.addTarget(self, action: "rotatedView:")
        tapRec.addTarget(self, action: "tappedView:")
        longpressRec.addTarget(self, action: "longpressedView:")
        self.addGestureRecognizer(dragRec)
        //self.addGestureRecognizer(rotateRec)
        self.addGestureRecognizer(tapRec)
        self.addGestureRecognizer(longpressRec)
        self.userInteractionEnabled = true
        
        nameLabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
        nameLabel.text = self.name
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.sizeToFit()
        self.addSubview(nameLabel)
    }
    
    init(frame: CGRect, name: String, height: CGFloat, width: CGFloat, status: Int){
        self.name = name
        self.furnitureWidth = width
        self.furnitureHeight = height
        self.status = status
        super.init(frame: frame)
        
        dragRec.addTarget(self, action: "draggedView:")
        rotateRec.addTarget(self, action: "rotatedView:")
        tapRec.addTarget(self, action: "tappedView:")
        longpressRec.addTarget(self, action: "longpressedView:")
        self.addGestureRecognizer(dragRec)
        //self.addGestureRecognizer(rotateRec)
        self.addGestureRecognizer(tapRec)
        //self.addGestureRecognizer(longpressRec)
        self.userInteractionEnabled = true
        
        nameLabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
        nameLabel.text = self.name
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.textColor = UIColor.whiteColor()
        self.addSubview(nameLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}