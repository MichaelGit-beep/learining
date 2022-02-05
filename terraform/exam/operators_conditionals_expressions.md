Operators just like in python
> \+ - != == >= <= < >

## Logical operators: 
&& - logical and 
    8 > 7 && 1 == 1

|| - logical or
    8 < 7 || 1 == 1

! - not operator
    var.somebool = true
    ! var.somebool = false
    > (1+1==2)
        true
    > !(1+1==2)
        false
    > !!(1+1==2)
        true

## Ternary operator:
    condition ? if_true : if_false

    
    resource "random_password" "pass1"{
        length = var.number < 200 ? 1 : 100 
    }

    output "password"{
        value = random_password.pass1.result 
    }
    