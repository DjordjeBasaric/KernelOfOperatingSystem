#include "../h/riscv.hpp"
#include "../lib/console.h"
#include "../h/_thread.hpp"
#include "../test/printing.hpp"
#include "../h/_sem.hpp"
#include "../h/MemoryAllocator.h"


void Riscv::popSppSpie(){
    mc_sstatus(Riscv::SSTATUS_SPP);
    __asm__ volatile ("csrw sepc, ra"); // zato ovde upisujem da nas vrati tamo odakle je i ova funkcija bila i pozvana i zbog toga ova funckija nije inline
    __asm__ volatile ("sret"); //ovo sret ce vratiti tamo gde je sepc rekao, i to nam ne odgovara

}



void Riscv::interruptRoutineHandler(){
    uint64 volatile fcode;
    asm volatile("mv %0, a0" : "=r" (fcode));
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida
    uint64 volatile sepc = r_sepc();    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    uint64 volatile sstatus = r_sstatus();

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
        //softverski prekid, sistemski poziv iz koristnickog ili sistemskog rezima

        sepc = sepc+4;
        switch(fcode){
            case 0x01:{
                void* ret;
                size_t size;
                asm volatile("mv %0, a1" : "=r" (size));
                ret = MemoryAllocator::mem_alloc(size);
                asm volatile("mv a0, %0" : : "r" (ret));

                break;
            }
            case 0x02:{
                void* p;
                asm volatile("mv %0, a1" : "=r" (p));
                retval = MemoryAllocator::mem_free(p);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x11: {

                uint64 volatile handle, start_routine, arg;
                asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
                asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
                asm volatile("mv %0, a3" : "=r" (arg));
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
                                                (void *) stack_space);
                asm volatile("mv a0, %0" : : "r" (retval));
                break;
                }
            case 0x12: {
                retval = _thread::thread_exit();
                asm volatile("mv a0, %0" : : "r" (retval));
                break;
                }
            case 0x13:
                _thread::thread_dispatch();
                break;

            case 0x21:{
                uint64 handle, init;

                asm volatile("mv %0, a1" : "=r" (handle));
                asm volatile("mv %0, a2" : "=r" (init));
                retval = _sem::open_sem((sem_t*)(handle), init);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x22:{
                uint64 handle;
                asm volatile("mv %0, a1" : "=r" (handle));
                retval = _sem::close_sem((sem_t)handle);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x23:{
                uint64 handle;
                asm volatile("mv %0, a1" : "=r" (handle));
                retval = _sem::sem_wait((sem_t)handle);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x24:{
                uint64 handle;
                asm volatile("mv %0, a1" : "=r" (handle));
                retval = _sem::sem_signal((sem_t)handle);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x26:{
                uint64 handle;
                asm volatile("mv %0, a1" : "=r" (handle));
                retval = _sem::sem_trywait((sem_t)handle);
                asm volatile("mv a0, %0" : : "r" (retval));

                break;
            }
            case 0x41: {
                char ch = __getc();
                asm volatile("mv a0, %0" : : "r" (ch));
                break;
            }

            case 0x50:{
                int idT = _thread::running->getThreadId();
                asm volatile("mv a0, %0" : : "r" (idT));
              //  _thread::thread_dispatch();
                break;
            }
            case 0x51:{
                uint64 handle;
                asm volatile("mv %0, a1" : "=r" (handle));
                _thread::join_thread((thread_t*)handle);
                break;
            }


            default:
                break;

        }

            w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
            w_sstatus(sstatus);


    }
    else if (scause == 0x8000000000000001UL){
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
        console_handler();
    }
    else{
        printString("\nPc greske: ");
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
        printString("\nStVal greske: ");
        printInt(r_stval());
        printString("\nRazlog greske scause: ");
        printInt(scause);
        switch(scause) {
            case 2:
                printString(" Nelegelna instrukcija");
                break;
            case 5:
                printString(" Nedozvoljena adresa citanja");
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
                break;
        }
    }
}

