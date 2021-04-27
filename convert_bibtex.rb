require 'bibtex'
require 'yaml'
require 'optparse'

ConvTable = {
  # Physical Review
  "Physical Review"   => "Phys. Rev." ,
  "Physical Review A" => "Phys. Rev. A.",
  "Physical Review B" => "Phys. Rev. B.",
  "Physical Review C" => "Phys. Rev. C.",
  "Physical Review D" => "Phys. Rev. D.",
  "Physical Review E" => "Phys. Rev. E.",
  "Physical Review Letters" => "Phys. Rev. Lett.",

  # ACS
  "Journal of the American Chemical Society" => "J. Am. Chem. Soc.",
  "Journal of organometallic chemistry" => "J. Organomet. Chem.",
  "Inorganic Chemistry" => "Inorg. Chem.",
  "Chemistry of Materials" => "Chem. Mater.",
  "The Journal of Physical Chemistry A" => "J. Phys. Chem. A",
  "The Journal of Physical Chemistry B" => "J. Phys. Chem. B",
  "The Journal of Physical Chemistry C" => "J. Phys. Chem. C",
  "The Journal of Physical Chemistry Letters" => "J. Phys. Chem. Lett.",
  "Chemical Reviews" => "Chem. Rev.",

  "Journal of Applied Crystallography"  => "J. Appl. Crystallogr.",
  "Computational Materials Science"     => "Comp. Mat. Sci.",
  "Journal of Physics: Condensed Matter"  => "J. Phys. Condens. Matter",
  "Journal of Computational Chemistry"  => "J. Comput. Chem.",
  "The Journal of Chemical Physics"     => "J. Chem. Phys",
  "International Journal of Quantum Chemistry" => "Int. J. Quantum Chem.",

  "Bulletin of the Chemical Society of Japan" => "Bull. Chem. Soc. Jpn.",
  "Russian Chemical Bulletin" => "Russ. Chem. Bull",
  "Acta Crystallographica Section B: Structural Science, Crystal Engineering and Materials" => "Acta Crystallogr., Sect B: Struct. Sci., Cryst. Eng. Mater.",
  "Acta Crystallographica Section B: Structural Crystallography and Crystal Chemistry" => "Acta Crystallogr. B Struct. Cryst. Cryst. Chem.",

  "Coordination Chemistry Reviews" => "Coord. Chem. Rev.",
}


def convert(filename, convert_table, case_sensitive = true)
  b = BibTeX.open(filename)
  b_articles = b['@article']
  b.each do |item|
    if b_articles.include?(item)
      # Journal article
      if convert_table.has_key?(item.journal)
        item.journal = convert_table[item.journal]
      else
        STDERR.puts "warning: #{item.key} * '#{item.journal}' not found"
      end
    else  # Not article
      STDERR.puts "warning: #{item.key} : skip (not @article) "
    end

    puts item
  end
end


if __FILE__ == $0
  file_list = ARGV
  file_list.each do |file|
    convert(file, ConvTable)
  end
  #puts ConvTable.to_yaml
end

