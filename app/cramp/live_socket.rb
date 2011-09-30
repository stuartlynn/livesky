class LiveSocket < Cramp::Action

  on_start :create_redis,:handle_join
  on_finish :destroy_redis
#  periodic_timer :check_activities, :every => 15
  self.transport = :sse
  
  
  def create_redis
    redis_details = YAML.load_file( 'config/redis.yml')
    redis_details = redis_details['production']
    @sub = EM::Hiredis.connect("redis://:#{redis_details['password']}@#{redis_details["host"]}:#{redis_details["port"]}/#{redis_details["db"]}")
    subscribe
  end
  
  def destroy_redis
    puts "lost user :-("
    @sub.close_connection_after_writing
  end
  
  def check_activities
    puts "fiering update "
    render encode_json(:action=>"update", :message=>"fired automagically")
  end
  
  def handle_join
      @user_count ||=0
      @user_count +=1
      puts "user joined"
      render ({:action=>"hello", :message=>"How you doin"}).to_json
    end
  
  
  private

  def subscribe
    @sub.subscribe('classifications')
    @sub.on(:message) {|channel, message| puts "pushing out classificaion" ;render ({:action=>"new_classification",:message=>message}).to_json }    
  end
  
  def encode_json(obj)
    Yajl::Encoder.encode(obj)
  end
  
  def parse_json(str)
    Yajl::Parser.parse(str, :symbolize_keys => true)
  end

end