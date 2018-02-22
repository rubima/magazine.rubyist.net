 %o{ Object subclass: 'MyClass'. }
 %o{ MyClass compile: '
   my_method: num 
     [num := num - 1. 0 < num.] whileTrue:[ 
       val := (num % 2).
       (val = 0) ifTrue: [
         Kernel puts: num.].].'}
 MyClass.new.my_method(10)
