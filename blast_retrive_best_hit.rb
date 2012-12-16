# Description: retrive the best blast hit (only one) from xml-blast output. Use a reference database to provide an automatic annotation in next steps.
# Organization: -
# Author: Taffarel Melo Torres
# Contact: taffarelmelotorres@gmail.com
# Additional information: run 5GB in a few minutes (in average 30), using only 1 CPU Processor and too little RAM.
# License: RuBioinfo by Taffarel Melo Torres is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License. Based on a work at https://github.com/taffareltorres/RuBioinfo. Permissions beyond the scope of this license may be available at https://github.com/taffareltorres/RuBioinfo.


# require gem libxml-ruby
require "xml/libxml"
# create the output file
file = File.new('best_blast_hits_(query|=|subject)', 'a')
# optimized input reading (xml-blast output). Too little RAM is required
reader = XML::Reader.file 'blast_output.xml'
# reading xml-tags
while reader.read
# read if is not a final xml-tag
  if reader.node_type != XML::Reader::TYPE_END_ELEMENT
# read a specific xml-tag from xml-blast output
# you can add a new tag if necessary
    case reader.name
      when 'Iteration_query-def'
        reader.read
        cab_query = reader.value
      when 'Hit_num'
        reader.read
        hit_num = reader.value
      when 'Hit_def'
        reader.read
        cab_subject = reader.value
# verify if this is a first (best) blast result
# increase value to list more hits
        if hit_num.to_i <= 1
# save in a file the query associated with the best subject
          file.puts('>' + cab_query + '|=' + cab_subject)
        else
      end
    end
  end
end
