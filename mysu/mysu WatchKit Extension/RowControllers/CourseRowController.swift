//
//  CourseRowController.swift
//  mysu WatchKit Extension
//
//  Created by ynsclk on 27.02.2020.
//  Copyright © 2020 ynsclk. All rights reserved.
//

import WatchKit

class CourseRowController: NSObject {

    @IBOutlet weak var courseGroup: WKInterfaceGroup!
    @IBOutlet weak var course: WKInterfaceLabel!
    @IBOutlet weak var time: WKInterfaceLabel!
    @IBOutlet weak var venue: WKInterfaceLabel!
    @IBOutlet weak var building: WKInterfaceLabel!
    @IBOutlet weak var endTime: WKInterfaceLabel!
}
