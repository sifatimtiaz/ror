# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def smart_truncate(s, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      #return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
      return s.split(/\.(\s|$)+/).reject{ |s| s.strip.empty? }[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '...'
    end
    #a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    a = s.split(/[ ]+/)  # to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '...' : '')
  end
end
