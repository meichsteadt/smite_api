class Api
  attr_reader(:dev_id, :key, :session_id, :prefix, :count)
  def initialize()
    @dev_id = ENV['devId']
    @key = ENV['authKey']
    @prefix = "http://api.xbox.smitegame.com/smiteapi.svc"
    @count = 0
    @session_id = create_session
  end

  def create_signature(method)
    string = "#{@dev_id}#{method}#{@key}#{self.timestamp}"
    md5 = Digest::MD5.new
    md5 << string
    md5.to_s
  end

  def create_session
    response = RestClient.get("#{@prefix}/createsessionJson/#{@dev_id}/#{self.create_signature('createsession')}/#{self.timestamp}")
    @count += 1
    @session_id = JSON.parse(response)["session_id"]
  end

  def session_id=(session_id)
    @session_id = session_id
  end

  def timestamp
    return Time.now.getutc.strftime('%Y%m%d%H%M%S')
  end

  def get_data_used
    response = RestClient.get("#{prefix}/getdatausedJson/#{@dev_id}/#{self.create_signature('getdataused')}/#{@session_id}/#{self.timestamp}")
    @count += 1
    JSON.parse(response)
  end

  def get_match_ids_by_queue(queue_id = 426, hour = self.hour, date = self.date)
    @count += 1
    response = RestClient.get("#{prefix}/getmatchidsbyqueueJson/#{@dev_id}/#{self.create_signature('getmatchidsbyqueue')}/#{@session_id}/#{self.timestamp}/#{queue_id}/#{date}/#{hour}")
    JSON.parse(response).map {|k,v| k["Match"]}
  end

  def get_esports_pro_league_details
    @count += 1
    response = RestClient.get("#{prefix}/getesportsproleaguedetailsJson/#{@dev_id}/#{self.create_signature('getesportsproleaguedetails')}/#{@session_id}/#{self.timestamp}")
    JSON.parse(response)
  end

  def get_match_details(match_id)
    @count += 1
    response = RestClient.get("#{prefix}/getmatchdetailsJson/#{@dev_id}/#{self.create_signature('getmatchdetails')}/#{@session_id}/#{self.timestamp}/#{match_id}")
    JSON.parse(response)
  end

  def get_match_details_batch(match_ids)
    @count += 1
    uri = URI::encode(match_ids.join(","))
    response = RestClient.get("#{prefix}/getmatchdetailsbatchJson/#{@dev_id}/#{self.create_signature('getmatchdetailsbatch')}/#{@session_id}/#{self.timestamp}/#{uri}")
    JSON.parse(response)
  end

  def queue_id(name)
    queues = {"arena": 435, "conquest": 426, "clash": 466, "ranked": 451, "joust": 448}
    return queues[name]
  end

  def gods
    @count += 1
    response = RestClient.get("#{prefix}/getgodsJson/#{@dev_id}/#{self.create_signature('getgods')}/#{@session_id}/#{self.timestamp}/1")
    gods = JSON.parse(response)
  end

  def get_player(player_name)
    @count += 1
    response = RestClient.get("#{prefix}/getplayerJson/#{@dev_id}/#{self.create_signature('getplayer')}/#{@session_id}/#{self.timestamp}/#{player_name}")
    JSON.parse(response)
  end

  def get_items
    @count += 1
    response = RestClient.get("#{prefix}/getitemsJson/#{@dev_id}/#{self.create_signature('getitems')}/#{@session_id}/#{self.timestamp}/1")
    JSON.parse(response)
  end

  def get_god_ranks(player_name)
    @count += 1
    response = RestClient.get("#{prefix}/getgodranksJson/#{@dev_id}/#{self.create_signature('getgodranks')}/#{@session_id}/#{self.timestamp}/#{player_name}")
    JSON.parse(response)
  end

  def get_match_history(player_name)
    @count += 1
    response = RestClient.get("#{prefix}/getmatchhistoryJson/#{@dev_id}/#{self.create_signature('getmatchhistory')}/#{@session_id}/#{self.timestamp}/#{player_name}")
    JSON.parse(response)
  end

  def get_match_player_details(match_id)
    @count += 1
    response = RestClient.get("#{prefix}/getmatchplayerdetailsJson/#{@dev_id}/#{self.create_signature('getmatchplayerdetails')}/#{@session_id}/#{self.timestamp}/#{match_id}")
    JSON.parse(response)
  end

  def date(month = Time.now.month, day = Time.now.day)
    Time.new(Time.now.year, month, day).strftime("%Y%m%d")
  end

  def hour(time = nil)
    unless time
      Time.now.strftime("%H")
    else
      Time.new(1,1,1, time).strftime("%H")
    end
  end

  def count=(number)
    @count = number
  end
end
