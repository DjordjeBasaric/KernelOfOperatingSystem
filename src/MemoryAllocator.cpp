//
// Created by basara on 9.8.24..
//

#include "../h/MemoryAllocator.h"
#include "../test/printing.hpp"
Mem_Block* MemoryAllocator::free_Block = nullptr;


void tryToJoin(Mem_Block* current_Block){
    if (!current_Block) return;
    if (current_Block->next && current_Block+current_Block->size == current_Block->next){
        current_Block->size += current_Block->next->size;
        current_Block->next = current_Block->next->next;
        if(current_Block->next) current_Block->next->prev = current_Block;
    }
}

void *MemoryAllocator::mem_alloc(size_t size) {
    Mem_Block *block = free_Block;
    while(block != nullptr){
        if(block->size >= size) break;
        block = block->next;
    }

    if(block == nullptr){
        return 0; //Ne moze da se smesti
    }
    size_t remainingSize = block->size - size;
    if(remainingSize >= sizeof(Mem_Block) + MEM_BLOCK_SIZE) { //fragment memorije ostaje i ulancavam ga u listu
        block->size = size;
        size_t offset = sizeof(Mem_Block) + size; // velicina samog bloka koji alociram
        Mem_Block *new_block = (Mem_Block*)((size_t)block + offset); //(Mem_Block*)((char*)block + offset) adresa blocka + velicina bloka
        if (block->prev) {
            block->prev->next = new_block;
            new_block->prev = block->prev;
        } // ovde izbacujem block iz liste freeMem i ubacujem newBlock
        else free_Block = new_block;
        new_block->next = block->next;
        if(block->next) block->next->prev = new_block;
        new_block->size = remainingSize - sizeof(Mem_Block);
    }
    else {//ako od ostatka ne mogu da napravim blok, onda uzimam ceo blok
        if (block->prev) block->prev->next = block->next;
        if(block->next) block->next->prev = block->prev;
        else free_Block = block->next;
    }
    block->next = nullptr;
    return block + sizeof(Mem_Block);
}

int MemoryAllocator::mem_free(void * pointerToBlock) {

    if(pointerToBlock<HEAP_START_ADDR || pointerToBlock>HEAP_END_ADDR){
        return -1; // blockToDelete nije u opsegu granica memorije
    }

    Mem_Block* current_Block = nullptr;
    Mem_Block* block_ToFree = (Mem_Block*) pointerToBlock;

    if(free_Block && block_ToFree>free_Block){ //da li uopste ima slobodnog prostora i ako ima da li je adresa Bloka veca od pocetka slobodnog prostora
        current_Block = free_Block;
        while(current_Block->next!=nullptr){ //nadji poziciju okja je pre zauzetog bloka
            if ( block_ToFree < current_Block->next ) break;
            current_Block = current_Block->next;
        }
    }
    if(!current_Block){  //blok se nalazi ispred slobodnog prostora
        block_ToFree->next = free_Block;
        free_Block->prev = block_ToFree;
        free_Block = block_ToFree;
    }
    else{
        block_ToFree->next = current_Block; //blok se nalazi negde u sredini ili na kraju
        current_Block->next = block_ToFree;
        if(current_Block->next) current_Block->next->prev = block_ToFree;
        block_ToFree->prev = current_Block;
    }

    tryToJoin(block_ToFree); //pokusaj da spojis slobodan prostor sa sledecim ili blokom pre njega
    tryToJoin(current_Block);
    return 0;
}

