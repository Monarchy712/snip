[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$snippets = [ordered]@{
    "1" = @{
        Title = "Class, Encapsulation and Data Abstraction"
        Code = @'
#include <iostream>
using namespace std;

class BankAccount {
private:
    double balance; // hidden implementation detail
public:
    BankAccount(double b) : balance(b) {}
    void deposit(double amount) {
        if (amount > 0) balance += amount;
    }
    double getBalance() const { return balance; }
};

int main() {
    BankAccount account(100);
    account.deposit(50);
    cout << account.getBalance() << '\n';
}
'@
    }
    "2" = @{
        Title = "Default, Parameterized and Destructor"
        Code = @'
#include <iostream>
using namespace std;

class Demo {
    int x;
public:
    Demo() : x(0) { cout << "Default constructor\n"; }
    Demo(int a) : x(a) { cout << "Parameterized constructor\n"; }
    ~Demo() { cout << "Destructor for " << x << '\n'; }
    void show() const { cout << x << '\n'; }
};

int main() {
    Demo a;
    Demo b(10);
    a.show();
    b.show();
}
'@
    }
    "3" = @{
        Title = "Copy Constructor"
        Code = @'
#include <iostream>
using namespace std;

class Demo {
    int x;
public:
    Demo(int a) : x(a) {}
    Demo(const Demo& other) : x(other.x) {
        cout << "Copy constructor called\n";
    }
    void show() const { cout << x << '\n'; }
};

int main() {
    Demo a(10);
    Demo b = a;
    b.show();
}
'@
    }
    "4" = @{
        Title = "Shallow Copy vs Deep Copy"
        Code = @'
#include <iostream>
using namespace std;

class Box {
public:
    int* ptr;

    Box(int value) : ptr(new int(value)) {}

    // Deep copy: allocate separate memory and copy the value.
    Box(const Box& other) : ptr(new int(*other.ptr)) {}

    ~Box() { delete ptr; }
};

int main() {
    Box a(10);
    Box b = a;       // invokes deep-copy constructor
    *b.ptr = 99;
    cout << *a.ptr << '\n'; // 10
    cout << *b.ptr << '\n'; // 99
}
'@
    }
    "5" = @{
        Title = "Static and Non-Static Members"
        Code = @'
#include <iostream>
using namespace std;

class Student {
public:
    static int count;
    int roll;

    Student(int r) : roll(r) { ++count; }
    void show() const { cout << roll << '\n'; }
    static void showCount() { cout << count << '\n'; }
};

int Student::count = 0;

int main() {
    Student a(1), b(2);
    a.show();
    Student::showCount();
}
'@
    }
    "6" = @{
        Title = "Inheritance and Derived Class"
        Code = @'
#include <iostream>
using namespace std;

class Base {
public:
    int x;
    Base(int a) : x(a) {}
    void showBase() const { cout << x << '\n'; }
};

class Derived : public Base {
public:
    int y;
    Derived(int a, int b) : Base(a), y(b) {}
    void show() const { cout << x << " " << y << '\n'; }
};

int main() {
    Derived d(10, 20);
    d.showBase();
    d.show();
}
'@
    }
    "7" = @{
        Title = "Constructor Inheritance and Base Initializer"
        Code = @'
#include <iostream>
using namespace std;

class Base {
public:
    Base(int x) { cout << "Base: " << x << '\n'; }
};

class Derived : public Base {
public:
    using Base::Base; // inherit base constructors
};

class AnotherDerived : public Base {
public:
    AnotherDerived(int x) : Base(x) {}
};

int main() {
    Derived a(10);
    AnotherDerived b(20);
}
'@
    }
    "8" = @{
        Title = "Compile-Time Polymorphism: Function Overloading"
        Code = @'
#include <iostream>
using namespace std;

class Print {
public:
    void show(int x) { cout << "int: " << x << '\n'; }
    void show(double x) { cout << "double: " << x << '\n'; }
    void show(string x) { cout << "string: " << x << '\n'; }
};

int main() {
    Print p;
    p.show(10);
    p.show(2.5);
    p.show(string("hello"));
}
'@
    }
    "9" = @{
        Title = "Runtime Polymorphism: Virtual and Override"
        Code = @'
#include <iostream>
using namespace std;

class Base {
public:
    virtual void show() { cout << "Base\n"; }
    virtual ~Base() = default;
};

class Derived : public Base {
public:
    void show() override { cout << "Derived\n"; }
};

int main() {
    Derived d;
    Base& ref = d;
    ref.show(); // Derived
}
'@
    }
    "10" = @{
        Title = "Operator Overloading: + and this"
        Code = @'
#include <iostream>
using namespace std;

class Number {
    int value;
public:
    Number(int v = 0) : value(v) {}
    Number operator+(const Number& other) const {
        return Number(this->value + other.value);
    }
    void show() const { cout << value << '\n'; }
};

int main() {
    Number a(10), b(20);
    Number c = a + b;
    c.show();
}
'@
    }
    "11" = @{
        Title = "ostream Operator and Friend Function"
        Code = @'
#include <iostream>
using namespace std;

class Point {
    int x, y;
public:
    Point(int a, int b) : x(a), y(b) {}
    friend ostream& operator<<(ostream& out, const Point& p);
};

ostream& operator<<(ostream& out, const Point& p) {
    out << '(' << p.x << ", " << p.y << ')';
    return out;
}

int main() {
    Point p(2, 3);
    cout << p << '\n';
}
'@
    }
    "12" = @{
        Title = "Friend Class"
        Code = @'
#include <iostream>
using namespace std;

class A {
    int secret = 42;
    friend class B;
};

class B {
public:
    void reveal(const A& obj) {
        cout << obj.secret << '\n';
    }
};

int main() {
    A a;
    B b;
    b.reveal(a);
}
'@
    }
    "13" = @{
        Title = "Dynamic Allocation and Destructor"
        Code = @'
#include <iostream>
using namespace std;

class Array {
    int* data;
    int size;
public:
    Array(int n) : data(new int[n]{}), size(n) {}
    ~Array() { delete[] data; }
    void set(int i, int value) {
        if (i >= 0 && i < size) data[i] = value;
    }
    void print() const {
        for (int i = 0; i < size; ++i) cout << data[i] << ' ';
        cout << '\n';
    }
};

int main() {
    Array a(3);
    a.set(0, 10);
    a.set(1, 20);
    a.print();
}
'@
    }
    "14" = @{
        Title = "Assignment Operator Overloading"
        Code = @'
#include <iostream>
using namespace std;

class Buffer {
    int* ptr;
public:
    Buffer(int v = 0) : ptr(new int(v)) {}
    Buffer(const Buffer& other) : ptr(new int(*other.ptr)) {}

    Buffer& operator=(const Buffer& other) {
        if (this != &other) {
            int* fresh = new int(*other.ptr);
            delete ptr;
            ptr = fresh;
        }
        return *this;
    }

    ~Buffer() { delete ptr; }
    int get() const { return *ptr; }
};

int main() {
    Buffer a(10), b(20);
    b = a;
    cout << b.get() << '\n';
}
'@
    }
    "15" = @{
        Title = "Inheritance Types: Single, Multilevel, Multiple"
        Code = @'
#include <iostream>
using namespace std;

class A { public: void a() { cout << "A\n"; } };
class B : public A { public: void b() { cout << "B\n"; } }; // single
class C : public B { public: void c() { cout << "C\n"; } }; // multilevel
class X { public: void x() { cout << "X\n"; } };
class Y { public: void y() { cout << "Y\n"; } };
class Z : public X, public Y {}; // multiple

int main() {
    C obj;
    obj.a(); obj.b(); obj.c();
    Z z;
    z.x(); z.y();
}
'@
    }
    "16" = @{
        Title = "Diamond Problem and Virtual Base Class"
        Code = @'
#include <iostream>
using namespace std;

class Person {
public:
    int id;
    Person() : id(1) {}
};

class Student : virtual public Person {};
class Employee : virtual public Person {};
class TA : public Student, public Employee {};

int main() {
    TA t;
    t.id = 25; // one shared Person base subobject
    cout << t.id << '\n';
}
'@
    }
    "17" = @{
        Title = "Pure Virtual Function and Abstract Class"
        Code = @'
#include <iostream>
using namespace std;

class Shape {
public:
    virtual double area() const = 0; // pure virtual
    virtual ~Shape() = default;
};

class Circle : public Shape {
    double r;
public:
    Circle(double radius) : r(radius) {}
    double area() const override { return 3.14159 * r * r; }
};

int main() {
    Circle c(2);
    cout << c.area() << '\n';
    // Shape s; // invalid: abstract class
}
'@
    }
    "18" = @{
        Title = "Function Overriding without Virtual"
        Code = @'
#include <iostream>
using namespace std;

class Base {
public:
    void show() { cout << "Base\n"; }
};

class Derived : public Base {
public:
    void show() { cout << "Derived\n"; }
};

int main() {
    Derived d;
    d.show(); // Derived
    Base* p = &d;
    p->show(); // Base: non-virtual, static binding
}
'@
    }
    "19" = @{
        Title = "Friend Function"
        Code = @'
#include <iostream>
using namespace std;

class Box {
    int width;
public:
    Box(int w) : width(w) {}
    friend void printWidth(const Box& b);
};

void printWidth(const Box& b) {
    cout << b.width << '\n';
}

int main() {
    Box b(15);
    printWidth(b);
}
'@
    }
    "20" = @{
        Title = "Quick Combined OOP Demo"
        Code = @'
#include <iostream>
using namespace std;

class Base {
protected:
    int value;
public:
    Base(int v) : value(v) {}
    virtual void display() const { cout << "Base " << value << '\n'; }
    virtual ~Base() = default;
    friend class Inspector;
};

class Derived : public Base {
public:
    using Base::Base;
    void display() const override { cout << "Derived " << value << '\n'; }
    Derived operator+(const Derived& rhs) const {
        return Derived(value + rhs.value);
    }
    friend ostream& operator<<(ostream& out, const Derived& d) {
        return out << d.value;
    }
};

class Inspector {
public:
    void inspect(const Base& b) { cout << "Inspector sees " << b.value << '\n'; }
};

int main() {
    Derived a(10), b(20);
    Derived c = a + b;
    cout << "Sum: " << c << '\n';
    Base* p = &c;
    p->display();
    Inspector i;
    i.inspect(c);
}
'@
    }
}

while ($true) {
    Clear-Host
    Write-Host ""
    Write-Host "  +======================================================+" -ForegroundColor Cyan
    Write-Host "  |          IOOP CSLP02 Snippet Picker (Exam Mode)      |" -ForegroundColor Cyan
    Write-Host "  +======================================================+" -ForegroundColor Cyan
    Write-Host ""

    foreach ($key in $snippets.Keys) {
        $title = $snippets[$key].Title
        Write-Host ("  [{0,2}] {1}" -f $key, $title)
    }

    Write-Host ""
    Write-Host "  [Q] Quit"
    $choice = (Read-Host "`n  Enter choice").Trim().ToUpper()

    if ($choice -eq "Q") { break }

    if (-not $snippets.Contains($choice)) {
        Write-Host "`n  Invalid choice." -ForegroundColor Red
        Start-Sleep -Seconds 1
        continue
    }

    $code = $snippets[$choice].Code

    if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) {
        $code | Set-Clipboard
        Write-Host "`n  OK: $($snippets[$choice].Title)" -ForegroundColor Green
        Write-Host "  Code copied to clipboard. Paste into your IDE."
    } else {
        Write-Host "`n  Clipboard command unavailable. Code follows:" -ForegroundColor Yellow
        Write-Host $code
    }

    $again = Read-Host "`n  Press Enter to return to menu, or type Q to quit"
    if ($again.Trim().ToUpper() -eq "Q") { break }
}
