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

// Insert at beginning
void insertBeg(int x){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;
    newNode->next = head;
    head = newNode;
}

// Insert at end
void insertEnd(int x){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;
    newNode->next = NULL;

    if(head == NULL){
        head = newNode;
        return;
    }

    struct Node* temp = head;
    while(temp->next != NULL) temp = temp->next;
    temp->next = newNode;
}

// Delete from beginning
void deleteBeg(){
    if(head == NULL) return;
    struct Node* temp = head;
    head = head->next;
    free(temp);
}

// Delete from end
void deleteEnd(){
    if(head == NULL) return;

    if(head->next == NULL){
        free(head);
        head = NULL;
        return;
    }

    struct Node* temp = head;
    while(temp->next->next != NULL) temp = temp->next;
    free(temp->next);
    temp->next = NULL;
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
    insertBeg(10);
    insertEnd(20);
    insertEnd(30);
    display();

    deleteBeg();
    deleteEnd();
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

// Insert at beginning
void insertBeg(int x){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;
    newNode->prev = NULL;
    newNode->next = head;

    if(head != NULL) head->prev = newNode;
    head = newNode;
}

// Insert at end
void insertEnd(int x){
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = x;
    newNode->next = NULL;

    if(head == NULL){
        newNode->prev = NULL;
        head = newNode;
        return;
    }

    struct Node* temp = head;
    while(temp->next != NULL) temp = temp->next;

    temp->next = newNode;
    newNode->prev = temp;
}

// Delete from beginning
void deleteBeg(){
    if(head == NULL) return;

    struct Node* temp = head;
    head = head->next;

    if(head != NULL) head->prev = NULL;
    free(temp);
}

// Delete from end
void deleteEnd(){
    if(head == NULL) return;

    struct Node* temp = head;
    while(temp->next != NULL) temp = temp->next;

    if(temp->prev != NULL) temp->prev->next = NULL;
    else head = NULL;

    free(temp);
}

// Display forward
void display(){
    struct Node* temp = head;
    while(temp != NULL){
        printf("%d <-> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

int main(){
    insertBeg(10);
    insertEnd(20);
    insertEnd(30);
    display();

    deleteBeg();
    deleteEnd();
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
