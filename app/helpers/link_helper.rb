# View helper methods for generating links.
module LinkHelper
  
  # Returns a link to file _absolute_or_relative_path_.  Supported _options_:
  # * :label - determines the linked text.  Supported values:
  #   * "string" - the string
  #   * nil - defaults to _absolute_or_relative_path_
  #   * :basename - basename of file
  #   * :relative_path - file path relative to <tt>Rails.root</tt>
  #   * :absolute_path - absolute file path
  #
  # All other options are treated as html attributes in the generated tag.
  #
  #   link_to_file("logs/foo.log")  
  #   #=> <a href="file:///var/rails_app/logs/foo.log">logs/foo.log</a>
  #   
  #   link_to_file("/logs/bar.log", :label => 'log of bar')
  #   #=> <a href="file:///logs/bar.log">log of bar</a>
  #
  #   link_to_file("/logs/baz.log", :id => "baz_log")
  #   #=> <a href="file:///logs/baz.log" id="baz_log">baz.log</a>
  def link_to_file(absolute_or_relative_path, options = {})
    label = file_link_label(absolute_or_relative_path, options)
    absolute_path = App::File.absolute_path(absolute_or_relative_path).to_s
    url = "file://#{absolute_path}"
    link_to(label, url, options).html_safe
  end
  
  # Returns a link to file _absolute_or_relative_path_ with the <tt>txmt</tt> protocol,
  # i.e., file will be opened in Textmate.
  #
  # Options supported:
  # * all the options supported by link_to_file, including html options
  # * :line - puts cursor at specified line number
  # * :column - puts cursor at specified column
  #
  # Generally, this requires Textmate on a Mac to work.  If you are ambitious you can set
  # the <tt>txmt</tt> protocol on your platform / browser to open another editor.
  #
  #   link_to_textmate_file("foo.log", :line => 1, :column => 2)
  #   #=> <a href="txmt://open?url=file:///var/rails_app/foo.log&line=1&column=2">foo</a>
  def link_to_textmate_file(absolute_or_relative_path, options = {})
    label = file_link_label(absolute_or_relative_path, options)
    line = options.delete(:line)
    column = options.delete(:column)
    absolute_path = App::File.absolute_path(absolute_or_relative_path).to_s
    url = "txmt://open?url=file://#{absolute_path}&line=#{line}&column=#{column}"
    content_tag(:a, label, options.merge(:href => url)).gsub("&amp;", "&").html_safe
  end
  
  # Returns string to use as link for various file link methods.
  # Has side-effect of deleting :label key from _options_.
  # See link_to_file() for documentation of options.
  def file_link_label(absolute_or_relative_path, options = {}) #:nodoc:
    label = options.delete(:label)
    if label.blank?
      absolute_or_relative_path
    else
      absolute_path = App::File.absolute_path(absolute_or_relative_path).to_s
      if label == :absolute_path
        absolute_path
      elsif label == :relative_path
        absolute_path.sub("#{Rails.root}/", "")
      elsif label == :basename
        ::File.basename(absolute_path)
      else
        label.to_s
      end
    end
  end
  
end
