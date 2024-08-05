//
// Created by basara on 20.6.24..
//


#include "../lib/hw.h"
#include "../h/_thread.hpp"
#include "../lib/console.h"

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    uint64 const fcode = 0x11;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    return 0;
    //dodati promenljivu za povratnu vrednost
}

void thread_dispatch(){
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
}

void thread_exit(){
    uint64 const fcode = 0x12;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
    //dodati i ovde promenljivu
}

void getc(){
    uint64 const fcode = 0x20;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    __asm__ volatile("ecall");
}

void putc(char c){
    __putc(c);
}