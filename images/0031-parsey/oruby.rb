 # Objective Ruby
 require 'date'
 birthday = %o{ Date new:1993 month:2 day:24 }
 %o{ (birthday = Date today) ifTrue:[Kernel puts:'Happy'] }
