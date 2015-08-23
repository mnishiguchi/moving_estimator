# ==> 1. Set response headers
# http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-headers
set_file_headers filename:    "users-#{Date.today}.csv",
                 disposition: "attachment"

# ==> 2. Set options if you want (e.g. :col_sep, :headers, etc)
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
options = { headers: true }

# ==> 3. Generate csv that is to be downloaded

attributes = %w(id username sign_in_count created_at confirmed_at updated_at)

CSV.generate(options) do |csv|
  # Column names in a first row
  csv << attributes

  # Write each record as an array of strings
  @users.unscoped.each do |user|
    csv << attributes.map{ |attr| user.send(attr) }
  end
end
