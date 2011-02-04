class NambaLogin
  require 'rubygems'
  require 'httparty'
  include HTTParty
  format :html

  def NambaLogin.get_dev_namba_url session_id
    "http://namba.dev/username.php?s="+session_id
  end

  def NambaLogin.get_kg_namba_url session_id
    "http://namba.kg/username.php?s="+session_id
  end
end
