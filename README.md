# DatePicker

Using UIDatePicker, Date, DateFormatter and unwind segue to create a Date event app.

![date picker app](Assets/date-picker-app.png)

## Key Methods 

#### prepare(for segue: ) - passes data from the destination view controller to the source view controller 
```swift 
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
```

#### updateUIFromUnwindSegue - unwind segue method, gets data from the source view controller to the destination view controller
```swift
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
```
