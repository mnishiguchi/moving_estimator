# ==> response headers
# http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-headers
filename = "#{@moving.title}-items-#{Date.today}.csv"
response.headers["Content-Disposition"] = "attachment; filename='#{filename}'"

# ==> options (:col_sep, :headers, etc)
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
options = {}

# ==> column names
attributes = %w(name volume quantity room category description)

CSV.generate(options) do |csv|
  # table header
  csv << [ Time.zone.now.getlocal ]
  csv << [ @moving.title ]
  csv << [ @moving.description ]
  csv << []
  csv << attributes

  # table body
  @moving_items.each do |item|
    csv << attributes.map{ |attr| item.send(attr) }
  end
end
