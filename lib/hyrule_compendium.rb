require "json"
require "uri"
require "net/http"
require "open-uri"

class NoEntryError < StandardError
    # Raised when a given entry does not exist in the compendium
    # 
    # Parameters:
    #   * `target_entry`: Non-existant input entry that causes error.
    #       - type: str, int

    def initialize(target_entry)
        if target_entry.is_a? String
            super "Entry with name '#{target_entry}' not in compendium."
        elsif target_entry.is_a? Integer
            super "Entry with ID '#{target_entry}' not in compendium."
        end
    end
end

class NoCategoryError < StandardError
    # Raised when a given category does not exist in the compendium
    # 
    # Parameters:
    #   * `target_category`: Non-existant input category that causes error.
    #       - type: str

    def initialize(target_category)
        super "Category '#{target_category}' not in compendium. Categories are 'creatures', 'equipment', 'materials', 'monsters', and 'treaure'."
    end
end

def make_req url, timeout
    uri = URI url
    res = Net::HTTP.start uri.host, uri.port, read_timeout: timeout do |http|
        req = Net::HTTP::Get.new uri
        http.request req
    end
    return (JSON.parse res.body)["data"]
end

class Hyrule_Compendium
    # Base class for the Hyrule-Compendium
    #
    # Parameters:
    #   * `url`: The base URL of the API server
    #       - type: str
    #       - default: "http://botw-compendium.herokuapp.com/api/v2"
    #   * `default_timeout`: Default seconds to wait for response for all API calling functions until raising `Net::ReadTimeout`.
    #       - type: float, int
    #       - default: `nil` (no timeout)
    #       - notes: If a API calling function has a parameter `timeout`, it will overide this.

    def initialize url: "http://botw-compendium.herokuapp.com/api/v2", default_timeout: nil
        @base = url
        @default_timeout = default_timeout
    end

    def get_entry entry, timeout=@default_timeout
        # Gets an entry from the compendium.
        #
        # Parameters:
        #   * `entry`: The ID or name of the entry to be retrieved.
        #       - type: str, int
        #   * `timeout`: Seconds to wait for response until raising `Net::ReadTimeout`.
        #       - type: float, int
        #       - default: `@default_timeout`
        #
        # Returns: The entry's metadata.
        #   - type: hash
        #
        # Raises:
        #   * `NoEntryError` when the entry is not found.

        res = make_req("#{@base}/entry/#{entry.to_s.gsub " ", "%20"}", timeout=timeout)
        if res == {}
            raise NoEntryError.new entry
        end
        return res
    end

    def get_category category, timeout=@default_timeout
        # Gets all entries from a category in the compendium.
        # 
        # Parameters:
        #   * `category`: The name of the category to be retrieved. Must be one of the compendium categories.
        #       - type: string
        #       - notes: 
        #           * must be "creatures", "equipment", "materials", "monsters", or "treasure"
        #           * the category "creatures" has two sub-categories, as keys: "food" and "non_food"
        #   * `timeout`: Seconds to wait for response until raising `Net::ReadTimeout`.
        #       - type: float, int
        #       - default: `@default_timeout`
        #
        # Returns: All entries in the category.
        #   - type: array, hash (for creatures)
        #
        # Raises:
        #   * `NoCategoryError` when the category is not found.

        if !(["creatures", "equipment", "materials", "monsters", "treasure"].include? category)
            raise NoCategoryError.new category
        end
        return make_req "#{@base}/category/#{category}", timeout=timeout
    end

    def get_all timeout=@default_timeout
        # Gets all entries from the compendium.
        #
        # Parameters:
        #   * `timeout`: Seconds to wait for response until raising `Net::ReadTimeout`.
        #       - type: float, int
        #       - default: `@default_timeout`
        #
        # Returns: all items in the compendium with their metadata, nested in categories.
        #   - type: hash

        return make_req @base, timeout
    end

    def download_entry_image entry, output_file=nil, timeout=@default_timeout
        # Downloads the image of a compendium entry.
        # 
        # Parameters:
        #   * `entry`: The ID or name of the entry of the image to be downloaded.
        #       - type: str, int
        #   * `output_file`: The output file's path.
        #       - type: str
        #       - default: entry's name with a ".png" extension with spaces replaced with underscores
        #   * `timeout`: Seconds to wait for server response until raising `Net::ReadTimeout`.
        #       - type: float, int
        #       - default: `@default_timeout`

        entry_data = get_entry entry, timeout
        open entry_data["image"] do |image|
            File.open output_file || (entry_data["name"] + ".png").gsub(" ", "_"), "wb" do |file|
                file.write image.read
            end
        end
    end
end