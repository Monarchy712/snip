[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

while ($true) {

Clear-Host

Write-Host ""
Write-Host "  +============================================+" -ForegroundColor Cyan
Write-Host "  |        DSA Snippet Picker (Exam Mode)       |" -ForegroundColor Cyan
Write-Host "  +============================================+" -ForegroundColor Cyan
Write-Host ""

# ====== SORTING ======
Write-Host "   [1] Bubble Sort"
Write-Host "   [2] Insertion Sort"
Write-Host "   [3] Merge Sort"
Write-Host "   [4] Quick Sort"
Write-Host "   [5] Selection Sort"

# ====== LINKED LIST ======
Write-Host ""
Write-Host "   [6] Singly Linked List (All Ops)"
Write-Host "   [7] Doubly Linked List (All Ops)"

Write-Host ""

$choice = Read-Host "  Enter choice"

switch ($choice) {

# ================= SINGLY LINKED LIST =================
"6" {
$code = @"
#include<stdio.h>
#include<stdlib.h>

struct Node {
    int data;
    struct Node* next;
};

struct Node* head = NULL;

// Insert at position (1-based)
void insertPos(int x, int pos){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;

    if(pos == 1){
        newNode->next = head;
        head = newNode;
        return;
    }

    struct Node* temp = head;
    for(int i = 1; i < pos-1 && temp != NULL; i++){
        temp = temp->next;
    }

    if(temp == NULL){
        printf("Invalid Position\n");
        return;
    }

    newNode->next = temp->next;
    temp->next = newNode;
}

// Delete at position
void deletePos(int pos){
    if(head == NULL){
        printf("List Empty\n");
        return;
    }

    if(pos == 1){
        struct Node* temp = head;
        head = head->next;
        free(temp);
        return;
    }

    struct Node* temp = head;
    for(int i = 1; i < pos-1 && temp->next != NULL; i++){
        temp = temp->next;
    }

    if(temp->next == NULL){
        printf("Invalid Position\n");
        return;
    }

    struct Node* del = temp->next;
    temp->next = del->next;
    free(del);
}

// Reverse list
void reverse(){
    struct Node *prev = NULL, *curr = head, *next;

    while(curr != NULL){
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }

    head = prev;
}

// Display
void display(){
    struct Node* temp = head;
    while(temp != NULL){
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

int main(){
    insertPos(10,1);
    insertPos(20,2);
    insertPos(15,2);
    display();

    deletePos(2);
    display();

    reverse();
    display();

    return 0;
}
"@
}

# ================= DOUBLY LINKED LIST =================
"7" {
$code = @"
#include<stdio.h>
#include<stdlib.h>

struct Node {
    int data;
    struct Node* prev;
    struct Node* next;
};

struct Node* head = NULL;

// Insert at position
void insertPos(int x, int pos){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;

    if(pos == 1){
        newNode->prev = NULL;
        newNode->next = head;
        if(head != NULL) head->prev = newNode;
        head = newNode;
        return;
    }

    struct Node* temp = head;
    for(int i = 1; i < pos-1 && temp != NULL; i++){
        temp = temp->next;
    }

    if(temp == NULL){
        printf("Invalid Position\n");
        return;
    }

    newNode->next = temp->next;
    newNode->prev = temp;

    if(temp->next != NULL)
        temp->next->prev = newNode;

    temp->next = newNode;
}

// Delete at position
void deletePos(int pos){
    if(head == NULL){
        printf("List Empty\n");
        return;
    }

    if(pos == 1){
        struct Node* temp = head;
        head = head->next;
        if(head != NULL) head->prev = NULL;
        free(temp);
        return;
    }

    struct Node* temp = head;
    for(int i = 1; i < pos && temp != NULL; i++){
        temp = temp->next;
    }

    if(temp == NULL){
        printf("Invalid Position\n");
        return;
    }

    if(temp->prev != NULL)
        temp->prev->next = temp->next;

    if(temp->next != NULL)
        temp->next->prev = temp->prev;

    free(temp);
}

// Reverse DLL
void reverse(){
    struct Node* temp = NULL;
    struct Node* curr = head;

    while(curr != NULL){
        temp = curr->prev;
        curr->prev = curr->next;
        curr->next = temp;
        curr = curr->prev;
    }

    if(temp != NULL)
        head = temp->prev;
}

// Display
void display(){
    struct Node* temp = head;
    while(temp != NULL){
        printf("%d <-> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

int main(){
    insertPos(10,1);
    insertPos(20,2);
    insertPos(15,2);
    display();

    deletePos(2);
    display();

    reverse();
    display();

    return 0;
}
"@
}

# ================= (Sorting cases stay SAME from your previous code) =================

default {
    Write-Host "Invalid choice" -ForegroundColor Red
    Start-Sleep -Seconds 1
    continue
}
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
