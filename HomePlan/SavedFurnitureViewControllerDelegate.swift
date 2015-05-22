//
//  SavedFurnitureViewControllerDelegate.swift
//  home generator
//
//  Created by 刘炳辰 on 15/5/22.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import Foundation
import UIKit

protocol SavedFurnitureViewControllerDelegate{
    func addNewFurniture(name: String, furnitureWidth: CGFloat, furnitureHeight: CGFloat)
    func showyes(controller: SavedFutnitureViewController)
}