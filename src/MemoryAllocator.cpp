//
// Created by basara on 9.8.24..
//

#include "../h/MemoryAllocator.h"

Mem_Block* MemoryAllocator::free_Block = nullptr;


void MemoryAllocator::tryToJoin(Mem_Block* current_Block){
    if (!current_Block) return;

    //da li ima sledeceg i da li je adresa sledeceg odmah do njega
    if (current_Block->next && current_Block+current_Block->size == current_Block->next){
        current_Block->size += current_Block->next->size; //spaja velicine sebe i sledeceg
        current_Block->next = current_Block->next->next;
        if(current_Block->next) current_Block->next->prev = current_Block;
    }
}

void *MemoryAllocator::mem_alloc(size_t size) {
    Mem_Block *block = free_Block;
    //Trazi prvi blok koji odgovara velicini
    while (block != nullptr) {
        if (block->size >= size) break;
        block = block->next;
    }

    if (block == nullptr) {
        return nullptr; // Ne postoji takav blok
    }

    size_t remainingSize = block->size - size; //preostalo mesta
    if (remainingSize >= sizeof(Mem_Block) + MEM_BLOCK_SIZE) { //da li je dovoljno da se napravi blok od te preostale memorije
        block->size = size;
        size_t offset = sizeof(Mem_Block) + size;
        Mem_Block *new_block = (Mem_Block*)((size_t)block + offset);

        new_block->size = remainingSize - sizeof(Mem_Block); //ubacujem novi blok u listu slobodnih
        new_block->next = block->next;
        new_block->prev = block->prev;

        if (block->next) block->next->prev = new_block;
        if (block->prev) {
            block->prev->next = new_block;
        } else {
            free_Block = new_block;
        }
    } else {
        if (block->next) block->next->prev = block->prev; //nije dovoljno da se napravi blok i zauzima se ceo blok
        if (block->prev) block->prev->next = block->next;
        else free_Block = block->next;
    }

    block->next = nullptr; //izbacujem zauzeti blok iz liste
    block->prev = nullptr;
    return (void*)((size_t)block + sizeof(Mem_Block)); // vracam adresu bloka

}
int MemoryAllocator::mem_free(void *pointerToBlock) {
    if (pointerToBlock < HEAP_START_ADDR || pointerToBlock >= HEAP_END_ADDR) {
        return -1; // blockToDelete nije u opsegu granica memorije
    }

    Mem_Block *block_ToFree = (Mem_Block *) ((size_t)pointerToBlock - sizeof(Mem_Block)); // kastujem pointer u blok

    Mem_Block *current_Block = free_Block;

    if (!current_Block || block_ToFree < current_Block) { //da li ima praznog prostora ili je adresa bloka manja od pocetka liste slobodnih
        block_ToFree->next = free_Block;
        block_ToFree->prev = nullptr; //blok stavljam ispred slobodnog prostora
        if (free_Block) free_Block->prev = block_ToFree;
        free_Block = block_ToFree;
    } else {
        while (current_Block->next && current_Block->next < block_ToFree) {
            current_Block = current_Block->next;//trazim mesto u listi
        }
        block_ToFree->next = current_Block->next;
        block_ToFree->prev = current_Block;
        if (current_Block->next) current_Block->next->prev = block_ToFree;
        current_Block->next = block_ToFree;
    }

    tryToJoin(block_ToFree); //pokusavam da spojim sa sledecim blokom
    tryToJoin(current_Block); //pokusavam da spojim sa prethodnim blokom

    return 0;
}
