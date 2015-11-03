class Switch
  def self.async_load(&callback)
    url = "#{'SERVER_URL'.info_plist}/api/switches"
    AFMotion::JSON.get(url) do |result|
      if result.success?
        payload = result.object.with_indifferent_access
        callback.call payload[:data]
      else
        callback.call []
      end
    end
  end

  def self.toggle(switch_id, state, &callback)
    url = "#{'SERVER_URL'.info_plist}/api/switches/#{switch_id}"
    AFMotion::JSON.put(url, switch: { state: state }) do |result|
      if result.success?
        callback.call result
      else
        callback.call nil
      end
    end
  end
end
