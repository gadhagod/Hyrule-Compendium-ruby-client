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

module Hyrule_Compendium

    $base = "http://botw-compendium.herokuapp.com/api/v1"

    def Hyrule_Compendium.get_entry entry
        return make_req("#{$base}/entry/#{entry.to_s.gsub " ", "%20"}")["data"]
    end

    def Hyrule_Compendium.get_category category
        return make_req("#{$base}/category/#{category}")["data"]
    end

    def Hyrule_Compendium.get_all
        return make_req $base
    end
end