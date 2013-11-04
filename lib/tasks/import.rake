task :import_unicode => :environment do
  File.open(Rails.root + 'vendor/UnicodeData.txt') do |f|
    1_000.times.map do
      codepoint, name = f.gets.split(';')
      next if name =~ /<control>/
      puts codepoint + ' : ' + name + ' : ' + [codepoint.to_i(16)].pack("U")
      puts 'generating symbol and representation...'
      s = Sym.find_or_create_by_name name
      r = UnicodeRepresentation.find_or_create_by_codepoint codepoint.to_i(16)
      s.unicode_representations << r
    end
  end
end
