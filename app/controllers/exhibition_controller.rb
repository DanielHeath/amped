class ExhibitionController < ApplicationController

  def index
    @exhibition_json = apollo_hash
    @exhibition_json['items'].each do |item|
      item['multimedia_detail'] = JSON.parse( powerhouse_api_get item['multimedia_uri'] )['multimedia']
      item['item_detail'      ] = JSON.parse( powerhouse_api_get item['item_uri'      ] )['item']
    end
    @items = @exhibition_json['items']
#    Rails.logger.debug "***************************"
#    Rails.logger.debug @items.to_yaml
#    Rails.logger.debug "***************************"
  end
  
  def apollo_hash
    JSON.parse(apollo_content)
  end
  
  def apollo_content
    powerhouse_api_get "/api/v1/item/json/?api_key=651770a0533e4d0&significance_statement=apollo"
  end
  
  def powerhouse_api_get(uri)
    RestClient.get powerhouse_api + uri
  end
  
  def powerhouse_api
    "http://api.powerhousemuseum.com"
  end

end
