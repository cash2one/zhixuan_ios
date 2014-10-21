//
//  departmentCustomCell.swift
//  zhixuan_ios
//
//  Created by simplejoy on 14-10-9.
//  Copyright (c) 2014年 simplejoy. All rights reserved.
//

import UIKit


class DepartmentCell: UITableViewCell {
    //营业部表格自定义
    @IBOutlet weak var departmentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var cmCountLabel: UILabel!
    
    var departmentObj:NSDictionary?
    
}
