//
//  SavedFutnitureViewController.swift
//  HomePlan
//
//  Created by 刘炳辰 on 15/5/22.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import Foundation
import UIKit

class SavedFutnitureViewController: UIViewController {
    
    var furnitureList = [FurnitureInfo]()
    var furnitureViewList = [UIView]()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    var delegate:SavedFurnitureViewControllerDelegate?
    
    func swippedDown(){
        //self.tabBarController?.tabBar.hidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func longpressedView(sender:UILongPressGestureRecognizer){
        if(sender.state == UIGestureRecognizerState.Began){
            let alert = SCLAlertView()
            let tmp = sender.view as! FurnitureView
            
            alert.addButton("删除该家具"){
                var dataModel = DataModel()
                let tmp = sender.view as! FurnitureView
                for(var i = 0; i < dataModel.furnitureList.count; i++){
                    if(dataModel.furnitureList[i].name == tmp.name &&
                        dataModel.furnitureList[i].height == tmp.furnitureHeight &&
                        dataModel.furnitureList[i].width == tmp.furnitureWidth){
                            dataModel.furnitureList.removeAtIndex(i)
                            break
                    }
                }
                dataModel.saveData()
                sender.view!.removeFromSuperview()
                let successAlert = SCLAlertView()
                successAlert.showSuccess("删除成功", subTitle: "已成功删除保存在本地的该家具", closeButtonTitle: "好的", duration: 3)
            }
            alert.addButton("添加到房间", action: {
                let name = tmp.name
                let width = tmp.furnitureWidth
                let height = tmp.furnitureHeight
                self.delegate?.addNewFurniture(name, furnitureWidth: width, furnitureHeight: height)
                //self.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.showNotice("操作该家具", subTitle: "选择以下操作", closeButtonTitle: "Cancel")
        }
    }
    
    func createFurnitureList(){
        let datamodel = DataModel()
        furnitureList = datamodel.furnitureList
        if(furnitureList.count != 0){
            for(var i = 0; i < furnitureList.count ; i++){
                let longpressRec = UILongPressGestureRecognizer()
                longpressRec.addTarget(self, action: "longpressedView:")
                
                let newFurnitureView = FurnitureView(frame: CGRectMake(150, 200, furnitureList[i].height*30, furnitureList[i].width*30), name: furnitureList[i].name, height: furnitureList[i].height , width: furnitureList[i].width ,status: 1)
                newFurnitureView.backgroundColor = UIColor(red:0,green:CGFloat(arc4random_uniform(100))/100,blue:CGFloat(arc4random_uniform(100))/100,alpha:0.7)
                newFurnitureView.layer.masksToBounds = true
                newFurnitureView.layer.cornerRadius = 5.0
                newFurnitureView.status = 1
                newFurnitureView.addGestureRecognizer(longpressRec)
                
                furnitureViewList.append(newFurnitureView)
                self.view.addSubview(newFurnitureView)
                /*
                UIView.animateWithDuration(2, animations: {
                self.roomView.frame = CGRectMake(25, 50, roomWidth, roomHeight)
                self.roomView.backgroundColor = UIColor(red: 1,green: CGFloat(arc4random_uniform(100))/100,blue: CGFloat(arc4random_uniform(100))/100,alpha:1.0)
                })*/
            }
        }else{
            let label = UILabel(frame: CGRectMake(self.view.frame.width/4, 200, self.view.frame.width/2, 150))
            label.text = "还没有家具"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont(name: "Arial", size: 40)
            label.backgroundColor = UIColor(red: 0, green: 0.86, blue: 0.39, alpha: 0.8)
            label.textColor = UIColor.whiteColor()
            self.view.addSubview(label)
        }
    }
    
    @IBAction func showyes(sender: AnyObject) {
        delegate?.showyes(self)
    }
    override func viewDidLoad() {
        self.tabBarController?.tabBar.hidden = true
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        swipeDownRec.direction = UISwipeGestureRecognizerDirection.Down
        swipeDownRec.addTarget(self,action:"swippedDown")
        self.view.addGestureRecognizer(swipeDownRec)
        
        createFurnitureList()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}