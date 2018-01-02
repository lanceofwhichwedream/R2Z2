module R2Z2
  module DiscordCommands
    module DeleteStreamer
      extend Discordrb::Commands::CommandContainer
      command(:delstreamer, description: 'Removes a streamer', usage: 'delstreamer <username>', min_args: 1) do |event, name|
        if (name.is_a? String) and (STREAM_DATA.stream_data[event.server.id]["streamers"].keys.include? name)
          n = STREAM_DATA.stream_data[event.server.id]["streamers"].delete(name)
          STREAM_DATA.stream_data.keys.each do |x|
            unless STREAM_DATA.stream_data[x]["streamers"].nil?
              if STREAM_DATA.stream_data[x]["streamers"].keys.include? name
                @state = true
              else
                @state = false
              end
            end
          end
          m = STREAMER_HASH.streamer_hash.delete(name) if @state == false
          STREAMER_HASH.update(m)
          STREAM_DATA.update(n)
          event << "I've removed " + name + " from the list of streamers"
        else
          event << "Enter a valid username"
        end
      end
    end
  end
end
