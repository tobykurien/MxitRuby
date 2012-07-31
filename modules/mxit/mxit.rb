require 'cgi'

class Mxit
    @@mock_mxit_headers = {
        "HTTP_X_MXIT_LOCATION"=>"ZA,,06,,,Germiston,83354,81131486,7efb4d", 
        "HTTP_X_MXIT_LOGIN"=>"tobykurien", 
        "HTTP_X_MXIT_USERID_R"=>"m36264391002", 
        "HTTP_X_MXIT_HOME"=>"http://aws1.tobykurien.com/app", 
        "HTTP_X_MXIT_NICK"=>"Toby+Kurien", 
        #"HTTP_X_MXIT_USER_INPUT"=>"This+is+my+message+", 
        "HTTP_X_MXIT_PROFILE"=>"en,ZA,1976-05-12,Male,1", 
        "HTTP_X_MXIT_CONTACT"=>"gauteng_events", 
        "HTTP_X_MXIT_ID_R"=>"m36264391002",
        
        "HTTP_UA_PIXELS"=>"800x1280",  
        "HTTP_X_FORWARDED_FOR"=>"41.56.72.123", 
        "HTTP_X_DEVICE_USER_AGENT" => "Mock"
    }

    @@province_codes = {
        "01" => "North-Western Province",
        "02" => "KwaZulu-Natal",
        "03" => "Free State",
        "05" => "Eastern Cape",
        "06" => "Gauteng",
        "07" => "Mpumalanga",
        "08" => "Northern Cape",
        "09" => "Limpopo",
        "10" => "North-West",
        "11" => "Western Cape"
    }

    def initialize(request_env)
        @env =  @@mock_mxit_headers.merge request_env
    end

    def username
        @env['HTTP_X_MXIT_LOGIN']
    end

    def user_id
        @env['HTTP_X_MXIT_USERID_R']
    end

    def nickname
        CGI::unescape @env['HTTP_X_MXIT_NICK']
    end

    def message
        CGI::unescape @env['HTTP_X_MXIT_USER_INPUT'] rescue nil
    end

    def country_code
        @env['HTTP_X_MXIT_LOCATION'].split(',')[0]
    end

    def province_name
        code = @env['HTTP_X_MXIT_LOCATION'].split(',')[2]
        @@province_codes[code]
    end

    def ruty_safe?(method)
        true
    end

end
