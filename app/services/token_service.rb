class TokenService
  def sign_creator data
    sig = ""
    data.each {|key,value| sig += "#{key}=#{value}"}
    sig += API_SECRET
    sig = Digest::MD5.hexdigest(sig)
    data['sig'] = sig
  end
  def http_build_query data
    data.map{|k,v| "#{k}=#{v}"}.join("&")
  end
end