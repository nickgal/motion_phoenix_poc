class InterfaceController < WKInterfaceController
  extend IB

  outlet :switches_table, WKInterfaceTable

  def awakeWithContext(context)
    super

    # Initialize variables here.
    url = NSURL.URLWithString "http://192.168.101.106:4000/api/switches"
    conf = NSURLSessionConfiguration.defaultSessionConfiguration
    session = NSURLSession.sessionWithConfiguration conf
    task = session.dataTaskWithURL(url, completionHandler: lambda do |data, res, error|
      if error
        NSLog("error? %@", error)
      else
        json = NSJSONSerialization.JSONObjectWithData data, options: 0, error: nil
        switches = json["data"]
        @switches_table.setNumberOfRows(switches.length, withRowType: "SwitchRow")
        switches.each_with_index do |switch, index|
          row = @switches_table.rowControllerAtIndex(index)
          row.switch_item.setTitle switch["name"]
          row.switch_item.setOn switch["state"]
          # mp row
        end
      end
    end)
    task.resume
    # Configure interface objects here.
    NSLog("%@ awakeWithContext", self)

    self
  end

  def willActivate
    # This method is called when watch view controller is about to be visible to user
    NSLog("%@ will activate", self)
    super
  end

  def didDeactivate
    # This method is called when watch view controller is no longer visible
    NSLog("%@ did deactivate", self)
    super
  end

end
