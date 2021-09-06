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

  "Journal of the Physical Society of Japan" => "J. Phys. Soc. Japan",

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
  "ACS Applied Materials \\& Interfaces" => "ACS Appl. Mater. Interfaces",
  "Nano Letters" => "Nano Lett.",

  # Elsevier
  "Chemical Physics Letters" => "Chem. Phys. Lett.",
  "Computer Physics Communications" => "Comput. Phys. Commun.",

  # nature and science
  "Nature Photonics" => "Nat. Photonics",
  "Nature" => "Nature",
  "Science" => "Science",


  #RSC
  "Chemical Society Reviews" => "Chem. Soc. Rev.",

  "Solid State Communications" => "Solid State Commun.",
  "IEEE Journal of Quantum Electronics" => "IEEE J. Quantum Electron.",
  "Advanced Materials" => "Adv. Mater.",
  "Laser \\& Photonics Reviews" => "Laser Photonics Rev.",
  "Nanomaterials" => "Nanomaterials",
  "Sensors and Actuators B: Chemical" => "Sens. Actuators B Chem.",
  "Sensors and Actuators" => "Sens. Actuators",
  "Journal of Electroanalytical Chemistry and Interfacial Electrochemistry" => "J. Electroanal. Chem. Interf. Electrochem.", "Journal of the Optical Society of America" => "J. Opt. Soc. Am.", "The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science" => "London, Edinburgh Dublin Philos. Mag. J. Sci.", "Zeitschrift für Physik A Hadrons and nuclei" => "Z. Phys. A",

  "Applied Physics Letters"  => "Appl. Phys. Lett.",
  "Journal of Applied Crystallography"  => "J. Appl. Crystallogr.",
  "Computational Materials Science"     => "Comp. Mat. Sci.",
  "Journal of Physics: Condensed Matter"  => "J. Phys. Condens. Matter",
  "Journal of Computational Chemistry"  => "J. Comput. Chem.",
  "The Journal of Chemical Physics"     => "J. Chem. Phys.",
  "International Journal of Quantum Chemistry" => "Int. J. Quantum Chem.",

  "Bulletin of the Chemical Society of Japan" => "Bull. Chem. Soc. Jpn.",
  "Russian Chemical Bulletin" => "Russ. Chem. Bull",
  "Acta Crystallographica Section B: Structural Science, Crystal Engineering and Materials" => "Acta Crystallogr., Sect B: Struct. Sci., Cryst. Eng. Mater.",
  "Acta Crystallographica Section B: Structural Crystallography and Crystal Chemistry" => "Acta Crystallogr. B Struct. Cryst. Cryst. Chem.",

  "Coordination Chemistry Reviews" => "Coord. Chem. Rev.",
}


def convert(filename, convert_table, case_sensitive = true, no_title = false)
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

      if no_title == true
        item.title = ""
      end
    else  # Not article
      STDERR.puts "warning: #{item.key} : skip (not @article) "
    end

    puts item
  end
end


if __FILE__ == $0
  no_title = false
  case_sensitive = true
  opt = OptionParser.new
  opt.on('-i', 'ignore case'){|v| case_sensitive = false}
  opt.on('--no-title'){|v| no_title = true}
  opt.parse!(ARGV)
  STDERR.puts "Disable Title : #{no_title}"
  file_list = ARGV
  
  file_list.each do |file|
    convert(file, ConvTable, case_sensitive, no_title)
  end
  #puts ConvTable.to_yaml
end

