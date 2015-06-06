class PageObject
  include Capybara::DSL
  include Assertions
  include Capybara::RSpecMatchers

  def f(*args)
    page.find(selector, *args)
  end

  def p
    selector
  end

  def all(*args)
    page.all(selector, *args)
  end

  def find_all_with_webdriver(*args)
    page.driver.browser.find_elements(:css,selector, *args)
  end

  def find_with_webdriver(*args)
    page.driver.browser.find_element(:css,selector, *args)
  end

  def should_match_fields fields
    if fields.is_a?(Hash)
      match_fields fields
    else
      fields.hashes.each do |field|
        match_fields field 
      end
    end
  end

  def match_fields field 
    field.each do|key,value|
      element = page.find(get_selector(key))
      if element.tag_name == 'input' && element[:type] == 'checkbox'
        value == 'true' ? element.should(be_checked) : element.should_not(be_checked)
      else
        element.should match value
      end
    end
  end

  def process_fields fields,block 
    fields = fields.is_a?(Array) ? fields : fields.raw.map{|x|x[0]}
    fields.each do |field|
      block.call(field)
    end
  end

  def get_selector children
    children = children.gsub(" ","").underscore
    child_object = self
    children.split('.').each do |child|
      method_name = child.split('(')[0]
      arguments = child.split('(')[1].chomp(')').split(',') if child.include? '('
      child_object = arguments.present? ? child_object.send(method_name,*[*arguments]) : child_object.send(child)
    end
    child_object.selector
  end


  def should_have_enabled fields 
    process_fields(fields,Proc.new{|field| page.find(get_selector(field)).should be_enabled})
  end

  def should_have_disabled fields 
    process_fields(fields,Proc.new{|field| page.find(get_selector(field)).should be_disabled})
  end

  def should_not_have fields
    process_fields(fields,Proc.new{|field|page.should_not have_css get_selector(field)})
  end

  def set value,*followed_by_tab
    node = self.f
    if node.tag_name.eql? "select"
      node.select value 
    else
      node.set value
      page.execute_script("$(\"#{selector}\").trigger('change')") if (followed_by_tab.present? && followed_by_tab[0].eql?(:followed_by_tab))
    end
  end

end
