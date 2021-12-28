require 'digest/sha2'

class Shortener

  attr_reader :url, :link_model
  def initialize(url, link_model = Link)
    @url = url
    @link_model = link_model
  end

  def generate_short_link
    link_model.create(original_url: url, lookup_code: lookup_code)
  end

  def lookup_code
    # 1. get a lookup code
    # 2. check if it already exists
    # 3. break out of the loop if it does not exist
    # 4. if not, get another code
    i = 0
    loop do
      code = get_fresh_code(i)
      break code unless link_model.exists?(lookup_code: code)
      i = i + 1
    end
  end

  private 
  
  def get_fresh_code(i)
    Digest::SHA256.hexdigest(url)[i..(i + 6)]
  end
end