//
// Created by basara on 7.8.24..
//

#include "../h/_sem.hpp"

int _sem::open_sem(sem_t* handle, unsigned init){
    *handle = new _sem(init);
    if(*handle != nullptr) return 0;
    return -1;
}

int _sem::close_sem(sem_t id) {
    while(!id->blocked.empty()){
        Scheduler::put(id->blocked.get());
    }
  //  delete id;
    id=nullptr;
    return 0;
}

int _sem::sem_signal(sem_t id) {
    if (id->val<=0){
        if(id->blocked.get() != nullptr){
            Scheduler::put(id->blocked.get());
        }
        return -1;
    }
    else id->val++;
    return 0;
}

int _sem::sem_wait(sem_t id) {
    if (id->val>0) id->val++;
    else {
        _thread *old = _thread::running;
        if(!old->isFinished()){ id->blocked.put(_thread::running);}//ako nit nije zavrsena ubaci je u red cekanja na semaforu
        _thread::running = Scheduler::get();
        _thread::contextSwitch(&old->context, &_thread::running->context);
    }
    if (!id){
        return -1;
    }
    else return 0;
}

