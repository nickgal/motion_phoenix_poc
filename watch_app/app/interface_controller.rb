class InterfaceController < WKInterfaceController
  extend IB

  outlet :switches_table, WKInterfaceTable

  def awakeWithContext(context)
    super

    # Initialize variables here.
    # Switch.async_load do |switches|
    switches = [
      {name: 'xmas tree', state: false},
      {name: 'xmas lights', state: false},
      {name: 'plant heater', state: false},
      {name: 'plant lights', state: true},
      {name: 'living room light', state: false}
    ]
      @switches_table.setNumberOfRows(switches.length, withRowType: "SwitchRow")
      switches.each_with_index do |switch, index|
        row = @switches_table.rowControllerAtIndex(index)
        row.switch_item.setTitle switch[:name]
        row.switch_item.setOn switch[:state]
        # mp row
      end
    # end
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
