[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

while ($true) {

Clear-Host

Write-Host ""
Write-Host "  +============================================+" -ForegroundColor Cyan
Write-Host "  |        DSA Snippet Picker (Exam Mode)       |" -ForegroundColor Cyan
Write-Host "  +============================================+" -ForegroundColor Cyan
Write-Host ""
Write-Host "   [1] Linked List - Polynomial Addition"
Write-Host "   [2] Addition of Two Big Numbers (Linked List)"
Write-Host "   [3] Radix Sort"
Write-Host "   [4] Sparse Matrix (Multi-linked List)"
Write-Host "   [5] Heap Sort (Min Heap + Max Heap Heapify)"
Write-Host "   [6] AVL Tree - Insertion"
Write-Host ""

$code = $null
$choice = Read-Host "  Enter choice"

switch ($choice) {

# ================= LINKED LIST - POLYNOMIAL ADDITION =================
"1" {
$code = @'
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>

struct node{
    int coeff;
    int exp;
    struct node * next;
};

struct node* createNode(int coeff, int exp){
    struct node* n = (struct node*) malloc(sizeof(struct node));
    n->coeff = coeff;
    n->exp = exp;
    n->next = NULL;
    return n;
}

// inserts at the end, keeps the list in the order of insertion
void insertEnd(struct node** head, struct node** tail, int coeff, int exp){
    struct node* temp = createNode(coeff, exp);

    if(*head==NULL){
        *head = temp;
        *tail = temp;
        return ;
    }
    (*tail)->next = temp;
    *tail = temp;
}

// both polynomials are stored in decreasing order of exponent
struct node* add(struct node* head1, struct node* head2){
    struct node* head = NULL;
    struct node* tail = NULL;
    while(head1!=NULL && head2!=NULL){
        if(head1->exp == head2->exp){
            insertEnd(&head, &tail, head1->coeff + head2->coeff, head1->exp);
            head1 = head1->next;
            head2 = head2->next;
        }
        else if(head1->exp > head2->exp){
            insertEnd(&head, &tail, head1->coeff, head1->exp);
            head1 = head1->next;
        }
        else{
            insertEnd(&head, &tail, head2->coeff, head2->exp);
            head2 = head2->next;
        }
    }
    while(head1!=NULL){
        insertEnd(&head, &tail, head1->coeff, head1->exp);
        head1 = head1->next;
    }
    while(head2!=NULL){
        insertEnd(&head, &tail, head2->coeff, head2->exp);
        head2 = head2->next;
    }

    return head;
}

void printList(struct node* head){
    int first = 1;
    while(head!=NULL){
        if(head->coeff != 0){
            if(head->coeff >= 0)
                printf(first ? "%dx^%d" : " + %dx^%d", head->coeff, head->exp);
            else
                printf(first ? "-%dx^%d" : " - %dx^%d", -head->coeff, head->exp);
            first = 0;
        }
        head = head->next;
    }
    if(first) printf("0");
    printf("\n");
}

// parses strings like 3x^4+2x-5 (terms must be in decreasing order of exponent)
struct node* parsePolynomial(char poly[]){
    struct node* head = NULL;
    struct node* tail = NULL;
    int i = 0;

    while(poly[i] != '\0'){
        int sign = 1;
        if(poly[i] == '+'){
            sign = 1;
            i++;
        }
        else if(poly[i] == '-'){
            sign = -1;
            i++;
        }

        int coeff = 0;
        int coeffPresent = 0;

        while(isdigit(poly[i])){
            coeff = coeff * 10 + (poly[i] - '0');
            coeffPresent = 1;
            i++;
        }

        int exp = 0;

        if(poly[i] == 'x'){
            if(!coeffPresent)
                coeff = 1;

            i++;

            if(poly[i] == '^'){
                i++;
                while(isdigit(poly[i])){
                    exp = exp * 10 + (poly[i] - '0');
                    i++;
                }
            }
            else{
                exp = 1;
            }
        }

        insertEnd(&head, &tail, sign * coeff, exp);
    }

    return head;
}

int main(){
    char poly1[200];
    char poly2[200];
    scanf("%s %s", poly1, poly2);

    struct node *head1 = parsePolynomial(poly1);
    struct node *head2 = parsePolynomial(poly2);

    struct node *head = add(head1, head2);
    printf("Sum : ");
    printList(head);

    return 0;
}
'@
}

# ================= ADDITION OF TWO BIG NUMBERS (LINKED LIST) =================
"2" {
$code = @'
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct node{
    int digit;
    struct node * next;
};

struct node* createNode(int digit){
    struct node* n = (struct node*) malloc(sizeof(struct node));
    n->digit = digit;
    n->next = NULL;
    return n;
}

// inserts at the front, so the number string ends up reversed
void insert(struct node** head, int digit){
    struct node* temp = createNode(digit);
    temp->next = *head;
    *head = temp;
}

void insertEnd(struct node** head, struct node** tail, int digit){
    struct node* temp = createNode(digit);

    if(*head==NULL){
        *head = temp;
        *tail = temp;
        return ;
    }
    (*tail)->next = temp;
    *tail = temp;
}

// least significant digit is at the head of the list
struct node* parseNumber(char num[]){
    struct node* head = NULL;
    for(int i = 0; num[i] != '\0'; i++){
        insert(&head, num[i] - '0');
    }
    return head;
}

struct node* add(struct node* head1, struct node* head2){
    struct node* head = NULL;
    struct node* tail = NULL;
    int carry = 0;

    while(head1!=NULL || head2!=NULL || carry){
        int sum = carry;
        if(head1!=NULL){
            sum += head1->digit;
            head1 = head1->next;
        }
        if(head2!=NULL){
            sum += head2->digit;
            head2 = head2->next;
        }
        insertEnd(&head, &tail, sum % 10);
        carry = sum / 10;
    }

    return head;
}

// prints from the most significant digit
void printList(struct node* head){
    if(head==NULL) return ;
    printList(head->next);
    printf("%d", head->digit);
}

int main(){
    char num1[1000];
    char num2[1000];
    scanf("%s %s", num1, num2);

    struct node *head1 = parseNumber(num1);
    struct node *head2 = parseNumber(num2);

    struct node *head = add(head1, head2);
    printf("Sum : ");
    printList(head);
    printf("\n");

    return 0;
}
'@
}

# ================= RADIX SORT =================
"3" {
$code = @'
#include<bits/stdc++.h>
using namespace std;

void radixSort(int arr[], int n);

int findMax(int arr[], int n);

void countSort(int arr[], int n, int exp);

int main(){
    int arr[] = {170, 45, 75, 90, 802, 24, 2, 66, 0, 1000};
    int n = sizeof(arr) / sizeof(arr[0]);

    cout<<"Original array : ";
    for(int i = 0; i<n;i++) cout<<arr[i]<<" ";
    cout<<endl;

    radixSort(arr,n);
    cout<<"Sorted array   : ";
    for(int i = 0; i<n;i++) cout<<arr[i]<<" ";

    return 0;
}

void radixSort(int arr[], int n){
    int max = findMax(arr, n);
    for (int exp = 1; max/exp>0; exp *=10) countSort(arr, n, exp);
}

int findMax(int arr[], int n){
    int max = arr[0];
    for(int i = 1; i<n;i++){
        if(arr[i]>max){
            max = arr[i];
        }
    }
    return max;
}

void countSort(int arr[], int n, int exp){
    int output[n];
    int count[10] = {0};

    for(int i =0; i<n;i++) count[(arr[i]/exp)%10]++;

    for(int i =1; i<10; i++) count[i] += count[i-1];

    for(int i = n-1; i>=0;  i--)
        output[--count[(arr[i]/exp)%10]] = arr[i];

    for(int i =0; i<n;i++) arr[i] = output[i];
}
'@
}

# ================= SPARSE MATRIX (MULTI-LINKED LIST) =================
"4" {
$code = @'
#include<bits/stdc++.h>
using namespace std;

// every non-zero element is linked to the next one in its row (right)
// and to the next one in its column (down)
struct Node {
    int row;
    int col;
    int val;
    struct Node* right;
    struct Node* down;
};

struct Sparse {
    int rows;
    int cols;
    Node** rowHead;
    Node** colHead;
};

Sparse* createSparse(int rows, int cols);

void insert(Sparse* m, int row, int col, int val);

void display(Sparse* m);

void displayTriplets(Sparse* m);

int main(){
    int rows = 4, cols = 5;
    Sparse* m = createSparse(rows, cols);

    insert(m, 0, 2, 3);
    insert(m, 0, 4, 7);
    insert(m, 1, 0, 5);
    insert(m, 2, 3, 2);
    insert(m, 3, 1, 9);
    insert(m, 0, 0, 1);

    cout<<"Matrix :"<<endl;
    display(m);

    cout<<"Row Col Val"<<endl;
    displayTriplets(m);

    return 0;
}

Sparse* createSparse(int rows, int cols){
    Sparse* m = new Sparse();
    m->rows = rows;
    m->cols = cols;
    m->rowHead = new Node*[rows]();
    m->colHead = new Node*[cols]();
    return m;
}

void insert(Sparse* m, int row, int col, int val){
    if(val == 0) return;

    Node* n = new Node();
    n->row = row;
    n->col = col;
    n->val = val;
    n->right = nullptr;
    n->down = nullptr;

    // link into the row list, sorted by column
    if(m->rowHead[row] == nullptr || m->rowHead[row]->col > col){
        n->right = m->rowHead[row];
        m->rowHead[row] = n;
    }
    else{
        Node* cur = m->rowHead[row];
        while(cur->right != nullptr && cur->right->col < col) cur = cur->right;
        n->right = cur->right;
        cur->right = n;
    }

    // link into the column list, sorted by row
    if(m->colHead[col] == nullptr || m->colHead[col]->row > row){
        n->down = m->colHead[col];
        m->colHead[col] = n;
    }
    else{
        Node* cur = m->colHead[col];
        while(cur->down != nullptr && cur->down->row < row) cur = cur->down;
        n->down = cur->down;
        cur->down = n;
    }
}

void display(Sparse* m){
    for(int i = 0; i<m->rows;i++){
        Node* cur = m->rowHead[i];
        for(int j = 0; j<m->cols;j++){
            if(cur != nullptr && cur->col == j){
                cout<<cur->val<<" ";
                cur = cur->right;
            }
            else cout<<"0 ";
        }
        cout<<endl;
    }
}

void displayTriplets(Sparse* m){
    for(int i = 0; i<m->rows;i++){
        Node* cur = m->rowHead[i];
        while(cur != nullptr){
            cout<<cur->row<<"   "<<cur->col<<"   "<<cur->val<<endl;
            cur = cur->right;
        }
    }
}
'@
}

# ================= HEAP SORT (MIN HEAP + MAX HEAP HEAPIFY) =================
"5" {
$code = @'
#include<bits/stdc++.h>
using namespace std;

void maxHeapify(int arr[], int n, int i);

void minHeapify(int arr[], int n, int i);

void heapSortMax(int arr[], int n);

void heapSortMin(int arr[], int n);

void printArray(int arr[], int n);

int main(){
    int arr1[] = {12, 11, 13, 5, 6, 7, 20, 1};
    int n = sizeof(arr1) / sizeof(arr1[0]);
    int arr2[n];
    for(int i = 0; i<n;i++) arr2[i] = arr1[i];

    cout<<"Original array            : ";
    printArray(arr1, n);

    heapSortMax(arr1, n);
    cout<<"Max Heap sort (ascending) : ";
    printArray(arr1, n);

    heapSortMin(arr2, n);
    cout<<"Min Heap sort (descending): ";
    printArray(arr2, n);

    return 0;
}

// sinks arr[i] down so the subtree rooted at i is a max heap
void maxHeapify(int arr[], int n, int i){
    int largest = i;
    int left = 2*i + 1;
    int right = 2*i + 2;

    if(left < n && arr[left] > arr[largest]) largest = left;
    if(right < n && arr[right] > arr[largest]) largest = right;

    if(largest != i){
        swap(arr[i], arr[largest]);
        maxHeapify(arr, n, largest);
    }
}

// sinks arr[i] down so the subtree rooted at i is a min heap
void minHeapify(int arr[], int n, int i){
    int smallest = i;
    int left = 2*i + 1;
    int right = 2*i + 2;

    if(left < n && arr[left] < arr[smallest]) smallest = left;
    if(right < n && arr[right] < arr[smallest]) smallest = right;

    if(smallest != i){
        swap(arr[i], arr[smallest]);
        minHeapify(arr, n, smallest);
    }
}

void heapSortMax(int arr[], int n){
    for(int i = n/2 - 1; i>=0; i--) maxHeapify(arr, n, i);

    for(int i = n-1; i>0; i--){
        swap(arr[0], arr[i]);
        maxHeapify(arr, i, 0);
    }
}

void heapSortMin(int arr[], int n){
    for(int i = n/2 - 1; i>=0; i--) minHeapify(arr, n, i);

    for(int i = n-1; i>0; i--){
        swap(arr[0], arr[i]);
        minHeapify(arr, i, 0);
    }
}

void printArray(int arr[], int n){
    for(int i = 0; i<n;i++) cout<<arr[i]<<" ";
    cout<<endl;
}
'@
}

# ================= AVL TREE - INSERTION =================
"6" {
$code = @'
#include<bits/stdc++.h>
using namespace std;

struct Node {
    int data;
    int height;
    struct Node* left;
    struct Node* right;
};

Node* createNode(int val);

int height(Node* n);

int balanceFactor(Node* n);

Node* rotateRight(Node* y);

Node* rotateLeft(Node* x);

Node* insert(Node* root, int val);

void inorder(Node* root);

void preorder(Node* root);

int main(){
    int values[] = {10, 20, 30, 40, 50, 25};
    int n = sizeof(values) / sizeof(values[0]);

    Node* root = nullptr;
    for(int i = 0; i<n;i++) root = insert(root, values[i]);

    cout<<"Inorder   : ";
    inorder(root);
    cout<<endl;

    cout<<"Preorder  : ";
    preorder(root);
    cout<<endl;

    return 0;
}

Node* createNode(int val){
    Node* n = new Node();
    n->data = val;
    n->height = 1;
    n->left = nullptr;
    n->right = nullptr;
    return n;
}

int height(Node* n){
    return n == nullptr ? 0 : n->height;
}

int balanceFactor(Node* n){
    return n == nullptr ? 0 : height(n->left) - height(n->right);
}

Node* rotateRight(Node* y){
    Node* x = y->left;
    Node* t = x->right;

    x->right = y;
    y->left = t;

    y->height = 1 + max(height(y->left), height(y->right));
    x->height = 1 + max(height(x->left), height(x->right));
    return x;
}

Node* rotateLeft(Node* x){
    Node* y = x->right;
    Node* t = y->left;

    y->left = x;
    x->right = t;

    x->height = 1 + max(height(x->left), height(x->right));
    y->height = 1 + max(height(y->left), height(y->right));
    return y;
}

Node* insert(Node* root, int val){
    if(root == nullptr) return createNode(val);

    if(val < root->data) root->left = insert(root->left, val);
    else if(val > root->data) root->right = insert(root->right, val);
    else return root;

    root->height = 1 + max(height(root->left), height(root->right));

    int bf = balanceFactor(root);

    // left left
    if(bf > 1 && val < root->left->data) return rotateRight(root);

    // right right
    if(bf < -1 && val > root->right->data) return rotateLeft(root);

    // left right
    if(bf > 1 && val > root->left->data){
        root->left = rotateLeft(root->left);
        return rotateRight(root);
    }

    // right left
    if(bf < -1 && val < root->right->data){
        root->right = rotateRight(root->right);
        return rotateLeft(root);
    }

    return root;
}

void inorder(Node* root){
    if(root == nullptr) return ;
    inorder(root->left);
    cout<<root->data<<" ";
    inorder(root->right);
}

void preorder(Node* root){
    if(root == nullptr) return ;
    cout<<root->data<<" ";
    preorder(root->left);
    preorder(root->right);
}
'@
}

default {
    Write-Host "Invalid choice" -ForegroundColor Red
}
}

if ($null -eq $code) {
    Start-Sleep -Seconds 1
    continue
}

# Clipboard logic
if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) {
    $code | Set-Clipboard
    Write-Host ""
    Write-Host "  OK copied to clipboard!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Clipboard not supported. Showing code below:" -ForegroundColor Yellow
    Write-Host $code
}

$again = Read-Host "`nDo you want another snippet? (y/n)"
if ($again -ne "y") { break }

}
