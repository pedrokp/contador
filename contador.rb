#Autor: Pedro Kowalski Pereira
#22/09/2017

require 'open-uri'  
require 'nokogiri'

@dic = Hash.new(0)
doc = Nokogiri::HTML(open('http://www.threescompany.com/','r:UTF-8',&:read))
doc.css('script').remove
doc.css('style').remove
conteudo = doc.css('body')

def palavras_na_string(string)
  string.scan(/[\w']+[^a-zA-Z]/i)
end

def cont_freq(lista) 
  for palavra in lista
    @dic[palavra] += 1
  end
  @dic
end

conteudo.each do |entrada|  
  palavras = palavras_na_string(entrada.content)
  cont_freq(palavras)
end

puts "SITE: #{doc.title}"
puts "Número de palavras: #{@dic.length} ..."  
puts "frequência => palavra"

@dic.sort {|b,a| a[1] <=> b[1]}.each do |key,value|
  puts "#{value} => #{key}"
end
puts "Número de palavras: #{@dic.length} ..." 