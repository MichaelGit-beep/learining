class A: 
    a = 1
    b = 2
    def __private(self):
        print('This is a private method')
    def update_a(self):
        A.a += 1
    def update_b(self):
        A.b += 1
    def __str__(self):
        return 'Private class'
            
a = A()
a.update_a()
print(A.a)
b = A()
print(b.a)


        
    
    