class Playlist

  def initialize(period, model)
    @period = period
    @model = model
  end

  def query
    @query = Play.playlist(@period, @model)
  end

  def rank(num)
    @plays = query
    @plays.delete_if{|k,v| k == 170} #Remove "bad" values from array 170 == "v/a"
    @ranked = @plays.to_a.sort_by!{|x,y| y }.reverse.at(num - 1)
  end

  def popular #creates an array of elements who's playcount is 2x average for given period.
    @plays = query
    array = @plays.delete_if{|k,v| v == 1}.values
    stats = DescriptiveStatistics::Stats.new(array)
    popular = stats.value_from_percentile(75)
    puts popular
    @popular = @plays.select{|k,v| v >= popular}
  end

  def unique
    @plays = query.select{|k,v| v == 1 }
  end

  def random(method)
    @plays = send(method).to_a
    @plays[rand(@plays.count)]
  end

  def self.message(period, model, rank = nil)

    @play = Playlist.new(period, model).rank(rank)

    valid = true

    if @play[1] < 2
      valid = false
    end

      model_name = model.to_s

    if period == :day
      period_name = "Today's"
    elsif period == :week
      period_name = "This week's"
    elsif period == :month
      period_name = "This month's"
    end

    model_relation = instance_eval(model_name.capitalize).find(@play[0])

    if model == :artist
      message = {:text => "#{period_name} ##{rank} artist is: #{model_relation.name.upcase} #WRFL http://gog.is/#{model_relation.name.downcase.gsub(" ","+")}+music", :is_valid => valid}
    else
      message = {:text => "#{period_name} ##{rank} #{model} is: #{model_relation.name.upcase} by #{Artist.find(model_relation.artist_id).name.upcase} #WRFL http://gog.is/#{Artist.find(model_relation.artist_id).name.downcase.gsub(" ","+")}+music", :is_valid => valid}
    end

  end

end