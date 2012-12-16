# Description: make an automatic annotation of sequences from a multifasta format. Use the output from script blast_retrive_best_hit.rb.
# Organization: -
# Author: Taffarel Melo Torres
# Contact: taffarelmelotorres@gmail.com
# Additional information: this step is too slow (200MB need a day to finish), but for this use only 1 CPU Processor and too little RAM. We will provide upgrades and a better performance.
# License: RuBioinfo by Taffarel Melo Torres is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License. Based on a work at https://github.com/taffareltorres/RuBioinfo. Permissions beyond the scope of this license may be available at https://github.com/taffareltorres/RuBioinfo.


# import bioruby. Need install the BioRuby gem (gem install bio)
require 'bio'
# open multifasta file
a = Bio::FlatFile.new(Bio::FastaFormat, File.new('fasta_to_annot.fasta'))
# create a fasta file annotated automatically
file = File.new('fasta_annot.fasta', 'a')
# split sequences from multifasta file
a.each_entry do |seq|
# read header file line by line (output from blast_retrive_best_hit.rb)
  File.new('best_blast_hits_(query|=|subject)').each do |header|
# optimized (at the moment) for to a fast verify and make the annotation
    i = 0
    while i <= 1
      i = 1
      if header != "\n"
# regex to save only gi from best_blast_hits
        gi = header.chomp.gsub(/[a-zA-z].*/,'')
# if header from sequence include gi from best_blast_hits print sequence annotated
        if seq.to_s.include? gi
          file.puts(header.chomp + "\n" + seq.seq)
        end
      end
# finish when return the fist hit
    break if i == 1
    end
  end
end
