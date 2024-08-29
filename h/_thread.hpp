#ifndef PROJECT_BASE_HPP
#define PROJECT_BASE_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"
#include "_sem.hpp"
#include "syscall_c.hpp"


class _sem;

typedef _thread* thread_t;
class _thread{
public:
    static _thread *running;

    static int id_th; //NAPRAVLJENO ZA MAXTHREAD

    using Body = void (*)(void(*)); //pokazivac na funkciju koja nema argumente ni povratnu vrednost

    ~_thread() {delete[] stack;}

    bool isFinished() const {
        return finished; }

    void setFinished(bool fin) {
        sem_signal(semJoin);
        _thread::finished = fin;
    }

    static int create_thread(thread_t* handle, Body body, void* arg, void* stack_space);

    static int thread_exit();

    static void join_thread(thread_t* handle);

    int getThreadId() const {return this->id;} //NAPRAVLJENO ZA MAXTHREAD


private:
    _thread(Body body, void* arg, void* stack_space):
        body(body),
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
        context({
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false),
        id(id_th++) { //NAPRAVLJENO ZA MAXTHREAD

            if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
        }



    struct Context{
        uint64 ra; //u ra se nalazi povratna adresa gde treba da se vrati thread
        uint64 sp; //stack pointer
    };

    Body body; //za svaki tred pamtim telo koje on izvrsava
    uint64 *stack; //pokazivac na stek(tj. pocetak steka)
    Context context;
    void* arg;
    bool finished;  //flag da li je thread gotov


    sem_t semJoin;
    int id; //NAPRAVLJENO ZA MAXTHREAD


    static void contextSwitch(Context *oldContext, Context *runningContext);

    static void thread_dispatch(); //trenutno izvrsavani thread zameni nekim drugim

    static void threadWrapper();

    friend class Riscv;
    friend class _sem;

};

#endif //PROJECT_BASE_HPP
