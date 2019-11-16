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
  
  var event: Event? {
    didSet { // property observer, gets called when the property changes
      // changes meaning when it gets assigned a new value
      // update UI whenever the event changes
      if event?.willAttend ?? false {
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
    
    // 2. we need to set the event object for the detailViewController
    // where we segueing to now has its event set successfully
    detailViewController.event = event
  }
  
  // MARK:- actions and methods
  
  @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    // updating the event's date
    event?.date = sender.date
  }
  
  // unwind segue action
  // we need to create an IBAction for the unwind segue
  // we need to connect the action button from the source
  // view controller (DetailViewController) to this unwind segue action
  
  // it's REQUIRED to have a parameter of type UIStoryboardSegue in
  // the unwind segue action
  // why: this is the only way interface builder can recognize
  // an unwind segue to connect to
  
  // Steps to create an unwind segue - returning from a source view controller
  // 1. write an @IBAction func
  // 2. a UIStorybaordSegue parameter is REQUIRED e.g segue: UIStoryboardSegue
  // 3. type cast ( as? ) and get access to the soure view controller instance
  // 4. setup ui accordingly see event = detailViewController.event, didSet{....} on event property above
  // 5. in storyboard control-drag action button to "exit" icon in source view controlller scene and select e.g this method (updateUIFromUnwindSegue)
  @IBAction func updateUIFromUnwindSegue(segue: UIStoryboardSegue) {
    // we need access to the source destination view controller
    guard let detailViewController = segue.source as? DetailViewController else {
      return // more on refactoring to fatalError() later
    }
    event = detailViewController.event
    // after event is set here, didSet{....} on the event property gets called
    // and the UI (user interface) is updated
    // ui elements that gets updated are the rsvpLabel's text and createEventButton's titleLabel
  }
}

extension CreateEventViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    // updating the event's name
    event?.name = eventTextField.text ?? "" // use nil-coelescing to unwrap
    return true
  }
}
