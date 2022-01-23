//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by munira almallki on 06/03/1443 AH.
//

import UIKit
protocol AddItemTableViewControllerDelegate : AnyObject {
    func saveButtonPressed(by controller : AddItemTableViewController, with objective:String , at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller : AddItemTableViewController)
    
    
}

