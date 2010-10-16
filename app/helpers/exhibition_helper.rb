
module ExhibitionHelper
  
  def render_powerhouse_content(name, value)
    if value.is_a? Hash
      render_hash(name, value)
    elsif value.is_a? Array
      render_array(name, value)
    elsif value =~ %r{http://images.powerhousemuseum.com}
      val = value.gsub('http://images.powerhousemuseum.com/images/zoomify/thumbs/', 'http://www.powerhousemuseum.com/images/zoomify/TLF_mediums/')
      "<img src='#{val}' alt='' />"
    else
      "<span class='#{name}'>#{value.to_s}</span>"
    end
  end
  
  def render_hash(name, hash)
    Builder::XmlMarkup.new.ul(:class => name) do |ul|
      hash.each do |k, v|
        ul.li(:class => k) do |li|
          li << render_powerhouse_content(k, v)
        end
      end
    end
  end
  
  def render_array(name, array)
    Builder::XmlMarkup.new.ul(:class => name) do |ul|
      array.each do |v|
        ul.li do |li|
          li << render_powerhouse_content(name, v)
        end
      end
    end
  end
  
end
