//
// Created by basara on 7.8.24..
//

#ifndef OS1_PROJEKAT__SEM_H
#define OS1_PROJEKAT__SEM_H

#include "_semQ.h"
#include "scheduler.hpp"
#include "_thread.hpp"

class _sem {
    typedef _sem* sem_t;
public:
    static int open_sem(sem_t* handle, unsigned init);
    static int close_sem(sem_t id);
    static int sem_wait(sem_t id);
    static int sem_signal(sem_t id);
private:
    _sem(unsigned v):val(v){ }
    unsigned val;
    _semQ blocked;
};


#endif //OS1_PROJEKAT__SEM_H
