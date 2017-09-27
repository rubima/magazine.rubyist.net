phone_book = <?xml>
  <phonebook>
    <entry>
      <name>Burak</name> 
      <phone where="work">  +41 21 693 68 67</phone>
      <phone where="mobile">+41 79 602 23 23</phone>
    </entry>
  </phonebook>
</xml>

puts phone_book.class.name
#=> REXML::Document

puts phone_book.elements["//phone[@where='mobile']"].text
#=> +41 79 602 23 23

puts phone_book.elements["//descr/a"].attribute('href')
#=> http://acme.org
