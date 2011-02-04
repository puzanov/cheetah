class NambaLogin
  require 'rubygems'
  require 'httparty'
  include HTTParty
  format :html

  def NambaLogin.get_dev_namba_url
    "http://namba.dev/username.php"
  end

  def NambaLogin.get_kg_namba_url
    "http://namba.kg/username.php"
  end
end

class NambaLoginKG
  def NambaLoginKG.get_login session_id
    options = { :query => {:s => session_id}}
    NambaLogin.get(NambaLogin.get_kg_namba_url, options)    
  end
end

class NambaLoginDEV
  def NambaLoginDEV.get_login session_id
    options = { :query => {:s => session_id}}
    NambaLogin.get(NambaLogin.get_dev_namba_url, options)    
  end
end

