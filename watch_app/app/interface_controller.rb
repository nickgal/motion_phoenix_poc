class InterfaceController < WKInterfaceController
  extend IB

  outlet :switches_table, WKInterfaceTable
  # outlet_collection :labels, UILabel # @property IBOutletCollection(UILabel) NSArray * labels;


  def awakeWithContext(context)
    super

    # Initialize variables here.
    # @hello_world.text = "hellow"
    @switches_table.setNumberOfRows(5, withRowType: "SwitchRow")
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
