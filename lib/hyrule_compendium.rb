require "json"
require "uri"
require "net/http"

def make_req url
    uri = URI url
    res = Net::HTTP.start uri.host, uri.port do |http|
        req = Net::HTTP::Get.new uri
        http.request req
    end
    return JSON.parse res.body
end

class Hyrule_Compendium
    def initialize url="http://botw-compendium.herokuapp.com"
        @base = url + "/api/v1"
    end

    def get_entry entry
        return make_req("#{@base}/entry/#{entry.to_s.gsub " ", "%20"}")["data"]
    end

    def get_category category
        return make_req("#{@base}/category/#{category}")["data"]
    end

    def get_all
        return make_req @base
    end
end

x = Hyrule_Compendium.new "http://127.0.0.1:5000"