module CsvHelper

  # Based on http://apidock.com/rails/ActionController/Streaming/send_file_headers!
  def set_file_headers(options)
    [:filename, :disposition].each do |arg|
      raise ArgumentError, ":#{arg} option required" if options[arg].nil?
    end

    disposition = options[:disposition]
    disposition += %(; filename="#{options[:filename]}") if options[:filename]

    headers.merge!(
      'Content-Disposition'       => disposition
    )
  end
end
