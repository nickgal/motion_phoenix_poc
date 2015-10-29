class Switch
  def self.async_load(&callback)
    url = "http://192.168.101.106:4000/api/switches"
    AFMotion::JSON.get(url) do |result|
      if result.success?
        payload = result.object.with_indifferent_access
        callback.call payload[:data]
      else
        callback.call nil
      end
    end
  end

  def self.toggle(switch_id, state, &callback)
    url = "http://192.168.101.106:4000/api/switches/#{switch_id}"
    AFMotion::JSON.put(url, switch: { state: state }) do |result|
      if result.success?
        callback.call result
      else
        callback.call nil
      end
    end
  end
end
