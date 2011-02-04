class NambaLogin
  require 'net/http'
  require 'uri'
  
  def NambaLogin.get_dev_namba_url
    "http://namba.dev/username.php?s="
  end

  def NambaLogin.get_kg_namba_url
    "http://namba.kg/username.php?s="
  end
  
  def NambaLogin.get_content(requested_url)
    url = URI.parse(requested_url.chomp)
    full_path = "#{url.path}?#{url.query}"
    the_request = Net::HTTP::Get.new(full_path)

    the_response = Net::HTTP.start(url.host, url.port) { |http|
      http.request(the_request)
    }

    raise "Response was not 200, response was #{the_response.code}" if the_response.code != "200"
    return the_response.body
  end 
end

class NambaLoginKG
  def NambaLoginKG.get_login session_id
    NambaLogin.get_content NambaLogin.get_kg_namba_url + session_id   
  end
end

class NambaLoginDEV
  def NambaLoginDEV.get_login session_id
    NambaLogin.get_content NambaLogin.get_dev_namba_url + session_id   
  end
end

