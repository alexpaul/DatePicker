//
//  ViewController.swift
//  DatePicker
//
//  Created by Alex Paul on 11/14/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
  
  // MARK:- outlets and properties
  
  @IBOutlet weak var eventTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var createEventButton: UIButton!
  @IBOutlet weak var rsvpLabel: UILabel!
  
  var event: Event! {
    didSet { // property observer, gets called when the property changes
      // update UI whenever the event changes
      if event.willAttend {
        // update label and button
        rsvpLabel.text = "RSVP YES"
        createEventButton.setTitle("View Event", for: .normal)
      } else {
        rsvpLabel.text = "RSVP NO"
        createEventButton.setTitle("RSVP to Event", for: .normal)
      }
    }
  }
  
  // MARK: - view controller life cycle methods
  override func viewDidLoad() { // configure startup logic
    super.viewDidLoad()
    // we need to set this view controller as the delegate object
    // for the eventTextField
    // Date() creates (instantiates) a new Date object with the current date and time
    event = Event(name: "Event name not set", willAttend: false, date: Date())
    eventTextField.delegate = self // self is this view controller instance
    
    // configure the date picker in code
    datePicker.minimumDate = Date() // user is NOT allowed to set a event prior to today's date
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepare(for segue: )")
    
    // here is where we want to setup and pass the event data to
    // the detail view controller
    
    // 1. we need to get an instance of the detail view controller
    // the detail view controller is where we are transitioning to ->
    // segue.source is where the segue is coming from
    // segue.destination is where the segue is going to
    
    //let detailViewController = segue.destination // detailViewController is a UIViewController
    
    guard let detailViewController = segue.destination as? DetailViewController else {
      return
    }
    
    // we could set the event on the detail view controller
    
    // where we segueing to now has its event set successfully
    detailViewController.event = event
  }
  
  // MARK:- actions and methods
  
  @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    // updating the event's date
    event.date = sender.date
  }
}

extension CreateEventViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    // updating the event's name
    event.name = eventTextField.text ?? "" // use nil-coelescing to unwrap
    return true
  }
}
