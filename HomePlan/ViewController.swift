//
//  ViewController.swift
//  HomePlan
//
//  Created by 刘炳辰 on 15/5/22.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SavedFurnitureViewControllerDelegate {
    
    var ratio:CGFloat = 1.0
    var oldRatio:CGFloat = 1.0
    
    var roomView:UIView!
    var heightView:UIView!
    var widthView:UIView!
    
    var heightLabel:UILabel!
    var widthLabel:UILabel!
    
    var furnitureViewList = [FurnitureView]()
    //use index to check is there already has a roomview
    var index = 0
    
    @IBOutlet weak var savedFurButton: UIButton!
    @IBOutlet weak var addFurnitureButton: UIButton!
    @IBOutlet weak var setRoomButton: UIButton!
    
    @IBAction func setRoomSize(sender: AnyObject) {
        self.setRoomSize()
    }
    
    @IBAction func showSavedFurniture(sender: AnyObject) {
        let SavedFurnitureViewController = SavedFutnitureViewController()
        SavedFurnitureViewController.delegate = self
        self.presentViewController(SavedFurnitureViewController, animated: true, completion: nil)
    }
    
    @IBAction func addNewFurniture(sender: AnyObject) {
        if(index == 0){
            let alert = SCLAlertView()
            alert.addButton("添加一个新room"){
                self.setRoomSize()
            }
            alert.showError("不可以", subTitle: "请先添加一个room", closeButtonTitle: "OK")
        }else{
            let add_furniture_alert = SCLAlertView()
            
            let text_length = add_furniture_alert.addTextField(title: "请输入长度")
            text_length.keyboardType = UIKeyboardType.NumberPad
            let text_width = add_furniture_alert.addTextField(title: "请输入宽度")
            text_width.keyboardType = UIKeyboardType.NumberPad
            let text_name = add_furniture_alert.addTextField(title: "请输入名字")
            
            add_furniture_alert.addButton("OK"){
                
                if (text_length.text != "" && text_width.text != ""){
                    let length = CGFloat((text_length.text as NSString).doubleValue) * self.ratio
                    let width = CGFloat((text_width.text as NSString).doubleValue) * self.ratio
                    //create a new furniure
                    let newFurnitureView = FurnitureView(frame: CGRectMake(240, 240, 10, 10), name: text_name.text, height: CGFloat((text_length.text as NSString).doubleValue), width:  CGFloat((text_width.text as NSString).doubleValue))
                    newFurnitureView.backgroundColor = UIColor(red:0,green:CGFloat(arc4random_uniform(100))/100,blue:CGFloat(arc4random_uniform(100))/100,alpha:0.8)
                    newFurnitureView.layer.masksToBounds = true
                    newFurnitureView.layer.cornerRadius = 5.0
                    newFurnitureView.status = 0
                    
                    UIView.animateWithDuration(1.0, animations: {
                        newFurnitureView.frame = CGRectMake(195, 195, length+10, width+10)
                    })
                    UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        newFurnitureView.frame = CGRectMake(200, 200, length, width)
                        }, completion: nil)
                    
                    self.furnitureViewList.append(newFurnitureView)
                    self.view.addSubview(newFurnitureView)
                }
                else{
                    println("llalalalala")
                }
            }
            
            add_furniture_alert.showEdit("添加一个家具", subTitle: "设置家具长和宽", closeButtonTitle: "取消")
        }
    }
    
    func setRoomSize(){
        let set_size_alert = SCLAlertView()
        
        let text_width = set_size_alert.addTextField(title: "请输入宽度feet")
        text_width.keyboardType = UIKeyboardType.NumberPad
        let text_length = set_size_alert.addTextField(title: "请输入长度feet")
        text_length.keyboardType = UIKeyboardType.NumberPad
        
        set_size_alert.addButton("OK"){
            if(text_length.text != "" && text_width.text != ""){
                
                var width = CGFloat(text_width.text.toInt()!)
                var length = CGFloat(text_length.text.toInt()!)
                
                self.ratio = (self.view.frame.width - 50) / width
                
                let roomWidth = self.view.frame.width - 50
                let roomHeight = (self.view.frame.width - 50) * length / width
                
                if(self.index == 0){
                    self.oldRatio = self.ratio
                    self.roomView = UIView(frame: CGRectMake(self.view.center.x-10, self.view.center.y-10 , 20, 20))
                    self.roomView.backgroundColor = UIColor(red: 1,green: 0.9,blue: 0.9,alpha:1.0)
                    self.roomView.layer.cornerRadius = 5.0
                    
                    self.heightView = UIView(frame: CGRectMake(2.5, -300, 20, 300))
                    self.heightView.backgroundColor = UIColor(red: 0, green: 0.86, blue: 0.90, alpha: 1.0)
                    self.heightView.layer.cornerRadius = 10.0
                    
                    self.heightLabel = UILabel(frame: CGRectMake(1, 90, 18, 300))
                    //self.heightLabel.backgroundColor = UIColor.blueColor()
                    self.heightLabel.text = "长度 ：\(Int(length)) 英尺"
                    self.heightLabel.textColor = UIColor.blackColor()
                    self.heightLabel.numberOfLines = 0
                    self.heightLabel.sizeToFit()
                    
                    self.widthView = UIView(frame: CGRectMake(-300, 26, 300, 20))
                    self.widthView.backgroundColor = UIColor(red: 0, green: 0.86, blue: 0.90, alpha: 1.0)
                    self.widthView.layer.cornerRadius = 10.0
                    self.widthLabel = UILabel(frame: CGRectMake(90, 0, 300, 20))
                    //self.widthLabel.backgroundColor =
                    self.widthLabel.text = "宽度 ：\(Int(width)) 英尺"
                    self.widthLabel.textColor = UIColor.blackColor()
                    //self.widthLabel.sizeToFit()
                    
                    self.heightView.addSubview(self.heightLabel)
                    self.widthView.addSubview(self.widthLabel)
                    self.view.addSubview(self.heightView)
                    self.view.addSubview(self.widthView)
                    self.view.addSubview(self.roomView)
                    
                    UIView.animateWithDuration(1.0, animations: {
                        self.roomView.frame = CGRectMake(20, 40, roomWidth+10, roomHeight+20)
                        self.heightView.frame = CGRectMake(2.5, roomHeight/2-100, 20, 300)
                        self.widthView.frame = CGRectMake(self.view.center.x-150, 26, 300, 20)
                    })
                    UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        self.roomView.frame = CGRectMake(25, 50, roomWidth, roomHeight)
                        }, completion: nil)
                    
                    self.oldRatio = self.ratio
                    self.index = 1
                }else{
                    self.heightLabel.text = "长度 ：\(Int(length)) 英尺"
                    self.widthLabel.text = "宽度 ：\(Int(width)) 英尺"
                    
                    UIView.animateWithDuration(0.3, animations: {
                        self.roomView.frame = CGRectMake(25, 50, roomWidth, roomHeight)
                        self.roomView.backgroundColor = UIColor(red: 1,green: CGFloat(arc4random_uniform(80))/100,blue: CGFloat(arc4random_uniform(80))/100,alpha:1.0)
                        for(var i = 0 ; i < self.furnitureViewList.count ; i++ ){
                            self.furnitureViewList[i].frame = CGRectMake(self.furnitureViewList[i].frame.origin.x, self.furnitureViewList[i].frame.origin.y, self.furnitureViewList[i].frame.width*self.ratio/self.oldRatio, self.furnitureViewList[i].frame.height*self.ratio/self.oldRatio)
                        }
                        
                    })
                    
                    UIView.beginAnimations("flipHeight", context: nil)
                    UIView.setAnimationDuration(1.3)
                    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
                    UIView.setAnimationDelegate(self)
                    UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.heightView, cache: true)
                    UIView.commitAnimations()
                    
                    UIView.beginAnimations("flipWidth", context: nil)
                    UIView.setAnimationDuration(1.3)
                    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
                    UIView.setAnimationDelegate(self)
                    UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.widthView, cache: true)
                    UIView.commitAnimations()
                    
                    UIView.beginAnimations("flipRoom", context: nil)
                    UIView.setAnimationDuration(1.3)
                    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
                    UIView.setAnimationDelegate(self)
                    UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: self.roomView, cache: true)
                    UIView.commitAnimations()
                    
                }
            }
        }
        set_size_alert.showEdit("设置房间大小", subTitle: "请输入房间长和宽", closeButtonTitle: "取消")
    }
    
    func addNewFurniture(name: String, furnitureWidth: CGFloat, furnitureHeight: CGFloat) {
        let length = furnitureHeight * self.ratio
        let width = furnitureWidth * self.ratio
        //create a new furniure
        let newFurnitureView = FurnitureView(frame: CGRectMake(100, 100, length, width), name: name, height: furnitureHeight, width:  furnitureWidth)
        newFurnitureView.backgroundColor = UIColor(red:0,green:CGFloat(arc4random_uniform(100))/100,blue:CGFloat(arc4random_uniform(100))/100,alpha:0.7)
        newFurnitureView.layer.masksToBounds = true
        newFurnitureView.layer.cornerRadius = 5.0
        newFurnitureView.status = 0
     
        self.view.addSubview(newFurnitureView)
        self.furnitureViewList.append(newFurnitureView)
    }
    
    func showyes(controller: SavedFutnitureViewController){
        println("yeah")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavedFurnitureView"{
            let controller = segue.destinationViewController as! SavedFutnitureViewController
            //controller.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 0, green: 0.156, blue: 0.27, alpha: 0.9)
        addFurnitureButton.layer.cornerRadius = 8.0
        savedFurButton.layer.cornerRadius = 8.0
        setRoomButton.layer.cornerRadius = 8.0
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

