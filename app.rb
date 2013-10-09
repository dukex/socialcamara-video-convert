require 'rubygems'
require 'digest/md5'
require 'json'

class App
  def initialize
  end

  def call(env)
    request = Rack::Request.new(env)
    video_url = request.params['video_url']
    id = Digest::MD5.hexdigest(video_url)
    convert(video_url, id)
    [202, {'Content-Type' => 'application/json'}, [{id: id}.to_json]]
  end

  def convert(video_url, id)
      require 'open-uri'
      File.open("tmp/#{id}.asf", "wb") do |saved_file|
        open(video_url + "&d=1", "User-Agent" => "Mozila Safari 19.2",) do |read_file|
          saved_file.write(read_file.read)
        end
      end
      `ffmpeg -i tmp/#{id}.asf public/video/#{id}.mp4`
      system "rm  tmp/#{id}.asf"
  end
end


