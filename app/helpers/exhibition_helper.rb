
module ExhibitionHelper

  def item_image(item)
    n = item['multimedia_detail']
    n = n[0]
    n = n['images']
    n = n['thumbnail']
    n = n['url']
  end
  
  INCLUDED = ["description", "significance_statement"]
  def render_powerhouse_content(name, value)
    if value.is_a? Hash
      render_hash(name, value) { |k, v| render_powerhouse_content(k, v) }
    elsif value.is_a? Array
      render_array(name, value) { |k, v| render_powerhouse_content(k, v) }
    elsif value =~ %r{http://images.powerhousemuseum.com}
      ""
    else
      if INCLUDED.include?(name)
        "<p class='#{name}'>#{value.to_s}</p>"
      else
        ""
      end
    end
  end

  def render_powerhouse_images(name, value)
    if value.is_a? Hash
      render_hash(name, value) { |k, v| render_powerhouse_images(k, v) }
    elsif value.is_a? Array
      render_array(name, value) { |k, v| render_powerhouse_images(k, v) }
    elsif value =~ %r{http://images.powerhousemuseum.com}
      val = value.gsub('http://images.powerhousemuseum.com/images/zoomify/thumbs/', 'http://www.powerhousemuseum.com/images/zoomify/TLF_mediums/')
      "<img src='#{val}' alt='' />"
    else
        ""
    end
  end
  
  def render_hash(name, hash)
    hash.map { |k, v| yield k, v }.join("")
  end
  
  def render_array(name, array)
    array.map { |v| yield name, v }.join("")
  end
end
