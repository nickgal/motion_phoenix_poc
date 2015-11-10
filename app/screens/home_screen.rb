class HomeScreen < PM::TableScreen
  title "Switches"
  refreshable
  stylesheet HomeScreenStylesheet
  row_height :auto, estimated: 44

  def on_load
    @switches = []
    load_async
    phoenix_connect

    # view.tap do |table|
    #   rmq(table).apply_style :table
    # end
  end

  def table_data
    [{
      cells: @switches.map do |switch|
        {
          title: switch[:name],
          properties: {
            background_color: color.from_hex('444444'),
            text_label: {
              color: color.white
            }
            # 'textLabel.color' => color.random
          },
          accessory: {
            view: :switch,
            value: switch[:state],
            action: :toggle_switch,
            arguments: { switch: switch },
          }
        }
      end
    }]
  end

  def toggle_switch(args={})
    Switch.toggle args[:switch]["id"], args[:value] do
    end
  end

  def on_refresh
    load_async
  end

  def load_async
    Switch.async_load do |switches|
      @switches = switches
      stop_refreshing
      update_table_data
    end
  end

  def phoenix_connect
    url = "#{'SERVER_URL'.info_plist}/socket/websocket".to_url
    @socket = PhxSocket.alloc.initWithURL url, heartbeatInterval: 20
    @socket.connect

    @channel = PhxChannel.alloc.initWithSocket @socket, topic: "switches:lobby", params: {}
    @channel.onEvent("update", callback: lambda do |payload, _ref|
      index = @switches.find_index{|switch| switch["id"] == payload["id"]}
      @switches[index] = payload
      update_table_data
    end)
    @channel.join
  end

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    find.all.reapply_styles
  end
end
