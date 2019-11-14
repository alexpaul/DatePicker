//
//  DetailViewController.swift
//  DatePicker
//
//  Created by Alex Paul on 11/14/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK:- outlets and properties
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var selectedDateLabel: UILabel!
  @IBOutlet weak var switchControl: UISwitch!
  
  // we need an (Event) from the source view controller (CreateEventViewController)
  var event: Event? // default value is nil
  
  // DateFormatter will help us to format the Date object
  // in a more readable format
  // lazy variable - is a variable that gets created the first time its needed
  //
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy h:mm a" // .dateFormat we have more flexibility with the appearnance of the string
    //formatter.dateStyle = .long
    //formatter.timeStyle = .medium
    return formatter
  }() // () calls the the function (closure)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  // method to update the UI elements
  func updateUI() {
    guard let date = event?.date else {
      return
    }
    selectedDateLabel.text = dateFormatter.string(from: date)
    
    // set switch positon base on value of willAttend, true or false
    // if true switch will be turned on, else switch will be turned off
    switchControl.isOn = event?.willAttend ?? false // true or false
    
    messageLabel.text = event?.name ?? "Event name not available"
  }
  
  @IBAction func rsvpChanged(_ sender: UISwitch) {
    
  }
  
}
