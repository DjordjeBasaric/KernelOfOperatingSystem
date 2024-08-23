
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	ca013103          	ld	sp,-864(sp) # 80009ca0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	7a1040ef          	jal	ra,80004fbc <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv13pushRegistersEv>:
#CUVANJE DELA KONTEKSTA PROCESORA
.global _ZN5Riscv13pushRegistersEv
.type _ZN5Riscv13pushRegistersEv, @function
_ZN5Riscv13pushRegistersEv:
    addi sp, sp, -256 //alocirani prostor na steku
    80001020:	f0010113          	addi	sp,sp,-256
    // ra i sp se ne cuvaju ovde, zato sto ih cuvam u contextu
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00313c23          	sd	gp,24(sp)
    80001028:	02413023          	sd	tp,32(sp)
    8000102c:	02513423          	sd	t0,40(sp)
    80001030:	02613823          	sd	t1,48(sp)
    80001034:	02713c23          	sd	t2,56(sp)
    80001038:	04813023          	sd	s0,64(sp)
    8000103c:	04913423          	sd	s1,72(sp)
    80001040:	04a13823          	sd	a0,80(sp)
    80001044:	04b13c23          	sd	a1,88(sp)
    80001048:	06c13023          	sd	a2,96(sp)
    8000104c:	06d13423          	sd	a3,104(sp)
    80001050:	06e13823          	sd	a4,112(sp)
    80001054:	06f13c23          	sd	a5,120(sp)
    80001058:	09013023          	sd	a6,128(sp)
    8000105c:	09113423          	sd	a7,136(sp)
    80001060:	09213823          	sd	s2,144(sp)
    80001064:	09313c23          	sd	s3,152(sp)
    80001068:	0b413023          	sd	s4,160(sp)
    8000106c:	0b513423          	sd	s5,168(sp)
    80001070:	0b613823          	sd	s6,176(sp)
    80001074:	0b713c23          	sd	s7,184(sp)
    80001078:	0d813023          	sd	s8,192(sp)
    8000107c:	0d913423          	sd	s9,200(sp)
    80001080:	0da13823          	sd	s10,208(sp)
    80001084:	0db13c23          	sd	s11,216(sp)
    80001088:	0fc13023          	sd	t3,224(sp)
    8000108c:	0fd13423          	sd	t4,232(sp)
    80001090:	0fe13823          	sd	t5,240(sp)
    80001094:	0ff13c23          	sd	t6,248(sp)
    ret
    80001098:	00008067          	ret

000000008000109c <_ZN5Riscv12popRegistersEv>:
.type _ZN5Riscv12popRegistersEv, @function
_ZN5Riscv12popRegistersEv:
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp) //oslobadjanje prostora
    .endr
    8000109c:	01813183          	ld	gp,24(sp)
    800010a0:	02013203          	ld	tp,32(sp)
    800010a4:	02813283          	ld	t0,40(sp)
    800010a8:	03013303          	ld	t1,48(sp)
    800010ac:	03813383          	ld	t2,56(sp)
    800010b0:	04013403          	ld	s0,64(sp)
    800010b4:	04813483          	ld	s1,72(sp)
    800010b8:	05013503          	ld	a0,80(sp)
    800010bc:	05813583          	ld	a1,88(sp)
    800010c0:	06013603          	ld	a2,96(sp)
    800010c4:	06813683          	ld	a3,104(sp)
    800010c8:	07013703          	ld	a4,112(sp)
    800010cc:	07813783          	ld	a5,120(sp)
    800010d0:	08013803          	ld	a6,128(sp)
    800010d4:	08813883          	ld	a7,136(sp)
    800010d8:	09013903          	ld	s2,144(sp)
    800010dc:	09813983          	ld	s3,152(sp)
    800010e0:	0a013a03          	ld	s4,160(sp)
    800010e4:	0a813a83          	ld	s5,168(sp)
    800010e8:	0b013b03          	ld	s6,176(sp)
    800010ec:	0b813b83          	ld	s7,184(sp)
    800010f0:	0c013c03          	ld	s8,192(sp)
    800010f4:	0c813c83          	ld	s9,200(sp)
    800010f8:	0d013d03          	ld	s10,208(sp)
    800010fc:	0d813d83          	ld	s11,216(sp)
    80001100:	0e013e03          	ld	t3,224(sp)
    80001104:	0e813e83          	ld	t4,232(sp)
    80001108:	0f013f03          	ld	t5,240(sp)
    8000110c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001110:	10010113          	addi	sp,sp,256
    ret
    80001114:	00008067          	ret

0000000080001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0) #iz ra cuvam u a0, to a0 je old->context.ra
    80001118:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    8000111c:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1) #iz running->context.ra cuvam u ra
    80001120:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001124:	0085b103          	ld	sp,8(a1)

    80001128:	00008067          	ret
    8000112c:	0000                	unimp
	...

0000000080001130 <_ZN5Riscv16interruptRoutineEv>:
.global _ZN5Riscv16interruptRoutineEv // da bi definicija bila vidljiva od svih
.type _ZN5Riscv16interruptRoutineEv, @function
_ZN5Riscv16interruptRoutineEv: #kad se ovde uradi name manling onda se normalno citaju odavde funckije

    # cuvanje vrednosti registara na stek
    addi sp, sp, -256
    80001130:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001134:	00013023          	sd	zero,0(sp)
    80001138:	00113423          	sd	ra,8(sp)
    8000113c:	00213823          	sd	sp,16(sp)
    80001140:	00313c23          	sd	gp,24(sp)
    80001144:	02413023          	sd	tp,32(sp)
    80001148:	02513423          	sd	t0,40(sp)
    8000114c:	02613823          	sd	t1,48(sp)
    80001150:	02713c23          	sd	t2,56(sp)
    80001154:	04813023          	sd	s0,64(sp)
    80001158:	04913423          	sd	s1,72(sp)
    8000115c:	04b13c23          	sd	a1,88(sp)
    80001160:	06c13023          	sd	a2,96(sp)
    80001164:	06d13423          	sd	a3,104(sp)
    80001168:	06e13823          	sd	a4,112(sp)
    8000116c:	06f13c23          	sd	a5,120(sp)
    80001170:	09013023          	sd	a6,128(sp)
    80001174:	09113423          	sd	a7,136(sp)
    80001178:	09213823          	sd	s2,144(sp)
    8000117c:	09313c23          	sd	s3,152(sp)
    80001180:	0b413023          	sd	s4,160(sp)
    80001184:	0b513423          	sd	s5,168(sp)
    80001188:	0b613823          	sd	s6,176(sp)
    8000118c:	0b713c23          	sd	s7,184(sp)
    80001190:	0d813023          	sd	s8,192(sp)
    80001194:	0d913423          	sd	s9,200(sp)
    80001198:	0da13823          	sd	s10,208(sp)
    8000119c:	0db13c23          	sd	s11,216(sp)
    800011a0:	0fc13023          	sd	t3,224(sp)
    800011a4:	0fd13423          	sd	t4,232(sp)
    800011a8:	0fe13823          	sd	t5,240(sp)
    800011ac:	0ff13c23          	sd	t6,248(sp)

     #pozivanje hendlera da ne bi pisali u asembleru
     # static void Riscv::handleSupervisorTrap
     call _ZN5Riscv23interruptRoutineHandlerEv
    800011b0:	498000ef          	jal	ra,80001648 <_ZN5Riscv23interruptRoutineHandlerEv>

    # vrati vrednosti registara sa steka
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011b4:	00013003          	ld	zero,0(sp)
    800011b8:	00813083          	ld	ra,8(sp)
    800011bc:	01013103          	ld	sp,16(sp)
    800011c0:	01813183          	ld	gp,24(sp)
    800011c4:	02013203          	ld	tp,32(sp)
    800011c8:	02813283          	ld	t0,40(sp)
    800011cc:	03013303          	ld	t1,48(sp)
    800011d0:	03813383          	ld	t2,56(sp)
    800011d4:	04013403          	ld	s0,64(sp)
    800011d8:	04813483          	ld	s1,72(sp)
    800011dc:	05813583          	ld	a1,88(sp)
    800011e0:	06013603          	ld	a2,96(sp)
    800011e4:	06813683          	ld	a3,104(sp)
    800011e8:	07013703          	ld	a4,112(sp)
    800011ec:	07813783          	ld	a5,120(sp)
    800011f0:	08013803          	ld	a6,128(sp)
    800011f4:	08813883          	ld	a7,136(sp)
    800011f8:	09013903          	ld	s2,144(sp)
    800011fc:	09813983          	ld	s3,152(sp)
    80001200:	0a013a03          	ld	s4,160(sp)
    80001204:	0a813a83          	ld	s5,168(sp)
    80001208:	0b013b03          	ld	s6,176(sp)
    8000120c:	0b813b83          	ld	s7,184(sp)
    80001210:	0c013c03          	ld	s8,192(sp)
    80001214:	0c813c83          	ld	s9,200(sp)
    80001218:	0d013d03          	ld	s10,208(sp)
    8000121c:	0d813d83          	ld	s11,216(sp)
    80001220:	0e013e03          	ld	t3,224(sp)
    80001224:	0e813e83          	ld	t4,232(sp)
    80001228:	0f013f03          	ld	t5,240(sp)
    8000122c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001230:	10010113          	addi	sp,sp,256

    sret
    80001234:	10200073          	sret
	...

0000000080001240 <_Znwm>:
#include "../h/MemoryAllocator.h"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00113423          	sd	ra,8(sp)
    80001248:	00813023          	sd	s0,0(sp)
    8000124c:	01010413          	addi	s0,sp,16
    //return __mem_alloc(n);
    return MemoryAllocator::mem_alloc(n);
    80001250:	00000097          	auipc	ra,0x0
    80001254:	234080e7          	jalr	564(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001258:	00813083          	ld	ra,8(sp)
    8000125c:	00013403          	ld	s0,0(sp)
    80001260:	01010113          	addi	sp,sp,16
    80001264:	00008067          	ret

0000000080001268 <_Znam>:

void *operator new[](size_t n)
{
    80001268:	ff010113          	addi	sp,sp,-16
    8000126c:	00113423          	sd	ra,8(sp)
    80001270:	00813023          	sd	s0,0(sp)
    80001274:	01010413          	addi	s0,sp,16
    //return __mem_alloc(n);
    return MemoryAllocator::mem_alloc(n);
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	20c080e7          	jalr	524(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001280:	00813083          	ld	ra,8(sp)
    80001284:	00013403          	ld	s0,0(sp)
    80001288:	01010113          	addi	sp,sp,16
    8000128c:	00008067          	ret

0000000080001290 <_ZdlPv>:

void operator delete(void *p) noexcept
{
    80001290:	ff010113          	addi	sp,sp,-16
    80001294:	00113423          	sd	ra,8(sp)
    80001298:	00813023          	sd	s0,0(sp)
    8000129c:	01010413          	addi	s0,sp,16
    //__mem_free(p);
    MemoryAllocator::mem_free(p);
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	2b8080e7          	jalr	696(ra) # 80001558 <_ZN15MemoryAllocator8mem_freeEPv>
}
    800012a8:	00813083          	ld	ra,8(sp)
    800012ac:	00013403          	ld	s0,0(sp)
    800012b0:	01010113          	addi	sp,sp,16
    800012b4:	00008067          	ret

00000000800012b8 <_ZdaPv>:

void operator delete[](void *p) noexcept
{
    800012b8:	ff010113          	addi	sp,sp,-16
    800012bc:	00113423          	sd	ra,8(sp)
    800012c0:	00813023          	sd	s0,0(sp)
    800012c4:	01010413          	addi	s0,sp,16
    //__mem_free(p);
    MemoryAllocator::mem_free(p);
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	290080e7          	jalr	656(ra) # 80001558 <_ZN15MemoryAllocator8mem_freeEPv>
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *_thread)
{
    readyCoroutineQueue.addLast(_thread);
    800012e0:	ff010113          	addi	sp,sp,-16
    800012e4:	00813423          	sd	s0,8(sp)
    800012e8:	01010413          	addi	s0,sp,16
    800012ec:	00100793          	li	a5,1
    800012f0:	00f50863          	beq	a0,a5,80001300 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800012f4:	00813403          	ld	s0,8(sp)
    800012f8:	01010113          	addi	sp,sp,16
    800012fc:	00008067          	ret
    80001300:	000107b7          	lui	a5,0x10
    80001304:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001308:	fef596e3          	bne	a1,a5,800012f4 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    8000130c:	00009797          	auipc	a5,0x9
    80001310:	bb478793          	addi	a5,a5,-1100 # 80009ec0 <_ZN9Scheduler19readyCoroutineQueueE>
    80001314:	0007b023          	sd	zero,0(a5)
    80001318:	0007b423          	sd	zero,8(a5)
    8000131c:	fd9ff06f          	j	800012f4 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001320 <_ZN9Scheduler3getEv>:
{
    80001320:	fe010113          	addi	sp,sp,-32
    80001324:	00113c23          	sd	ra,24(sp)
    80001328:	00813823          	sd	s0,16(sp)
    8000132c:	00913423          	sd	s1,8(sp)
    80001330:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001334:	00009517          	auipc	a0,0x9
    80001338:	b8c53503          	ld	a0,-1140(a0) # 80009ec0 <_ZN9Scheduler19readyCoroutineQueueE>
    8000133c:	04050263          	beqz	a0,80001380 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001340:	00853783          	ld	a5,8(a0)
    80001344:	00009717          	auipc	a4,0x9
    80001348:	b6f73e23          	sd	a5,-1156(a4) # 80009ec0 <_ZN9Scheduler19readyCoroutineQueueE>
        if (!head) { tail = 0; }
    8000134c:	02078463          	beqz	a5,80001374 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001350:	00053483          	ld	s1,0(a0)
        delete elem;
    80001354:	00000097          	auipc	ra,0x0
    80001358:	f3c080e7          	jalr	-196(ra) # 80001290 <_ZdlPv>
}
    8000135c:	00048513          	mv	a0,s1
    80001360:	01813083          	ld	ra,24(sp)
    80001364:	01013403          	ld	s0,16(sp)
    80001368:	00813483          	ld	s1,8(sp)
    8000136c:	02010113          	addi	sp,sp,32
    80001370:	00008067          	ret
        if (!head) { tail = 0; }
    80001374:	00009797          	auipc	a5,0x9
    80001378:	b407ba23          	sd	zero,-1196(a5) # 80009ec8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    8000137c:	fd5ff06f          	j	80001350 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001380:	00050493          	mv	s1,a0
    return readyCoroutineQueue.removeFirst();
    80001384:	fd9ff06f          	j	8000135c <_ZN9Scheduler3getEv+0x3c>

0000000080001388 <_ZN9Scheduler3putEP7_thread>:
{
    80001388:	fe010113          	addi	sp,sp,-32
    8000138c:	00113c23          	sd	ra,24(sp)
    80001390:	00813823          	sd	s0,16(sp)
    80001394:	00913423          	sd	s1,8(sp)
    80001398:	02010413          	addi	s0,sp,32
    8000139c:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    800013a0:	01000513          	li	a0,16
    800013a4:	00000097          	auipc	ra,0x0
    800013a8:	e9c080e7          	jalr	-356(ra) # 80001240 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800013ac:	00953023          	sd	s1,0(a0)
    800013b0:	00053423          	sd	zero,8(a0)
        if (tail)
    800013b4:	00009797          	auipc	a5,0x9
    800013b8:	b147b783          	ld	a5,-1260(a5) # 80009ec8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013bc:	02078263          	beqz	a5,800013e0 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800013c0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800013c4:	00009797          	auipc	a5,0x9
    800013c8:	b0a7b223          	sd	a0,-1276(a5) # 80009ec8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013cc:	01813083          	ld	ra,24(sp)
    800013d0:	01013403          	ld	s0,16(sp)
    800013d4:	00813483          	ld	s1,8(sp)
    800013d8:	02010113          	addi	sp,sp,32
    800013dc:	00008067          	ret
            head = tail = elem;
    800013e0:	00009797          	auipc	a5,0x9
    800013e4:	ae078793          	addi	a5,a5,-1312 # 80009ec0 <_ZN9Scheduler19readyCoroutineQueueE>
    800013e8:	00a7b423          	sd	a0,8(a5)
    800013ec:	00a7b023          	sd	a0,0(a5)
    800013f0:	fddff06f          	j	800013cc <_ZN9Scheduler3putEP7_thread+0x44>

00000000800013f4 <_GLOBAL__sub_I__ZN9Scheduler19readyCoroutineQueueE>:
    800013f4:	ff010113          	addi	sp,sp,-16
    800013f8:	00113423          	sd	ra,8(sp)
    800013fc:	00813023          	sd	s0,0(sp)
    80001400:	01010413          	addi	s0,sp,16
    80001404:	000105b7          	lui	a1,0x10
    80001408:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000140c:	00100513          	li	a0,1
    80001410:	00000097          	auipc	ra,0x0
    80001414:	ed0080e7          	jalr	-304(ra) # 800012e0 <_Z41__static_initialization_and_destruction_0ii>
    80001418:	00813083          	ld	ra,8(sp)
    8000141c:	00013403          	ld	s0,0(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block>:
#include "../h/MemoryAllocator.h"

Mem_Block* MemoryAllocator::free_Block = nullptr;


void MemoryAllocator::tryToJoin(Mem_Block* current_Block){
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    if (!current_Block) return;
    80001434:	02050263          	beqz	a0,80001458 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block+0x30>

    //da li ima sledeceg i da li je adresa sledeceg odmah do njega
    if (current_Block->next && current_Block+current_Block->size == current_Block->next){
    80001438:	00053703          	ld	a4,0(a0)
    8000143c:	00070e63          	beqz	a4,80001458 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block+0x30>
    80001440:	01053683          	ld	a3,16(a0)
    80001444:	00169793          	slli	a5,a3,0x1
    80001448:	00d787b3          	add	a5,a5,a3
    8000144c:	00379793          	slli	a5,a5,0x3
    80001450:	00f507b3          	add	a5,a0,a5
    80001454:	00f70863          	beq	a4,a5,80001464 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block+0x3c>
        current_Block->size += current_Block->next->size; //spaja velicine sebe i sledeceg
        current_Block->next = current_Block->next->next;
        if(current_Block->next) current_Block->next->prev = current_Block;
    }
}
    80001458:	00813403          	ld	s0,8(sp)
    8000145c:	01010113          	addi	sp,sp,16
    80001460:	00008067          	ret
        current_Block->size += current_Block->next->size; //spaja velicine sebe i sledeceg
    80001464:	01073783          	ld	a5,16(a4)
    80001468:	00f686b3          	add	a3,a3,a5
    8000146c:	00d53823          	sd	a3,16(a0)
        current_Block->next = current_Block->next->next;
    80001470:	00073783          	ld	a5,0(a4)
    80001474:	00f53023          	sd	a5,0(a0)
        if(current_Block->next) current_Block->next->prev = current_Block;
    80001478:	fe0780e3          	beqz	a5,80001458 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block+0x30>
    8000147c:	00a7b423          	sd	a0,8(a5)
    80001480:	fd9ff06f          	j	80001458 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block+0x30>

0000000080001484 <_ZN15MemoryAllocator9mem_allocEm>:

void *MemoryAllocator::mem_alloc(size_t size) {
    80001484:	ff010113          	addi	sp,sp,-16
    80001488:	00813423          	sd	s0,8(sp)
    8000148c:	01010413          	addi	s0,sp,16
    80001490:	00050713          	mv	a4,a0
    Mem_Block *block = free_Block;
    80001494:	00009517          	auipc	a0,0x9
    80001498:	99c53503          	ld	a0,-1636(a0) # 80009e30 <_ZN15MemoryAllocator10free_BlockE>
    //Trazi prvi blok koji odgovara velicini
    while (block != nullptr) {
    8000149c:	00050a63          	beqz	a0,800014b0 <_ZN15MemoryAllocator9mem_allocEm+0x2c>
        if (block->size >= size) break;
    800014a0:	01053783          	ld	a5,16(a0)
    800014a4:	00e7f663          	bgeu	a5,a4,800014b0 <_ZN15MemoryAllocator9mem_allocEm+0x2c>
        block = block->next;
    800014a8:	00053503          	ld	a0,0(a0)
    while (block != nullptr) {
    800014ac:	ff1ff06f          	j	8000149c <_ZN15MemoryAllocator9mem_allocEm+0x18>
    }

    if (block == nullptr) {
    800014b0:	04050e63          	beqz	a0,8000150c <_ZN15MemoryAllocator9mem_allocEm+0x88>
        return nullptr; // Ne postoji takav blok
    }

    size_t remainingSize = block->size - size; //preostalo mesta
    800014b4:	01053783          	ld	a5,16(a0)
    800014b8:	40e787b3          	sub	a5,a5,a4
    if (remainingSize >= sizeof(Mem_Block) + MEM_BLOCK_SIZE) { //da li je dovoljno da se napravi blok od te preostale memorije
    800014bc:	05700693          	li	a3,87
    800014c0:	06f6f263          	bgeu	a3,a5,80001524 <_ZN15MemoryAllocator9mem_allocEm+0xa0>
        block->size = size;
    800014c4:	00e53823          	sd	a4,16(a0)
        size_t offset = sizeof(Mem_Block) + size;
    800014c8:	01870713          	addi	a4,a4,24
        Mem_Block *new_block = (Mem_Block*)((size_t)block + offset);
    800014cc:	00e50733          	add	a4,a0,a4

        new_block->size = remainingSize - sizeof(Mem_Block); //ubacujem novi blok u listu slobodnih
    800014d0:	fe878793          	addi	a5,a5,-24
    800014d4:	00f73823          	sd	a5,16(a4)
        new_block->next = block->next;
    800014d8:	00053783          	ld	a5,0(a0)
    800014dc:	00f73023          	sd	a5,0(a4)
        new_block->prev = block->prev;
    800014e0:	00853783          	ld	a5,8(a0)
    800014e4:	00f73423          	sd	a5,8(a4)

        if (block->next) block->next->prev = new_block;
    800014e8:	00053783          	ld	a5,0(a0)
    800014ec:	00078463          	beqz	a5,800014f4 <_ZN15MemoryAllocator9mem_allocEm+0x70>
    800014f0:	00e7b423          	sd	a4,8(a5)
        if (block->prev) {
    800014f4:	00853783          	ld	a5,8(a0)
    800014f8:	02078063          	beqz	a5,80001518 <_ZN15MemoryAllocator9mem_allocEm+0x94>
            block->prev->next = new_block;
    800014fc:	00e7b023          	sd	a4,0(a5)
        if (block->next) block->next->prev = block->prev; //nije dovoljno da se napravi blok i zauzima se ceo blok
        if (block->prev) block->prev->next = block->next;
        else free_Block = block->next;
    }

    block->next = nullptr; //izbacujem zauzeti blok iz liste
    80001500:	00053023          	sd	zero,0(a0)
    block->prev = nullptr;
    80001504:	00053423          	sd	zero,8(a0)
    return (void*)((size_t)block + sizeof(Mem_Block)); // vracam adresu bloka
    80001508:	01850513          	addi	a0,a0,24

}
    8000150c:	00813403          	ld	s0,8(sp)
    80001510:	01010113          	addi	sp,sp,16
    80001514:	00008067          	ret
            free_Block = new_block;
    80001518:	00009797          	auipc	a5,0x9
    8000151c:	90e7bc23          	sd	a4,-1768(a5) # 80009e30 <_ZN15MemoryAllocator10free_BlockE>
    80001520:	fe1ff06f          	j	80001500 <_ZN15MemoryAllocator9mem_allocEm+0x7c>
        if (block->next) block->next->prev = block->prev; //nije dovoljno da se napravi blok i zauzima se ceo blok
    80001524:	00053783          	ld	a5,0(a0)
    80001528:	00078663          	beqz	a5,80001534 <_ZN15MemoryAllocator9mem_allocEm+0xb0>
    8000152c:	00853703          	ld	a4,8(a0)
    80001530:	00e7b423          	sd	a4,8(a5)
        if (block->prev) block->prev->next = block->next;
    80001534:	00853783          	ld	a5,8(a0)
    80001538:	00078863          	beqz	a5,80001548 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
    8000153c:	00053703          	ld	a4,0(a0)
    80001540:	00e7b023          	sd	a4,0(a5)
    80001544:	fbdff06f          	j	80001500 <_ZN15MemoryAllocator9mem_allocEm+0x7c>
        else free_Block = block->next;
    80001548:	00053783          	ld	a5,0(a0)
    8000154c:	00009717          	auipc	a4,0x9
    80001550:	8ef73223          	sd	a5,-1820(a4) # 80009e30 <_ZN15MemoryAllocator10free_BlockE>
    80001554:	fadff06f          	j	80001500 <_ZN15MemoryAllocator9mem_allocEm+0x7c>

0000000080001558 <_ZN15MemoryAllocator8mem_freeEPv>:
int MemoryAllocator::mem_free(void *pointerToBlock) {
    if (pointerToBlock < HEAP_START_ADDR || pointerToBlock >= HEAP_END_ADDR) {
    80001558:	00008717          	auipc	a4,0x8
    8000155c:	71873703          	ld	a4,1816(a4) # 80009c70 <HEAP_START_ADDR>
    80001560:	0ae56863          	bltu	a0,a4,80001610 <_ZN15MemoryAllocator8mem_freeEPv+0xb8>
    80001564:	00050793          	mv	a5,a0
    80001568:	00008717          	auipc	a4,0x8
    8000156c:	70073703          	ld	a4,1792(a4) # 80009c68 <HEAP_END_ADDR>
    80001570:	0ae57463          	bgeu	a0,a4,80001618 <_ZN15MemoryAllocator8mem_freeEPv+0xc0>
int MemoryAllocator::mem_free(void *pointerToBlock) {
    80001574:	fe010113          	addi	sp,sp,-32
    80001578:	00113c23          	sd	ra,24(sp)
    8000157c:	00813823          	sd	s0,16(sp)
    80001580:	00913423          	sd	s1,8(sp)
    80001584:	02010413          	addi	s0,sp,32
        return -1; // blockToDelete nije u opsegu granica memorije
    }

    Mem_Block *block_ToFree = (Mem_Block *) ((size_t)pointerToBlock - sizeof(Mem_Block)); // kastujem pointer u blok
    80001588:	fe850513          	addi	a0,a0,-24

    Mem_Block *current_Block = free_Block;
    8000158c:	00009497          	auipc	s1,0x9
    80001590:	8a44b483          	ld	s1,-1884(s1) # 80009e30 <_ZN15MemoryAllocator10free_BlockE>

    if (!current_Block || block_ToFree < current_Block) { //da li ima praznog prostora ili je adresa bloka manja od pocetka liste slobodnih
    80001594:	00048463          	beqz	s1,8000159c <_ZN15MemoryAllocator8mem_freeEPv+0x44>
    80001598:	04957463          	bgeu	a0,s1,800015e0 <_ZN15MemoryAllocator8mem_freeEPv+0x88>
        block_ToFree->next = free_Block;
    8000159c:	fe97b423          	sd	s1,-24(a5)
        block_ToFree->prev = nullptr; //blok stavljam ispred slobodnog prostora
    800015a0:	00053423          	sd	zero,8(a0)
        if (free_Block) free_Block->prev = block_ToFree;
    800015a4:	00048463          	beqz	s1,800015ac <_ZN15MemoryAllocator8mem_freeEPv+0x54>
    800015a8:	00a4b423          	sd	a0,8(s1)
        free_Block = block_ToFree;
    800015ac:	00009797          	auipc	a5,0x9
    800015b0:	88a7b223          	sd	a0,-1916(a5) # 80009e30 <_ZN15MemoryAllocator10free_BlockE>
        block_ToFree->prev = current_Block;
        if (current_Block->next) current_Block->next->prev = block_ToFree;
        current_Block->next = block_ToFree;
    }

    tryToJoin(block_ToFree); //pokusavam da spojim sa sledecim blokom
    800015b4:	00000097          	auipc	ra,0x0
    800015b8:	e74080e7          	jalr	-396(ra) # 80001428 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block>
    tryToJoin(current_Block); //pokusavam da spojim sa prethodnim blokom
    800015bc:	00048513          	mv	a0,s1
    800015c0:	00000097          	auipc	ra,0x0
    800015c4:	e68080e7          	jalr	-408(ra) # 80001428 <_ZN15MemoryAllocator9tryToJoinEP9Mem_Block>

    return 0;
    800015c8:	00000513          	li	a0,0
}
    800015cc:	01813083          	ld	ra,24(sp)
    800015d0:	01013403          	ld	s0,16(sp)
    800015d4:	00813483          	ld	s1,8(sp)
    800015d8:	02010113          	addi	sp,sp,32
    800015dc:	00008067          	ret
        while (current_Block->next && current_Block->next < block_ToFree) {
    800015e0:	00048713          	mv	a4,s1
    800015e4:	0004b483          	ld	s1,0(s1)
    800015e8:	00048463          	beqz	s1,800015f0 <_ZN15MemoryAllocator8mem_freeEPv+0x98>
    800015ec:	fea4eae3          	bltu	s1,a0,800015e0 <_ZN15MemoryAllocator8mem_freeEPv+0x88>
        block_ToFree->next = current_Block->next;
    800015f0:	fe97b423          	sd	s1,-24(a5)
        block_ToFree->prev = current_Block;
    800015f4:	00e53423          	sd	a4,8(a0)
        if (current_Block->next) current_Block->next->prev = block_ToFree;
    800015f8:	00073783          	ld	a5,0(a4)
    800015fc:	00078463          	beqz	a5,80001604 <_ZN15MemoryAllocator8mem_freeEPv+0xac>
    80001600:	00a7b423          	sd	a0,8(a5)
        current_Block->next = block_ToFree;
    80001604:	00a73023          	sd	a0,0(a4)
    80001608:	00070493          	mv	s1,a4
    8000160c:	fa9ff06f          	j	800015b4 <_ZN15MemoryAllocator8mem_freeEPv+0x5c>
        return -1; // blockToDelete nije u opsegu granica memorije
    80001610:	fff00513          	li	a0,-1
    80001614:	00008067          	ret
    80001618:	fff00513          	li	a0,-1
}
    8000161c:	00008067          	ret

0000000080001620 <_ZN5Riscv10popSppSpieEv>:
#include "../test/printing.hpp"
#include "../h/_sem.hpp"
#include "../h/MemoryAllocator.h"


void Riscv::popSppSpie(){
    80001620:	ff010113          	addi	sp,sp,-16
    80001624:	00813423          	sd	s0,8(sp)
    80001628:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    8000162c:	10000793          	li	a5,256
    80001630:	1007b073          	csrc	sstatus,a5
    mc_sstatus(Riscv::SSTATUS_SPP);
    __asm__ volatile ("csrw sepc, ra"); // zato ovde upisujem da nas vrati tamo odakle je i ova funkcija bila i pozvana i zbog toga ova funckija nije inline
    80001634:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret"); //ovo sret ce vratiti tamo gde je sepc rekao, i to nam ne odgovara
    80001638:	10200073          	sret

}
    8000163c:	00813403          	ld	s0,8(sp)
    80001640:	01010113          	addi	sp,sp,16
    80001644:	00008067          	ret

0000000080001648 <_ZN5Riscv23interruptRoutineHandlerEv>:



void Riscv::interruptRoutineHandler(){
    80001648:	f8010113          	addi	sp,sp,-128
    8000164c:	06113c23          	sd	ra,120(sp)
    80001650:	06813823          	sd	s0,112(sp)
    80001654:	06913423          	sd	s1,104(sp)
    80001658:	08010413          	addi	s0,sp,128
    uint64 volatile fcode;
    asm volatile("mv %0, a0" : "=r" (fcode));
    8000165c:	00050793          	mv	a5,a0
    80001660:	fcf43c23          	sd	a5,-40(s0)
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001664:	142027f3          	csrr	a5,scause
    80001668:	faf43823          	sd	a5,-80(s0)
    return scause;
    8000166c:	fb043483          	ld	s1,-80(s0)
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001670:	141027f3          	csrr	a5,sepc
    80001674:	faf43423          	sd	a5,-88(s0)
    return sepc;
    80001678:	fa843783          	ld	a5,-88(s0)
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida
    uint64 volatile sepc = r_sepc();    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    8000167c:	fcf43823          	sd	a5,-48(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001680:	100027f3          	csrr	a5,sstatus
    80001684:	faf43023          	sd	a5,-96(s0)
    return sstatus;
    80001688:	fa043783          	ld	a5,-96(s0)
    uint64 volatile sstatus = r_sstatus();
    8000168c:	fcf43423          	sd	a5,-56(s0)

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
    80001690:	ff848713          	addi	a4,s1,-8
    80001694:	00100793          	li	a5,1
    80001698:	0ce7fa63          	bgeu	a5,a4,8000176c <_ZN5Riscv23interruptRoutineHandlerEv+0x124>
            w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
            w_sstatus(sstatus);


    }
    else if (scause == 0x8000000000000001UL){
    8000169c:	fff00793          	li	a5,-1
    800016a0:	03f79793          	slli	a5,a5,0x3f
    800016a4:	00178793          	addi	a5,a5,1
    800016a8:	20f48e63          	beq	s1,a5,800018c4 <_ZN5Riscv23interruptRoutineHandlerEv+0x27c>
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
    800016ac:	fff00793          	li	a5,-1
    800016b0:	03f79793          	slli	a5,a5,0x3f
    800016b4:	00978793          	addi	a5,a5,9
    800016b8:	20f48c63          	beq	s1,a5,800018d0 <_ZN5Riscv23interruptRoutineHandlerEv+0x288>
        console_handler();
    }
    else{
        printString("\nPc greske: ");
    800016bc:	00007517          	auipc	a0,0x7
    800016c0:	96450513          	addi	a0,a0,-1692 # 80008020 <CONSOLE_STATUS+0x10>
    800016c4:	00001097          	auipc	ra,0x1
    800016c8:	fd4080e7          	jalr	-44(ra) # 80002698 <_Z11printStringPKc>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800016cc:	141027f3          	csrr	a5,sepc
    800016d0:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    800016d4:	fc043503          	ld	a0,-64(s0)
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
    800016d8:	00000613          	li	a2,0
    800016dc:	00a00593          	li	a1,10
    800016e0:	0005051b          	sext.w	a0,a0
    800016e4:	00001097          	auipc	ra,0x1
    800016e8:	164080e7          	jalr	356(ra) # 80002848 <_Z8printIntiii>
        printString("\nStVal greske: ");
    800016ec:	00007517          	auipc	a0,0x7
    800016f0:	94450513          	addi	a0,a0,-1724 # 80008030 <CONSOLE_STATUS+0x20>
    800016f4:	00001097          	auipc	ra,0x1
    800016f8:	fa4080e7          	jalr	-92(ra) # 80002698 <_Z11printStringPKc>
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800016fc:	143027f3          	csrr	a5,stval
    80001700:	faf43c23          	sd	a5,-72(s0)
    return stval;
    80001704:	fb843503          	ld	a0,-72(s0)
        printInt(r_stval());
    80001708:	00000613          	li	a2,0
    8000170c:	00a00593          	li	a1,10
    80001710:	0005051b          	sext.w	a0,a0
    80001714:	00001097          	auipc	ra,0x1
    80001718:	134080e7          	jalr	308(ra) # 80002848 <_Z8printIntiii>
        printString("\nRazlog greske scause: ");
    8000171c:	00007517          	auipc	a0,0x7
    80001720:	92450513          	addi	a0,a0,-1756 # 80008040 <CONSOLE_STATUS+0x30>
    80001724:	00001097          	auipc	ra,0x1
    80001728:	f74080e7          	jalr	-140(ra) # 80002698 <_Z11printStringPKc>
        printInt(scause);
    8000172c:	00000613          	li	a2,0
    80001730:	00a00593          	li	a1,10
    80001734:	0004851b          	sext.w	a0,s1
    80001738:	00001097          	auipc	ra,0x1
    8000173c:	110080e7          	jalr	272(ra) # 80002848 <_Z8printIntiii>
        switch(scause) {
    80001740:	00500793          	li	a5,5
    80001744:	1af48663          	beq	s1,a5,800018f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x2a8>
    80001748:	00700793          	li	a5,7
    8000174c:	1af48c63          	beq	s1,a5,80001904 <_ZN5Riscv23interruptRoutineHandlerEv+0x2bc>
    80001750:	00200793          	li	a5,2
    80001754:	18f48463          	beq	s1,a5,800018dc <_ZN5Riscv23interruptRoutineHandlerEv+0x294>
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
    80001758:	00007517          	auipc	a0,0x7
    8000175c:	95850513          	addi	a0,a0,-1704 # 800080b0 <CONSOLE_STATUS+0xa0>
    80001760:	00001097          	auipc	ra,0x1
    80001764:	f38080e7          	jalr	-200(ra) # 80002698 <_Z11printStringPKc>
                break;
        }
    }
}
    80001768:	0580006f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>
        sepc = sepc+4;
    8000176c:	fd043783          	ld	a5,-48(s0)
    80001770:	00478793          	addi	a5,a5,4
    80001774:	fcf43823          	sd	a5,-48(s0)
        switch(fcode){
    80001778:	fd843783          	ld	a5,-40(s0)
    8000177c:	04100713          	li	a4,65
    80001780:	02f76863          	bltu	a4,a5,800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
    80001784:	00279793          	slli	a5,a5,0x2
    80001788:	00007717          	auipc	a4,0x7
    8000178c:	93070713          	addi	a4,a4,-1744 # 800080b8 <CONSOLE_STATUS+0xa8>
    80001790:	00e787b3          	add	a5,a5,a4
    80001794:	0007a783          	lw	a5,0(a5)
    80001798:	00e787b3          	add	a5,a5,a4
    8000179c:	00078067          	jr	a5
                asm volatile("mv %0, a1" : "=r" (size));
    800017a0:	00058513          	mv	a0,a1
                ret = MemoryAllocator::mem_alloc(size);
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	ce0080e7          	jalr	-800(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
                asm volatile("mv a0, %0" : : "r" (ret));
    800017ac:	00050513          	mv	a0,a0
            w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
    800017b0:	fd043783          	ld	a5,-48(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800017b4:	14179073          	csrw	sepc,a5
            w_sstatus(sstatus);
    800017b8:	fc843783          	ld	a5,-56(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800017bc:	10079073          	csrw	sstatus,a5
}
    800017c0:	07813083          	ld	ra,120(sp)
    800017c4:	07013403          	ld	s0,112(sp)
    800017c8:	06813483          	ld	s1,104(sp)
    800017cc:	08010113          	addi	sp,sp,128
    800017d0:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (p));
    800017d4:	00058513          	mv	a0,a1
                retval = MemoryAllocator::mem_free(p);
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	d80080e7          	jalr	-640(ra) # 80001558 <_ZN15MemoryAllocator8mem_freeEPv>
                asm volatile("mv a0, %0" : : "r" (retval));
    800017e0:	00050513          	mv	a0,a0
                break;
    800017e4:	fcdff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
    800017e8:	00058793          	mv	a5,a1
    800017ec:	f8f43423          	sd	a5,-120(s0)
                asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
    800017f0:	00060793          	mv	a5,a2
    800017f4:	f8f43823          	sd	a5,-112(s0)
                asm volatile("mv %0, a3" : "=r" (arg));
    800017f8:	00068793          	mv	a5,a3
    800017fc:	f8f43c23          	sd	a5,-104(s0)
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
    80001800:	00008537          	lui	a0,0x8
    80001804:	00000097          	auipc	ra,0x0
    80001808:	a64080e7          	jalr	-1436(ra) # 80001268 <_Znam>
    8000180c:	00050693          	mv	a3,a0
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
    80001810:	f8843503          	ld	a0,-120(s0)
    80001814:	f9043583          	ld	a1,-112(s0)
    80001818:	f9843603          	ld	a2,-104(s0)
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	3c4080e7          	jalr	964(ra) # 80001be0 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001824:	00050513          	mv	a0,a0
                break;
    80001828:	f89ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                retval = _thread::thread_exit();
    8000182c:	00000097          	auipc	ra,0x0
    80001830:	50c080e7          	jalr	1292(ra) # 80001d38 <_ZN7_thread11thread_exitEv>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001834:	00050513          	mv	a0,a0
                break;
    80001838:	f79ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                _thread::thread_dispatch();
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	490080e7          	jalr	1168(ra) # 80001ccc <_ZN7_thread15thread_dispatchEv>
                break;
    80001844:	f6dff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001848:	00058513          	mv	a0,a1
                asm volatile("mv %0, a2" : "=r" (init));
    8000184c:	00060593          	mv	a1,a2
                retval = _sem::open_sem((sem_t*)(handle), init);
    80001850:	0005859b          	sext.w	a1,a1
    80001854:	00000097          	auipc	ra,0x0
    80001858:	0c4080e7          	jalr	196(ra) # 80001918 <_ZN4_sem8open_semEPPS_j>
                asm volatile("mv a0, %0" : : "r" (retval));
    8000185c:	00050513          	mv	a0,a0
                break;
    80001860:	f51ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001864:	00058513          	mv	a0,a1
                retval = _sem::close_sem((sem_t)handle);
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	114080e7          	jalr	276(ra) # 8000197c <_ZN4_sem9close_semEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001870:	00050513          	mv	a0,a0
                break;
    80001874:	f3dff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001878:	00058513          	mv	a0,a1
                retval = _sem::sem_wait((sem_t)handle);
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	214080e7          	jalr	532(ra) # 80001a90 <_ZN4_sem8sem_waitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001884:	00050513          	mv	a0,a0
                break;
    80001888:	f29ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));
    8000188c:	00058513          	mv	a0,a1
                retval = _sem::sem_signal((sem_t)handle);
    80001890:	00000097          	auipc	ra,0x0
    80001894:	174080e7          	jalr	372(ra) # 80001a04 <_ZN4_sem10sem_signalEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001898:	00050513          	mv	a0,a0
                break;
    8000189c:	f15ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                asm volatile("mv %0, a1" : "=r" (handle));
    800018a0:	00058513          	mv	a0,a1
                retval = _sem::sem_trywait((sem_t)handle);
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	2a8080e7          	jalr	680(ra) # 80001b4c <_ZN4_sem11sem_trywaitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    800018ac:	00050513          	mv	a0,a0
                break;
    800018b0:	f01ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
                char ch = __getc();
    800018b4:	00006097          	auipc	ra,0x6
    800018b8:	804080e7          	jalr	-2044(ra) # 800070b8 <__getc>
                asm volatile("mv a0, %0" : : "r" (ch));
    800018bc:	00050513          	mv	a0,a0
                break;
    800018c0:	ef1ff06f          	j	800017b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x168>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018c4:	00200793          	li	a5,2
    800018c8:	1447b073          	csrc	sip,a5
}
    800018cc:	ef5ff06f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>
        console_handler();
    800018d0:	00006097          	auipc	ra,0x6
    800018d4:	820080e7          	jalr	-2016(ra) # 800070f0 <console_handler>
    800018d8:	ee9ff06f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>
                printString(" Nelegelna instrukcija");
    800018dc:	00006517          	auipc	a0,0x6
    800018e0:	77c50513          	addi	a0,a0,1916 # 80008058 <CONSOLE_STATUS+0x48>
    800018e4:	00001097          	auipc	ra,0x1
    800018e8:	db4080e7          	jalr	-588(ra) # 80002698 <_Z11printStringPKc>
                break;
    800018ec:	ed5ff06f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>
                printString(" Nedozvoljena adresa citanja");
    800018f0:	00006517          	auipc	a0,0x6
    800018f4:	78050513          	addi	a0,a0,1920 # 80008070 <CONSOLE_STATUS+0x60>
    800018f8:	00001097          	auipc	ra,0x1
    800018fc:	da0080e7          	jalr	-608(ra) # 80002698 <_Z11printStringPKc>
                break;
    80001900:	ec1ff06f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>
                printString(" Nedozvoljena adresa upisa");
    80001904:	00006517          	auipc	a0,0x6
    80001908:	78c50513          	addi	a0,a0,1932 # 80008090 <CONSOLE_STATUS+0x80>
    8000190c:	00001097          	auipc	ra,0x1
    80001910:	d8c080e7          	jalr	-628(ra) # 80002698 <_Z11printStringPKc>
                break;
    80001914:	eadff06f          	j	800017c0 <_ZN5Riscv23interruptRoutineHandlerEv+0x178>

0000000080001918 <_ZN4_sem8open_semEPPS_j>:
//

#include "../h/_sem.hpp"


int _sem::open_sem(sem_t* handle, unsigned init){
    80001918:	fe010113          	addi	sp,sp,-32
    8000191c:	00113c23          	sd	ra,24(sp)
    80001920:	00813823          	sd	s0,16(sp)
    80001924:	00913423          	sd	s1,8(sp)
    80001928:	01213023          	sd	s2,0(sp)
    8000192c:	02010413          	addi	s0,sp,32
    80001930:	00050493          	mv	s1,a0
    80001934:	00058913          	mv	s2,a1
    *handle = new _sem(init);
    80001938:	01800513          	li	a0,24
    8000193c:	00000097          	auipc	ra,0x0
    80001940:	904080e7          	jalr	-1788(ra) # 80001240 <_Znwm>
    static int close_sem(sem_t id);
    static int sem_wait(sem_t id);
    static int sem_trywait(sem_t id);
    static int sem_signal(sem_t id);
private:
    _sem(unsigned v):val(v){ }//mozda ce trebati new blocked
    80001944:	01252023          	sw	s2,0(a0)
    List() : head(0), tail(0) {}
    80001948:	00053423          	sd	zero,8(a0)
    8000194c:	00053823          	sd	zero,16(a0)
    80001950:	00a4b023          	sd	a0,0(s1)
    if(*handle != nullptr) return 0;
    80001954:	02050063          	beqz	a0,80001974 <_ZN4_sem8open_semEPPS_j+0x5c>
    80001958:	00000513          	li	a0,0
    return -1;
}
    8000195c:	01813083          	ld	ra,24(sp)
    80001960:	01013403          	ld	s0,16(sp)
    80001964:	00813483          	ld	s1,8(sp)
    80001968:	00013903          	ld	s2,0(sp)
    8000196c:	02010113          	addi	sp,sp,32
    80001970:	00008067          	ret
    return -1;
    80001974:	fff00513          	li	a0,-1
    80001978:	fe5ff06f          	j	8000195c <_ZN4_sem8open_semEPPS_j+0x44>

000000008000197c <_ZN4_sem9close_semEPS_>:

int _sem::close_sem(sem_t id) {
    8000197c:	fe010113          	addi	sp,sp,-32
    80001980:	00113c23          	sd	ra,24(sp)
    80001984:	00813823          	sd	s0,16(sp)
    80001988:	00913423          	sd	s1,8(sp)
    8000198c:	01213023          	sd	s2,0(sp)
    80001990:	02010413          	addi	s0,sp,32
    80001994:	00050493          	mv	s1,a0
    if(id==nullptr) return -1;
    80001998:	02051463          	bnez	a0,800019c0 <_ZN4_sem9close_semEPS_+0x44>
    8000199c:	fff00513          	li	a0,-1
    800019a0:	0440006f          	j	800019e4 <_ZN4_sem9close_semEPS_+0x68>
        if (!head) { tail = 0; }
    800019a4:	0004b823          	sd	zero,16(s1)
        T *ret = elem->data;
    800019a8:	00053903          	ld	s2,0(a0)
        delete elem;
    800019ac:	00000097          	auipc	ra,0x0
    800019b0:	8e4080e7          	jalr	-1820(ra) # 80001290 <_ZdlPv>
    while(!id->blocked.empty()){
        Scheduler::put(id->blocked.get());
    800019b4:	00090513          	mv	a0,s2
    800019b8:	00000097          	auipc	ra,0x0
    800019bc:	9d0080e7          	jalr	-1584(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
    800019c0:	0084b503          	ld	a0,8(s1)
    800019c4:	00050e63          	beqz	a0,800019e0 <_ZN4_sem9close_semEPS_+0x64>
        return head->data;
    800019c8:	00053783          	ld	a5,0(a0)
    while(!id->blocked.empty()){
    800019cc:	02078863          	beqz	a5,800019fc <_ZN4_sem9close_semEPS_+0x80>
        head = head->next;
    800019d0:	00853783          	ld	a5,8(a0)
    800019d4:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    800019d8:	fc0798e3          	bnez	a5,800019a8 <_ZN4_sem9close_semEPS_+0x2c>
    800019dc:	fc9ff06f          	j	800019a4 <_ZN4_sem9close_semEPS_+0x28>
    }
  //  delete id;
    id=nullptr;
    return 0;
    800019e0:	00000513          	li	a0,0
}
    800019e4:	01813083          	ld	ra,24(sp)
    800019e8:	01013403          	ld	s0,16(sp)
    800019ec:	00813483          	ld	s1,8(sp)
    800019f0:	00013903          	ld	s2,0(sp)
    800019f4:	02010113          	addi	sp,sp,32
    800019f8:	00008067          	ret
    return 0;
    800019fc:	00000513          	li	a0,0
    80001a00:	fe5ff06f          	j	800019e4 <_ZN4_sem9close_semEPS_+0x68>

0000000080001a04 <_ZN4_sem10sem_signalEPS_>:

int _sem::sem_signal(sem_t id) {
    if(id==nullptr) return -1;
    80001a04:	08050263          	beqz	a0,80001a88 <_ZN4_sem10sem_signalEPS_+0x84>
    80001a08:	00050793          	mv	a5,a0
        if (!head) { return 0; }
    80001a0c:	00853503          	ld	a0,8(a0)
    80001a10:	06050263          	beqz	a0,80001a74 <_ZN4_sem10sem_signalEPS_+0x70>
        return head->data;
    80001a14:	00053703          	ld	a4,0(a0)
    if (!id->blocked.empty()){
    80001a18:	04070e63          	beqz	a4,80001a74 <_ZN4_sem10sem_signalEPS_+0x70>
int _sem::sem_signal(sem_t id) {
    80001a1c:	fe010113          	addi	sp,sp,-32
    80001a20:	00113c23          	sd	ra,24(sp)
    80001a24:	00813823          	sd	s0,16(sp)
    80001a28:	00913423          	sd	s1,8(sp)
    80001a2c:	02010413          	addi	s0,sp,32
        head = head->next;
    80001a30:	00853703          	ld	a4,8(a0)
    80001a34:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001a38:	02070a63          	beqz	a4,80001a6c <_ZN4_sem10sem_signalEPS_+0x68>
        T *ret = elem->data;
    80001a3c:	00053483          	ld	s1,0(a0)
        delete elem;
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	850080e7          	jalr	-1968(ra) # 80001290 <_ZdlPv>
        Scheduler::put(id->blocked.get());
    80001a48:	00048513          	mv	a0,s1
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	93c080e7          	jalr	-1732(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    }
    else id->val++;
    return 0;
    80001a54:	00000513          	li	a0,0
}
    80001a58:	01813083          	ld	ra,24(sp)
    80001a5c:	01013403          	ld	s0,16(sp)
    80001a60:	00813483          	ld	s1,8(sp)
    80001a64:	02010113          	addi	sp,sp,32
    80001a68:	00008067          	ret
        if (!head) { tail = 0; }
    80001a6c:	0007b823          	sd	zero,16(a5)
    80001a70:	fcdff06f          	j	80001a3c <_ZN4_sem10sem_signalEPS_+0x38>
    else id->val++;
    80001a74:	0007a703          	lw	a4,0(a5)
    80001a78:	0017071b          	addiw	a4,a4,1
    80001a7c:	00e7a023          	sw	a4,0(a5)
    return 0;
    80001a80:	00000513          	li	a0,0
    80001a84:	00008067          	ret
    if(id==nullptr) return -1;
    80001a88:	fff00513          	li	a0,-1
}
    80001a8c:	00008067          	ret

0000000080001a90 <_ZN4_sem8sem_waitEPS_>:

int _sem::sem_wait(sem_t id) {
    if(id==nullptr) return -1;
    80001a90:	0a050a63          	beqz	a0,80001b44 <_ZN4_sem8sem_waitEPS_+0xb4>
int _sem::sem_wait(sem_t id) {
    80001a94:	fe010113          	addi	sp,sp,-32
    80001a98:	00113c23          	sd	ra,24(sp)
    80001a9c:	00813823          	sd	s0,16(sp)
    80001aa0:	00913423          	sd	s1,8(sp)
    80001aa4:	01213023          	sd	s2,0(sp)
    80001aa8:	02010413          	addi	s0,sp,32
    80001aac:	00050493          	mv	s1,a0
    _thread *old = _thread::running;
    80001ab0:	00008917          	auipc	s2,0x8
    80001ab4:	38893903          	ld	s2,904(s2) # 80009e38 <_ZN7_thread7runningE>
    if (id->val>0) id->val--;
    80001ab8:	00052783          	lw	a5,0(a0)
    80001abc:	02078463          	beqz	a5,80001ae4 <_ZN4_sem8sem_waitEPS_+0x54>
    80001ac0:	fff7879b          	addiw	a5,a5,-1
    80001ac4:	00f52023          	sw	a5,0(a0)
    }

    if (!id){
        return -1;
    }
    else return 0;
    80001ac8:	00000513          	li	a0,0
}
    80001acc:	01813083          	ld	ra,24(sp)
    80001ad0:	01013403          	ld	s0,16(sp)
    80001ad4:	00813483          	ld	s1,8(sp)
    80001ad8:	00013903          	ld	s2,0(sp)
    80001adc:	02010113          	addi	sp,sp,32
    80001ae0:	00008067          	ret

    using Body = void (*)(void(*)); //pokazivac na funkciju koja nema argumente ni povratnu vrednost

    ~_thread() {delete[] stack;}

    bool isFinished() const { return finished; }
    80001ae4:	02894783          	lbu	a5,40(s2)
        if(!old->isFinished()){
    80001ae8:	02078463          	beqz	a5,80001b10 <_ZN4_sem8sem_waitEPS_+0x80>
        _thread::running = Scheduler::get();
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	834080e7          	jalr	-1996(ra) # 80001320 <_ZN9Scheduler3getEv>
    80001af4:	00008797          	auipc	a5,0x8
    80001af8:	34a7b223          	sd	a0,836(a5) # 80009e38 <_ZN7_thread7runningE>
        _thread::contextSwitch(&old->context, &_thread::running->context);
    80001afc:	01050593          	addi	a1,a0,16
    80001b00:	01090513          	addi	a0,s2,16
    80001b04:	fffff097          	auipc	ra,0xfffff
    80001b08:	614080e7          	jalr	1556(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
    80001b0c:	fbdff06f          	j	80001ac8 <_ZN4_sem8sem_waitEPS_+0x38>
        Elem *elem = new Elem(data, 0);
    80001b10:	01000513          	li	a0,16
    80001b14:	fffff097          	auipc	ra,0xfffff
    80001b18:	72c080e7          	jalr	1836(ra) # 80001240 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001b1c:	01253023          	sd	s2,0(a0)
    80001b20:	00053423          	sd	zero,8(a0)
        if (tail)
    80001b24:	0104b783          	ld	a5,16(s1)
    80001b28:	00078863          	beqz	a5,80001b38 <_ZN4_sem8sem_waitEPS_+0xa8>
            tail->next = elem;
    80001b2c:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001b30:	00a4b823          	sd	a0,16(s1)
    80001b34:	fb9ff06f          	j	80001aec <_ZN4_sem8sem_waitEPS_+0x5c>
            head = tail = elem;
    80001b38:	00a4b823          	sd	a0,16(s1)
    80001b3c:	00a4b423          	sd	a0,8(s1)
    80001b40:	fadff06f          	j	80001aec <_ZN4_sem8sem_waitEPS_+0x5c>
    if(id==nullptr) return -1;
    80001b44:	fff00513          	li	a0,-1
}
    80001b48:	00008067          	ret

0000000080001b4c <_ZN4_sem11sem_trywaitEPS_>:

int _sem::sem_trywait(sem_t id) {
    80001b4c:	ff010113          	addi	sp,sp,-16
    80001b50:	00813423          	sd	s0,8(sp)
    80001b54:	01010413          	addi	s0,sp,16
    if(id==nullptr) return -1;
    80001b58:	02050263          	beqz	a0,80001b7c <_ZN4_sem11sem_trywaitEPS_+0x30>
    if (id->val>0) {
    80001b5c:	00052783          	lw	a5,0(a0)
    80001b60:	02078263          	beqz	a5,80001b84 <_ZN4_sem11sem_trywaitEPS_+0x38>
        id->val--;
    80001b64:	fff7879b          	addiw	a5,a5,-1
    80001b68:	0007871b          	sext.w	a4,a5
    80001b6c:	00f52023          	sw	a5,0(a0)
        if (id->val > 0) return 0;
    80001b70:	02071263          	bnez	a4,80001b94 <_ZN4_sem11sem_trywaitEPS_+0x48>
    }
    return 1;
    80001b74:	00100513          	li	a0,1
    80001b78:	0100006f          	j	80001b88 <_ZN4_sem11sem_trywaitEPS_+0x3c>
    if(id==nullptr) return -1;
    80001b7c:	fff00513          	li	a0,-1
    80001b80:	0080006f          	j	80001b88 <_ZN4_sem11sem_trywaitEPS_+0x3c>
    return 1;
    80001b84:	00100513          	li	a0,1
    80001b88:	00813403          	ld	s0,8(sp)
    80001b8c:	01010113          	addi	sp,sp,16
    80001b90:	00008067          	ret
        if (id->val > 0) return 0;
    80001b94:	00000513          	li	a0,0
    80001b98:	ff1ff06f          	j	80001b88 <_ZN4_sem11sem_trywaitEPS_+0x3c>

0000000080001b9c <_ZN7_thread13threadWrapperEv>:
    _thread::running->setFinished(true);
    _thread::thread_dispatch();
    return 1;
}

void _thread::threadWrapper() {
    80001b9c:	ff010113          	addi	sp,sp,-16
    80001ba0:	00113423          	sd	ra,8(sp)
    80001ba4:	00813023          	sd	s0,0(sp)
    80001ba8:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	a74080e7          	jalr	-1420(ra) # 80001620 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80001bb4:	00008797          	auipc	a5,0x8
    80001bb8:	2847b783          	ld	a5,644(a5) # 80009e38 <_ZN7_thread7runningE>
    80001bbc:	0007b703          	ld	a4,0(a5)
    80001bc0:	0207b503          	ld	a0,32(a5)
    80001bc4:	000700e7          	jalr	a4
   // running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    ::thread_exit();
    80001bc8:	00000097          	auipc	ra,0x0
    80001bcc:	46c080e7          	jalr	1132(ra) # 80002034 <_Z11thread_exitv>
    //_thread::thread_dispatch();
}
    80001bd0:	00813083          	ld	ra,8(sp)
    80001bd4:	00013403          	ld	s0,0(sp)
    80001bd8:	01010113          	addi	sp,sp,16
    80001bdc:	00008067          	ret

0000000080001be0 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>:
int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){
    80001be0:	fc010113          	addi	sp,sp,-64
    80001be4:	02113c23          	sd	ra,56(sp)
    80001be8:	02813823          	sd	s0,48(sp)
    80001bec:	02913423          	sd	s1,40(sp)
    80001bf0:	03213023          	sd	s2,32(sp)
    80001bf4:	01313c23          	sd	s3,24(sp)
    80001bf8:	01413823          	sd	s4,16(sp)
    80001bfc:	01513423          	sd	s5,8(sp)
    80001c00:	04010413          	addi	s0,sp,64
    80001c04:	00050a13          	mv	s4,a0
    80001c08:	00058993          	mv	s3,a1
    80001c0c:	00060a93          	mv	s5,a2
    80001c10:	00068913          	mv	s2,a3
    *handle = new _thread(body, arg, stack_space);
    80001c14:	03000513          	li	a0,48
    80001c18:	fffff097          	auipc	ra,0xfffff
    80001c1c:	628080e7          	jalr	1576(ra) # 80001240 <_Znwm>
    80001c20:	00050493          	mv	s1,a0
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false){
    80001c24:	01353023          	sd	s3,0(a0)
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    80001c28:	04098063          	beqz	s3,80001c68 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x88>
        finished(false){
    80001c2c:	0124b423          	sd	s2,8(s1)
    80001c30:	00000797          	auipc	a5,0x0
    80001c34:	f6c78793          	addi	a5,a5,-148 # 80001b9c <_ZN7_thread13threadWrapperEv>
    80001c38:	00f4b823          	sd	a5,16(s1)
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001c3c:	02090a63          	beqz	s2,80001c70 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x90>
    80001c40:	000086b7          	lui	a3,0x8
    80001c44:	00d90933          	add	s2,s2,a3
        finished(false){
    80001c48:	0124bc23          	sd	s2,24(s1)
    80001c4c:	0354b023          	sd	s5,32(s1)
    80001c50:	02048423          	sb	zero,40(s1)
        if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
    80001c54:	02098263          	beqz	s3,80001c78 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
    80001c58:	00048513          	mv	a0,s1
    80001c5c:	fffff097          	auipc	ra,0xfffff
    80001c60:	72c080e7          	jalr	1836(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001c64:	0140006f          	j	80001c78 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    80001c68:	00000913          	li	s2,0
    80001c6c:	fc1ff06f          	j	80001c2c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x4c>
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001c70:	00000913          	li	s2,0
    80001c74:	fd5ff06f          	j	80001c48 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x68>
    80001c78:	009a3023          	sd	s1,0(s4)
    if(*handle != nullptr) return 0;
    80001c7c:	02048663          	beqz	s1,80001ca8 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xc8>
    80001c80:	00000513          	li	a0,0
}
    80001c84:	03813083          	ld	ra,56(sp)
    80001c88:	03013403          	ld	s0,48(sp)
    80001c8c:	02813483          	ld	s1,40(sp)
    80001c90:	02013903          	ld	s2,32(sp)
    80001c94:	01813983          	ld	s3,24(sp)
    80001c98:	01013a03          	ld	s4,16(sp)
    80001c9c:	00813a83          	ld	s5,8(sp)
    80001ca0:	04010113          	addi	sp,sp,64
    80001ca4:	00008067          	ret
    return -1;
    80001ca8:	fff00513          	li	a0,-1
    80001cac:	fd9ff06f          	j	80001c84 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xa4>
    80001cb0:	00050913          	mv	s2,a0
    *handle = new _thread(body, arg, stack_space);
    80001cb4:	00048513          	mv	a0,s1
    80001cb8:	fffff097          	auipc	ra,0xfffff
    80001cbc:	5d8080e7          	jalr	1496(ra) # 80001290 <_ZdlPv>
    80001cc0:	00090513          	mv	a0,s2
    80001cc4:	00009097          	auipc	ra,0x9
    80001cc8:	2d4080e7          	jalr	724(ra) # 8000af98 <_Unwind_Resume>

0000000080001ccc <_ZN7_thread15thread_dispatchEv>:
void _thread::thread_dispatch(){
    80001ccc:	fe010113          	addi	sp,sp,-32
    80001cd0:	00113c23          	sd	ra,24(sp)
    80001cd4:	00813823          	sd	s0,16(sp)
    80001cd8:	00913423          	sd	s1,8(sp)
    80001cdc:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001ce0:	00008497          	auipc	s1,0x8
    80001ce4:	1584b483          	ld	s1,344(s1) # 80009e38 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001ce8:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001cec:	02078e63          	beqz	a5,80001d28 <_ZN7_thread15thread_dispatchEv+0x5c>
    running = Scheduler::get();
    80001cf0:	fffff097          	auipc	ra,0xfffff
    80001cf4:	630080e7          	jalr	1584(ra) # 80001320 <_ZN9Scheduler3getEv>
    80001cf8:	00008797          	auipc	a5,0x8
    80001cfc:	14a7b023          	sd	a0,320(a5) # 80009e38 <_ZN7_thread7runningE>
    if(old != running){
    80001d00:	00a48a63          	beq	s1,a0,80001d14 <_ZN7_thread15thread_dispatchEv+0x48>
        _thread::contextSwitch(&old->context, &running->context);
    80001d04:	01050593          	addi	a1,a0,16
    80001d08:	01048513          	addi	a0,s1,16
    80001d0c:	fffff097          	auipc	ra,0xfffff
    80001d10:	40c080e7          	jalr	1036(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001d14:	01813083          	ld	ra,24(sp)
    80001d18:	01013403          	ld	s0,16(sp)
    80001d1c:	00813483          	ld	s1,8(sp)
    80001d20:	02010113          	addi	sp,sp,32
    80001d24:	00008067          	ret
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001d28:	00048513          	mv	a0,s1
    80001d2c:	fffff097          	auipc	ra,0xfffff
    80001d30:	65c080e7          	jalr	1628(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001d34:	fbdff06f          	j	80001cf0 <_ZN7_thread15thread_dispatchEv+0x24>

0000000080001d38 <_ZN7_thread11thread_exitEv>:
int _thread::thread_exit() {
    80001d38:	ff010113          	addi	sp,sp,-16
    80001d3c:	00113423          	sd	ra,8(sp)
    80001d40:	00813023          	sd	s0,0(sp)
    80001d44:	01010413          	addi	s0,sp,16
    void setFinished(bool fin) { _thread::finished = fin; }
    80001d48:	00008797          	auipc	a5,0x8
    80001d4c:	0f07b783          	ld	a5,240(a5) # 80009e38 <_ZN7_thread7runningE>
    80001d50:	00100713          	li	a4,1
    80001d54:	02e78423          	sb	a4,40(a5)
    _thread::thread_dispatch();
    80001d58:	00000097          	auipc	ra,0x0
    80001d5c:	f74080e7          	jalr	-140(ra) # 80001ccc <_ZN7_thread15thread_dispatchEv>
}
    80001d60:	00100513          	li	a0,1
    80001d64:	00813083          	ld	ra,8(sp)
    80001d68:	00013403          	ld	s0,0(sp)
    80001d6c:	01010113          	addi	sp,sp,16
    80001d70:	00008067          	ret

0000000080001d74 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80001d74:	fe010113          	addi	sp,sp,-32
    80001d78:	00113c23          	sd	ra,24(sp)
    80001d7c:	00813823          	sd	s0,16(sp)
    80001d80:	00913423          	sd	s1,8(sp)
    80001d84:	01213023          	sd	s2,0(sp)
    80001d88:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80001d8c:	00006517          	auipc	a0,0x6
    80001d90:	43450513          	addi	a0,a0,1076 # 800081c0 <CONSOLE_STATUS+0x1b0>
    80001d94:	00001097          	auipc	ra,0x1
    80001d98:	904080e7          	jalr	-1788(ra) # 80002698 <_Z11printStringPKc>
    int test = getc() - '0';
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	2c4080e7          	jalr	708(ra) # 80002060 <_Z4getcv>
    80001da4:	00050913          	mv	s2,a0
    80001da8:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001dac:	00000097          	auipc	ra,0x0
    80001db0:	2b4080e7          	jalr	692(ra) # 80002060 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001db4:	fcb9091b          	addiw	s2,s2,-53
    80001db8:	00100793          	li	a5,1
    80001dbc:	0327f463          	bgeu	a5,s2,80001de4 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001dc0:	00700793          	li	a5,7
    80001dc4:	0e97e263          	bltu	a5,s1,80001ea8 <_Z8userMainv+0x134>
    80001dc8:	00249493          	slli	s1,s1,0x2
    80001dcc:	00006717          	auipc	a4,0x6
    80001dd0:	60c70713          	addi	a4,a4,1548 # 800083d8 <CONSOLE_STATUS+0x3c8>
    80001dd4:	00e484b3          	add	s1,s1,a4
    80001dd8:	0004a783          	lw	a5,0(s1)
    80001ddc:	00e787b3          	add	a5,a5,a4
    80001de0:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001de4:	00006517          	auipc	a0,0x6
    80001de8:	3fc50513          	addi	a0,a0,1020 # 800081e0 <CONSOLE_STATUS+0x1d0>
    80001dec:	00001097          	auipc	ra,0x1
    80001df0:	8ac080e7          	jalr	-1876(ra) # 80002698 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80001df4:	01813083          	ld	ra,24(sp)
    80001df8:	01013403          	ld	s0,16(sp)
    80001dfc:	00813483          	ld	s1,8(sp)
    80001e00:	00013903          	ld	s2,0(sp)
    80001e04:	02010113          	addi	sp,sp,32
    80001e08:	00008067          	ret
            Threads_C_API_test();
    80001e0c:	00002097          	auipc	ra,0x2
    80001e10:	768080e7          	jalr	1896(ra) # 80004574 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001e14:	00006517          	auipc	a0,0x6
    80001e18:	3fc50513          	addi	a0,a0,1020 # 80008210 <CONSOLE_STATUS+0x200>
    80001e1c:	00001097          	auipc	ra,0x1
    80001e20:	87c080e7          	jalr	-1924(ra) # 80002698 <_Z11printStringPKc>
            break;
    80001e24:	fd1ff06f          	j	80001df4 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001e28:	00003097          	auipc	ra,0x3
    80001e2c:	d24080e7          	jalr	-732(ra) # 80004b4c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001e30:	00006517          	auipc	a0,0x6
    80001e34:	42050513          	addi	a0,a0,1056 # 80008250 <CONSOLE_STATUS+0x240>
    80001e38:	00001097          	auipc	ra,0x1
    80001e3c:	860080e7          	jalr	-1952(ra) # 80002698 <_Z11printStringPKc>
            break;
    80001e40:	fb5ff06f          	j	80001df4 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001e44:	00000097          	auipc	ra,0x0
    80001e48:	588080e7          	jalr	1416(ra) # 800023cc <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001e4c:	00006517          	auipc	a0,0x6
    80001e50:	44450513          	addi	a0,a0,1092 # 80008290 <CONSOLE_STATUS+0x280>
    80001e54:	00001097          	auipc	ra,0x1
    80001e58:	844080e7          	jalr	-1980(ra) # 80002698 <_Z11printStringPKc>
            break;
    80001e5c:	f99ff06f          	j	80001df4 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001e60:	00002097          	auipc	ra,0x2
    80001e64:	834080e7          	jalr	-1996(ra) # 80003694 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001e68:	00006517          	auipc	a0,0x6
    80001e6c:	47850513          	addi	a0,a0,1144 # 800082e0 <CONSOLE_STATUS+0x2d0>
    80001e70:	00001097          	auipc	ra,0x1
    80001e74:	828080e7          	jalr	-2008(ra) # 80002698 <_Z11printStringPKc>
            break;
    80001e78:	f7dff06f          	j	80001df4 <_Z8userMainv+0x80>
            System_Mode_test();
    80001e7c:	00001097          	auipc	ra,0x1
    80001e80:	4c8080e7          	jalr	1224(ra) # 80003344 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80001e84:	00006517          	auipc	a0,0x6
    80001e88:	4b450513          	addi	a0,a0,1204 # 80008338 <CONSOLE_STATUS+0x328>
    80001e8c:	00001097          	auipc	ra,0x1
    80001e90:	80c080e7          	jalr	-2036(ra) # 80002698 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001e94:	00006517          	auipc	a0,0x6
    80001e98:	4c450513          	addi	a0,a0,1220 # 80008358 <CONSOLE_STATUS+0x348>
    80001e9c:	00000097          	auipc	ra,0x0
    80001ea0:	7fc080e7          	jalr	2044(ra) # 80002698 <_Z11printStringPKc>
            break;
    80001ea4:	f51ff06f          	j	80001df4 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001ea8:	00006517          	auipc	a0,0x6
    80001eac:	50850513          	addi	a0,a0,1288 # 800083b0 <CONSOLE_STATUS+0x3a0>
    80001eb0:	00000097          	auipc	ra,0x0
    80001eb4:	7e8080e7          	jalr	2024(ra) # 80002698 <_Z11printStringPKc>
    80001eb8:	f3dff06f          	j	80001df4 <_Z8userMainv+0x80>

0000000080001ebc <main>:




int main()
{
    80001ebc:	fe010113          	addi	sp,sp,-32
    80001ec0:	00113c23          	sd	ra,24(sp)
    80001ec4:	00813823          	sd	s0,16(sp)
    80001ec8:	02010413          	addi	s0,sp,32
    static void* mem_alloc(size_t size);

    static int mem_free(void*);

    static void init_mem(){
        free_Block = (Mem_Block*)HEAP_START_ADDR;
    80001ecc:	00008797          	auipc	a5,0x8
    80001ed0:	da47b783          	ld	a5,-604(a5) # 80009c70 <HEAP_START_ADDR>
    80001ed4:	00008697          	auipc	a3,0x8
    80001ed8:	f5c68693          	addi	a3,a3,-164 # 80009e30 <_ZN15MemoryAllocator10free_BlockE>
    80001edc:	00f6b023          	sd	a5,0(a3)
        free_Block->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR;
    80001ee0:	00008717          	auipc	a4,0x8
    80001ee4:	d8873703          	ld	a4,-632(a4) # 80009c68 <HEAP_END_ADDR>
    80001ee8:	40f70733          	sub	a4,a4,a5
    80001eec:	00e7b823          	sd	a4,16(a5)
        free_Block->next = nullptr;
    80001ef0:	0007b023          	sd	zero,0(a5)
        free_Block->prev = nullptr;
    80001ef4:	0006b783          	ld	a5,0(a3)
    80001ef8:	0007b423          	sd	zero,8(a5)
    MemoryAllocator::init_mem();
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine
    80001efc:	fffff797          	auipc	a5,0xfffff
    80001f00:	23478793          	addi	a5,a5,564 # 80001130 <_ZN5Riscv16interruptRoutineEv>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001f04:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001f08:	00200793          	li	a5,2
    80001f0c:	1007a073          	csrs	sstatus,a5


    thread_t thread1;

    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    80001f10:	00000613          	li	a2,0
    80001f14:	00000593          	li	a1,0
    80001f18:	fe840513          	addi	a0,s0,-24
    80001f1c:	00000097          	auipc	ra,0x0
    80001f20:	0bc080e7          	jalr	188(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = thread1;
    80001f24:	fe843783          	ld	a5,-24(s0)
    80001f28:	00008717          	auipc	a4,0x8
    80001f2c:	f0f73823          	sd	a5,-240(a4) # 80009e38 <_ZN7_thread7runningE>

    thread_t thread2;


    thread_create(&thread2, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80001f30:	00000613          	li	a2,0
    80001f34:	00000597          	auipc	a1,0x0
    80001f38:	e4058593          	addi	a1,a1,-448 # 80001d74 <_Z8userMainv>
    80001f3c:	fe040513          	addi	a0,s0,-32
    80001f40:	00000097          	auipc	ra,0x0
    80001f44:	098080e7          	jalr	152(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>

    thread_dispatch();
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	0c8080e7          	jalr	200(ra) # 80002010 <_Z15thread_dispatchv>

    while (!(thread2->isFinished())) {
    80001f50:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001f54:	0287c783          	lbu	a5,40(a5)
    80001f58:	00079863          	bnez	a5,80001f68 <main+0xac>
        thread_dispatch();
    80001f5c:	00000097          	auipc	ra,0x0
    80001f60:	0b4080e7          	jalr	180(ra) # 80002010 <_Z15thread_dispatchv>
    80001f64:	fedff06f          	j	80001f50 <main+0x94>
    }

    return 0;
}
    80001f68:	00000513          	li	a0,0
    80001f6c:	01813083          	ld	ra,24(sp)
    80001f70:	01013403          	ld	s0,16(sp)
    80001f74:	02010113          	addi	sp,sp,32
    80001f78:	00008067          	ret

0000000080001f7c <_Z9mem_allocm>:
#include "../lib/console.h"
#include "../h/syscall_c.hpp"



void* mem_alloc(size_t size){
    80001f7c:	ff010113          	addi	sp,sp,-16
    80001f80:	00813423          	sd	s0,8(sp)
    80001f84:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x01;
    void* retval;
    __asm__ volatile("mv a1, %0" : : "r"(size));
    80001f88:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001f8c:	00100793          	li	a5,1
    80001f90:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001f94:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001f98:	00050513          	mv	a0,a0
    return retval;
}
    80001f9c:	00813403          	ld	s0,8(sp)
    80001fa0:	01010113          	addi	sp,sp,16
    80001fa4:	00008067          	ret

0000000080001fa8 <_Z8mem_freem>:

int mem_free(size_t size){
    80001fa8:	ff010113          	addi	sp,sp,-16
    80001fac:	00813423          	sd	s0,8(sp)
    80001fb0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x02;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(size));
    80001fb4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001fb8:	00200793          	li	a5,2
    80001fbc:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001fc0:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval));
    80001fc4:	00050513          	mv	a0,a0
    return retval;

}
    80001fc8:	0005051b          	sext.w	a0,a0
    80001fcc:	00813403          	ld	s0,8(sp)
    80001fd0:	01010113          	addi	sp,sp,16
    80001fd4:	00008067          	ret

0000000080001fd8 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00813423          	sd	s0,8(sp)
    80001fe0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x11;
    int retval;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    80001fe4:	00060693          	mv	a3,a2
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80001fe8:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001fec:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001ff0:	01100793          	li	a5,17
    80001ff4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001ff8:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001ffc:	00050513          	mv	a0,a0
    return retval;//PROVERITI DA LI JE UREDU

    //dodati promenljivu za povratnu vrednost
}
    80002000:	0005051b          	sext.w	a0,a0
    80002004:	00813403          	ld	s0,8(sp)
    80002008:	01010113          	addi	sp,sp,16
    8000200c:	00008067          	ret

0000000080002010 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80002010:	ff010113          	addi	sp,sp,-16
    80002014:	00813423          	sd	s0,8(sp)
    80002018:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    8000201c:	01300793          	li	a5,19
    80002020:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002024:	00000073          	ecall
}
    80002028:	00813403          	ld	s0,8(sp)
    8000202c:	01010113          	addi	sp,sp,16
    80002030:	00008067          	ret

0000000080002034 <_Z11thread_exitv>:

int thread_exit(){
    80002034:	ff010113          	addi	sp,sp,-16
    80002038:	00813423          	sd	s0,8(sp)
    8000203c:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x12;
    int retval;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002040:	01200793          	li	a5,18
    80002044:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002048:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval));
    8000204c:	00050513          	mv	a0,a0
    return retval;
}
    80002050:	0005051b          	sext.w	a0,a0
    80002054:	00813403          	ld	s0,8(sp)
    80002058:	01010113          	addi	sp,sp,16
    8000205c:	00008067          	ret

0000000080002060 <_Z4getcv>:

char getc(){
    80002060:	ff010113          	addi	sp,sp,-16
    80002064:	00813423          	sd	s0,8(sp)
    80002068:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x41;
    char ch;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    8000206c:	04100793          	li	a5,65
    80002070:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002074:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (ch));
    80002078:	00050513          	mv	a0,a0
    return ch;
}
    8000207c:	0ff57513          	andi	a0,a0,255
    80002080:	00813403          	ld	s0,8(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_Z4putcc>:

void putc(char c){
    8000208c:	ff010113          	addi	sp,sp,-16
    80002090:	00113423          	sd	ra,8(sp)
    80002094:	00813023          	sd	s0,0(sp)
    80002098:	01010413          	addi	s0,sp,16
    __putc(c);
    8000209c:	00005097          	auipc	ra,0x5
    800020a0:	fe0080e7          	jalr	-32(ra) # 8000707c <__putc>
}
    800020a4:	00813083          	ld	ra,8(sp)
    800020a8:	00013403          	ld	s0,0(sp)
    800020ac:	01010113          	addi	sp,sp,16
    800020b0:	00008067          	ret

00000000800020b4 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    800020b4:	ff010113          	addi	sp,sp,-16
    800020b8:	00813423          	sd	s0,8(sp)
    800020bc:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x21;
    int retval;
    __asm__ volatile("mv a2, %0" : : "r"(init));
    800020c0:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    800020c4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    800020c8:	02100793          	li	a5,33
    800020cc:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800020d0:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    800020d4:	00050513          	mv	a0,a0
    return retval;
}
    800020d8:	0005051b          	sext.w	a0,a0
    800020dc:	00813403          	ld	s0,8(sp)
    800020e0:	01010113          	addi	sp,sp,16
    800020e4:	00008067          	ret

00000000800020e8 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle){
    800020e8:	ff010113          	addi	sp,sp,-16
    800020ec:	00813423          	sd	s0,8(sp)
    800020f0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x22;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    800020f4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    800020f8:	02200793          	li	a5,34
    800020fc:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002100:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80002104:	00050513          	mv	a0,a0
    return retval;
}
    80002108:	0005051b          	sext.w	a0,a0
    8000210c:	00813403          	ld	s0,8(sp)
    80002110:	01010113          	addi	sp,sp,16
    80002114:	00008067          	ret

0000000080002118 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t handle){
    80002118:	ff010113          	addi	sp,sp,-16
    8000211c:	00813423          	sd	s0,8(sp)
    80002120:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x23;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80002124:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002128:	02300793          	li	a5,35
    8000212c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002130:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80002134:	00050513          	mv	a0,a0
    return retval;
}
    80002138:	0005051b          	sext.w	a0,a0
    8000213c:	00813403          	ld	s0,8(sp)
    80002140:	01010113          	addi	sp,sp,16
    80002144:	00008067          	ret

0000000080002148 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t handle){
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00813423          	sd	s0,8(sp)
    80002150:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x24;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80002154:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002158:	02400793          	li	a5,36
    8000215c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002160:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80002164:	00050513          	mv	a0,a0
    return retval;
}
    80002168:	0005051b          	sext.w	a0,a0
    8000216c:	00813403          	ld	s0,8(sp)
    80002170:	01010113          	addi	sp,sp,16
    80002174:	00008067          	ret

0000000080002178 <_Z11sem_trywaitP4_sem>:

int sem_trywait(sem_t handle){
    80002178:	ff010113          	addi	sp,sp,-16
    8000217c:	00813423          	sd	s0,8(sp)
    80002180:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x26;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80002184:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002188:	02600793          	li	a5,38
    8000218c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002190:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80002194:	00050513          	mv	a0,a0
    return retval;
}
    80002198:	0005051b          	sext.w	a0,a0
    8000219c:	00813403          	ld	s0,8(sp)
    800021a0:	01010113          	addi	sp,sp,16
    800021a4:	00008067          	ret

00000000800021a8 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800021a8:	fe010113          	addi	sp,sp,-32
    800021ac:	00113c23          	sd	ra,24(sp)
    800021b0:	00813823          	sd	s0,16(sp)
    800021b4:	00913423          	sd	s1,8(sp)
    800021b8:	01213023          	sd	s2,0(sp)
    800021bc:	02010413          	addi	s0,sp,32
    800021c0:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800021c4:	00000913          	li	s2,0
    800021c8:	00c0006f          	j	800021d4 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800021cc:	00000097          	auipc	ra,0x0
    800021d0:	e44080e7          	jalr	-444(ra) # 80002010 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    800021d4:	00000097          	auipc	ra,0x0
    800021d8:	e8c080e7          	jalr	-372(ra) # 80002060 <_Z4getcv>
    800021dc:	0005059b          	sext.w	a1,a0
    800021e0:	01b00793          	li	a5,27
    800021e4:	02f58a63          	beq	a1,a5,80002218 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    800021e8:	0084b503          	ld	a0,8(s1)
    800021ec:	00002097          	auipc	ra,0x2
    800021f0:	c28080e7          	jalr	-984(ra) # 80003e14 <_ZN6Buffer3putEi>
        i++;
    800021f4:	0019071b          	addiw	a4,s2,1
    800021f8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800021fc:	0004a683          	lw	a3,0(s1)
    80002200:	0026979b          	slliw	a5,a3,0x2
    80002204:	00d787bb          	addw	a5,a5,a3
    80002208:	0017979b          	slliw	a5,a5,0x1
    8000220c:	02f767bb          	remw	a5,a4,a5
    80002210:	fc0792e3          	bnez	a5,800021d4 <_ZL16producerKeyboardPv+0x2c>
    80002214:	fb9ff06f          	j	800021cc <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80002218:	00100793          	li	a5,1
    8000221c:	00008717          	auipc	a4,0x8
    80002220:	c2f72e23          	sw	a5,-964(a4) # 80009e58 <_ZL9threadEnd>
    data->buffer->put('!');
    80002224:	02100593          	li	a1,33
    80002228:	0084b503          	ld	a0,8(s1)
    8000222c:	00002097          	auipc	ra,0x2
    80002230:	be8080e7          	jalr	-1048(ra) # 80003e14 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80002234:	0104b503          	ld	a0,16(s1)
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	f10080e7          	jalr	-240(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    80002240:	01813083          	ld	ra,24(sp)
    80002244:	01013403          	ld	s0,16(sp)
    80002248:	00813483          	ld	s1,8(sp)
    8000224c:	00013903          	ld	s2,0(sp)
    80002250:	02010113          	addi	sp,sp,32
    80002254:	00008067          	ret

0000000080002258 <_ZL8producerPv>:

static void producer(void *arg) {
    80002258:	fe010113          	addi	sp,sp,-32
    8000225c:	00113c23          	sd	ra,24(sp)
    80002260:	00813823          	sd	s0,16(sp)
    80002264:	00913423          	sd	s1,8(sp)
    80002268:	01213023          	sd	s2,0(sp)
    8000226c:	02010413          	addi	s0,sp,32
    80002270:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002274:	00000913          	li	s2,0
    80002278:	00c0006f          	j	80002284 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	d94080e7          	jalr	-620(ra) # 80002010 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002284:	00008797          	auipc	a5,0x8
    80002288:	bd47a783          	lw	a5,-1068(a5) # 80009e58 <_ZL9threadEnd>
    8000228c:	02079e63          	bnez	a5,800022c8 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002290:	0004a583          	lw	a1,0(s1)
    80002294:	0305859b          	addiw	a1,a1,48
    80002298:	0084b503          	ld	a0,8(s1)
    8000229c:	00002097          	auipc	ra,0x2
    800022a0:	b78080e7          	jalr	-1160(ra) # 80003e14 <_ZN6Buffer3putEi>
        i++;
    800022a4:	0019071b          	addiw	a4,s2,1
    800022a8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800022ac:	0004a683          	lw	a3,0(s1)
    800022b0:	0026979b          	slliw	a5,a3,0x2
    800022b4:	00d787bb          	addw	a5,a5,a3
    800022b8:	0017979b          	slliw	a5,a5,0x1
    800022bc:	02f767bb          	remw	a5,a4,a5
    800022c0:	fc0792e3          	bnez	a5,80002284 <_ZL8producerPv+0x2c>
    800022c4:	fb9ff06f          	j	8000227c <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800022c8:	0104b503          	ld	a0,16(s1)
    800022cc:	00000097          	auipc	ra,0x0
    800022d0:	e7c080e7          	jalr	-388(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    800022d4:	01813083          	ld	ra,24(sp)
    800022d8:	01013403          	ld	s0,16(sp)
    800022dc:	00813483          	ld	s1,8(sp)
    800022e0:	00013903          	ld	s2,0(sp)
    800022e4:	02010113          	addi	sp,sp,32
    800022e8:	00008067          	ret

00000000800022ec <_ZL8consumerPv>:

static void consumer(void *arg) {
    800022ec:	fd010113          	addi	sp,sp,-48
    800022f0:	02113423          	sd	ra,40(sp)
    800022f4:	02813023          	sd	s0,32(sp)
    800022f8:	00913c23          	sd	s1,24(sp)
    800022fc:	01213823          	sd	s2,16(sp)
    80002300:	01313423          	sd	s3,8(sp)
    80002304:	03010413          	addi	s0,sp,48
    80002308:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000230c:	00000993          	li	s3,0
    80002310:	01c0006f          	j	8000232c <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002314:	00000097          	auipc	ra,0x0
    80002318:	cfc080e7          	jalr	-772(ra) # 80002010 <_Z15thread_dispatchv>
    8000231c:	0500006f          	j	8000236c <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002320:	00a00513          	li	a0,10
    80002324:	00000097          	auipc	ra,0x0
    80002328:	d68080e7          	jalr	-664(ra) # 8000208c <_Z4putcc>
    while (!threadEnd) {
    8000232c:	00008797          	auipc	a5,0x8
    80002330:	b2c7a783          	lw	a5,-1236(a5) # 80009e58 <_ZL9threadEnd>
    80002334:	06079063          	bnez	a5,80002394 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002338:	00893503          	ld	a0,8(s2)
    8000233c:	00002097          	auipc	ra,0x2
    80002340:	b68080e7          	jalr	-1176(ra) # 80003ea4 <_ZN6Buffer3getEv>
        i++;
    80002344:	0019849b          	addiw	s1,s3,1
    80002348:	0004899b          	sext.w	s3,s1
        putc(key);
    8000234c:	0ff57513          	andi	a0,a0,255
    80002350:	00000097          	auipc	ra,0x0
    80002354:	d3c080e7          	jalr	-708(ra) # 8000208c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002358:	00092703          	lw	a4,0(s2)
    8000235c:	0027179b          	slliw	a5,a4,0x2
    80002360:	00e787bb          	addw	a5,a5,a4
    80002364:	02f4e7bb          	remw	a5,s1,a5
    80002368:	fa0786e3          	beqz	a5,80002314 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    8000236c:	05000793          	li	a5,80
    80002370:	02f4e4bb          	remw	s1,s1,a5
    80002374:	fa049ce3          	bnez	s1,8000232c <_ZL8consumerPv+0x40>
    80002378:	fa9ff06f          	j	80002320 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    8000237c:	00893503          	ld	a0,8(s2)
    80002380:	00002097          	auipc	ra,0x2
    80002384:	b24080e7          	jalr	-1244(ra) # 80003ea4 <_ZN6Buffer3getEv>
        putc(key);
    80002388:	0ff57513          	andi	a0,a0,255
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	d00080e7          	jalr	-768(ra) # 8000208c <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002394:	00893503          	ld	a0,8(s2)
    80002398:	00002097          	auipc	ra,0x2
    8000239c:	b98080e7          	jalr	-1128(ra) # 80003f30 <_ZN6Buffer6getCntEv>
    800023a0:	fca04ee3          	bgtz	a0,8000237c <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800023a4:	01093503          	ld	a0,16(s2)
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	da0080e7          	jalr	-608(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    800023b0:	02813083          	ld	ra,40(sp)
    800023b4:	02013403          	ld	s0,32(sp)
    800023b8:	01813483          	ld	s1,24(sp)
    800023bc:	01013903          	ld	s2,16(sp)
    800023c0:	00813983          	ld	s3,8(sp)
    800023c4:	03010113          	addi	sp,sp,48
    800023c8:	00008067          	ret

00000000800023cc <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800023cc:	f9010113          	addi	sp,sp,-112
    800023d0:	06113423          	sd	ra,104(sp)
    800023d4:	06813023          	sd	s0,96(sp)
    800023d8:	04913c23          	sd	s1,88(sp)
    800023dc:	05213823          	sd	s2,80(sp)
    800023e0:	05313423          	sd	s3,72(sp)
    800023e4:	05413023          	sd	s4,64(sp)
    800023e8:	03513c23          	sd	s5,56(sp)
    800023ec:	03613823          	sd	s6,48(sp)
    800023f0:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800023f4:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800023f8:	00006517          	auipc	a0,0x6
    800023fc:	00050513          	mv	a0,a0
    80002400:	00000097          	auipc	ra,0x0
    80002404:	298080e7          	jalr	664(ra) # 80002698 <_Z11printStringPKc>
    getString(input, 30);
    80002408:	01e00593          	li	a1,30
    8000240c:	fa040513          	addi	a0,s0,-96
    80002410:	00000097          	auipc	ra,0x0
    80002414:	310080e7          	jalr	784(ra) # 80002720 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002418:	fa040513          	addi	a0,s0,-96
    8000241c:	00000097          	auipc	ra,0x0
    80002420:	3dc080e7          	jalr	988(ra) # 800027f8 <_Z11stringToIntPKc>
    80002424:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002428:	00006517          	auipc	a0,0x6
    8000242c:	ff050513          	addi	a0,a0,-16 # 80008418 <CONSOLE_STATUS+0x408>
    80002430:	00000097          	auipc	ra,0x0
    80002434:	268080e7          	jalr	616(ra) # 80002698 <_Z11printStringPKc>
    getString(input, 30);
    80002438:	01e00593          	li	a1,30
    8000243c:	fa040513          	addi	a0,s0,-96
    80002440:	00000097          	auipc	ra,0x0
    80002444:	2e0080e7          	jalr	736(ra) # 80002720 <_Z9getStringPci>
    n = stringToInt(input);
    80002448:	fa040513          	addi	a0,s0,-96
    8000244c:	00000097          	auipc	ra,0x0
    80002450:	3ac080e7          	jalr	940(ra) # 800027f8 <_Z11stringToIntPKc>
    80002454:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002458:	00006517          	auipc	a0,0x6
    8000245c:	fe050513          	addi	a0,a0,-32 # 80008438 <CONSOLE_STATUS+0x428>
    80002460:	00000097          	auipc	ra,0x0
    80002464:	238080e7          	jalr	568(ra) # 80002698 <_Z11printStringPKc>
    80002468:	00000613          	li	a2,0
    8000246c:	00a00593          	li	a1,10
    80002470:	00090513          	mv	a0,s2
    80002474:	00000097          	auipc	ra,0x0
    80002478:	3d4080e7          	jalr	980(ra) # 80002848 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000247c:	00006517          	auipc	a0,0x6
    80002480:	fd450513          	addi	a0,a0,-44 # 80008450 <CONSOLE_STATUS+0x440>
    80002484:	00000097          	auipc	ra,0x0
    80002488:	214080e7          	jalr	532(ra) # 80002698 <_Z11printStringPKc>
    8000248c:	00000613          	li	a2,0
    80002490:	00a00593          	li	a1,10
    80002494:	00048513          	mv	a0,s1
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	3b0080e7          	jalr	944(ra) # 80002848 <_Z8printIntiii>
    printString(".\n");
    800024a0:	00006517          	auipc	a0,0x6
    800024a4:	fc850513          	addi	a0,a0,-56 # 80008468 <CONSOLE_STATUS+0x458>
    800024a8:	00000097          	auipc	ra,0x0
    800024ac:	1f0080e7          	jalr	496(ra) # 80002698 <_Z11printStringPKc>
    if(threadNum > n) {
    800024b0:	0324c463          	blt	s1,s2,800024d8 <_Z22producerConsumer_C_APIv+0x10c>
    } else if (threadNum < 1) {
    800024b4:	03205c63          	blez	s2,800024ec <_Z22producerConsumer_C_APIv+0x120>
    Buffer *buffer = new Buffer(n);
    800024b8:	03800513          	li	a0,56
    800024bc:	fffff097          	auipc	ra,0xfffff
    800024c0:	d84080e7          	jalr	-636(ra) # 80001240 <_Znwm>
    800024c4:	00050a13          	mv	s4,a0
    800024c8:	00048593          	mv	a1,s1
    800024cc:	00002097          	auipc	ra,0x2
    800024d0:	8ac080e7          	jalr	-1876(ra) # 80003d78 <_ZN6BufferC1Ei>
    800024d4:	0300006f          	j	80002504 <_Z22producerConsumer_C_APIv+0x138>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800024d8:	00006517          	auipc	a0,0x6
    800024dc:	f9850513          	addi	a0,a0,-104 # 80008470 <CONSOLE_STATUS+0x460>
    800024e0:	00000097          	auipc	ra,0x0
    800024e4:	1b8080e7          	jalr	440(ra) # 80002698 <_Z11printStringPKc>
        return;
    800024e8:	0140006f          	j	800024fc <_Z22producerConsumer_C_APIv+0x130>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800024ec:	00006517          	auipc	a0,0x6
    800024f0:	fc450513          	addi	a0,a0,-60 # 800084b0 <CONSOLE_STATUS+0x4a0>
    800024f4:	00000097          	auipc	ra,0x0
    800024f8:	1a4080e7          	jalr	420(ra) # 80002698 <_Z11printStringPKc>
        return;
    800024fc:	000b0113          	mv	sp,s6
    80002500:	1500006f          	j	80002650 <_Z22producerConsumer_C_APIv+0x284>
    sem_open(&waitForAll, 0);
    80002504:	00000593          	li	a1,0
    80002508:	00008517          	auipc	a0,0x8
    8000250c:	95850513          	addi	a0,a0,-1704 # 80009e60 <_ZL10waitForAll>
    80002510:	00000097          	auipc	ra,0x0
    80002514:	ba4080e7          	jalr	-1116(ra) # 800020b4 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    80002518:	00391793          	slli	a5,s2,0x3
    8000251c:	00f78793          	addi	a5,a5,15
    80002520:	ff07f793          	andi	a5,a5,-16
    80002524:	40f10133          	sub	sp,sp,a5
    80002528:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    8000252c:	0019071b          	addiw	a4,s2,1
    80002530:	00171793          	slli	a5,a4,0x1
    80002534:	00e787b3          	add	a5,a5,a4
    80002538:	00379793          	slli	a5,a5,0x3
    8000253c:	00f78793          	addi	a5,a5,15
    80002540:	ff07f793          	andi	a5,a5,-16
    80002544:	40f10133          	sub	sp,sp,a5
    80002548:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    8000254c:	00191613          	slli	a2,s2,0x1
    80002550:	012607b3          	add	a5,a2,s2
    80002554:	00379793          	slli	a5,a5,0x3
    80002558:	00f987b3          	add	a5,s3,a5
    8000255c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002560:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002564:	00008717          	auipc	a4,0x8
    80002568:	8fc73703          	ld	a4,-1796(a4) # 80009e60 <_ZL10waitForAll>
    8000256c:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002570:	00078613          	mv	a2,a5
    80002574:	00000597          	auipc	a1,0x0
    80002578:	d7858593          	addi	a1,a1,-648 # 800022ec <_ZL8consumerPv>
    8000257c:	f9840513          	addi	a0,s0,-104
    80002580:	00000097          	auipc	ra,0x0
    80002584:	a58080e7          	jalr	-1448(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002588:	00000493          	li	s1,0
    8000258c:	0280006f          	j	800025b4 <_Z22producerConsumer_C_APIv+0x1e8>
        thread_create(threads + i,
    80002590:	00000597          	auipc	a1,0x0
    80002594:	c1858593          	addi	a1,a1,-1000 # 800021a8 <_ZL16producerKeyboardPv>
                      data + i);
    80002598:	00179613          	slli	a2,a5,0x1
    8000259c:	00f60633          	add	a2,a2,a5
    800025a0:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    800025a4:	00c98633          	add	a2,s3,a2
    800025a8:	00000097          	auipc	ra,0x0
    800025ac:	a30080e7          	jalr	-1488(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800025b0:	0014849b          	addiw	s1,s1,1
    800025b4:	0524d263          	bge	s1,s2,800025f8 <_Z22producerConsumer_C_APIv+0x22c>
        data[i].id = i;
    800025b8:	00149793          	slli	a5,s1,0x1
    800025bc:	009787b3          	add	a5,a5,s1
    800025c0:	00379793          	slli	a5,a5,0x3
    800025c4:	00f987b3          	add	a5,s3,a5
    800025c8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800025cc:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    800025d0:	00008717          	auipc	a4,0x8
    800025d4:	89073703          	ld	a4,-1904(a4) # 80009e60 <_ZL10waitForAll>
    800025d8:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    800025dc:	00048793          	mv	a5,s1
    800025e0:	00349513          	slli	a0,s1,0x3
    800025e4:	00aa8533          	add	a0,s5,a0
    800025e8:	fa9054e3          	blez	s1,80002590 <_Z22producerConsumer_C_APIv+0x1c4>
    800025ec:	00000597          	auipc	a1,0x0
    800025f0:	c6c58593          	addi	a1,a1,-916 # 80002258 <_ZL8producerPv>
    800025f4:	fa5ff06f          	j	80002598 <_Z22producerConsumer_C_APIv+0x1cc>
    thread_dispatch();
    800025f8:	00000097          	auipc	ra,0x0
    800025fc:	a18080e7          	jalr	-1512(ra) # 80002010 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002600:	00000493          	li	s1,0
    80002604:	00994e63          	blt	s2,s1,80002620 <_Z22producerConsumer_C_APIv+0x254>
        sem_wait(waitForAll);
    80002608:	00008517          	auipc	a0,0x8
    8000260c:	85853503          	ld	a0,-1960(a0) # 80009e60 <_ZL10waitForAll>
    80002610:	00000097          	auipc	ra,0x0
    80002614:	b08080e7          	jalr	-1272(ra) # 80002118 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    80002618:	0014849b          	addiw	s1,s1,1
    8000261c:	fe9ff06f          	j	80002604 <_Z22producerConsumer_C_APIv+0x238>
    sem_close(waitForAll);
    80002620:	00008517          	auipc	a0,0x8
    80002624:	84053503          	ld	a0,-1984(a0) # 80009e60 <_ZL10waitForAll>
    80002628:	00000097          	auipc	ra,0x0
    8000262c:	ac0080e7          	jalr	-1344(ra) # 800020e8 <_Z9sem_closeP4_sem>
    delete buffer;
    80002630:	000a0e63          	beqz	s4,8000264c <_Z22producerConsumer_C_APIv+0x280>
    80002634:	000a0513          	mv	a0,s4
    80002638:	00002097          	auipc	ra,0x2
    8000263c:	980080e7          	jalr	-1664(ra) # 80003fb8 <_ZN6BufferD1Ev>
    80002640:	000a0513          	mv	a0,s4
    80002644:	fffff097          	auipc	ra,0xfffff
    80002648:	c4c080e7          	jalr	-948(ra) # 80001290 <_ZdlPv>
    8000264c:	000b0113          	mv	sp,s6

}
    80002650:	f9040113          	addi	sp,s0,-112
    80002654:	06813083          	ld	ra,104(sp)
    80002658:	06013403          	ld	s0,96(sp)
    8000265c:	05813483          	ld	s1,88(sp)
    80002660:	05013903          	ld	s2,80(sp)
    80002664:	04813983          	ld	s3,72(sp)
    80002668:	04013a03          	ld	s4,64(sp)
    8000266c:	03813a83          	ld	s5,56(sp)
    80002670:	03013b03          	ld	s6,48(sp)
    80002674:	07010113          	addi	sp,sp,112
    80002678:	00008067          	ret
    8000267c:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002680:	000a0513          	mv	a0,s4
    80002684:	fffff097          	auipc	ra,0xfffff
    80002688:	c0c080e7          	jalr	-1012(ra) # 80001290 <_ZdlPv>
    8000268c:	00048513          	mv	a0,s1
    80002690:	00009097          	auipc	ra,0x9
    80002694:	908080e7          	jalr	-1784(ra) # 8000af98 <_Unwind_Resume>

0000000080002698 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002698:	fe010113          	addi	sp,sp,-32
    8000269c:	00113c23          	sd	ra,24(sp)
    800026a0:	00813823          	sd	s0,16(sp)
    800026a4:	00913423          	sd	s1,8(sp)
    800026a8:	02010413          	addi	s0,sp,32
    800026ac:	00050493          	mv	s1,a0
    LOCK();
    800026b0:	00100613          	li	a2,1
    800026b4:	00000593          	li	a1,0
    800026b8:	00007517          	auipc	a0,0x7
    800026bc:	7b050513          	addi	a0,a0,1968 # 80009e68 <lockPrint>
    800026c0:	fffff097          	auipc	ra,0xfffff
    800026c4:	940080e7          	jalr	-1728(ra) # 80001000 <copy_and_swap>
    800026c8:	00050863          	beqz	a0,800026d8 <_Z11printStringPKc+0x40>
    800026cc:	00000097          	auipc	ra,0x0
    800026d0:	944080e7          	jalr	-1724(ra) # 80002010 <_Z15thread_dispatchv>
    800026d4:	fddff06f          	j	800026b0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800026d8:	0004c503          	lbu	a0,0(s1)
    800026dc:	00050a63          	beqz	a0,800026f0 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    800026e0:	00000097          	auipc	ra,0x0
    800026e4:	9ac080e7          	jalr	-1620(ra) # 8000208c <_Z4putcc>
        string++;
    800026e8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800026ec:	fedff06f          	j	800026d8 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    800026f0:	00000613          	li	a2,0
    800026f4:	00100593          	li	a1,1
    800026f8:	00007517          	auipc	a0,0x7
    800026fc:	77050513          	addi	a0,a0,1904 # 80009e68 <lockPrint>
    80002700:	fffff097          	auipc	ra,0xfffff
    80002704:	900080e7          	jalr	-1792(ra) # 80001000 <copy_and_swap>
    80002708:	fe0514e3          	bnez	a0,800026f0 <_Z11printStringPKc+0x58>
}
    8000270c:	01813083          	ld	ra,24(sp)
    80002710:	01013403          	ld	s0,16(sp)
    80002714:	00813483          	ld	s1,8(sp)
    80002718:	02010113          	addi	sp,sp,32
    8000271c:	00008067          	ret

0000000080002720 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002720:	fd010113          	addi	sp,sp,-48
    80002724:	02113423          	sd	ra,40(sp)
    80002728:	02813023          	sd	s0,32(sp)
    8000272c:	00913c23          	sd	s1,24(sp)
    80002730:	01213823          	sd	s2,16(sp)
    80002734:	01313423          	sd	s3,8(sp)
    80002738:	01413023          	sd	s4,0(sp)
    8000273c:	03010413          	addi	s0,sp,48
    80002740:	00050993          	mv	s3,a0
    80002744:	00058a13          	mv	s4,a1
    LOCK();
    80002748:	00100613          	li	a2,1
    8000274c:	00000593          	li	a1,0
    80002750:	00007517          	auipc	a0,0x7
    80002754:	71850513          	addi	a0,a0,1816 # 80009e68 <lockPrint>
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	8a8080e7          	jalr	-1880(ra) # 80001000 <copy_and_swap>
    80002760:	00050863          	beqz	a0,80002770 <_Z9getStringPci+0x50>
    80002764:	00000097          	auipc	ra,0x0
    80002768:	8ac080e7          	jalr	-1876(ra) # 80002010 <_Z15thread_dispatchv>
    8000276c:	fddff06f          	j	80002748 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002770:	00000913          	li	s2,0
    80002774:	00090493          	mv	s1,s2
    80002778:	0019091b          	addiw	s2,s2,1
    8000277c:	03495a63          	bge	s2,s4,800027b0 <_Z9getStringPci+0x90>
        cc = getc();
    80002780:	00000097          	auipc	ra,0x0
    80002784:	8e0080e7          	jalr	-1824(ra) # 80002060 <_Z4getcv>
        if(cc < 1)
    80002788:	02050463          	beqz	a0,800027b0 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    8000278c:	009984b3          	add	s1,s3,s1
    80002790:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002794:	00a00793          	li	a5,10
    80002798:	00f50a63          	beq	a0,a5,800027ac <_Z9getStringPci+0x8c>
    8000279c:	00d00793          	li	a5,13
    800027a0:	fcf51ae3          	bne	a0,a5,80002774 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800027a4:	00090493          	mv	s1,s2
    800027a8:	0080006f          	j	800027b0 <_Z9getStringPci+0x90>
    800027ac:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800027b0:	009984b3          	add	s1,s3,s1
    800027b4:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800027b8:	00000613          	li	a2,0
    800027bc:	00100593          	li	a1,1
    800027c0:	00007517          	auipc	a0,0x7
    800027c4:	6a850513          	addi	a0,a0,1704 # 80009e68 <lockPrint>
    800027c8:	fffff097          	auipc	ra,0xfffff
    800027cc:	838080e7          	jalr	-1992(ra) # 80001000 <copy_and_swap>
    800027d0:	fe0514e3          	bnez	a0,800027b8 <_Z9getStringPci+0x98>
    return buf;
}
    800027d4:	00098513          	mv	a0,s3
    800027d8:	02813083          	ld	ra,40(sp)
    800027dc:	02013403          	ld	s0,32(sp)
    800027e0:	01813483          	ld	s1,24(sp)
    800027e4:	01013903          	ld	s2,16(sp)
    800027e8:	00813983          	ld	s3,8(sp)
    800027ec:	00013a03          	ld	s4,0(sp)
    800027f0:	03010113          	addi	sp,sp,48
    800027f4:	00008067          	ret

00000000800027f8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800027f8:	ff010113          	addi	sp,sp,-16
    800027fc:	00813423          	sd	s0,8(sp)
    80002800:	01010413          	addi	s0,sp,16
    80002804:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002808:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000280c:	0006c603          	lbu	a2,0(a3)
    80002810:	fd06071b          	addiw	a4,a2,-48
    80002814:	0ff77713          	andi	a4,a4,255
    80002818:	00900793          	li	a5,9
    8000281c:	02e7e063          	bltu	a5,a4,8000283c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002820:	0025179b          	slliw	a5,a0,0x2
    80002824:	00a787bb          	addw	a5,a5,a0
    80002828:	0017979b          	slliw	a5,a5,0x1
    8000282c:	00168693          	addi	a3,a3,1
    80002830:	00c787bb          	addw	a5,a5,a2
    80002834:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002838:	fd5ff06f          	j	8000280c <_Z11stringToIntPKc+0x14>
    return n;
}
    8000283c:	00813403          	ld	s0,8(sp)
    80002840:	01010113          	addi	sp,sp,16
    80002844:	00008067          	ret

0000000080002848 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002848:	fc010113          	addi	sp,sp,-64
    8000284c:	02113c23          	sd	ra,56(sp)
    80002850:	02813823          	sd	s0,48(sp)
    80002854:	02913423          	sd	s1,40(sp)
    80002858:	03213023          	sd	s2,32(sp)
    8000285c:	01313c23          	sd	s3,24(sp)
    80002860:	04010413          	addi	s0,sp,64
    80002864:	00050493          	mv	s1,a0
    80002868:	00058913          	mv	s2,a1
    8000286c:	00060993          	mv	s3,a2
    LOCK();
    80002870:	00100613          	li	a2,1
    80002874:	00000593          	li	a1,0
    80002878:	00007517          	auipc	a0,0x7
    8000287c:	5f050513          	addi	a0,a0,1520 # 80009e68 <lockPrint>
    80002880:	ffffe097          	auipc	ra,0xffffe
    80002884:	780080e7          	jalr	1920(ra) # 80001000 <copy_and_swap>
    80002888:	00050863          	beqz	a0,80002898 <_Z8printIntiii+0x50>
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	784080e7          	jalr	1924(ra) # 80002010 <_Z15thread_dispatchv>
    80002894:	fddff06f          	j	80002870 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002898:	00098463          	beqz	s3,800028a0 <_Z8printIntiii+0x58>
    8000289c:	0804c463          	bltz	s1,80002924 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800028a0:	0004851b          	sext.w	a0,s1
    neg = 0;
    800028a4:	00000593          	li	a1,0
    }

    i = 0;
    800028a8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800028ac:	0009079b          	sext.w	a5,s2
    800028b0:	0325773b          	remuw	a4,a0,s2
    800028b4:	00048613          	mv	a2,s1
    800028b8:	0014849b          	addiw	s1,s1,1
    800028bc:	02071693          	slli	a3,a4,0x20
    800028c0:	0206d693          	srli	a3,a3,0x20
    800028c4:	00007717          	auipc	a4,0x7
    800028c8:	3bc70713          	addi	a4,a4,956 # 80009c80 <digits>
    800028cc:	00d70733          	add	a4,a4,a3
    800028d0:	00074683          	lbu	a3,0(a4)
    800028d4:	fd040713          	addi	a4,s0,-48
    800028d8:	00c70733          	add	a4,a4,a2
    800028dc:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800028e0:	0005071b          	sext.w	a4,a0
    800028e4:	0325553b          	divuw	a0,a0,s2
    800028e8:	fcf772e3          	bgeu	a4,a5,800028ac <_Z8printIntiii+0x64>
    if(neg)
    800028ec:	00058c63          	beqz	a1,80002904 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    800028f0:	fd040793          	addi	a5,s0,-48
    800028f4:	009784b3          	add	s1,a5,s1
    800028f8:	02d00793          	li	a5,45
    800028fc:	fef48823          	sb	a5,-16(s1)
    80002900:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002904:	fff4849b          	addiw	s1,s1,-1
    80002908:	0204c463          	bltz	s1,80002930 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    8000290c:	fd040793          	addi	a5,s0,-48
    80002910:	009787b3          	add	a5,a5,s1
    80002914:	ff07c503          	lbu	a0,-16(a5)
    80002918:	fffff097          	auipc	ra,0xfffff
    8000291c:	774080e7          	jalr	1908(ra) # 8000208c <_Z4putcc>
    80002920:	fe5ff06f          	j	80002904 <_Z8printIntiii+0xbc>
        x = -xx;
    80002924:	4090053b          	negw	a0,s1
        neg = 1;
    80002928:	00100593          	li	a1,1
        x = -xx;
    8000292c:	f7dff06f          	j	800028a8 <_Z8printIntiii+0x60>

    UNLOCK();
    80002930:	00000613          	li	a2,0
    80002934:	00100593          	li	a1,1
    80002938:	00007517          	auipc	a0,0x7
    8000293c:	53050513          	addi	a0,a0,1328 # 80009e68 <lockPrint>
    80002940:	ffffe097          	auipc	ra,0xffffe
    80002944:	6c0080e7          	jalr	1728(ra) # 80001000 <copy_and_swap>
    80002948:	fe0514e3          	bnez	a0,80002930 <_Z8printIntiii+0xe8>
    8000294c:	03813083          	ld	ra,56(sp)
    80002950:	03013403          	ld	s0,48(sp)
    80002954:	02813483          	ld	s1,40(sp)
    80002958:	02013903          	ld	s2,32(sp)
    8000295c:	01813983          	ld	s3,24(sp)
    80002960:	04010113          	addi	sp,sp,64
    80002964:	00008067          	ret

0000000080002968 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80002968:	fd010113          	addi	sp,sp,-48
    8000296c:	02113423          	sd	ra,40(sp)
    80002970:	02813023          	sd	s0,32(sp)
    80002974:	00913c23          	sd	s1,24(sp)
    80002978:	01213823          	sd	s2,16(sp)
    8000297c:	01313423          	sd	s3,8(sp)
    80002980:	03010413          	addi	s0,sp,48
    80002984:	00050493          	mv	s1,a0
    80002988:	00058993          	mv	s3,a1
    8000298c:	0015879b          	addiw	a5,a1,1
    80002990:	0007851b          	sext.w	a0,a5
    80002994:	00f4a023          	sw	a5,0(s1)
    80002998:	0004a823          	sw	zero,16(s1)
    8000299c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)MemoryAllocator::mem_alloc(sizeof(int) * cap);
    800029a0:	00251513          	slli	a0,a0,0x2
    800029a4:	fffff097          	auipc	ra,0xfffff
    800029a8:	ae0080e7          	jalr	-1312(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
    800029ac:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800029b0:	01000513          	li	a0,16
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	88c080e7          	jalr	-1908(ra) # 80001240 <_Znwm>
    800029bc:	00050913          	mv	s2,a0
};


class Semaphore{
public:
    Semaphore(unsigned init=1){
    800029c0:	00006797          	auipc	a5,0x6
    800029c4:	b4878793          	addi	a5,a5,-1208 # 80008508 <_ZTV9Semaphore+0x10>
    800029c8:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    800029cc:	00000593          	li	a1,0
    800029d0:	00850513          	addi	a0,a0,8
    800029d4:	fffff097          	auipc	ra,0xfffff
    800029d8:	6e0080e7          	jalr	1760(ra) # 800020b4 <_Z8sem_openPP4_semj>
    800029dc:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800029e0:	01000513          	li	a0,16
    800029e4:	fffff097          	auipc	ra,0xfffff
    800029e8:	85c080e7          	jalr	-1956(ra) # 80001240 <_Znwm>
    800029ec:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    800029f0:	00006797          	auipc	a5,0x6
    800029f4:	b1878793          	addi	a5,a5,-1256 # 80008508 <_ZTV9Semaphore+0x10>
    800029f8:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    800029fc:	00098593          	mv	a1,s3
    80002a00:	00850513          	addi	a0,a0,8
    80002a04:	fffff097          	auipc	ra,0xfffff
    80002a08:	6b0080e7          	jalr	1712(ra) # 800020b4 <_Z8sem_openPP4_semj>
    80002a0c:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80002a10:	01000513          	li	a0,16
    80002a14:	fffff097          	auipc	ra,0xfffff
    80002a18:	82c080e7          	jalr	-2004(ra) # 80001240 <_Znwm>
    80002a1c:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002a20:	00006797          	auipc	a5,0x6
    80002a24:	ae878793          	addi	a5,a5,-1304 # 80008508 <_ZTV9Semaphore+0x10>
    80002a28:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002a2c:	00100593          	li	a1,1
    80002a30:	00850513          	addi	a0,a0,8
    80002a34:	fffff097          	auipc	ra,0xfffff
    80002a38:	680080e7          	jalr	1664(ra) # 800020b4 <_Z8sem_openPP4_semj>
    80002a3c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80002a40:	01000513          	li	a0,16
    80002a44:	ffffe097          	auipc	ra,0xffffe
    80002a48:	7fc080e7          	jalr	2044(ra) # 80001240 <_Znwm>
    80002a4c:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002a50:	00006797          	auipc	a5,0x6
    80002a54:	ab878793          	addi	a5,a5,-1352 # 80008508 <_ZTV9Semaphore+0x10>
    80002a58:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002a5c:	00100593          	li	a1,1
    80002a60:	00850513          	addi	a0,a0,8
    80002a64:	fffff097          	auipc	ra,0xfffff
    80002a68:	650080e7          	jalr	1616(ra) # 800020b4 <_Z8sem_openPP4_semj>
    80002a6c:	0324b823          	sd	s2,48(s1)
}
    80002a70:	02813083          	ld	ra,40(sp)
    80002a74:	02013403          	ld	s0,32(sp)
    80002a78:	01813483          	ld	s1,24(sp)
    80002a7c:	01013903          	ld	s2,16(sp)
    80002a80:	00813983          	ld	s3,8(sp)
    80002a84:	03010113          	addi	sp,sp,48
    80002a88:	00008067          	ret
    80002a8c:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80002a90:	00090513          	mv	a0,s2
    80002a94:	ffffe097          	auipc	ra,0xffffe
    80002a98:	7fc080e7          	jalr	2044(ra) # 80001290 <_ZdlPv>
    80002a9c:	00048513          	mv	a0,s1
    80002aa0:	00008097          	auipc	ra,0x8
    80002aa4:	4f8080e7          	jalr	1272(ra) # 8000af98 <_Unwind_Resume>
    80002aa8:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80002aac:	00090513          	mv	a0,s2
    80002ab0:	ffffe097          	auipc	ra,0xffffe
    80002ab4:	7e0080e7          	jalr	2016(ra) # 80001290 <_ZdlPv>
    80002ab8:	00048513          	mv	a0,s1
    80002abc:	00008097          	auipc	ra,0x8
    80002ac0:	4dc080e7          	jalr	1244(ra) # 8000af98 <_Unwind_Resume>
    80002ac4:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80002ac8:	00090513          	mv	a0,s2
    80002acc:	ffffe097          	auipc	ra,0xffffe
    80002ad0:	7c4080e7          	jalr	1988(ra) # 80001290 <_ZdlPv>
    80002ad4:	00048513          	mv	a0,s1
    80002ad8:	00008097          	auipc	ra,0x8
    80002adc:	4c0080e7          	jalr	1216(ra) # 8000af98 <_Unwind_Resume>
    80002ae0:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80002ae4:	00090513          	mv	a0,s2
    80002ae8:	ffffe097          	auipc	ra,0xffffe
    80002aec:	7a8080e7          	jalr	1960(ra) # 80001290 <_ZdlPv>
    80002af0:	00048513          	mv	a0,s1
    80002af4:	00008097          	auipc	ra,0x8
    80002af8:	4a4080e7          	jalr	1188(ra) # 8000af98 <_Unwind_Resume>

0000000080002afc <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80002afc:	fe010113          	addi	sp,sp,-32
    80002b00:	00113c23          	sd	ra,24(sp)
    80002b04:	00813823          	sd	s0,16(sp)
    80002b08:	00913423          	sd	s1,8(sp)
    80002b0c:	01213023          	sd	s2,0(sp)
    80002b10:	02010413          	addi	s0,sp,32
    80002b14:	00050493          	mv	s1,a0
    80002b18:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80002b1c:	01853783          	ld	a5,24(a0)
    virtual ~Semaphore(){
        sem_close(myHandle);
    };

    int wait(){
        return sem_wait(myHandle);
    80002b20:	0087b503          	ld	a0,8(a5)
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	5f4080e7          	jalr	1524(ra) # 80002118 <_Z8sem_waitP4_sem>

    mutexTail->wait();
    80002b2c:	0304b783          	ld	a5,48(s1)
    80002b30:	0087b503          	ld	a0,8(a5)
    80002b34:	fffff097          	auipc	ra,0xfffff
    80002b38:	5e4080e7          	jalr	1508(ra) # 80002118 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80002b3c:	0084b783          	ld	a5,8(s1)
    80002b40:	0144a703          	lw	a4,20(s1)
    80002b44:	00271713          	slli	a4,a4,0x2
    80002b48:	00e787b3          	add	a5,a5,a4
    80002b4c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002b50:	0144a783          	lw	a5,20(s1)
    80002b54:	0017879b          	addiw	a5,a5,1
    80002b58:	0004a703          	lw	a4,0(s1)
    80002b5c:	02e7e7bb          	remw	a5,a5,a4
    80002b60:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80002b64:	0304b783          	ld	a5,48(s1)
    }
    int signal(){
        return sem_signal(myHandle);
    80002b68:	0087b503          	ld	a0,8(a5)
    80002b6c:	fffff097          	auipc	ra,0xfffff
    80002b70:	5dc080e7          	jalr	1500(ra) # 80002148 <_Z10sem_signalP4_sem>

    itemAvailable->signal();
    80002b74:	0204b783          	ld	a5,32(s1)
    80002b78:	0087b503          	ld	a0,8(a5)
    80002b7c:	fffff097          	auipc	ra,0xfffff
    80002b80:	5cc080e7          	jalr	1484(ra) # 80002148 <_Z10sem_signalP4_sem>

}
    80002b84:	01813083          	ld	ra,24(sp)
    80002b88:	01013403          	ld	s0,16(sp)
    80002b8c:	00813483          	ld	s1,8(sp)
    80002b90:	00013903          	ld	s2,0(sp)
    80002b94:	02010113          	addi	sp,sp,32
    80002b98:	00008067          	ret

0000000080002b9c <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80002b9c:	fe010113          	addi	sp,sp,-32
    80002ba0:	00113c23          	sd	ra,24(sp)
    80002ba4:	00813823          	sd	s0,16(sp)
    80002ba8:	00913423          	sd	s1,8(sp)
    80002bac:	01213023          	sd	s2,0(sp)
    80002bb0:	02010413          	addi	s0,sp,32
    80002bb4:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80002bb8:	02053783          	ld	a5,32(a0)
        return sem_wait(myHandle);
    80002bbc:	0087b503          	ld	a0,8(a5)
    80002bc0:	fffff097          	auipc	ra,0xfffff
    80002bc4:	558080e7          	jalr	1368(ra) # 80002118 <_Z8sem_waitP4_sem>

    mutexHead->wait();
    80002bc8:	0284b783          	ld	a5,40(s1)
    80002bcc:	0087b503          	ld	a0,8(a5)
    80002bd0:	fffff097          	auipc	ra,0xfffff
    80002bd4:	548080e7          	jalr	1352(ra) # 80002118 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80002bd8:	0084b703          	ld	a4,8(s1)
    80002bdc:	0104a783          	lw	a5,16(s1)
    80002be0:	00279693          	slli	a3,a5,0x2
    80002be4:	00d70733          	add	a4,a4,a3
    80002be8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80002bec:	0017879b          	addiw	a5,a5,1
    80002bf0:	0004a703          	lw	a4,0(s1)
    80002bf4:	02e7e7bb          	remw	a5,a5,a4
    80002bf8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80002bfc:	0284b783          	ld	a5,40(s1)
        return sem_signal(myHandle);
    80002c00:	0087b503          	ld	a0,8(a5)
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	544080e7          	jalr	1348(ra) # 80002148 <_Z10sem_signalP4_sem>

    spaceAvailable->signal();
    80002c0c:	0184b783          	ld	a5,24(s1)
    80002c10:	0087b503          	ld	a0,8(a5)
    80002c14:	fffff097          	auipc	ra,0xfffff
    80002c18:	534080e7          	jalr	1332(ra) # 80002148 <_Z10sem_signalP4_sem>

    return ret;
}
    80002c1c:	00090513          	mv	a0,s2
    80002c20:	01813083          	ld	ra,24(sp)
    80002c24:	01013403          	ld	s0,16(sp)
    80002c28:	00813483          	ld	s1,8(sp)
    80002c2c:	00013903          	ld	s2,0(sp)
    80002c30:	02010113          	addi	sp,sp,32
    80002c34:	00008067          	ret

0000000080002c38 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80002c38:	fe010113          	addi	sp,sp,-32
    80002c3c:	00113c23          	sd	ra,24(sp)
    80002c40:	00813823          	sd	s0,16(sp)
    80002c44:	00913423          	sd	s1,8(sp)
    80002c48:	01213023          	sd	s2,0(sp)
    80002c4c:	02010413          	addi	s0,sp,32
    80002c50:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80002c54:	02853783          	ld	a5,40(a0)
        return sem_wait(myHandle);
    80002c58:	0087b503          	ld	a0,8(a5)
    80002c5c:	fffff097          	auipc	ra,0xfffff
    80002c60:	4bc080e7          	jalr	1212(ra) # 80002118 <_Z8sem_waitP4_sem>
    mutexTail->wait();
    80002c64:	0304b783          	ld	a5,48(s1)
    80002c68:	0087b503          	ld	a0,8(a5)
    80002c6c:	fffff097          	auipc	ra,0xfffff
    80002c70:	4ac080e7          	jalr	1196(ra) # 80002118 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80002c74:	0144a783          	lw	a5,20(s1)
    80002c78:	0104a903          	lw	s2,16(s1)
    80002c7c:	0527c263          	blt	a5,s2,80002cc0 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80002c80:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80002c84:	0304b783          	ld	a5,48(s1)
        return sem_signal(myHandle);
    80002c88:	0087b503          	ld	a0,8(a5)
    80002c8c:	fffff097          	auipc	ra,0xfffff
    80002c90:	4bc080e7          	jalr	1212(ra) # 80002148 <_Z10sem_signalP4_sem>
    mutexHead->signal();
    80002c94:	0284b783          	ld	a5,40(s1)
    80002c98:	0087b503          	ld	a0,8(a5)
    80002c9c:	fffff097          	auipc	ra,0xfffff
    80002ca0:	4ac080e7          	jalr	1196(ra) # 80002148 <_Z10sem_signalP4_sem>

    return ret;
}
    80002ca4:	00090513          	mv	a0,s2
    80002ca8:	01813083          	ld	ra,24(sp)
    80002cac:	01013403          	ld	s0,16(sp)
    80002cb0:	00813483          	ld	s1,8(sp)
    80002cb4:	00013903          	ld	s2,0(sp)
    80002cb8:	02010113          	addi	sp,sp,32
    80002cbc:	00008067          	ret
        ret = cap - head + tail;
    80002cc0:	0004a703          	lw	a4,0(s1)
    80002cc4:	4127093b          	subw	s2,a4,s2
    80002cc8:	00f9093b          	addw	s2,s2,a5
    80002ccc:	fb9ff06f          	j	80002c84 <_ZN9BufferCPP6getCntEv+0x4c>

0000000080002cd0 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80002cd0:	fe010113          	addi	sp,sp,-32
    80002cd4:	00113c23          	sd	ra,24(sp)
    80002cd8:	00813823          	sd	s0,16(sp)
    80002cdc:	00913423          	sd	s1,8(sp)
    80002ce0:	02010413          	addi	s0,sp,32
    80002ce4:	00050493          	mv	s1,a0
    putc('\n');
    80002ce8:	00a00513          	li	a0,10
    80002cec:	fffff097          	auipc	ra,0xfffff
    80002cf0:	3a0080e7          	jalr	928(ra) # 8000208c <_Z4putcc>
    printString("Buffer deleted!\n");
    80002cf4:	00005517          	auipc	a0,0x5
    80002cf8:	7ec50513          	addi	a0,a0,2028 # 800084e0 <CONSOLE_STATUS+0x4d0>
    80002cfc:	00000097          	auipc	ra,0x0
    80002d00:	99c080e7          	jalr	-1636(ra) # 80002698 <_Z11printStringPKc>
    while (getCnt()) {
    80002d04:	00048513          	mv	a0,s1
    80002d08:	00000097          	auipc	ra,0x0
    80002d0c:	f30080e7          	jalr	-208(ra) # 80002c38 <_ZN9BufferCPP6getCntEv>
    80002d10:	02050c63          	beqz	a0,80002d48 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80002d14:	0084b783          	ld	a5,8(s1)
    80002d18:	0104a703          	lw	a4,16(s1)
    80002d1c:	00271713          	slli	a4,a4,0x2
    80002d20:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80002d24:	0007c503          	lbu	a0,0(a5)
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	364080e7          	jalr	868(ra) # 8000208c <_Z4putcc>
        head = (head + 1) % cap;
    80002d30:	0104a783          	lw	a5,16(s1)
    80002d34:	0017879b          	addiw	a5,a5,1
    80002d38:	0004a703          	lw	a4,0(s1)
    80002d3c:	02e7e7bb          	remw	a5,a5,a4
    80002d40:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80002d44:	fc1ff06f          	j	80002d04 <_ZN9BufferCPPD1Ev+0x34>
    putc('!');
    80002d48:	02100513          	li	a0,33
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	340080e7          	jalr	832(ra) # 8000208c <_Z4putcc>
    putc('\n');
    80002d54:	00a00513          	li	a0,10
    80002d58:	fffff097          	auipc	ra,0xfffff
    80002d5c:	334080e7          	jalr	820(ra) # 8000208c <_Z4putcc>
    MemoryAllocator::mem_free(buffer);
    80002d60:	0084b503          	ld	a0,8(s1)
    80002d64:	ffffe097          	auipc	ra,0xffffe
    80002d68:	7f4080e7          	jalr	2036(ra) # 80001558 <_ZN15MemoryAllocator8mem_freeEPv>
    delete itemAvailable;
    80002d6c:	0204b503          	ld	a0,32(s1)
    80002d70:	00050863          	beqz	a0,80002d80 <_ZN9BufferCPPD1Ev+0xb0>
    80002d74:	00053783          	ld	a5,0(a0)
    80002d78:	0087b783          	ld	a5,8(a5)
    80002d7c:	000780e7          	jalr	a5
    delete spaceAvailable;
    80002d80:	0184b503          	ld	a0,24(s1)
    80002d84:	00050863          	beqz	a0,80002d94 <_ZN9BufferCPPD1Ev+0xc4>
    80002d88:	00053783          	ld	a5,0(a0)
    80002d8c:	0087b783          	ld	a5,8(a5)
    80002d90:	000780e7          	jalr	a5
    delete mutexTail;
    80002d94:	0304b503          	ld	a0,48(s1)
    80002d98:	00050863          	beqz	a0,80002da8 <_ZN9BufferCPPD1Ev+0xd8>
    80002d9c:	00053783          	ld	a5,0(a0)
    80002da0:	0087b783          	ld	a5,8(a5)
    80002da4:	000780e7          	jalr	a5
    delete mutexHead;
    80002da8:	0284b503          	ld	a0,40(s1)
    80002dac:	00050863          	beqz	a0,80002dbc <_ZN9BufferCPPD1Ev+0xec>
    80002db0:	00053783          	ld	a5,0(a0)
    80002db4:	0087b783          	ld	a5,8(a5)
    80002db8:	000780e7          	jalr	a5
}
    80002dbc:	01813083          	ld	ra,24(sp)
    80002dc0:	01013403          	ld	s0,16(sp)
    80002dc4:	00813483          	ld	s1,8(sp)
    80002dc8:	02010113          	addi	sp,sp,32
    80002dcc:	00008067          	ret

0000000080002dd0 <_ZN9SemaphoreD1Ev>:
    virtual ~Semaphore(){
    80002dd0:	ff010113          	addi	sp,sp,-16
    80002dd4:	00113423          	sd	ra,8(sp)
    80002dd8:	00813023          	sd	s0,0(sp)
    80002ddc:	01010413          	addi	s0,sp,16
    80002de0:	00005797          	auipc	a5,0x5
    80002de4:	72878793          	addi	a5,a5,1832 # 80008508 <_ZTV9Semaphore+0x10>
    80002de8:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002dec:	00853503          	ld	a0,8(a0)
    80002df0:	fffff097          	auipc	ra,0xfffff
    80002df4:	2f8080e7          	jalr	760(ra) # 800020e8 <_Z9sem_closeP4_sem>
    };
    80002df8:	00813083          	ld	ra,8(sp)
    80002dfc:	00013403          	ld	s0,0(sp)
    80002e00:	01010113          	addi	sp,sp,16
    80002e04:	00008067          	ret

0000000080002e08 <_ZN9SemaphoreD0Ev>:
    virtual ~Semaphore(){
    80002e08:	fe010113          	addi	sp,sp,-32
    80002e0c:	00113c23          	sd	ra,24(sp)
    80002e10:	00813823          	sd	s0,16(sp)
    80002e14:	00913423          	sd	s1,8(sp)
    80002e18:	02010413          	addi	s0,sp,32
    80002e1c:	00050493          	mv	s1,a0
    80002e20:	00005797          	auipc	a5,0x5
    80002e24:	6e878793          	addi	a5,a5,1768 # 80008508 <_ZTV9Semaphore+0x10>
    80002e28:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002e2c:	00853503          	ld	a0,8(a0)
    80002e30:	fffff097          	auipc	ra,0xfffff
    80002e34:	2b8080e7          	jalr	696(ra) # 800020e8 <_Z9sem_closeP4_sem>
    };
    80002e38:	00048513          	mv	a0,s1
    80002e3c:	ffffe097          	auipc	ra,0xffffe
    80002e40:	454080e7          	jalr	1108(ra) # 80001290 <_ZdlPv>
    80002e44:	01813083          	ld	ra,24(sp)
    80002e48:	01013403          	ld	s0,16(sp)
    80002e4c:	00813483          	ld	s1,8(sp)
    80002e50:	02010113          	addi	sp,sp,32
    80002e54:	00008067          	ret

0000000080002e58 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002e58:	fe010113          	addi	sp,sp,-32
    80002e5c:	00113c23          	sd	ra,24(sp)
    80002e60:	00813823          	sd	s0,16(sp)
    80002e64:	00913423          	sd	s1,8(sp)
    80002e68:	01213023          	sd	s2,0(sp)
    80002e6c:	02010413          	addi	s0,sp,32
    80002e70:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002e74:	00100793          	li	a5,1
    80002e78:	02a7f863          	bgeu	a5,a0,80002ea8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002e7c:	00a00793          	li	a5,10
    80002e80:	02f577b3          	remu	a5,a0,a5
    80002e84:	02078e63          	beqz	a5,80002ec0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002e88:	fff48513          	addi	a0,s1,-1
    80002e8c:	00000097          	auipc	ra,0x0
    80002e90:	fcc080e7          	jalr	-52(ra) # 80002e58 <_ZL9fibonaccim>
    80002e94:	00050913          	mv	s2,a0
    80002e98:	ffe48513          	addi	a0,s1,-2
    80002e9c:	00000097          	auipc	ra,0x0
    80002ea0:	fbc080e7          	jalr	-68(ra) # 80002e58 <_ZL9fibonaccim>
    80002ea4:	00a90533          	add	a0,s2,a0
}
    80002ea8:	01813083          	ld	ra,24(sp)
    80002eac:	01013403          	ld	s0,16(sp)
    80002eb0:	00813483          	ld	s1,8(sp)
    80002eb4:	00013903          	ld	s2,0(sp)
    80002eb8:	02010113          	addi	sp,sp,32
    80002ebc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	150080e7          	jalr	336(ra) # 80002010 <_Z15thread_dispatchv>
    80002ec8:	fc1ff06f          	j	80002e88 <_ZL9fibonaccim+0x30>

0000000080002ecc <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002ecc:	fe010113          	addi	sp,sp,-32
    80002ed0:	00113c23          	sd	ra,24(sp)
    80002ed4:	00813823          	sd	s0,16(sp)
    80002ed8:	00913423          	sd	s1,8(sp)
    80002edc:	01213023          	sd	s2,0(sp)
    80002ee0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002ee4:	00a00493          	li	s1,10
    80002ee8:	0400006f          	j	80002f28 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002eec:	00005517          	auipc	a0,0x5
    80002ef0:	62c50513          	addi	a0,a0,1580 # 80008518 <_ZTV9Semaphore+0x20>
    80002ef4:	fffff097          	auipc	ra,0xfffff
    80002ef8:	7a4080e7          	jalr	1956(ra) # 80002698 <_Z11printStringPKc>
    80002efc:	00000613          	li	a2,0
    80002f00:	00a00593          	li	a1,10
    80002f04:	00048513          	mv	a0,s1
    80002f08:	00000097          	auipc	ra,0x0
    80002f0c:	940080e7          	jalr	-1728(ra) # 80002848 <_Z8printIntiii>
    80002f10:	00005517          	auipc	a0,0x5
    80002f14:	42050513          	addi	a0,a0,1056 # 80008330 <CONSOLE_STATUS+0x320>
    80002f18:	fffff097          	auipc	ra,0xfffff
    80002f1c:	780080e7          	jalr	1920(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002f20:	0014849b          	addiw	s1,s1,1
    80002f24:	0ff4f493          	andi	s1,s1,255
    80002f28:	00c00793          	li	a5,12
    80002f2c:	fc97f0e3          	bgeu	a5,s1,80002eec <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002f30:	00005517          	auipc	a0,0x5
    80002f34:	5f050513          	addi	a0,a0,1520 # 80008520 <_ZTV9Semaphore+0x28>
    80002f38:	fffff097          	auipc	ra,0xfffff
    80002f3c:	760080e7          	jalr	1888(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002f40:	00500313          	li	t1,5
    thread_dispatch();
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	0cc080e7          	jalr	204(ra) # 80002010 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002f4c:	01000513          	li	a0,16
    80002f50:	00000097          	auipc	ra,0x0
    80002f54:	f08080e7          	jalr	-248(ra) # 80002e58 <_ZL9fibonaccim>
    80002f58:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002f5c:	00005517          	auipc	a0,0x5
    80002f60:	5d450513          	addi	a0,a0,1492 # 80008530 <_ZTV9Semaphore+0x38>
    80002f64:	fffff097          	auipc	ra,0xfffff
    80002f68:	734080e7          	jalr	1844(ra) # 80002698 <_Z11printStringPKc>
    80002f6c:	00000613          	li	a2,0
    80002f70:	00a00593          	li	a1,10
    80002f74:	0009051b          	sext.w	a0,s2
    80002f78:	00000097          	auipc	ra,0x0
    80002f7c:	8d0080e7          	jalr	-1840(ra) # 80002848 <_Z8printIntiii>
    80002f80:	00005517          	auipc	a0,0x5
    80002f84:	3b050513          	addi	a0,a0,944 # 80008330 <CONSOLE_STATUS+0x320>
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	710080e7          	jalr	1808(ra) # 80002698 <_Z11printStringPKc>
    80002f90:	0400006f          	j	80002fd0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f94:	00005517          	auipc	a0,0x5
    80002f98:	58450513          	addi	a0,a0,1412 # 80008518 <_ZTV9Semaphore+0x20>
    80002f9c:	fffff097          	auipc	ra,0xfffff
    80002fa0:	6fc080e7          	jalr	1788(ra) # 80002698 <_Z11printStringPKc>
    80002fa4:	00000613          	li	a2,0
    80002fa8:	00a00593          	li	a1,10
    80002fac:	00048513          	mv	a0,s1
    80002fb0:	00000097          	auipc	ra,0x0
    80002fb4:	898080e7          	jalr	-1896(ra) # 80002848 <_Z8printIntiii>
    80002fb8:	00005517          	auipc	a0,0x5
    80002fbc:	37850513          	addi	a0,a0,888 # 80008330 <CONSOLE_STATUS+0x320>
    80002fc0:	fffff097          	auipc	ra,0xfffff
    80002fc4:	6d8080e7          	jalr	1752(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002fc8:	0014849b          	addiw	s1,s1,1
    80002fcc:	0ff4f493          	andi	s1,s1,255
    80002fd0:	00f00793          	li	a5,15
    80002fd4:	fc97f0e3          	bgeu	a5,s1,80002f94 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002fd8:	00005517          	auipc	a0,0x5
    80002fdc:	56850513          	addi	a0,a0,1384 # 80008540 <_ZTV9Semaphore+0x48>
    80002fe0:	fffff097          	auipc	ra,0xfffff
    80002fe4:	6b8080e7          	jalr	1720(ra) # 80002698 <_Z11printStringPKc>
    finishedD = true;
    80002fe8:	00100793          	li	a5,1
    80002fec:	00007717          	auipc	a4,0x7
    80002ff0:	e8f70223          	sb	a5,-380(a4) # 80009e70 <_ZL9finishedD>
    thread_dispatch();
    80002ff4:	fffff097          	auipc	ra,0xfffff
    80002ff8:	01c080e7          	jalr	28(ra) # 80002010 <_Z15thread_dispatchv>
}
    80002ffc:	01813083          	ld	ra,24(sp)
    80003000:	01013403          	ld	s0,16(sp)
    80003004:	00813483          	ld	s1,8(sp)
    80003008:	00013903          	ld	s2,0(sp)
    8000300c:	02010113          	addi	sp,sp,32
    80003010:	00008067          	ret

0000000080003014 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003014:	fe010113          	addi	sp,sp,-32
    80003018:	00113c23          	sd	ra,24(sp)
    8000301c:	00813823          	sd	s0,16(sp)
    80003020:	00913423          	sd	s1,8(sp)
    80003024:	01213023          	sd	s2,0(sp)
    80003028:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000302c:	00000493          	li	s1,0
    80003030:	0400006f          	j	80003070 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003034:	00005517          	auipc	a0,0x5
    80003038:	51c50513          	addi	a0,a0,1308 # 80008550 <_ZTV9Semaphore+0x58>
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	65c080e7          	jalr	1628(ra) # 80002698 <_Z11printStringPKc>
    80003044:	00000613          	li	a2,0
    80003048:	00a00593          	li	a1,10
    8000304c:	00048513          	mv	a0,s1
    80003050:	fffff097          	auipc	ra,0xfffff
    80003054:	7f8080e7          	jalr	2040(ra) # 80002848 <_Z8printIntiii>
    80003058:	00005517          	auipc	a0,0x5
    8000305c:	2d850513          	addi	a0,a0,728 # 80008330 <CONSOLE_STATUS+0x320>
    80003060:	fffff097          	auipc	ra,0xfffff
    80003064:	638080e7          	jalr	1592(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003068:	0014849b          	addiw	s1,s1,1
    8000306c:	0ff4f493          	andi	s1,s1,255
    80003070:	00200793          	li	a5,2
    80003074:	fc97f0e3          	bgeu	a5,s1,80003034 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003078:	00005517          	auipc	a0,0x5
    8000307c:	4e050513          	addi	a0,a0,1248 # 80008558 <_ZTV9Semaphore+0x60>
    80003080:	fffff097          	auipc	ra,0xfffff
    80003084:	618080e7          	jalr	1560(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003088:	00700313          	li	t1,7
    thread_dispatch();
    8000308c:	fffff097          	auipc	ra,0xfffff
    80003090:	f84080e7          	jalr	-124(ra) # 80002010 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003094:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003098:	00005517          	auipc	a0,0x5
    8000309c:	4d050513          	addi	a0,a0,1232 # 80008568 <_ZTV9Semaphore+0x70>
    800030a0:	fffff097          	auipc	ra,0xfffff
    800030a4:	5f8080e7          	jalr	1528(ra) # 80002698 <_Z11printStringPKc>
    800030a8:	00000613          	li	a2,0
    800030ac:	00a00593          	li	a1,10
    800030b0:	0009051b          	sext.w	a0,s2
    800030b4:	fffff097          	auipc	ra,0xfffff
    800030b8:	794080e7          	jalr	1940(ra) # 80002848 <_Z8printIntiii>
    800030bc:	00005517          	auipc	a0,0x5
    800030c0:	27450513          	addi	a0,a0,628 # 80008330 <CONSOLE_STATUS+0x320>
    800030c4:	fffff097          	auipc	ra,0xfffff
    800030c8:	5d4080e7          	jalr	1492(ra) # 80002698 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800030cc:	00c00513          	li	a0,12
    800030d0:	00000097          	auipc	ra,0x0
    800030d4:	d88080e7          	jalr	-632(ra) # 80002e58 <_ZL9fibonaccim>
    800030d8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800030dc:	00005517          	auipc	a0,0x5
    800030e0:	49450513          	addi	a0,a0,1172 # 80008570 <_ZTV9Semaphore+0x78>
    800030e4:	fffff097          	auipc	ra,0xfffff
    800030e8:	5b4080e7          	jalr	1460(ra) # 80002698 <_Z11printStringPKc>
    800030ec:	00000613          	li	a2,0
    800030f0:	00a00593          	li	a1,10
    800030f4:	0009051b          	sext.w	a0,s2
    800030f8:	fffff097          	auipc	ra,0xfffff
    800030fc:	750080e7          	jalr	1872(ra) # 80002848 <_Z8printIntiii>
    80003100:	00005517          	auipc	a0,0x5
    80003104:	23050513          	addi	a0,a0,560 # 80008330 <CONSOLE_STATUS+0x320>
    80003108:	fffff097          	auipc	ra,0xfffff
    8000310c:	590080e7          	jalr	1424(ra) # 80002698 <_Z11printStringPKc>
    80003110:	0400006f          	j	80003150 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003114:	00005517          	auipc	a0,0x5
    80003118:	43c50513          	addi	a0,a0,1084 # 80008550 <_ZTV9Semaphore+0x58>
    8000311c:	fffff097          	auipc	ra,0xfffff
    80003120:	57c080e7          	jalr	1404(ra) # 80002698 <_Z11printStringPKc>
    80003124:	00000613          	li	a2,0
    80003128:	00a00593          	li	a1,10
    8000312c:	00048513          	mv	a0,s1
    80003130:	fffff097          	auipc	ra,0xfffff
    80003134:	718080e7          	jalr	1816(ra) # 80002848 <_Z8printIntiii>
    80003138:	00005517          	auipc	a0,0x5
    8000313c:	1f850513          	addi	a0,a0,504 # 80008330 <CONSOLE_STATUS+0x320>
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	558080e7          	jalr	1368(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003148:	0014849b          	addiw	s1,s1,1
    8000314c:	0ff4f493          	andi	s1,s1,255
    80003150:	00500793          	li	a5,5
    80003154:	fc97f0e3          	bgeu	a5,s1,80003114 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80003158:	00005517          	auipc	a0,0x5
    8000315c:	42850513          	addi	a0,a0,1064 # 80008580 <_ZTV9Semaphore+0x88>
    80003160:	fffff097          	auipc	ra,0xfffff
    80003164:	538080e7          	jalr	1336(ra) # 80002698 <_Z11printStringPKc>
    finishedC = true;
    80003168:	00100793          	li	a5,1
    8000316c:	00007717          	auipc	a4,0x7
    80003170:	d0f702a3          	sb	a5,-763(a4) # 80009e71 <_ZL9finishedC>
    thread_dispatch();
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	e9c080e7          	jalr	-356(ra) # 80002010 <_Z15thread_dispatchv>
}
    8000317c:	01813083          	ld	ra,24(sp)
    80003180:	01013403          	ld	s0,16(sp)
    80003184:	00813483          	ld	s1,8(sp)
    80003188:	00013903          	ld	s2,0(sp)
    8000318c:	02010113          	addi	sp,sp,32
    80003190:	00008067          	ret

0000000080003194 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003194:	fe010113          	addi	sp,sp,-32
    80003198:	00113c23          	sd	ra,24(sp)
    8000319c:	00813823          	sd	s0,16(sp)
    800031a0:	00913423          	sd	s1,8(sp)
    800031a4:	01213023          	sd	s2,0(sp)
    800031a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800031ac:	00000913          	li	s2,0
    800031b0:	0400006f          	j	800031f0 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800031b4:	fffff097          	auipc	ra,0xfffff
    800031b8:	e5c080e7          	jalr	-420(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800031bc:	00148493          	addi	s1,s1,1
    800031c0:	000027b7          	lui	a5,0x2
    800031c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800031c8:	0097ee63          	bltu	a5,s1,800031e4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800031cc:	00000713          	li	a4,0
    800031d0:	000077b7          	lui	a5,0x7
    800031d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800031d8:	fce7eee3          	bltu	a5,a4,800031b4 <_ZL11workerBodyBPv+0x20>
    800031dc:	00170713          	addi	a4,a4,1
    800031e0:	ff1ff06f          	j	800031d0 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800031e4:	00a00793          	li	a5,10
    800031e8:	04f90663          	beq	s2,a5,80003234 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800031ec:	00190913          	addi	s2,s2,1
    800031f0:	00f00793          	li	a5,15
    800031f4:	0527e463          	bltu	a5,s2,8000323c <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800031f8:	00005517          	auipc	a0,0x5
    800031fc:	39850513          	addi	a0,a0,920 # 80008590 <_ZTV9Semaphore+0x98>
    80003200:	fffff097          	auipc	ra,0xfffff
    80003204:	498080e7          	jalr	1176(ra) # 80002698 <_Z11printStringPKc>
    80003208:	00000613          	li	a2,0
    8000320c:	00a00593          	li	a1,10
    80003210:	0009051b          	sext.w	a0,s2
    80003214:	fffff097          	auipc	ra,0xfffff
    80003218:	634080e7          	jalr	1588(ra) # 80002848 <_Z8printIntiii>
    8000321c:	00005517          	auipc	a0,0x5
    80003220:	11450513          	addi	a0,a0,276 # 80008330 <CONSOLE_STATUS+0x320>
    80003224:	fffff097          	auipc	ra,0xfffff
    80003228:	474080e7          	jalr	1140(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000322c:	00000493          	li	s1,0
    80003230:	f91ff06f          	j	800031c0 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80003234:	14102ff3          	csrr	t6,sepc
    80003238:	fb5ff06f          	j	800031ec <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    8000323c:	00005517          	auipc	a0,0x5
    80003240:	35c50513          	addi	a0,a0,860 # 80008598 <_ZTV9Semaphore+0xa0>
    80003244:	fffff097          	auipc	ra,0xfffff
    80003248:	454080e7          	jalr	1108(ra) # 80002698 <_Z11printStringPKc>
    finishedB = true;
    8000324c:	00100793          	li	a5,1
    80003250:	00007717          	auipc	a4,0x7
    80003254:	c2f70123          	sb	a5,-990(a4) # 80009e72 <_ZL9finishedB>
    thread_dispatch();
    80003258:	fffff097          	auipc	ra,0xfffff
    8000325c:	db8080e7          	jalr	-584(ra) # 80002010 <_Z15thread_dispatchv>
}
    80003260:	01813083          	ld	ra,24(sp)
    80003264:	01013403          	ld	s0,16(sp)
    80003268:	00813483          	ld	s1,8(sp)
    8000326c:	00013903          	ld	s2,0(sp)
    80003270:	02010113          	addi	sp,sp,32
    80003274:	00008067          	ret

0000000080003278 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003278:	fe010113          	addi	sp,sp,-32
    8000327c:	00113c23          	sd	ra,24(sp)
    80003280:	00813823          	sd	s0,16(sp)
    80003284:	00913423          	sd	s1,8(sp)
    80003288:	01213023          	sd	s2,0(sp)
    8000328c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003290:	00000913          	li	s2,0
    80003294:	0380006f          	j	800032cc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003298:	fffff097          	auipc	ra,0xfffff
    8000329c:	d78080e7          	jalr	-648(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800032a0:	00148493          	addi	s1,s1,1
    800032a4:	000027b7          	lui	a5,0x2
    800032a8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800032ac:	0097ee63          	bltu	a5,s1,800032c8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800032b0:	00000713          	li	a4,0
    800032b4:	000077b7          	lui	a5,0x7
    800032b8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800032bc:	fce7eee3          	bltu	a5,a4,80003298 <_ZL11workerBodyAPv+0x20>
    800032c0:	00170713          	addi	a4,a4,1
    800032c4:	ff1ff06f          	j	800032b4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800032c8:	00190913          	addi	s2,s2,1
    800032cc:	00900793          	li	a5,9
    800032d0:	0527e063          	bltu	a5,s2,80003310 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800032d4:	00005517          	auipc	a0,0x5
    800032d8:	2d450513          	addi	a0,a0,724 # 800085a8 <_ZTV9Semaphore+0xb0>
    800032dc:	fffff097          	auipc	ra,0xfffff
    800032e0:	3bc080e7          	jalr	956(ra) # 80002698 <_Z11printStringPKc>
    800032e4:	00000613          	li	a2,0
    800032e8:	00a00593          	li	a1,10
    800032ec:	0009051b          	sext.w	a0,s2
    800032f0:	fffff097          	auipc	ra,0xfffff
    800032f4:	558080e7          	jalr	1368(ra) # 80002848 <_Z8printIntiii>
    800032f8:	00005517          	auipc	a0,0x5
    800032fc:	03850513          	addi	a0,a0,56 # 80008330 <CONSOLE_STATUS+0x320>
    80003300:	fffff097          	auipc	ra,0xfffff
    80003304:	398080e7          	jalr	920(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003308:	00000493          	li	s1,0
    8000330c:	f99ff06f          	j	800032a4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003310:	00005517          	auipc	a0,0x5
    80003314:	2a050513          	addi	a0,a0,672 # 800085b0 <_ZTV9Semaphore+0xb8>
    80003318:	fffff097          	auipc	ra,0xfffff
    8000331c:	380080e7          	jalr	896(ra) # 80002698 <_Z11printStringPKc>
    finishedA = true;
    80003320:	00100793          	li	a5,1
    80003324:	00007717          	auipc	a4,0x7
    80003328:	b4f707a3          	sb	a5,-1201(a4) # 80009e73 <_ZL9finishedA>
}
    8000332c:	01813083          	ld	ra,24(sp)
    80003330:	01013403          	ld	s0,16(sp)
    80003334:	00813483          	ld	s1,8(sp)
    80003338:	00013903          	ld	s2,0(sp)
    8000333c:	02010113          	addi	sp,sp,32
    80003340:	00008067          	ret

0000000080003344 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80003344:	fd010113          	addi	sp,sp,-48
    80003348:	02113423          	sd	ra,40(sp)
    8000334c:	02813023          	sd	s0,32(sp)
    80003350:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80003354:	00000613          	li	a2,0
    80003358:	00000597          	auipc	a1,0x0
    8000335c:	f2058593          	addi	a1,a1,-224 # 80003278 <_ZL11workerBodyAPv>
    80003360:	fd040513          	addi	a0,s0,-48
    80003364:	fffff097          	auipc	ra,0xfffff
    80003368:	c74080e7          	jalr	-908(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000336c:	00005517          	auipc	a0,0x5
    80003370:	25450513          	addi	a0,a0,596 # 800085c0 <_ZTV9Semaphore+0xc8>
    80003374:	fffff097          	auipc	ra,0xfffff
    80003378:	324080e7          	jalr	804(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000337c:	00000613          	li	a2,0
    80003380:	00000597          	auipc	a1,0x0
    80003384:	e1458593          	addi	a1,a1,-492 # 80003194 <_ZL11workerBodyBPv>
    80003388:	fd840513          	addi	a0,s0,-40
    8000338c:	fffff097          	auipc	ra,0xfffff
    80003390:	c4c080e7          	jalr	-948(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80003394:	00005517          	auipc	a0,0x5
    80003398:	24450513          	addi	a0,a0,580 # 800085d8 <_ZTV9Semaphore+0xe0>
    8000339c:	fffff097          	auipc	ra,0xfffff
    800033a0:	2fc080e7          	jalr	764(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800033a4:	00000613          	li	a2,0
    800033a8:	00000597          	auipc	a1,0x0
    800033ac:	c6c58593          	addi	a1,a1,-916 # 80003014 <_ZL11workerBodyCPv>
    800033b0:	fe040513          	addi	a0,s0,-32
    800033b4:	fffff097          	auipc	ra,0xfffff
    800033b8:	c24080e7          	jalr	-988(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800033bc:	00005517          	auipc	a0,0x5
    800033c0:	23450513          	addi	a0,a0,564 # 800085f0 <_ZTV9Semaphore+0xf8>
    800033c4:	fffff097          	auipc	ra,0xfffff
    800033c8:	2d4080e7          	jalr	724(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800033cc:	00000613          	li	a2,0
    800033d0:	00000597          	auipc	a1,0x0
    800033d4:	afc58593          	addi	a1,a1,-1284 # 80002ecc <_ZL11workerBodyDPv>
    800033d8:	fe840513          	addi	a0,s0,-24
    800033dc:	fffff097          	auipc	ra,0xfffff
    800033e0:	bfc080e7          	jalr	-1028(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800033e4:	00005517          	auipc	a0,0x5
    800033e8:	22450513          	addi	a0,a0,548 # 80008608 <_ZTV9Semaphore+0x110>
    800033ec:	fffff097          	auipc	ra,0xfffff
    800033f0:	2ac080e7          	jalr	684(ra) # 80002698 <_Z11printStringPKc>
    800033f4:	00c0006f          	j	80003400 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800033f8:	fffff097          	auipc	ra,0xfffff
    800033fc:	c18080e7          	jalr	-1000(ra) # 80002010 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003400:	00007797          	auipc	a5,0x7
    80003404:	a737c783          	lbu	a5,-1421(a5) # 80009e73 <_ZL9finishedA>
    80003408:	fe0788e3          	beqz	a5,800033f8 <_Z16System_Mode_testv+0xb4>
    8000340c:	00007797          	auipc	a5,0x7
    80003410:	a667c783          	lbu	a5,-1434(a5) # 80009e72 <_ZL9finishedB>
    80003414:	fe0782e3          	beqz	a5,800033f8 <_Z16System_Mode_testv+0xb4>
    80003418:	00007797          	auipc	a5,0x7
    8000341c:	a597c783          	lbu	a5,-1447(a5) # 80009e71 <_ZL9finishedC>
    80003420:	fc078ce3          	beqz	a5,800033f8 <_Z16System_Mode_testv+0xb4>
    80003424:	00007797          	auipc	a5,0x7
    80003428:	a4c7c783          	lbu	a5,-1460(a5) # 80009e70 <_ZL9finishedD>
    8000342c:	fc0786e3          	beqz	a5,800033f8 <_Z16System_Mode_testv+0xb4>
    }

    80003430:	02813083          	ld	ra,40(sp)
    80003434:	02013403          	ld	s0,32(sp)
    80003438:	03010113          	addi	sp,sp,48
    8000343c:	00008067          	ret

0000000080003440 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003440:	fd010113          	addi	sp,sp,-48
    80003444:	02113423          	sd	ra,40(sp)
    80003448:	02813023          	sd	s0,32(sp)
    8000344c:	00913c23          	sd	s1,24(sp)
    80003450:	01213823          	sd	s2,16(sp)
    80003454:	01313423          	sd	s3,8(sp)
    80003458:	03010413          	addi	s0,sp,48
    8000345c:	00050993          	mv	s3,a0
    80003460:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003464:	00000913          	li	s2,0
    80003468:	00c0006f          	j	80003474 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    static void dispatch() {thread_dispatch();}
    8000346c:	fffff097          	auipc	ra,0xfffff
    80003470:	ba4080e7          	jalr	-1116(ra) # 80002010 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80003474:	fffff097          	auipc	ra,0xfffff
    80003478:	bec080e7          	jalr	-1044(ra) # 80002060 <_Z4getcv>
    8000347c:	0005059b          	sext.w	a1,a0
    80003480:	01b00793          	li	a5,27
    80003484:	02f58a63          	beq	a1,a5,800034b8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80003488:	0084b503          	ld	a0,8(s1)
    8000348c:	fffff097          	auipc	ra,0xfffff
    80003490:	670080e7          	jalr	1648(ra) # 80002afc <_ZN9BufferCPP3putEi>
        i++;
    80003494:	0019071b          	addiw	a4,s2,1
    80003498:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    8000349c:	0004a683          	lw	a3,0(s1)
    800034a0:	0026979b          	slliw	a5,a3,0x2
    800034a4:	00d787bb          	addw	a5,a5,a3
    800034a8:	0017979b          	slliw	a5,a5,0x1
    800034ac:	02f767bb          	remw	a5,a4,a5
    800034b0:	fc0792e3          	bnez	a5,80003474 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800034b4:	fb9ff06f          	j	8000346c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    800034b8:	00100793          	li	a5,1
    800034bc:	00007717          	auipc	a4,0x7
    800034c0:	9af72e23          	sw	a5,-1604(a4) # 80009e78 <_ZL9threadEnd>
    td->buffer->put('!');
    800034c4:	0209b783          	ld	a5,32(s3)
    800034c8:	02100593          	li	a1,33
    800034cc:	0087b503          	ld	a0,8(a5)
    800034d0:	fffff097          	auipc	ra,0xfffff
    800034d4:	62c080e7          	jalr	1580(ra) # 80002afc <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800034d8:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    800034dc:	0087b503          	ld	a0,8(a5)
    800034e0:	fffff097          	auipc	ra,0xfffff
    800034e4:	c68080e7          	jalr	-920(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    800034e8:	02813083          	ld	ra,40(sp)
    800034ec:	02013403          	ld	s0,32(sp)
    800034f0:	01813483          	ld	s1,24(sp)
    800034f4:	01013903          	ld	s2,16(sp)
    800034f8:	00813983          	ld	s3,8(sp)
    800034fc:	03010113          	addi	sp,sp,48
    80003500:	00008067          	ret

0000000080003504 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003504:	fe010113          	addi	sp,sp,-32
    80003508:	00113c23          	sd	ra,24(sp)
    8000350c:	00813823          	sd	s0,16(sp)
    80003510:	00913423          	sd	s1,8(sp)
    80003514:	01213023          	sd	s2,0(sp)
    80003518:	02010413          	addi	s0,sp,32
    8000351c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003520:	00000913          	li	s2,0
    80003524:	00c0006f          	j	80003530 <_ZN12ProducerSync8producerEPv+0x2c>
    static void dispatch() {thread_dispatch();}
    80003528:	fffff097          	auipc	ra,0xfffff
    8000352c:	ae8080e7          	jalr	-1304(ra) # 80002010 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80003530:	00007797          	auipc	a5,0x7
    80003534:	9487a783          	lw	a5,-1720(a5) # 80009e78 <_ZL9threadEnd>
    80003538:	02079e63          	bnez	a5,80003574 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000353c:	0004a583          	lw	a1,0(s1)
    80003540:	0305859b          	addiw	a1,a1,48
    80003544:	0084b503          	ld	a0,8(s1)
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	5b4080e7          	jalr	1460(ra) # 80002afc <_ZN9BufferCPP3putEi>
        i++;
    80003550:	0019071b          	addiw	a4,s2,1
    80003554:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80003558:	0004a683          	lw	a3,0(s1)
    8000355c:	0026979b          	slliw	a5,a3,0x2
    80003560:	00d787bb          	addw	a5,a5,a3
    80003564:	0017979b          	slliw	a5,a5,0x1
    80003568:	02f767bb          	remw	a5,a4,a5
    8000356c:	fc0792e3          	bnez	a5,80003530 <_ZN12ProducerSync8producerEPv+0x2c>
    80003570:	fb9ff06f          	j	80003528 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80003574:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    80003578:	0087b503          	ld	a0,8(a5)
    8000357c:	fffff097          	auipc	ra,0xfffff
    80003580:	bcc080e7          	jalr	-1076(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    80003584:	01813083          	ld	ra,24(sp)
    80003588:	01013403          	ld	s0,16(sp)
    8000358c:	00813483          	ld	s1,8(sp)
    80003590:	00013903          	ld	s2,0(sp)
    80003594:	02010113          	addi	sp,sp,32
    80003598:	00008067          	ret

000000008000359c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    8000359c:	fd010113          	addi	sp,sp,-48
    800035a0:	02113423          	sd	ra,40(sp)
    800035a4:	02813023          	sd	s0,32(sp)
    800035a8:	00913c23          	sd	s1,24(sp)
    800035ac:	01213823          	sd	s2,16(sp)
    800035b0:	01313423          	sd	s3,8(sp)
    800035b4:	01413023          	sd	s4,0(sp)
    800035b8:	03010413          	addi	s0,sp,48
    800035bc:	00050993          	mv	s3,a0
    800035c0:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800035c4:	00000a13          	li	s4,0
    800035c8:	01c0006f          	j	800035e4 <_ZN12ConsumerSync8consumerEPv+0x48>
    static void dispatch() {thread_dispatch();}
    800035cc:	fffff097          	auipc	ra,0xfffff
    800035d0:	a44080e7          	jalr	-1468(ra) # 80002010 <_Z15thread_dispatchv>
    800035d4:	0500006f          	j	80003624 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    800035d8:	00a00513          	li	a0,10
    800035dc:	fffff097          	auipc	ra,0xfffff
    800035e0:	ab0080e7          	jalr	-1360(ra) # 8000208c <_Z4putcc>
    while (!threadEnd) {
    800035e4:	00007797          	auipc	a5,0x7
    800035e8:	8947a783          	lw	a5,-1900(a5) # 80009e78 <_ZL9threadEnd>
    800035ec:	06079263          	bnez	a5,80003650 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800035f0:	00893503          	ld	a0,8(s2)
    800035f4:	fffff097          	auipc	ra,0xfffff
    800035f8:	5a8080e7          	jalr	1448(ra) # 80002b9c <_ZN9BufferCPP3getEv>
        i++;
    800035fc:	001a049b          	addiw	s1,s4,1
    80003600:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003604:	0ff57513          	andi	a0,a0,255
    80003608:	fffff097          	auipc	ra,0xfffff
    8000360c:	a84080e7          	jalr	-1404(ra) # 8000208c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003610:	00092703          	lw	a4,0(s2)
    80003614:	0027179b          	slliw	a5,a4,0x2
    80003618:	00e787bb          	addw	a5,a5,a4
    8000361c:	02f4e7bb          	remw	a5,s1,a5
    80003620:	fa0786e3          	beqz	a5,800035cc <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003624:	05000793          	li	a5,80
    80003628:	02f4e4bb          	remw	s1,s1,a5
    8000362c:	fa049ce3          	bnez	s1,800035e4 <_ZN12ConsumerSync8consumerEPv+0x48>
    80003630:	fa9ff06f          	j	800035d8 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003634:	0209b783          	ld	a5,32(s3)
    80003638:	0087b503          	ld	a0,8(a5)
    8000363c:	fffff097          	auipc	ra,0xfffff
    80003640:	560080e7          	jalr	1376(ra) # 80002b9c <_ZN9BufferCPP3getEv>
        //Console::putc(key);
        putc(key);
    80003644:	0ff57513          	andi	a0,a0,255
    80003648:	fffff097          	auipc	ra,0xfffff
    8000364c:	a44080e7          	jalr	-1468(ra) # 8000208c <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80003650:	0209b783          	ld	a5,32(s3)
    80003654:	0087b503          	ld	a0,8(a5)
    80003658:	fffff097          	auipc	ra,0xfffff
    8000365c:	5e0080e7          	jalr	1504(ra) # 80002c38 <_ZN9BufferCPP6getCntEv>
    80003660:	fca04ae3          	bgtz	a0,80003634 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80003664:	01093783          	ld	a5,16(s2)
        return sem_signal(myHandle);
    80003668:	0087b503          	ld	a0,8(a5)
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	adc080e7          	jalr	-1316(ra) # 80002148 <_Z10sem_signalP4_sem>
}
    80003674:	02813083          	ld	ra,40(sp)
    80003678:	02013403          	ld	s0,32(sp)
    8000367c:	01813483          	ld	s1,24(sp)
    80003680:	01013903          	ld	s2,16(sp)
    80003684:	00813983          	ld	s3,8(sp)
    80003688:	00013a03          	ld	s4,0(sp)
    8000368c:	03010113          	addi	sp,sp,48
    80003690:	00008067          	ret

0000000080003694 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003694:	f9010113          	addi	sp,sp,-112
    80003698:	06113423          	sd	ra,104(sp)
    8000369c:	06813023          	sd	s0,96(sp)
    800036a0:	04913c23          	sd	s1,88(sp)
    800036a4:	05213823          	sd	s2,80(sp)
    800036a8:	05313423          	sd	s3,72(sp)
    800036ac:	05413023          	sd	s4,64(sp)
    800036b0:	03513c23          	sd	s5,56(sp)
    800036b4:	03613823          	sd	s6,48(sp)
    800036b8:	03713423          	sd	s7,40(sp)
    800036bc:	03813023          	sd	s8,32(sp)
    800036c0:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800036c4:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800036c8:	00005517          	auipc	a0,0x5
    800036cc:	d3050513          	addi	a0,a0,-720 # 800083f8 <CONSOLE_STATUS+0x3e8>
    800036d0:	fffff097          	auipc	ra,0xfffff
    800036d4:	fc8080e7          	jalr	-56(ra) # 80002698 <_Z11printStringPKc>
    getString(input, 30);
    800036d8:	01e00593          	li	a1,30
    800036dc:	f9040513          	addi	a0,s0,-112
    800036e0:	fffff097          	auipc	ra,0xfffff
    800036e4:	040080e7          	jalr	64(ra) # 80002720 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800036e8:	f9040513          	addi	a0,s0,-112
    800036ec:	fffff097          	auipc	ra,0xfffff
    800036f0:	10c080e7          	jalr	268(ra) # 800027f8 <_Z11stringToIntPKc>
    800036f4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800036f8:	00005517          	auipc	a0,0x5
    800036fc:	d2050513          	addi	a0,a0,-736 # 80008418 <CONSOLE_STATUS+0x408>
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	f98080e7          	jalr	-104(ra) # 80002698 <_Z11printStringPKc>
    getString(input, 30);
    80003708:	01e00593          	li	a1,30
    8000370c:	f9040513          	addi	a0,s0,-112
    80003710:	fffff097          	auipc	ra,0xfffff
    80003714:	010080e7          	jalr	16(ra) # 80002720 <_Z9getStringPci>
    n = stringToInt(input);
    80003718:	f9040513          	addi	a0,s0,-112
    8000371c:	fffff097          	auipc	ra,0xfffff
    80003720:	0dc080e7          	jalr	220(ra) # 800027f8 <_Z11stringToIntPKc>
    80003724:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003728:	00005517          	auipc	a0,0x5
    8000372c:	d1050513          	addi	a0,a0,-752 # 80008438 <CONSOLE_STATUS+0x428>
    80003730:	fffff097          	auipc	ra,0xfffff
    80003734:	f68080e7          	jalr	-152(ra) # 80002698 <_Z11printStringPKc>
    80003738:	00000613          	li	a2,0
    8000373c:	00a00593          	li	a1,10
    80003740:	00090513          	mv	a0,s2
    80003744:	fffff097          	auipc	ra,0xfffff
    80003748:	104080e7          	jalr	260(ra) # 80002848 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000374c:	00005517          	auipc	a0,0x5
    80003750:	d0450513          	addi	a0,a0,-764 # 80008450 <CONSOLE_STATUS+0x440>
    80003754:	fffff097          	auipc	ra,0xfffff
    80003758:	f44080e7          	jalr	-188(ra) # 80002698 <_Z11printStringPKc>
    8000375c:	00000613          	li	a2,0
    80003760:	00a00593          	li	a1,10
    80003764:	00048513          	mv	a0,s1
    80003768:	fffff097          	auipc	ra,0xfffff
    8000376c:	0e0080e7          	jalr	224(ra) # 80002848 <_Z8printIntiii>
    printString(".\n");
    80003770:	00005517          	auipc	a0,0x5
    80003774:	cf850513          	addi	a0,a0,-776 # 80008468 <CONSOLE_STATUS+0x458>
    80003778:	fffff097          	auipc	ra,0xfffff
    8000377c:	f20080e7          	jalr	-224(ra) # 80002698 <_Z11printStringPKc>
    if(threadNum > n) {
    80003780:	0324c463          	blt	s1,s2,800037a8 <_Z29producerConsumer_CPP_Sync_APIv+0x114>
    } else if (threadNum < 1) {
    80003784:	03205c63          	blez	s2,800037bc <_Z29producerConsumer_CPP_Sync_APIv+0x128>
    BufferCPP *buffer = new BufferCPP(n);
    80003788:	03800513          	li	a0,56
    8000378c:	ffffe097          	auipc	ra,0xffffe
    80003790:	ab4080e7          	jalr	-1356(ra) # 80001240 <_Znwm>
    80003794:	00050a93          	mv	s5,a0
    80003798:	00048593          	mv	a1,s1
    8000379c:	fffff097          	auipc	ra,0xfffff
    800037a0:	1cc080e7          	jalr	460(ra) # 80002968 <_ZN9BufferCPPC1Ei>
    800037a4:	0300006f          	j	800037d4 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800037a8:	00005517          	auipc	a0,0x5
    800037ac:	cc850513          	addi	a0,a0,-824 # 80008470 <CONSOLE_STATUS+0x460>
    800037b0:	fffff097          	auipc	ra,0xfffff
    800037b4:	ee8080e7          	jalr	-280(ra) # 80002698 <_Z11printStringPKc>
        return;
    800037b8:	0140006f          	j	800037cc <_Z29producerConsumer_CPP_Sync_APIv+0x138>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800037bc:	00005517          	auipc	a0,0x5
    800037c0:	cf450513          	addi	a0,a0,-780 # 800084b0 <CONSOLE_STATUS+0x4a0>
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	ed4080e7          	jalr	-300(ra) # 80002698 <_Z11printStringPKc>
        return;
    800037cc:	000b8113          	mv	sp,s7
    800037d0:	26c0006f          	j	80003a3c <_Z29producerConsumer_CPP_Sync_APIv+0x3a8>
    waitForAll = new Semaphore(0);
    800037d4:	01000513          	li	a0,16
    800037d8:	ffffe097          	auipc	ra,0xffffe
    800037dc:	a68080e7          	jalr	-1432(ra) # 80001240 <_Znwm>
    800037e0:	00050493          	mv	s1,a0
    Semaphore(unsigned init=1){
    800037e4:	00005797          	auipc	a5,0x5
    800037e8:	d2478793          	addi	a5,a5,-732 # 80008508 <_ZTV9Semaphore+0x10>
    800037ec:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    800037f0:	00000593          	li	a1,0
    800037f4:	00850513          	addi	a0,a0,8
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	8bc080e7          	jalr	-1860(ra) # 800020b4 <_Z8sem_openPP4_semj>
    80003800:	00006797          	auipc	a5,0x6
    80003804:	6897b023          	sd	s1,1664(a5) # 80009e80 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003808:	00391793          	slli	a5,s2,0x3
    8000380c:	00f78793          	addi	a5,a5,15
    80003810:	ff07f793          	andi	a5,a5,-16
    80003814:	40f10133          	sub	sp,sp,a5
    80003818:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000381c:	0019071b          	addiw	a4,s2,1
    80003820:	00171793          	slli	a5,a4,0x1
    80003824:	00e787b3          	add	a5,a5,a4
    80003828:	00379793          	slli	a5,a5,0x3
    8000382c:	00f78793          	addi	a5,a5,15
    80003830:	ff07f793          	andi	a5,a5,-16
    80003834:	40f10133          	sub	sp,sp,a5
    80003838:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000383c:	00191c13          	slli	s8,s2,0x1
    80003840:	012c07b3          	add	a5,s8,s2
    80003844:	00379793          	slli	a5,a5,0x3
    80003848:	00fa07b3          	add	a5,s4,a5
    8000384c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003850:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003854:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003858:	02800513          	li	a0,40
    8000385c:	ffffe097          	auipc	ra,0xffffe
    80003860:	9e4080e7          	jalr	-1564(ra) # 80001240 <_Znwm>
    80003864:	00050b13          	mv	s6,a0
    80003868:	012c0c33          	add	s8,s8,s2
    8000386c:	003c1c13          	slli	s8,s8,0x3
    80003870:	018a0c33          	add	s8,s4,s8
    Thread(){};
    80003874:	00053823          	sd	zero,16(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003878:	00005797          	auipc	a5,0x5
    8000387c:	e3078793          	addi	a5,a5,-464 # 800086a8 <_ZTV12ConsumerSync+0x10>
    80003880:	00f53023          	sd	a5,0(a0)
    80003884:	03853023          	sd	s8,32(a0)
            thread_create(&myhandle, &threadWrapper,this);
    80003888:	00050613          	mv	a2,a0
    8000388c:	00000597          	auipc	a1,0x0
    80003890:	23458593          	addi	a1,a1,564 # 80003ac0 <_ZN6Thread13threadWrapperEPv>
    80003894:	00850513          	addi	a0,a0,8
    80003898:	ffffe097          	auipc	ra,0xffffe
    8000389c:	740080e7          	jalr	1856(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800038a0:	00000493          	li	s1,0
        return 0;
    800038a4:	0600006f          	j	80003904 <_Z29producerConsumer_CPP_Sync_APIv+0x270>
            threads[i] = new ProducerKeyboard(data+i);
    800038a8:	02800513          	li	a0,40
    800038ac:	ffffe097          	auipc	ra,0xffffe
    800038b0:	994080e7          	jalr	-1644(ra) # 80001240 <_Znwm>
    800038b4:	00149793          	slli	a5,s1,0x1
    800038b8:	009787b3          	add	a5,a5,s1
    800038bc:	00379793          	slli	a5,a5,0x3
    800038c0:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    800038c4:	00053823          	sd	zero,16(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800038c8:	00005717          	auipc	a4,0x5
    800038cc:	d9070713          	addi	a4,a4,-624 # 80008658 <_ZTV16ProducerKeyboard+0x10>
    800038d0:	00e53023          	sd	a4,0(a0)
    800038d4:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    800038d8:	00349793          	slli	a5,s1,0x3
    800038dc:	00f987b3          	add	a5,s3,a5
    800038e0:	00a7b023          	sd	a0,0(a5)
    800038e4:	0880006f          	j	8000396c <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
            thread_create(&myhandle, &threadWrapper,this);
    800038e8:	00050613          	mv	a2,a0
    800038ec:	00000597          	auipc	a1,0x0
    800038f0:	1d458593          	addi	a1,a1,468 # 80003ac0 <_ZN6Thread13threadWrapperEPv>
    800038f4:	00850513          	addi	a0,a0,8
    800038f8:	ffffe097          	auipc	ra,0xffffe
    800038fc:	6e0080e7          	jalr	1760(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003900:	0014849b          	addiw	s1,s1,1
    80003904:	0924d863          	bge	s1,s2,80003994 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        data[i].id = i;
    80003908:	00149793          	slli	a5,s1,0x1
    8000390c:	009787b3          	add	a5,a5,s1
    80003910:	00379793          	slli	a5,a5,0x3
    80003914:	00fa07b3          	add	a5,s4,a5
    80003918:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000391c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003920:	00006717          	auipc	a4,0x6
    80003924:	56073703          	ld	a4,1376(a4) # 80009e80 <_ZL10waitForAll>
    80003928:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    8000392c:	f6905ee3          	blez	s1,800038a8 <_Z29producerConsumer_CPP_Sync_APIv+0x214>
            threads[i] = new ProducerSync(data+i);
    80003930:	02800513          	li	a0,40
    80003934:	ffffe097          	auipc	ra,0xffffe
    80003938:	90c080e7          	jalr	-1780(ra) # 80001240 <_Znwm>
    8000393c:	00149793          	slli	a5,s1,0x1
    80003940:	009787b3          	add	a5,a5,s1
    80003944:	00379793          	slli	a5,a5,0x3
    80003948:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    8000394c:	00053823          	sd	zero,16(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003950:	00005717          	auipc	a4,0x5
    80003954:	d3070713          	addi	a4,a4,-720 # 80008680 <_ZTV12ProducerSync+0x10>
    80003958:	00e53023          	sd	a4,0(a0)
    8000395c:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80003960:	00349793          	slli	a5,s1,0x3
    80003964:	00f987b3          	add	a5,s3,a5
    80003968:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    8000396c:	00349793          	slli	a5,s1,0x3
    80003970:	00f987b3          	add	a5,s3,a5
    80003974:	0007b503          	ld	a0,0(a5)
        if (body == nullptr){
    80003978:	01053583          	ld	a1,16(a0)
    8000397c:	f60586e3          	beqz	a1,800038e8 <_Z29producerConsumer_CPP_Sync_APIv+0x254>
            thread_create(&myhandle, body,arg);
    80003980:	01853603          	ld	a2,24(a0)
    80003984:	00850513          	addi	a0,a0,8
    80003988:	ffffe097          	auipc	ra,0xffffe
    8000398c:	650080e7          	jalr	1616(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    80003990:	f71ff06f          	j	80003900 <_Z29producerConsumer_CPP_Sync_APIv+0x26c>
    static void dispatch() {thread_dispatch();}
    80003994:	ffffe097          	auipc	ra,0xffffe
    80003998:	67c080e7          	jalr	1660(ra) # 80002010 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    8000399c:	00000493          	li	s1,0
    800039a0:	02994063          	blt	s2,s1,800039c0 <_Z29producerConsumer_CPP_Sync_APIv+0x32c>
        return sem_wait(myHandle);
    800039a4:	00006797          	auipc	a5,0x6
    800039a8:	4dc7b783          	ld	a5,1244(a5) # 80009e80 <_ZL10waitForAll>
    800039ac:	0087b503          	ld	a0,8(a5)
    800039b0:	ffffe097          	auipc	ra,0xffffe
    800039b4:	768080e7          	jalr	1896(ra) # 80002118 <_Z8sem_waitP4_sem>
    800039b8:	0014849b          	addiw	s1,s1,1
    800039bc:	fe5ff06f          	j	800039a0 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    for (int i = 0; i < threadNum; i++) {
    800039c0:	00000493          	li	s1,0
    800039c4:	0080006f          	j	800039cc <_Z29producerConsumer_CPP_Sync_APIv+0x338>
    800039c8:	0014849b          	addiw	s1,s1,1
    800039cc:	0324d263          	bge	s1,s2,800039f0 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
        delete threads[i];
    800039d0:	00349793          	slli	a5,s1,0x3
    800039d4:	00f987b3          	add	a5,s3,a5
    800039d8:	0007b503          	ld	a0,0(a5)
    800039dc:	fe0506e3          	beqz	a0,800039c8 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    800039e0:	00053783          	ld	a5,0(a0)
    800039e4:	0087b783          	ld	a5,8(a5)
    800039e8:	000780e7          	jalr	a5
    800039ec:	fddff06f          	j	800039c8 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    delete consumerThread;
    800039f0:	000b0a63          	beqz	s6,80003a04 <_Z29producerConsumer_CPP_Sync_APIv+0x370>
    800039f4:	000b3783          	ld	a5,0(s6)
    800039f8:	0087b783          	ld	a5,8(a5)
    800039fc:	000b0513          	mv	a0,s6
    80003a00:	000780e7          	jalr	a5
    delete waitForAll;
    80003a04:	00006517          	auipc	a0,0x6
    80003a08:	47c53503          	ld	a0,1148(a0) # 80009e80 <_ZL10waitForAll>
    80003a0c:	00050863          	beqz	a0,80003a1c <_Z29producerConsumer_CPP_Sync_APIv+0x388>
    80003a10:	00053783          	ld	a5,0(a0)
    80003a14:	0087b783          	ld	a5,8(a5)
    80003a18:	000780e7          	jalr	a5
    delete buffer;
    80003a1c:	000a8e63          	beqz	s5,80003a38 <_Z29producerConsumer_CPP_Sync_APIv+0x3a4>
    80003a20:	000a8513          	mv	a0,s5
    80003a24:	fffff097          	auipc	ra,0xfffff
    80003a28:	2ac080e7          	jalr	684(ra) # 80002cd0 <_ZN9BufferCPPD1Ev>
    80003a2c:	000a8513          	mv	a0,s5
    80003a30:	ffffe097          	auipc	ra,0xffffe
    80003a34:	860080e7          	jalr	-1952(ra) # 80001290 <_ZdlPv>
    80003a38:	000b8113          	mv	sp,s7

}
    80003a3c:	f9040113          	addi	sp,s0,-112
    80003a40:	06813083          	ld	ra,104(sp)
    80003a44:	06013403          	ld	s0,96(sp)
    80003a48:	05813483          	ld	s1,88(sp)
    80003a4c:	05013903          	ld	s2,80(sp)
    80003a50:	04813983          	ld	s3,72(sp)
    80003a54:	04013a03          	ld	s4,64(sp)
    80003a58:	03813a83          	ld	s5,56(sp)
    80003a5c:	03013b03          	ld	s6,48(sp)
    80003a60:	02813b83          	ld	s7,40(sp)
    80003a64:	02013c03          	ld	s8,32(sp)
    80003a68:	07010113          	addi	sp,sp,112
    80003a6c:	00008067          	ret
    80003a70:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003a74:	000a8513          	mv	a0,s5
    80003a78:	ffffe097          	auipc	ra,0xffffe
    80003a7c:	818080e7          	jalr	-2024(ra) # 80001290 <_ZdlPv>
    80003a80:	00048513          	mv	a0,s1
    80003a84:	00007097          	auipc	ra,0x7
    80003a88:	514080e7          	jalr	1300(ra) # 8000af98 <_Unwind_Resume>
    80003a8c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003a90:	00048513          	mv	a0,s1
    80003a94:	ffffd097          	auipc	ra,0xffffd
    80003a98:	7fc080e7          	jalr	2044(ra) # 80001290 <_ZdlPv>
    80003a9c:	00090513          	mv	a0,s2
    80003aa0:	00007097          	auipc	ra,0x7
    80003aa4:	4f8080e7          	jalr	1272(ra) # 8000af98 <_Unwind_Resume>

0000000080003aa8 <_ZN6Thread3runEv>:
    virtual void run(){}
    80003aa8:	ff010113          	addi	sp,sp,-16
    80003aac:	00813423          	sd	s0,8(sp)
    80003ab0:	01010413          	addi	s0,sp,16
    80003ab4:	00813403          	ld	s0,8(sp)
    80003ab8:	01010113          	addi	sp,sp,16
    80003abc:	00008067          	ret

0000000080003ac0 <_ZN6Thread13threadWrapperEPv>:
        if (thr) thr->run();
    80003ac0:	02050863          	beqz	a0,80003af0 <_ZN6Thread13threadWrapperEPv+0x30>
    static void threadWrapper(void* p){
    80003ac4:	ff010113          	addi	sp,sp,-16
    80003ac8:	00113423          	sd	ra,8(sp)
    80003acc:	00813023          	sd	s0,0(sp)
    80003ad0:	01010413          	addi	s0,sp,16
        if (thr) thr->run();
    80003ad4:	00053783          	ld	a5,0(a0)
    80003ad8:	0107b783          	ld	a5,16(a5)
    80003adc:	000780e7          	jalr	a5
    }
    80003ae0:	00813083          	ld	ra,8(sp)
    80003ae4:	00013403          	ld	s0,0(sp)
    80003ae8:	01010113          	addi	sp,sp,16
    80003aec:	00008067          	ret
    80003af0:	00008067          	ret

0000000080003af4 <_ZN6ThreadD1Ev>:
    virtual ~Thread() { thread_exit();}
    80003af4:	ff010113          	addi	sp,sp,-16
    80003af8:	00113423          	sd	ra,8(sp)
    80003afc:	00813023          	sd	s0,0(sp)
    80003b00:	01010413          	addi	s0,sp,16
    80003b04:	00005797          	auipc	a5,0x5
    80003b08:	b2c78793          	addi	a5,a5,-1236 # 80008630 <_ZTV6Thread+0x10>
    80003b0c:	00f53023          	sd	a5,0(a0)
    80003b10:	ffffe097          	auipc	ra,0xffffe
    80003b14:	524080e7          	jalr	1316(ra) # 80002034 <_Z11thread_exitv>
    80003b18:	00813083          	ld	ra,8(sp)
    80003b1c:	00013403          	ld	s0,0(sp)
    80003b20:	01010113          	addi	sp,sp,16
    80003b24:	00008067          	ret

0000000080003b28 <_ZN6ThreadD0Ev>:
    80003b28:	fe010113          	addi	sp,sp,-32
    80003b2c:	00113c23          	sd	ra,24(sp)
    80003b30:	00813823          	sd	s0,16(sp)
    80003b34:	00913423          	sd	s1,8(sp)
    80003b38:	02010413          	addi	s0,sp,32
    80003b3c:	00050493          	mv	s1,a0
    80003b40:	00005797          	auipc	a5,0x5
    80003b44:	af078793          	addi	a5,a5,-1296 # 80008630 <_ZTV6Thread+0x10>
    80003b48:	00f53023          	sd	a5,0(a0)
    80003b4c:	ffffe097          	auipc	ra,0xffffe
    80003b50:	4e8080e7          	jalr	1256(ra) # 80002034 <_Z11thread_exitv>
    80003b54:	00048513          	mv	a0,s1
    80003b58:	ffffd097          	auipc	ra,0xffffd
    80003b5c:	738080e7          	jalr	1848(ra) # 80001290 <_ZdlPv>
    80003b60:	01813083          	ld	ra,24(sp)
    80003b64:	01013403          	ld	s0,16(sp)
    80003b68:	00813483          	ld	s1,8(sp)
    80003b6c:	02010113          	addi	sp,sp,32
    80003b70:	00008067          	ret

0000000080003b74 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003b74:	ff010113          	addi	sp,sp,-16
    80003b78:	00113423          	sd	ra,8(sp)
    80003b7c:	00813023          	sd	s0,0(sp)
    80003b80:	01010413          	addi	s0,sp,16
    80003b84:	00005797          	auipc	a5,0x5
    80003b88:	aac78793          	addi	a5,a5,-1364 # 80008630 <_ZTV6Thread+0x10>
    80003b8c:	00f53023          	sd	a5,0(a0)
    80003b90:	ffffe097          	auipc	ra,0xffffe
    80003b94:	4a4080e7          	jalr	1188(ra) # 80002034 <_Z11thread_exitv>
    80003b98:	00813083          	ld	ra,8(sp)
    80003b9c:	00013403          	ld	s0,0(sp)
    80003ba0:	01010113          	addi	sp,sp,16
    80003ba4:	00008067          	ret

0000000080003ba8 <_ZN12ConsumerSyncD0Ev>:
    80003ba8:	fe010113          	addi	sp,sp,-32
    80003bac:	00113c23          	sd	ra,24(sp)
    80003bb0:	00813823          	sd	s0,16(sp)
    80003bb4:	00913423          	sd	s1,8(sp)
    80003bb8:	02010413          	addi	s0,sp,32
    80003bbc:	00050493          	mv	s1,a0
    80003bc0:	00005797          	auipc	a5,0x5
    80003bc4:	a7078793          	addi	a5,a5,-1424 # 80008630 <_ZTV6Thread+0x10>
    80003bc8:	00f53023          	sd	a5,0(a0)
    80003bcc:	ffffe097          	auipc	ra,0xffffe
    80003bd0:	468080e7          	jalr	1128(ra) # 80002034 <_Z11thread_exitv>
    80003bd4:	00048513          	mv	a0,s1
    80003bd8:	ffffd097          	auipc	ra,0xffffd
    80003bdc:	6b8080e7          	jalr	1720(ra) # 80001290 <_ZdlPv>
    80003be0:	01813083          	ld	ra,24(sp)
    80003be4:	01013403          	ld	s0,16(sp)
    80003be8:	00813483          	ld	s1,8(sp)
    80003bec:	02010113          	addi	sp,sp,32
    80003bf0:	00008067          	ret

0000000080003bf4 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003bf4:	ff010113          	addi	sp,sp,-16
    80003bf8:	00113423          	sd	ra,8(sp)
    80003bfc:	00813023          	sd	s0,0(sp)
    80003c00:	01010413          	addi	s0,sp,16
    80003c04:	00005797          	auipc	a5,0x5
    80003c08:	a2c78793          	addi	a5,a5,-1492 # 80008630 <_ZTV6Thread+0x10>
    80003c0c:	00f53023          	sd	a5,0(a0)
    80003c10:	ffffe097          	auipc	ra,0xffffe
    80003c14:	424080e7          	jalr	1060(ra) # 80002034 <_Z11thread_exitv>
    80003c18:	00813083          	ld	ra,8(sp)
    80003c1c:	00013403          	ld	s0,0(sp)
    80003c20:	01010113          	addi	sp,sp,16
    80003c24:	00008067          	ret

0000000080003c28 <_ZN12ProducerSyncD0Ev>:
    80003c28:	fe010113          	addi	sp,sp,-32
    80003c2c:	00113c23          	sd	ra,24(sp)
    80003c30:	00813823          	sd	s0,16(sp)
    80003c34:	00913423          	sd	s1,8(sp)
    80003c38:	02010413          	addi	s0,sp,32
    80003c3c:	00050493          	mv	s1,a0
    80003c40:	00005797          	auipc	a5,0x5
    80003c44:	9f078793          	addi	a5,a5,-1552 # 80008630 <_ZTV6Thread+0x10>
    80003c48:	00f53023          	sd	a5,0(a0)
    80003c4c:	ffffe097          	auipc	ra,0xffffe
    80003c50:	3e8080e7          	jalr	1000(ra) # 80002034 <_Z11thread_exitv>
    80003c54:	00048513          	mv	a0,s1
    80003c58:	ffffd097          	auipc	ra,0xffffd
    80003c5c:	638080e7          	jalr	1592(ra) # 80001290 <_ZdlPv>
    80003c60:	01813083          	ld	ra,24(sp)
    80003c64:	01013403          	ld	s0,16(sp)
    80003c68:	00813483          	ld	s1,8(sp)
    80003c6c:	02010113          	addi	sp,sp,32
    80003c70:	00008067          	ret

0000000080003c74 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003c74:	ff010113          	addi	sp,sp,-16
    80003c78:	00113423          	sd	ra,8(sp)
    80003c7c:	00813023          	sd	s0,0(sp)
    80003c80:	01010413          	addi	s0,sp,16
    80003c84:	00005797          	auipc	a5,0x5
    80003c88:	9ac78793          	addi	a5,a5,-1620 # 80008630 <_ZTV6Thread+0x10>
    80003c8c:	00f53023          	sd	a5,0(a0)
    80003c90:	ffffe097          	auipc	ra,0xffffe
    80003c94:	3a4080e7          	jalr	932(ra) # 80002034 <_Z11thread_exitv>
    80003c98:	00813083          	ld	ra,8(sp)
    80003c9c:	00013403          	ld	s0,0(sp)
    80003ca0:	01010113          	addi	sp,sp,16
    80003ca4:	00008067          	ret

0000000080003ca8 <_ZN16ProducerKeyboardD0Ev>:
    80003ca8:	fe010113          	addi	sp,sp,-32
    80003cac:	00113c23          	sd	ra,24(sp)
    80003cb0:	00813823          	sd	s0,16(sp)
    80003cb4:	00913423          	sd	s1,8(sp)
    80003cb8:	02010413          	addi	s0,sp,32
    80003cbc:	00050493          	mv	s1,a0
    80003cc0:	00005797          	auipc	a5,0x5
    80003cc4:	97078793          	addi	a5,a5,-1680 # 80008630 <_ZTV6Thread+0x10>
    80003cc8:	00f53023          	sd	a5,0(a0)
    80003ccc:	ffffe097          	auipc	ra,0xffffe
    80003cd0:	368080e7          	jalr	872(ra) # 80002034 <_Z11thread_exitv>
    80003cd4:	00048513          	mv	a0,s1
    80003cd8:	ffffd097          	auipc	ra,0xffffd
    80003cdc:	5b8080e7          	jalr	1464(ra) # 80001290 <_ZdlPv>
    80003ce0:	01813083          	ld	ra,24(sp)
    80003ce4:	01013403          	ld	s0,16(sp)
    80003ce8:	00813483          	ld	s1,8(sp)
    80003cec:	02010113          	addi	sp,sp,32
    80003cf0:	00008067          	ret

0000000080003cf4 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003cf4:	ff010113          	addi	sp,sp,-16
    80003cf8:	00113423          	sd	ra,8(sp)
    80003cfc:	00813023          	sd	s0,0(sp)
    80003d00:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003d04:	02053583          	ld	a1,32(a0)
    80003d08:	fffff097          	auipc	ra,0xfffff
    80003d0c:	738080e7          	jalr	1848(ra) # 80003440 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003d10:	00813083          	ld	ra,8(sp)
    80003d14:	00013403          	ld	s0,0(sp)
    80003d18:	01010113          	addi	sp,sp,16
    80003d1c:	00008067          	ret

0000000080003d20 <_ZN12ProducerSync3runEv>:
    void run() override {
    80003d20:	ff010113          	addi	sp,sp,-16
    80003d24:	00113423          	sd	ra,8(sp)
    80003d28:	00813023          	sd	s0,0(sp)
    80003d2c:	01010413          	addi	s0,sp,16
        producer(td);
    80003d30:	02053583          	ld	a1,32(a0)
    80003d34:	fffff097          	auipc	ra,0xfffff
    80003d38:	7d0080e7          	jalr	2000(ra) # 80003504 <_ZN12ProducerSync8producerEPv>
    }
    80003d3c:	00813083          	ld	ra,8(sp)
    80003d40:	00013403          	ld	s0,0(sp)
    80003d44:	01010113          	addi	sp,sp,16
    80003d48:	00008067          	ret

0000000080003d4c <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003d4c:	ff010113          	addi	sp,sp,-16
    80003d50:	00113423          	sd	ra,8(sp)
    80003d54:	00813023          	sd	s0,0(sp)
    80003d58:	01010413          	addi	s0,sp,16
        consumer(td);
    80003d5c:	02053583          	ld	a1,32(a0)
    80003d60:	00000097          	auipc	ra,0x0
    80003d64:	83c080e7          	jalr	-1988(ra) # 8000359c <_ZN12ConsumerSync8consumerEPv>
    }
    80003d68:	00813083          	ld	ra,8(sp)
    80003d6c:	00013403          	ld	s0,0(sp)
    80003d70:	01010113          	addi	sp,sp,16
    80003d74:	00008067          	ret

0000000080003d78 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003d78:	fe010113          	addi	sp,sp,-32
    80003d7c:	00113c23          	sd	ra,24(sp)
    80003d80:	00813823          	sd	s0,16(sp)
    80003d84:	00913423          	sd	s1,8(sp)
    80003d88:	01213023          	sd	s2,0(sp)
    80003d8c:	02010413          	addi	s0,sp,32
    80003d90:	00050493          	mv	s1,a0
    80003d94:	00058913          	mv	s2,a1
    80003d98:	0015879b          	addiw	a5,a1,1
    80003d9c:	0007851b          	sext.w	a0,a5
    80003da0:	00f4a023          	sw	a5,0(s1)
    80003da4:	0004a823          	sw	zero,16(s1)
    80003da8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)MemoryAllocator::mem_alloc(sizeof(int) * cap);
    80003dac:	00251513          	slli	a0,a0,0x2
    80003db0:	ffffd097          	auipc	ra,0xffffd
    80003db4:	6d4080e7          	jalr	1748(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
    80003db8:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80003dbc:	00000593          	li	a1,0
    80003dc0:	02048513          	addi	a0,s1,32
    80003dc4:	ffffe097          	auipc	ra,0xffffe
    80003dc8:	2f0080e7          	jalr	752(ra) # 800020b4 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80003dcc:	00090593          	mv	a1,s2
    80003dd0:	01848513          	addi	a0,s1,24
    80003dd4:	ffffe097          	auipc	ra,0xffffe
    80003dd8:	2e0080e7          	jalr	736(ra) # 800020b4 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80003ddc:	00100593          	li	a1,1
    80003de0:	02848513          	addi	a0,s1,40
    80003de4:	ffffe097          	auipc	ra,0xffffe
    80003de8:	2d0080e7          	jalr	720(ra) # 800020b4 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80003dec:	00100593          	li	a1,1
    80003df0:	03048513          	addi	a0,s1,48
    80003df4:	ffffe097          	auipc	ra,0xffffe
    80003df8:	2c0080e7          	jalr	704(ra) # 800020b4 <_Z8sem_openPP4_semj>
}
    80003dfc:	01813083          	ld	ra,24(sp)
    80003e00:	01013403          	ld	s0,16(sp)
    80003e04:	00813483          	ld	s1,8(sp)
    80003e08:	00013903          	ld	s2,0(sp)
    80003e0c:	02010113          	addi	sp,sp,32
    80003e10:	00008067          	ret

0000000080003e14 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80003e14:	fe010113          	addi	sp,sp,-32
    80003e18:	00113c23          	sd	ra,24(sp)
    80003e1c:	00813823          	sd	s0,16(sp)
    80003e20:	00913423          	sd	s1,8(sp)
    80003e24:	01213023          	sd	s2,0(sp)
    80003e28:	02010413          	addi	s0,sp,32
    80003e2c:	00050493          	mv	s1,a0
    80003e30:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003e34:	01853503          	ld	a0,24(a0)
    80003e38:	ffffe097          	auipc	ra,0xffffe
    80003e3c:	2e0080e7          	jalr	736(ra) # 80002118 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80003e40:	0304b503          	ld	a0,48(s1)
    80003e44:	ffffe097          	auipc	ra,0xffffe
    80003e48:	2d4080e7          	jalr	724(ra) # 80002118 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80003e4c:	0084b783          	ld	a5,8(s1)
    80003e50:	0144a703          	lw	a4,20(s1)
    80003e54:	00271713          	slli	a4,a4,0x2
    80003e58:	00e787b3          	add	a5,a5,a4
    80003e5c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003e60:	0144a783          	lw	a5,20(s1)
    80003e64:	0017879b          	addiw	a5,a5,1
    80003e68:	0004a703          	lw	a4,0(s1)
    80003e6c:	02e7e7bb          	remw	a5,a5,a4
    80003e70:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003e74:	0304b503          	ld	a0,48(s1)
    80003e78:	ffffe097          	auipc	ra,0xffffe
    80003e7c:	2d0080e7          	jalr	720(ra) # 80002148 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80003e80:	0204b503          	ld	a0,32(s1)
    80003e84:	ffffe097          	auipc	ra,0xffffe
    80003e88:	2c4080e7          	jalr	708(ra) # 80002148 <_Z10sem_signalP4_sem>

}
    80003e8c:	01813083          	ld	ra,24(sp)
    80003e90:	01013403          	ld	s0,16(sp)
    80003e94:	00813483          	ld	s1,8(sp)
    80003e98:	00013903          	ld	s2,0(sp)
    80003e9c:	02010113          	addi	sp,sp,32
    80003ea0:	00008067          	ret

0000000080003ea4 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003ea4:	fe010113          	addi	sp,sp,-32
    80003ea8:	00113c23          	sd	ra,24(sp)
    80003eac:	00813823          	sd	s0,16(sp)
    80003eb0:	00913423          	sd	s1,8(sp)
    80003eb4:	01213023          	sd	s2,0(sp)
    80003eb8:	02010413          	addi	s0,sp,32
    80003ebc:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003ec0:	02053503          	ld	a0,32(a0)
    80003ec4:	ffffe097          	auipc	ra,0xffffe
    80003ec8:	254080e7          	jalr	596(ra) # 80002118 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80003ecc:	0284b503          	ld	a0,40(s1)
    80003ed0:	ffffe097          	auipc	ra,0xffffe
    80003ed4:	248080e7          	jalr	584(ra) # 80002118 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80003ed8:	0084b703          	ld	a4,8(s1)
    80003edc:	0104a783          	lw	a5,16(s1)
    80003ee0:	00279693          	slli	a3,a5,0x2
    80003ee4:	00d70733          	add	a4,a4,a3
    80003ee8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003eec:	0017879b          	addiw	a5,a5,1
    80003ef0:	0004a703          	lw	a4,0(s1)
    80003ef4:	02e7e7bb          	remw	a5,a5,a4
    80003ef8:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003efc:	0284b503          	ld	a0,40(s1)
    80003f00:	ffffe097          	auipc	ra,0xffffe
    80003f04:	248080e7          	jalr	584(ra) # 80002148 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80003f08:	0184b503          	ld	a0,24(s1)
    80003f0c:	ffffe097          	auipc	ra,0xffffe
    80003f10:	23c080e7          	jalr	572(ra) # 80002148 <_Z10sem_signalP4_sem>

    return ret;
}
    80003f14:	00090513          	mv	a0,s2
    80003f18:	01813083          	ld	ra,24(sp)
    80003f1c:	01013403          	ld	s0,16(sp)
    80003f20:	00813483          	ld	s1,8(sp)
    80003f24:	00013903          	ld	s2,0(sp)
    80003f28:	02010113          	addi	sp,sp,32
    80003f2c:	00008067          	ret

0000000080003f30 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003f30:	fe010113          	addi	sp,sp,-32
    80003f34:	00113c23          	sd	ra,24(sp)
    80003f38:	00813823          	sd	s0,16(sp)
    80003f3c:	00913423          	sd	s1,8(sp)
    80003f40:	01213023          	sd	s2,0(sp)
    80003f44:	02010413          	addi	s0,sp,32
    80003f48:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80003f4c:	02853503          	ld	a0,40(a0)
    80003f50:	ffffe097          	auipc	ra,0xffffe
    80003f54:	1c8080e7          	jalr	456(ra) # 80002118 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80003f58:	0304b503          	ld	a0,48(s1)
    80003f5c:	ffffe097          	auipc	ra,0xffffe
    80003f60:	1bc080e7          	jalr	444(ra) # 80002118 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80003f64:	0144a783          	lw	a5,20(s1)
    80003f68:	0104a903          	lw	s2,16(s1)
    80003f6c:	0327ce63          	blt	a5,s2,80003fa8 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80003f70:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80003f74:	0304b503          	ld	a0,48(s1)
    80003f78:	ffffe097          	auipc	ra,0xffffe
    80003f7c:	1d0080e7          	jalr	464(ra) # 80002148 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80003f80:	0284b503          	ld	a0,40(s1)
    80003f84:	ffffe097          	auipc	ra,0xffffe
    80003f88:	1c4080e7          	jalr	452(ra) # 80002148 <_Z10sem_signalP4_sem>

    return ret;
}
    80003f8c:	00090513          	mv	a0,s2
    80003f90:	01813083          	ld	ra,24(sp)
    80003f94:	01013403          	ld	s0,16(sp)
    80003f98:	00813483          	ld	s1,8(sp)
    80003f9c:	00013903          	ld	s2,0(sp)
    80003fa0:	02010113          	addi	sp,sp,32
    80003fa4:	00008067          	ret
        ret = cap - head + tail;
    80003fa8:	0004a703          	lw	a4,0(s1)
    80003fac:	4127093b          	subw	s2,a4,s2
    80003fb0:	00f9093b          	addw	s2,s2,a5
    80003fb4:	fc1ff06f          	j	80003f74 <_ZN6Buffer6getCntEv+0x44>

0000000080003fb8 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003fb8:	fe010113          	addi	sp,sp,-32
    80003fbc:	00113c23          	sd	ra,24(sp)
    80003fc0:	00813823          	sd	s0,16(sp)
    80003fc4:	00913423          	sd	s1,8(sp)
    80003fc8:	02010413          	addi	s0,sp,32
    80003fcc:	00050493          	mv	s1,a0
    putc('\n');
    80003fd0:	00a00513          	li	a0,10
    80003fd4:	ffffe097          	auipc	ra,0xffffe
    80003fd8:	0b8080e7          	jalr	184(ra) # 8000208c <_Z4putcc>
    printString("Buffer deleted!\n");
    80003fdc:	00004517          	auipc	a0,0x4
    80003fe0:	50450513          	addi	a0,a0,1284 # 800084e0 <CONSOLE_STATUS+0x4d0>
    80003fe4:	ffffe097          	auipc	ra,0xffffe
    80003fe8:	6b4080e7          	jalr	1716(ra) # 80002698 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003fec:	00048513          	mv	a0,s1
    80003ff0:	00000097          	auipc	ra,0x0
    80003ff4:	f40080e7          	jalr	-192(ra) # 80003f30 <_ZN6Buffer6getCntEv>
    80003ff8:	02a05c63          	blez	a0,80004030 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003ffc:	0084b783          	ld	a5,8(s1)
    80004000:	0104a703          	lw	a4,16(s1)
    80004004:	00271713          	slli	a4,a4,0x2
    80004008:	00e787b3          	add	a5,a5,a4
        putc(ch);
    8000400c:	0007c503          	lbu	a0,0(a5)
    80004010:	ffffe097          	auipc	ra,0xffffe
    80004014:	07c080e7          	jalr	124(ra) # 8000208c <_Z4putcc>
        head = (head + 1) % cap;
    80004018:	0104a783          	lw	a5,16(s1)
    8000401c:	0017879b          	addiw	a5,a5,1
    80004020:	0004a703          	lw	a4,0(s1)
    80004024:	02e7e7bb          	remw	a5,a5,a4
    80004028:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    8000402c:	fc1ff06f          	j	80003fec <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004030:	02100513          	li	a0,33
    80004034:	ffffe097          	auipc	ra,0xffffe
    80004038:	058080e7          	jalr	88(ra) # 8000208c <_Z4putcc>
    putc('\n');
    8000403c:	00a00513          	li	a0,10
    80004040:	ffffe097          	auipc	ra,0xffffe
    80004044:	04c080e7          	jalr	76(ra) # 8000208c <_Z4putcc>
    MemoryAllocator::mem_free(buffer);
    80004048:	0084b503          	ld	a0,8(s1)
    8000404c:	ffffd097          	auipc	ra,0xffffd
    80004050:	50c080e7          	jalr	1292(ra) # 80001558 <_ZN15MemoryAllocator8mem_freeEPv>
    sem_close(itemAvailable);
    80004054:	0204b503          	ld	a0,32(s1)
    80004058:	ffffe097          	auipc	ra,0xffffe
    8000405c:	090080e7          	jalr	144(ra) # 800020e8 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80004060:	0184b503          	ld	a0,24(s1)
    80004064:	ffffe097          	auipc	ra,0xffffe
    80004068:	084080e7          	jalr	132(ra) # 800020e8 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    8000406c:	0304b503          	ld	a0,48(s1)
    80004070:	ffffe097          	auipc	ra,0xffffe
    80004074:	078080e7          	jalr	120(ra) # 800020e8 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80004078:	0284b503          	ld	a0,40(s1)
    8000407c:	ffffe097          	auipc	ra,0xffffe
    80004080:	06c080e7          	jalr	108(ra) # 800020e8 <_Z9sem_closeP4_sem>
}
    80004084:	01813083          	ld	ra,24(sp)
    80004088:	01013403          	ld	s0,16(sp)
    8000408c:	00813483          	ld	s1,8(sp)
    80004090:	02010113          	addi	sp,sp,32
    80004094:	00008067          	ret

0000000080004098 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004098:	fe010113          	addi	sp,sp,-32
    8000409c:	00113c23          	sd	ra,24(sp)
    800040a0:	00813823          	sd	s0,16(sp)
    800040a4:	00913423          	sd	s1,8(sp)
    800040a8:	01213023          	sd	s2,0(sp)
    800040ac:	02010413          	addi	s0,sp,32
    800040b0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800040b4:	00100793          	li	a5,1
    800040b8:	02a7f863          	bgeu	a5,a0,800040e8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800040bc:	00a00793          	li	a5,10
    800040c0:	02f577b3          	remu	a5,a0,a5
    800040c4:	02078e63          	beqz	a5,80004100 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800040c8:	fff48513          	addi	a0,s1,-1
    800040cc:	00000097          	auipc	ra,0x0
    800040d0:	fcc080e7          	jalr	-52(ra) # 80004098 <_ZL9fibonaccim>
    800040d4:	00050913          	mv	s2,a0
    800040d8:	ffe48513          	addi	a0,s1,-2
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	fbc080e7          	jalr	-68(ra) # 80004098 <_ZL9fibonaccim>
    800040e4:	00a90533          	add	a0,s2,a0
}
    800040e8:	01813083          	ld	ra,24(sp)
    800040ec:	01013403          	ld	s0,16(sp)
    800040f0:	00813483          	ld	s1,8(sp)
    800040f4:	00013903          	ld	s2,0(sp)
    800040f8:	02010113          	addi	sp,sp,32
    800040fc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004100:	ffffe097          	auipc	ra,0xffffe
    80004104:	f10080e7          	jalr	-240(ra) # 80002010 <_Z15thread_dispatchv>
    80004108:	fc1ff06f          	j	800040c8 <_ZL9fibonaccim+0x30>

000000008000410c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000410c:	fe010113          	addi	sp,sp,-32
    80004110:	00113c23          	sd	ra,24(sp)
    80004114:	00813823          	sd	s0,16(sp)
    80004118:	00913423          	sd	s1,8(sp)
    8000411c:	01213023          	sd	s2,0(sp)
    80004120:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004124:	00a00493          	li	s1,10
    80004128:	0400006f          	j	80004168 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000412c:	00004517          	auipc	a0,0x4
    80004130:	3ec50513          	addi	a0,a0,1004 # 80008518 <_ZTV9Semaphore+0x20>
    80004134:	ffffe097          	auipc	ra,0xffffe
    80004138:	564080e7          	jalr	1380(ra) # 80002698 <_Z11printStringPKc>
    8000413c:	00000613          	li	a2,0
    80004140:	00a00593          	li	a1,10
    80004144:	00048513          	mv	a0,s1
    80004148:	ffffe097          	auipc	ra,0xffffe
    8000414c:	700080e7          	jalr	1792(ra) # 80002848 <_Z8printIntiii>
    80004150:	00004517          	auipc	a0,0x4
    80004154:	1e050513          	addi	a0,a0,480 # 80008330 <CONSOLE_STATUS+0x320>
    80004158:	ffffe097          	auipc	ra,0xffffe
    8000415c:	540080e7          	jalr	1344(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004160:	0014849b          	addiw	s1,s1,1
    80004164:	0ff4f493          	andi	s1,s1,255
    80004168:	00c00793          	li	a5,12
    8000416c:	fc97f0e3          	bgeu	a5,s1,8000412c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004170:	00004517          	auipc	a0,0x4
    80004174:	3b050513          	addi	a0,a0,944 # 80008520 <_ZTV9Semaphore+0x28>
    80004178:	ffffe097          	auipc	ra,0xffffe
    8000417c:	520080e7          	jalr	1312(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004180:	00500313          	li	t1,5
    thread_dispatch();
    80004184:	ffffe097          	auipc	ra,0xffffe
    80004188:	e8c080e7          	jalr	-372(ra) # 80002010 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000418c:	01000513          	li	a0,16
    80004190:	00000097          	auipc	ra,0x0
    80004194:	f08080e7          	jalr	-248(ra) # 80004098 <_ZL9fibonaccim>
    80004198:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000419c:	00004517          	auipc	a0,0x4
    800041a0:	39450513          	addi	a0,a0,916 # 80008530 <_ZTV9Semaphore+0x38>
    800041a4:	ffffe097          	auipc	ra,0xffffe
    800041a8:	4f4080e7          	jalr	1268(ra) # 80002698 <_Z11printStringPKc>
    800041ac:	00000613          	li	a2,0
    800041b0:	00a00593          	li	a1,10
    800041b4:	0009051b          	sext.w	a0,s2
    800041b8:	ffffe097          	auipc	ra,0xffffe
    800041bc:	690080e7          	jalr	1680(ra) # 80002848 <_Z8printIntiii>
    800041c0:	00004517          	auipc	a0,0x4
    800041c4:	17050513          	addi	a0,a0,368 # 80008330 <CONSOLE_STATUS+0x320>
    800041c8:	ffffe097          	auipc	ra,0xffffe
    800041cc:	4d0080e7          	jalr	1232(ra) # 80002698 <_Z11printStringPKc>
    800041d0:	0400006f          	j	80004210 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800041d4:	00004517          	auipc	a0,0x4
    800041d8:	34450513          	addi	a0,a0,836 # 80008518 <_ZTV9Semaphore+0x20>
    800041dc:	ffffe097          	auipc	ra,0xffffe
    800041e0:	4bc080e7          	jalr	1212(ra) # 80002698 <_Z11printStringPKc>
    800041e4:	00000613          	li	a2,0
    800041e8:	00a00593          	li	a1,10
    800041ec:	00048513          	mv	a0,s1
    800041f0:	ffffe097          	auipc	ra,0xffffe
    800041f4:	658080e7          	jalr	1624(ra) # 80002848 <_Z8printIntiii>
    800041f8:	00004517          	auipc	a0,0x4
    800041fc:	13850513          	addi	a0,a0,312 # 80008330 <CONSOLE_STATUS+0x320>
    80004200:	ffffe097          	auipc	ra,0xffffe
    80004204:	498080e7          	jalr	1176(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004208:	0014849b          	addiw	s1,s1,1
    8000420c:	0ff4f493          	andi	s1,s1,255
    80004210:	00f00793          	li	a5,15
    80004214:	fc97f0e3          	bgeu	a5,s1,800041d4 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004218:	00004517          	auipc	a0,0x4
    8000421c:	32850513          	addi	a0,a0,808 # 80008540 <_ZTV9Semaphore+0x48>
    80004220:	ffffe097          	auipc	ra,0xffffe
    80004224:	478080e7          	jalr	1144(ra) # 80002698 <_Z11printStringPKc>
    finishedD = true;
    80004228:	00100793          	li	a5,1
    8000422c:	00006717          	auipc	a4,0x6
    80004230:	c4f70e23          	sb	a5,-932(a4) # 80009e88 <_ZL9finishedD>
    thread_dispatch();
    80004234:	ffffe097          	auipc	ra,0xffffe
    80004238:	ddc080e7          	jalr	-548(ra) # 80002010 <_Z15thread_dispatchv>
}
    8000423c:	01813083          	ld	ra,24(sp)
    80004240:	01013403          	ld	s0,16(sp)
    80004244:	00813483          	ld	s1,8(sp)
    80004248:	00013903          	ld	s2,0(sp)
    8000424c:	02010113          	addi	sp,sp,32
    80004250:	00008067          	ret

0000000080004254 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004254:	fe010113          	addi	sp,sp,-32
    80004258:	00113c23          	sd	ra,24(sp)
    8000425c:	00813823          	sd	s0,16(sp)
    80004260:	00913423          	sd	s1,8(sp)
    80004264:	01213023          	sd	s2,0(sp)
    80004268:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000426c:	00000493          	li	s1,0
    80004270:	0400006f          	j	800042b0 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004274:	00004517          	auipc	a0,0x4
    80004278:	2dc50513          	addi	a0,a0,732 # 80008550 <_ZTV9Semaphore+0x58>
    8000427c:	ffffe097          	auipc	ra,0xffffe
    80004280:	41c080e7          	jalr	1052(ra) # 80002698 <_Z11printStringPKc>
    80004284:	00000613          	li	a2,0
    80004288:	00a00593          	li	a1,10
    8000428c:	00048513          	mv	a0,s1
    80004290:	ffffe097          	auipc	ra,0xffffe
    80004294:	5b8080e7          	jalr	1464(ra) # 80002848 <_Z8printIntiii>
    80004298:	00004517          	auipc	a0,0x4
    8000429c:	09850513          	addi	a0,a0,152 # 80008330 <CONSOLE_STATUS+0x320>
    800042a0:	ffffe097          	auipc	ra,0xffffe
    800042a4:	3f8080e7          	jalr	1016(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800042a8:	0014849b          	addiw	s1,s1,1
    800042ac:	0ff4f493          	andi	s1,s1,255
    800042b0:	00200793          	li	a5,2
    800042b4:	fc97f0e3          	bgeu	a5,s1,80004274 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800042b8:	00004517          	auipc	a0,0x4
    800042bc:	2a050513          	addi	a0,a0,672 # 80008558 <_ZTV9Semaphore+0x60>
    800042c0:	ffffe097          	auipc	ra,0xffffe
    800042c4:	3d8080e7          	jalr	984(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800042c8:	00700313          	li	t1,7
    thread_dispatch();
    800042cc:	ffffe097          	auipc	ra,0xffffe
    800042d0:	d44080e7          	jalr	-700(ra) # 80002010 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800042d4:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800042d8:	00004517          	auipc	a0,0x4
    800042dc:	29050513          	addi	a0,a0,656 # 80008568 <_ZTV9Semaphore+0x70>
    800042e0:	ffffe097          	auipc	ra,0xffffe
    800042e4:	3b8080e7          	jalr	952(ra) # 80002698 <_Z11printStringPKc>
    800042e8:	00000613          	li	a2,0
    800042ec:	00a00593          	li	a1,10
    800042f0:	0009051b          	sext.w	a0,s2
    800042f4:	ffffe097          	auipc	ra,0xffffe
    800042f8:	554080e7          	jalr	1364(ra) # 80002848 <_Z8printIntiii>
    800042fc:	00004517          	auipc	a0,0x4
    80004300:	03450513          	addi	a0,a0,52 # 80008330 <CONSOLE_STATUS+0x320>
    80004304:	ffffe097          	auipc	ra,0xffffe
    80004308:	394080e7          	jalr	916(ra) # 80002698 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000430c:	00c00513          	li	a0,12
    80004310:	00000097          	auipc	ra,0x0
    80004314:	d88080e7          	jalr	-632(ra) # 80004098 <_ZL9fibonaccim>
    80004318:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000431c:	00004517          	auipc	a0,0x4
    80004320:	25450513          	addi	a0,a0,596 # 80008570 <_ZTV9Semaphore+0x78>
    80004324:	ffffe097          	auipc	ra,0xffffe
    80004328:	374080e7          	jalr	884(ra) # 80002698 <_Z11printStringPKc>
    8000432c:	00000613          	li	a2,0
    80004330:	00a00593          	li	a1,10
    80004334:	0009051b          	sext.w	a0,s2
    80004338:	ffffe097          	auipc	ra,0xffffe
    8000433c:	510080e7          	jalr	1296(ra) # 80002848 <_Z8printIntiii>
    80004340:	00004517          	auipc	a0,0x4
    80004344:	ff050513          	addi	a0,a0,-16 # 80008330 <CONSOLE_STATUS+0x320>
    80004348:	ffffe097          	auipc	ra,0xffffe
    8000434c:	350080e7          	jalr	848(ra) # 80002698 <_Z11printStringPKc>
    80004350:	0400006f          	j	80004390 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004354:	00004517          	auipc	a0,0x4
    80004358:	1fc50513          	addi	a0,a0,508 # 80008550 <_ZTV9Semaphore+0x58>
    8000435c:	ffffe097          	auipc	ra,0xffffe
    80004360:	33c080e7          	jalr	828(ra) # 80002698 <_Z11printStringPKc>
    80004364:	00000613          	li	a2,0
    80004368:	00a00593          	li	a1,10
    8000436c:	00048513          	mv	a0,s1
    80004370:	ffffe097          	auipc	ra,0xffffe
    80004374:	4d8080e7          	jalr	1240(ra) # 80002848 <_Z8printIntiii>
    80004378:	00004517          	auipc	a0,0x4
    8000437c:	fb850513          	addi	a0,a0,-72 # 80008330 <CONSOLE_STATUS+0x320>
    80004380:	ffffe097          	auipc	ra,0xffffe
    80004384:	318080e7          	jalr	792(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004388:	0014849b          	addiw	s1,s1,1
    8000438c:	0ff4f493          	andi	s1,s1,255
    80004390:	00500793          	li	a5,5
    80004394:	fc97f0e3          	bgeu	a5,s1,80004354 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004398:	00004517          	auipc	a0,0x4
    8000439c:	21850513          	addi	a0,a0,536 # 800085b0 <_ZTV9Semaphore+0xb8>
    800043a0:	ffffe097          	auipc	ra,0xffffe
    800043a4:	2f8080e7          	jalr	760(ra) # 80002698 <_Z11printStringPKc>
    finishedC = true;
    800043a8:	00100793          	li	a5,1
    800043ac:	00006717          	auipc	a4,0x6
    800043b0:	acf70ea3          	sb	a5,-1315(a4) # 80009e89 <_ZL9finishedC>
    thread_dispatch();
    800043b4:	ffffe097          	auipc	ra,0xffffe
    800043b8:	c5c080e7          	jalr	-932(ra) # 80002010 <_Z15thread_dispatchv>
}
    800043bc:	01813083          	ld	ra,24(sp)
    800043c0:	01013403          	ld	s0,16(sp)
    800043c4:	00813483          	ld	s1,8(sp)
    800043c8:	00013903          	ld	s2,0(sp)
    800043cc:	02010113          	addi	sp,sp,32
    800043d0:	00008067          	ret

00000000800043d4 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800043d4:	fe010113          	addi	sp,sp,-32
    800043d8:	00113c23          	sd	ra,24(sp)
    800043dc:	00813823          	sd	s0,16(sp)
    800043e0:	00913423          	sd	s1,8(sp)
    800043e4:	01213023          	sd	s2,0(sp)
    800043e8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800043ec:	00000913          	li	s2,0
    800043f0:	0380006f          	j	80004428 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    800043f4:	ffffe097          	auipc	ra,0xffffe
    800043f8:	c1c080e7          	jalr	-996(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800043fc:	00148493          	addi	s1,s1,1
    80004400:	000027b7          	lui	a5,0x2
    80004404:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004408:	0097ee63          	bltu	a5,s1,80004424 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000440c:	00000713          	li	a4,0
    80004410:	000077b7          	lui	a5,0x7
    80004414:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004418:	fce7eee3          	bltu	a5,a4,800043f4 <_ZL11workerBodyBPv+0x20>
    8000441c:	00170713          	addi	a4,a4,1
    80004420:	ff1ff06f          	j	80004410 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004424:	00190913          	addi	s2,s2,1
    80004428:	00f00793          	li	a5,15
    8000442c:	0527e063          	bltu	a5,s2,8000446c <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004430:	00004517          	auipc	a0,0x4
    80004434:	16050513          	addi	a0,a0,352 # 80008590 <_ZTV9Semaphore+0x98>
    80004438:	ffffe097          	auipc	ra,0xffffe
    8000443c:	260080e7          	jalr	608(ra) # 80002698 <_Z11printStringPKc>
    80004440:	00000613          	li	a2,0
    80004444:	00a00593          	li	a1,10
    80004448:	0009051b          	sext.w	a0,s2
    8000444c:	ffffe097          	auipc	ra,0xffffe
    80004450:	3fc080e7          	jalr	1020(ra) # 80002848 <_Z8printIntiii>
    80004454:	00004517          	auipc	a0,0x4
    80004458:	edc50513          	addi	a0,a0,-292 # 80008330 <CONSOLE_STATUS+0x320>
    8000445c:	ffffe097          	auipc	ra,0xffffe
    80004460:	23c080e7          	jalr	572(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004464:	00000493          	li	s1,0
    80004468:	f99ff06f          	j	80004400 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    8000446c:	00004517          	auipc	a0,0x4
    80004470:	12c50513          	addi	a0,a0,300 # 80008598 <_ZTV9Semaphore+0xa0>
    80004474:	ffffe097          	auipc	ra,0xffffe
    80004478:	224080e7          	jalr	548(ra) # 80002698 <_Z11printStringPKc>
    finishedB = true;
    8000447c:	00100793          	li	a5,1
    80004480:	00006717          	auipc	a4,0x6
    80004484:	a0f70523          	sb	a5,-1526(a4) # 80009e8a <_ZL9finishedB>
    thread_dispatch();
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	b88080e7          	jalr	-1144(ra) # 80002010 <_Z15thread_dispatchv>
}
    80004490:	01813083          	ld	ra,24(sp)
    80004494:	01013403          	ld	s0,16(sp)
    80004498:	00813483          	ld	s1,8(sp)
    8000449c:	00013903          	ld	s2,0(sp)
    800044a0:	02010113          	addi	sp,sp,32
    800044a4:	00008067          	ret

00000000800044a8 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800044a8:	fe010113          	addi	sp,sp,-32
    800044ac:	00113c23          	sd	ra,24(sp)
    800044b0:	00813823          	sd	s0,16(sp)
    800044b4:	00913423          	sd	s1,8(sp)
    800044b8:	01213023          	sd	s2,0(sp)
    800044bc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800044c0:	00000913          	li	s2,0
    800044c4:	0380006f          	j	800044fc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800044c8:	ffffe097          	auipc	ra,0xffffe
    800044cc:	b48080e7          	jalr	-1208(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800044d0:	00148493          	addi	s1,s1,1
    800044d4:	000027b7          	lui	a5,0x2
    800044d8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800044dc:	0097ee63          	bltu	a5,s1,800044f8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800044e0:	00000713          	li	a4,0
    800044e4:	000077b7          	lui	a5,0x7
    800044e8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800044ec:	fce7eee3          	bltu	a5,a4,800044c8 <_ZL11workerBodyAPv+0x20>
    800044f0:	00170713          	addi	a4,a4,1
    800044f4:	ff1ff06f          	j	800044e4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800044f8:	00190913          	addi	s2,s2,1
    800044fc:	00900793          	li	a5,9
    80004500:	0527e063          	bltu	a5,s2,80004540 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004504:	00004517          	auipc	a0,0x4
    80004508:	0a450513          	addi	a0,a0,164 # 800085a8 <_ZTV9Semaphore+0xb0>
    8000450c:	ffffe097          	auipc	ra,0xffffe
    80004510:	18c080e7          	jalr	396(ra) # 80002698 <_Z11printStringPKc>
    80004514:	00000613          	li	a2,0
    80004518:	00a00593          	li	a1,10
    8000451c:	0009051b          	sext.w	a0,s2
    80004520:	ffffe097          	auipc	ra,0xffffe
    80004524:	328080e7          	jalr	808(ra) # 80002848 <_Z8printIntiii>
    80004528:	00004517          	auipc	a0,0x4
    8000452c:	e0850513          	addi	a0,a0,-504 # 80008330 <CONSOLE_STATUS+0x320>
    80004530:	ffffe097          	auipc	ra,0xffffe
    80004534:	168080e7          	jalr	360(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004538:	00000493          	li	s1,0
    8000453c:	f99ff06f          	j	800044d4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004540:	00004517          	auipc	a0,0x4
    80004544:	07050513          	addi	a0,a0,112 # 800085b0 <_ZTV9Semaphore+0xb8>
    80004548:	ffffe097          	auipc	ra,0xffffe
    8000454c:	150080e7          	jalr	336(ra) # 80002698 <_Z11printStringPKc>
    finishedA = true;
    80004550:	00100793          	li	a5,1
    80004554:	00006717          	auipc	a4,0x6
    80004558:	92f70ba3          	sb	a5,-1737(a4) # 80009e8b <_ZL9finishedA>
}
    8000455c:	01813083          	ld	ra,24(sp)
    80004560:	01013403          	ld	s0,16(sp)
    80004564:	00813483          	ld	s1,8(sp)
    80004568:	00013903          	ld	s2,0(sp)
    8000456c:	02010113          	addi	sp,sp,32
    80004570:	00008067          	ret

0000000080004574 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80004574:	fd010113          	addi	sp,sp,-48
    80004578:	02113423          	sd	ra,40(sp)
    8000457c:	02813023          	sd	s0,32(sp)
    80004580:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004584:	00000613          	li	a2,0
    80004588:	00000597          	auipc	a1,0x0
    8000458c:	f2058593          	addi	a1,a1,-224 # 800044a8 <_ZL11workerBodyAPv>
    80004590:	fd040513          	addi	a0,s0,-48
    80004594:	ffffe097          	auipc	ra,0xffffe
    80004598:	a44080e7          	jalr	-1468(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000459c:	00004517          	auipc	a0,0x4
    800045a0:	02450513          	addi	a0,a0,36 # 800085c0 <_ZTV9Semaphore+0xc8>
    800045a4:	ffffe097          	auipc	ra,0xffffe
    800045a8:	0f4080e7          	jalr	244(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800045ac:	00000613          	li	a2,0
    800045b0:	00000597          	auipc	a1,0x0
    800045b4:	e2458593          	addi	a1,a1,-476 # 800043d4 <_ZL11workerBodyBPv>
    800045b8:	fd840513          	addi	a0,s0,-40
    800045bc:	ffffe097          	auipc	ra,0xffffe
    800045c0:	a1c080e7          	jalr	-1508(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    800045c4:	00004517          	auipc	a0,0x4
    800045c8:	01450513          	addi	a0,a0,20 # 800085d8 <_ZTV9Semaphore+0xe0>
    800045cc:	ffffe097          	auipc	ra,0xffffe
    800045d0:	0cc080e7          	jalr	204(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800045d4:	00000613          	li	a2,0
    800045d8:	00000597          	auipc	a1,0x0
    800045dc:	c7c58593          	addi	a1,a1,-900 # 80004254 <_ZL11workerBodyCPv>
    800045e0:	fe040513          	addi	a0,s0,-32
    800045e4:	ffffe097          	auipc	ra,0xffffe
    800045e8:	9f4080e7          	jalr	-1548(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800045ec:	00004517          	auipc	a0,0x4
    800045f0:	00450513          	addi	a0,a0,4 # 800085f0 <_ZTV9Semaphore+0xf8>
    800045f4:	ffffe097          	auipc	ra,0xffffe
    800045f8:	0a4080e7          	jalr	164(ra) # 80002698 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800045fc:	00000613          	li	a2,0
    80004600:	00000597          	auipc	a1,0x0
    80004604:	b0c58593          	addi	a1,a1,-1268 # 8000410c <_ZL11workerBodyDPv>
    80004608:	fe840513          	addi	a0,s0,-24
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	9cc080e7          	jalr	-1588(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004614:	00004517          	auipc	a0,0x4
    80004618:	ff450513          	addi	a0,a0,-12 # 80008608 <_ZTV9Semaphore+0x110>
    8000461c:	ffffe097          	auipc	ra,0xffffe
    80004620:	07c080e7          	jalr	124(ra) # 80002698 <_Z11printStringPKc>
    80004624:	00c0006f          	j	80004630 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	9e8080e7          	jalr	-1560(ra) # 80002010 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004630:	00006797          	auipc	a5,0x6
    80004634:	85b7c783          	lbu	a5,-1957(a5) # 80009e8b <_ZL9finishedA>
    80004638:	fe0788e3          	beqz	a5,80004628 <_Z18Threads_C_API_testv+0xb4>
    8000463c:	00006797          	auipc	a5,0x6
    80004640:	84e7c783          	lbu	a5,-1970(a5) # 80009e8a <_ZL9finishedB>
    80004644:	fe0782e3          	beqz	a5,80004628 <_Z18Threads_C_API_testv+0xb4>
    80004648:	00006797          	auipc	a5,0x6
    8000464c:	8417c783          	lbu	a5,-1983(a5) # 80009e89 <_ZL9finishedC>
    80004650:	fc078ce3          	beqz	a5,80004628 <_Z18Threads_C_API_testv+0xb4>
    80004654:	00006797          	auipc	a5,0x6
    80004658:	8347c783          	lbu	a5,-1996(a5) # 80009e88 <_ZL9finishedD>
    8000465c:	fc0786e3          	beqz	a5,80004628 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80004660:	02813083          	ld	ra,40(sp)
    80004664:	02013403          	ld	s0,32(sp)
    80004668:	03010113          	addi	sp,sp,48
    8000466c:	00008067          	ret

0000000080004670 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004670:	fe010113          	addi	sp,sp,-32
    80004674:	00113c23          	sd	ra,24(sp)
    80004678:	00813823          	sd	s0,16(sp)
    8000467c:	00913423          	sd	s1,8(sp)
    80004680:	01213023          	sd	s2,0(sp)
    80004684:	02010413          	addi	s0,sp,32
    80004688:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000468c:	00100793          	li	a5,1
    80004690:	02a7f863          	bgeu	a5,a0,800046c0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004694:	00a00793          	li	a5,10
    80004698:	02f577b3          	remu	a5,a0,a5
    8000469c:	02078e63          	beqz	a5,800046d8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800046a0:	fff48513          	addi	a0,s1,-1
    800046a4:	00000097          	auipc	ra,0x0
    800046a8:	fcc080e7          	jalr	-52(ra) # 80004670 <_ZL9fibonaccim>
    800046ac:	00050913          	mv	s2,a0
    800046b0:	ffe48513          	addi	a0,s1,-2
    800046b4:	00000097          	auipc	ra,0x0
    800046b8:	fbc080e7          	jalr	-68(ra) # 80004670 <_ZL9fibonaccim>
    800046bc:	00a90533          	add	a0,s2,a0
}
    800046c0:	01813083          	ld	ra,24(sp)
    800046c4:	01013403          	ld	s0,16(sp)
    800046c8:	00813483          	ld	s1,8(sp)
    800046cc:	00013903          	ld	s2,0(sp)
    800046d0:	02010113          	addi	sp,sp,32
    800046d4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800046d8:	ffffe097          	auipc	ra,0xffffe
    800046dc:	938080e7          	jalr	-1736(ra) # 80002010 <_Z15thread_dispatchv>
    800046e0:	fc1ff06f          	j	800046a0 <_ZL9fibonaccim+0x30>

00000000800046e4 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800046e4:	fe010113          	addi	sp,sp,-32
    800046e8:	00113c23          	sd	ra,24(sp)
    800046ec:	00813823          	sd	s0,16(sp)
    800046f0:	00913423          	sd	s1,8(sp)
    800046f4:	01213023          	sd	s2,0(sp)
    800046f8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800046fc:	00000913          	li	s2,0
    80004700:	0380006f          	j	80004738 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004704:	ffffe097          	auipc	ra,0xffffe
    80004708:	90c080e7          	jalr	-1780(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000470c:	00148493          	addi	s1,s1,1
    80004710:	000027b7          	lui	a5,0x2
    80004714:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004718:	0097ee63          	bltu	a5,s1,80004734 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000471c:	00000713          	li	a4,0
    80004720:	000077b7          	lui	a5,0x7
    80004724:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004728:	fce7eee3          	bltu	a5,a4,80004704 <_ZN7WorkerA11workerBodyAEPv+0x20>
    8000472c:	00170713          	addi	a4,a4,1
    80004730:	ff1ff06f          	j	80004720 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004734:	00190913          	addi	s2,s2,1
    80004738:	00900793          	li	a5,9
    8000473c:	0527e063          	bltu	a5,s2,8000477c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004740:	00004517          	auipc	a0,0x4
    80004744:	e6850513          	addi	a0,a0,-408 # 800085a8 <_ZTV9Semaphore+0xb0>
    80004748:	ffffe097          	auipc	ra,0xffffe
    8000474c:	f50080e7          	jalr	-176(ra) # 80002698 <_Z11printStringPKc>
    80004750:	00000613          	li	a2,0
    80004754:	00a00593          	li	a1,10
    80004758:	0009051b          	sext.w	a0,s2
    8000475c:	ffffe097          	auipc	ra,0xffffe
    80004760:	0ec080e7          	jalr	236(ra) # 80002848 <_Z8printIntiii>
    80004764:	00004517          	auipc	a0,0x4
    80004768:	bcc50513          	addi	a0,a0,-1076 # 80008330 <CONSOLE_STATUS+0x320>
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	f2c080e7          	jalr	-212(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004774:	00000493          	li	s1,0
    80004778:	f99ff06f          	j	80004710 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000477c:	00004517          	auipc	a0,0x4
    80004780:	e3450513          	addi	a0,a0,-460 # 800085b0 <_ZTV9Semaphore+0xb8>
    80004784:	ffffe097          	auipc	ra,0xffffe
    80004788:	f14080e7          	jalr	-236(ra) # 80002698 <_Z11printStringPKc>
    finishedA = true;
    8000478c:	00100793          	li	a5,1
    80004790:	00005717          	auipc	a4,0x5
    80004794:	6ef70fa3          	sb	a5,1791(a4) # 80009e8f <_ZL9finishedA>
}
    80004798:	01813083          	ld	ra,24(sp)
    8000479c:	01013403          	ld	s0,16(sp)
    800047a0:	00813483          	ld	s1,8(sp)
    800047a4:	00013903          	ld	s2,0(sp)
    800047a8:	02010113          	addi	sp,sp,32
    800047ac:	00008067          	ret

00000000800047b0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800047b0:	fe010113          	addi	sp,sp,-32
    800047b4:	00113c23          	sd	ra,24(sp)
    800047b8:	00813823          	sd	s0,16(sp)
    800047bc:	00913423          	sd	s1,8(sp)
    800047c0:	01213023          	sd	s2,0(sp)
    800047c4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800047c8:	00000913          	li	s2,0
    800047cc:	0380006f          	j	80004804 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800047d0:	ffffe097          	auipc	ra,0xffffe
    800047d4:	840080e7          	jalr	-1984(ra) # 80002010 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800047d8:	00148493          	addi	s1,s1,1
    800047dc:	000027b7          	lui	a5,0x2
    800047e0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800047e4:	0097ee63          	bltu	a5,s1,80004800 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800047e8:	00000713          	li	a4,0
    800047ec:	000077b7          	lui	a5,0x7
    800047f0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800047f4:	fce7eee3          	bltu	a5,a4,800047d0 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800047f8:	00170713          	addi	a4,a4,1
    800047fc:	ff1ff06f          	j	800047ec <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004800:	00190913          	addi	s2,s2,1
    80004804:	00f00793          	li	a5,15
    80004808:	0527e063          	bltu	a5,s2,80004848 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000480c:	00004517          	auipc	a0,0x4
    80004810:	d8450513          	addi	a0,a0,-636 # 80008590 <_ZTV9Semaphore+0x98>
    80004814:	ffffe097          	auipc	ra,0xffffe
    80004818:	e84080e7          	jalr	-380(ra) # 80002698 <_Z11printStringPKc>
    8000481c:	00000613          	li	a2,0
    80004820:	00a00593          	li	a1,10
    80004824:	0009051b          	sext.w	a0,s2
    80004828:	ffffe097          	auipc	ra,0xffffe
    8000482c:	020080e7          	jalr	32(ra) # 80002848 <_Z8printIntiii>
    80004830:	00004517          	auipc	a0,0x4
    80004834:	b0050513          	addi	a0,a0,-1280 # 80008330 <CONSOLE_STATUS+0x320>
    80004838:	ffffe097          	auipc	ra,0xffffe
    8000483c:	e60080e7          	jalr	-416(ra) # 80002698 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004840:	00000493          	li	s1,0
    80004844:	f99ff06f          	j	800047dc <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004848:	00004517          	auipc	a0,0x4
    8000484c:	d5050513          	addi	a0,a0,-688 # 80008598 <_ZTV9Semaphore+0xa0>
    80004850:	ffffe097          	auipc	ra,0xffffe
    80004854:	e48080e7          	jalr	-440(ra) # 80002698 <_Z11printStringPKc>
    finishedB = true;
    80004858:	00100793          	li	a5,1
    8000485c:	00005717          	auipc	a4,0x5
    80004860:	62f70923          	sb	a5,1586(a4) # 80009e8e <_ZL9finishedB>
    thread_dispatch();
    80004864:	ffffd097          	auipc	ra,0xffffd
    80004868:	7ac080e7          	jalr	1964(ra) # 80002010 <_Z15thread_dispatchv>
}
    8000486c:	01813083          	ld	ra,24(sp)
    80004870:	01013403          	ld	s0,16(sp)
    80004874:	00813483          	ld	s1,8(sp)
    80004878:	00013903          	ld	s2,0(sp)
    8000487c:	02010113          	addi	sp,sp,32
    80004880:	00008067          	ret

0000000080004884 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004884:	fe010113          	addi	sp,sp,-32
    80004888:	00113c23          	sd	ra,24(sp)
    8000488c:	00813823          	sd	s0,16(sp)
    80004890:	00913423          	sd	s1,8(sp)
    80004894:	01213023          	sd	s2,0(sp)
    80004898:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000489c:	00000493          	li	s1,0
    800048a0:	0400006f          	j	800048e0 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800048a4:	00004517          	auipc	a0,0x4
    800048a8:	cac50513          	addi	a0,a0,-852 # 80008550 <_ZTV9Semaphore+0x58>
    800048ac:	ffffe097          	auipc	ra,0xffffe
    800048b0:	dec080e7          	jalr	-532(ra) # 80002698 <_Z11printStringPKc>
    800048b4:	00000613          	li	a2,0
    800048b8:	00a00593          	li	a1,10
    800048bc:	00048513          	mv	a0,s1
    800048c0:	ffffe097          	auipc	ra,0xffffe
    800048c4:	f88080e7          	jalr	-120(ra) # 80002848 <_Z8printIntiii>
    800048c8:	00004517          	auipc	a0,0x4
    800048cc:	a6850513          	addi	a0,a0,-1432 # 80008330 <CONSOLE_STATUS+0x320>
    800048d0:	ffffe097          	auipc	ra,0xffffe
    800048d4:	dc8080e7          	jalr	-568(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800048d8:	0014849b          	addiw	s1,s1,1
    800048dc:	0ff4f493          	andi	s1,s1,255
    800048e0:	00200793          	li	a5,2
    800048e4:	fc97f0e3          	bgeu	a5,s1,800048a4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800048e8:	00004517          	auipc	a0,0x4
    800048ec:	c7050513          	addi	a0,a0,-912 # 80008558 <_ZTV9Semaphore+0x60>
    800048f0:	ffffe097          	auipc	ra,0xffffe
    800048f4:	da8080e7          	jalr	-600(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800048f8:	00700313          	li	t1,7
    thread_dispatch();
    800048fc:	ffffd097          	auipc	ra,0xffffd
    80004900:	714080e7          	jalr	1812(ra) # 80002010 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004904:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004908:	00004517          	auipc	a0,0x4
    8000490c:	c6050513          	addi	a0,a0,-928 # 80008568 <_ZTV9Semaphore+0x70>
    80004910:	ffffe097          	auipc	ra,0xffffe
    80004914:	d88080e7          	jalr	-632(ra) # 80002698 <_Z11printStringPKc>
    80004918:	00000613          	li	a2,0
    8000491c:	00a00593          	li	a1,10
    80004920:	0009051b          	sext.w	a0,s2
    80004924:	ffffe097          	auipc	ra,0xffffe
    80004928:	f24080e7          	jalr	-220(ra) # 80002848 <_Z8printIntiii>
    8000492c:	00004517          	auipc	a0,0x4
    80004930:	a0450513          	addi	a0,a0,-1532 # 80008330 <CONSOLE_STATUS+0x320>
    80004934:	ffffe097          	auipc	ra,0xffffe
    80004938:	d64080e7          	jalr	-668(ra) # 80002698 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000493c:	00c00513          	li	a0,12
    80004940:	00000097          	auipc	ra,0x0
    80004944:	d30080e7          	jalr	-720(ra) # 80004670 <_ZL9fibonaccim>
    80004948:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000494c:	00004517          	auipc	a0,0x4
    80004950:	c2450513          	addi	a0,a0,-988 # 80008570 <_ZTV9Semaphore+0x78>
    80004954:	ffffe097          	auipc	ra,0xffffe
    80004958:	d44080e7          	jalr	-700(ra) # 80002698 <_Z11printStringPKc>
    8000495c:	00000613          	li	a2,0
    80004960:	00a00593          	li	a1,10
    80004964:	0009051b          	sext.w	a0,s2
    80004968:	ffffe097          	auipc	ra,0xffffe
    8000496c:	ee0080e7          	jalr	-288(ra) # 80002848 <_Z8printIntiii>
    80004970:	00004517          	auipc	a0,0x4
    80004974:	9c050513          	addi	a0,a0,-1600 # 80008330 <CONSOLE_STATUS+0x320>
    80004978:	ffffe097          	auipc	ra,0xffffe
    8000497c:	d20080e7          	jalr	-736(ra) # 80002698 <_Z11printStringPKc>
    80004980:	0400006f          	j	800049c0 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004984:	00004517          	auipc	a0,0x4
    80004988:	bcc50513          	addi	a0,a0,-1076 # 80008550 <_ZTV9Semaphore+0x58>
    8000498c:	ffffe097          	auipc	ra,0xffffe
    80004990:	d0c080e7          	jalr	-756(ra) # 80002698 <_Z11printStringPKc>
    80004994:	00000613          	li	a2,0
    80004998:	00a00593          	li	a1,10
    8000499c:	00048513          	mv	a0,s1
    800049a0:	ffffe097          	auipc	ra,0xffffe
    800049a4:	ea8080e7          	jalr	-344(ra) # 80002848 <_Z8printIntiii>
    800049a8:	00004517          	auipc	a0,0x4
    800049ac:	98850513          	addi	a0,a0,-1656 # 80008330 <CONSOLE_STATUS+0x320>
    800049b0:	ffffe097          	auipc	ra,0xffffe
    800049b4:	ce8080e7          	jalr	-792(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800049b8:	0014849b          	addiw	s1,s1,1
    800049bc:	0ff4f493          	andi	s1,s1,255
    800049c0:	00500793          	li	a5,5
    800049c4:	fc97f0e3          	bgeu	a5,s1,80004984 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    800049c8:	00004517          	auipc	a0,0x4
    800049cc:	bb850513          	addi	a0,a0,-1096 # 80008580 <_ZTV9Semaphore+0x88>
    800049d0:	ffffe097          	auipc	ra,0xffffe
    800049d4:	cc8080e7          	jalr	-824(ra) # 80002698 <_Z11printStringPKc>
    finishedC = true;
    800049d8:	00100793          	li	a5,1
    800049dc:	00005717          	auipc	a4,0x5
    800049e0:	4af708a3          	sb	a5,1201(a4) # 80009e8d <_ZL9finishedC>
    thread_dispatch();
    800049e4:	ffffd097          	auipc	ra,0xffffd
    800049e8:	62c080e7          	jalr	1580(ra) # 80002010 <_Z15thread_dispatchv>
}
    800049ec:	01813083          	ld	ra,24(sp)
    800049f0:	01013403          	ld	s0,16(sp)
    800049f4:	00813483          	ld	s1,8(sp)
    800049f8:	00013903          	ld	s2,0(sp)
    800049fc:	02010113          	addi	sp,sp,32
    80004a00:	00008067          	ret

0000000080004a04 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80004a04:	fe010113          	addi	sp,sp,-32
    80004a08:	00113c23          	sd	ra,24(sp)
    80004a0c:	00813823          	sd	s0,16(sp)
    80004a10:	00913423          	sd	s1,8(sp)
    80004a14:	01213023          	sd	s2,0(sp)
    80004a18:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004a1c:	00a00493          	li	s1,10
    80004a20:	0400006f          	j	80004a60 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004a24:	00004517          	auipc	a0,0x4
    80004a28:	af450513          	addi	a0,a0,-1292 # 80008518 <_ZTV9Semaphore+0x20>
    80004a2c:	ffffe097          	auipc	ra,0xffffe
    80004a30:	c6c080e7          	jalr	-916(ra) # 80002698 <_Z11printStringPKc>
    80004a34:	00000613          	li	a2,0
    80004a38:	00a00593          	li	a1,10
    80004a3c:	00048513          	mv	a0,s1
    80004a40:	ffffe097          	auipc	ra,0xffffe
    80004a44:	e08080e7          	jalr	-504(ra) # 80002848 <_Z8printIntiii>
    80004a48:	00004517          	auipc	a0,0x4
    80004a4c:	8e850513          	addi	a0,a0,-1816 # 80008330 <CONSOLE_STATUS+0x320>
    80004a50:	ffffe097          	auipc	ra,0xffffe
    80004a54:	c48080e7          	jalr	-952(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004a58:	0014849b          	addiw	s1,s1,1
    80004a5c:	0ff4f493          	andi	s1,s1,255
    80004a60:	00c00793          	li	a5,12
    80004a64:	fc97f0e3          	bgeu	a5,s1,80004a24 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80004a68:	00004517          	auipc	a0,0x4
    80004a6c:	ab850513          	addi	a0,a0,-1352 # 80008520 <_ZTV9Semaphore+0x28>
    80004a70:	ffffe097          	auipc	ra,0xffffe
    80004a74:	c28080e7          	jalr	-984(ra) # 80002698 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004a78:	00500313          	li	t1,5
    thread_dispatch();
    80004a7c:	ffffd097          	auipc	ra,0xffffd
    80004a80:	594080e7          	jalr	1428(ra) # 80002010 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004a84:	01000513          	li	a0,16
    80004a88:	00000097          	auipc	ra,0x0
    80004a8c:	be8080e7          	jalr	-1048(ra) # 80004670 <_ZL9fibonaccim>
    80004a90:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004a94:	00004517          	auipc	a0,0x4
    80004a98:	a9c50513          	addi	a0,a0,-1380 # 80008530 <_ZTV9Semaphore+0x38>
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	bfc080e7          	jalr	-1028(ra) # 80002698 <_Z11printStringPKc>
    80004aa4:	00000613          	li	a2,0
    80004aa8:	00a00593          	li	a1,10
    80004aac:	0009051b          	sext.w	a0,s2
    80004ab0:	ffffe097          	auipc	ra,0xffffe
    80004ab4:	d98080e7          	jalr	-616(ra) # 80002848 <_Z8printIntiii>
    80004ab8:	00004517          	auipc	a0,0x4
    80004abc:	87850513          	addi	a0,a0,-1928 # 80008330 <CONSOLE_STATUS+0x320>
    80004ac0:	ffffe097          	auipc	ra,0xffffe
    80004ac4:	bd8080e7          	jalr	-1064(ra) # 80002698 <_Z11printStringPKc>
    80004ac8:	0400006f          	j	80004b08 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004acc:	00004517          	auipc	a0,0x4
    80004ad0:	a4c50513          	addi	a0,a0,-1460 # 80008518 <_ZTV9Semaphore+0x20>
    80004ad4:	ffffe097          	auipc	ra,0xffffe
    80004ad8:	bc4080e7          	jalr	-1084(ra) # 80002698 <_Z11printStringPKc>
    80004adc:	00000613          	li	a2,0
    80004ae0:	00a00593          	li	a1,10
    80004ae4:	00048513          	mv	a0,s1
    80004ae8:	ffffe097          	auipc	ra,0xffffe
    80004aec:	d60080e7          	jalr	-672(ra) # 80002848 <_Z8printIntiii>
    80004af0:	00004517          	auipc	a0,0x4
    80004af4:	84050513          	addi	a0,a0,-1984 # 80008330 <CONSOLE_STATUS+0x320>
    80004af8:	ffffe097          	auipc	ra,0xffffe
    80004afc:	ba0080e7          	jalr	-1120(ra) # 80002698 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004b00:	0014849b          	addiw	s1,s1,1
    80004b04:	0ff4f493          	andi	s1,s1,255
    80004b08:	00f00793          	li	a5,15
    80004b0c:	fc97f0e3          	bgeu	a5,s1,80004acc <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80004b10:	00004517          	auipc	a0,0x4
    80004b14:	a3050513          	addi	a0,a0,-1488 # 80008540 <_ZTV9Semaphore+0x48>
    80004b18:	ffffe097          	auipc	ra,0xffffe
    80004b1c:	b80080e7          	jalr	-1152(ra) # 80002698 <_Z11printStringPKc>
    finishedD = true;
    80004b20:	00100793          	li	a5,1
    80004b24:	00005717          	auipc	a4,0x5
    80004b28:	36f70423          	sb	a5,872(a4) # 80009e8c <_ZL9finishedD>
    thread_dispatch();
    80004b2c:	ffffd097          	auipc	ra,0xffffd
    80004b30:	4e4080e7          	jalr	1252(ra) # 80002010 <_Z15thread_dispatchv>
}
    80004b34:	01813083          	ld	ra,24(sp)
    80004b38:	01013403          	ld	s0,16(sp)
    80004b3c:	00813483          	ld	s1,8(sp)
    80004b40:	00013903          	ld	s2,0(sp)
    80004b44:	02010113          	addi	sp,sp,32
    80004b48:	00008067          	ret

0000000080004b4c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80004b4c:	fc010113          	addi	sp,sp,-64
    80004b50:	02113c23          	sd	ra,56(sp)
    80004b54:	02813823          	sd	s0,48(sp)
    80004b58:	02913423          	sd	s1,40(sp)
    80004b5c:	03213023          	sd	s2,32(sp)
    80004b60:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80004b64:	02000513          	li	a0,32
    80004b68:	ffffc097          	auipc	ra,0xffffc
    80004b6c:	6d8080e7          	jalr	1752(ra) # 80001240 <_Znwm>
    Thread(){};
    80004b70:	00053823          	sd	zero,16(a0)
    WorkerA():Thread() {}
    80004b74:	00004797          	auipc	a5,0x4
    80004b78:	b6c78793          	addi	a5,a5,-1172 # 800086e0 <_ZTV7WorkerA+0x10>
    80004b7c:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80004b80:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80004b84:	00004517          	auipc	a0,0x4
    80004b88:	a3c50513          	addi	a0,a0,-1476 # 800085c0 <_ZTV9Semaphore+0xc8>
    80004b8c:	ffffe097          	auipc	ra,0xffffe
    80004b90:	b0c080e7          	jalr	-1268(ra) # 80002698 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80004b94:	02000513          	li	a0,32
    80004b98:	ffffc097          	auipc	ra,0xffffc
    80004b9c:	6a8080e7          	jalr	1704(ra) # 80001240 <_Znwm>
    80004ba0:	00053823          	sd	zero,16(a0)
    WorkerB():Thread() {}
    80004ba4:	00004797          	auipc	a5,0x4
    80004ba8:	b6478793          	addi	a5,a5,-1180 # 80008708 <_ZTV7WorkerB+0x10>
    80004bac:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80004bb0:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80004bb4:	00004517          	auipc	a0,0x4
    80004bb8:	a2450513          	addi	a0,a0,-1500 # 800085d8 <_ZTV9Semaphore+0xe0>
    80004bbc:	ffffe097          	auipc	ra,0xffffe
    80004bc0:	adc080e7          	jalr	-1316(ra) # 80002698 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80004bc4:	02000513          	li	a0,32
    80004bc8:	ffffc097          	auipc	ra,0xffffc
    80004bcc:	678080e7          	jalr	1656(ra) # 80001240 <_Znwm>
    80004bd0:	00053823          	sd	zero,16(a0)
    WorkerC():Thread() {}
    80004bd4:	00004797          	auipc	a5,0x4
    80004bd8:	b5c78793          	addi	a5,a5,-1188 # 80008730 <_ZTV7WorkerC+0x10>
    80004bdc:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80004be0:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80004be4:	00004517          	auipc	a0,0x4
    80004be8:	a0c50513          	addi	a0,a0,-1524 # 800085f0 <_ZTV9Semaphore+0xf8>
    80004bec:	ffffe097          	auipc	ra,0xffffe
    80004bf0:	aac080e7          	jalr	-1364(ra) # 80002698 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80004bf4:	02000513          	li	a0,32
    80004bf8:	ffffc097          	auipc	ra,0xffffc
    80004bfc:	648080e7          	jalr	1608(ra) # 80001240 <_Znwm>
    80004c00:	00053823          	sd	zero,16(a0)
    WorkerD():Thread() {}
    80004c04:	00004797          	auipc	a5,0x4
    80004c08:	b5478793          	addi	a5,a5,-1196 # 80008758 <_ZTV7WorkerD+0x10>
    80004c0c:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80004c10:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80004c14:	00004517          	auipc	a0,0x4
    80004c18:	9f450513          	addi	a0,a0,-1548 # 80008608 <_ZTV9Semaphore+0x110>
    80004c1c:	ffffe097          	auipc	ra,0xffffe
    80004c20:	a7c080e7          	jalr	-1412(ra) # 80002698 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80004c24:	00000493          	li	s1,0
    80004c28:	0200006f          	j	80004c48 <_Z20Threads_CPP_API_testv+0xfc>
            thread_create(&myhandle, &threadWrapper,this);
    80004c2c:	00050613          	mv	a2,a0
    80004c30:	fffff597          	auipc	a1,0xfffff
    80004c34:	e9058593          	addi	a1,a1,-368 # 80003ac0 <_ZN6Thread13threadWrapperEPv>
    80004c38:	00850513          	addi	a0,a0,8
    80004c3c:	ffffd097          	auipc	ra,0xffffd
    80004c40:	39c080e7          	jalr	924(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    80004c44:	0014849b          	addiw	s1,s1,1
    80004c48:	00300793          	li	a5,3
    80004c4c:	0297cc63          	blt	a5,s1,80004c84 <_Z20Threads_CPP_API_testv+0x138>
        threads[i]->start();
    80004c50:	00349793          	slli	a5,s1,0x3
    80004c54:	fe040713          	addi	a4,s0,-32
    80004c58:	00f707b3          	add	a5,a4,a5
    80004c5c:	fe07b503          	ld	a0,-32(a5)
        if (body == nullptr){
    80004c60:	01053583          	ld	a1,16(a0)
    80004c64:	fc0584e3          	beqz	a1,80004c2c <_Z20Threads_CPP_API_testv+0xe0>
            thread_create(&myhandle, body,arg);
    80004c68:	01853603          	ld	a2,24(a0)
    80004c6c:	00850513          	addi	a0,a0,8
    80004c70:	ffffd097          	auipc	ra,0xffffd
    80004c74:	368080e7          	jalr	872(ra) # 80001fd8 <_Z13thread_createPP7_threadPFvPvES2_>
    80004c78:	fcdff06f          	j	80004c44 <_Z20Threads_CPP_API_testv+0xf8>
    static void dispatch() {thread_dispatch();}
    80004c7c:	ffffd097          	auipc	ra,0xffffd
    80004c80:	394080e7          	jalr	916(ra) # 80002010 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004c84:	00005797          	auipc	a5,0x5
    80004c88:	20b7c783          	lbu	a5,523(a5) # 80009e8f <_ZL9finishedA>
    80004c8c:	fe0788e3          	beqz	a5,80004c7c <_Z20Threads_CPP_API_testv+0x130>
    80004c90:	00005797          	auipc	a5,0x5
    80004c94:	1fe7c783          	lbu	a5,510(a5) # 80009e8e <_ZL9finishedB>
    80004c98:	fe0782e3          	beqz	a5,80004c7c <_Z20Threads_CPP_API_testv+0x130>
    80004c9c:	00005797          	auipc	a5,0x5
    80004ca0:	1f17c783          	lbu	a5,497(a5) # 80009e8d <_ZL9finishedC>
    80004ca4:	fc078ce3          	beqz	a5,80004c7c <_Z20Threads_CPP_API_testv+0x130>
    80004ca8:	00005797          	auipc	a5,0x5
    80004cac:	1e47c783          	lbu	a5,484(a5) # 80009e8c <_ZL9finishedD>
    80004cb0:	fc0786e3          	beqz	a5,80004c7c <_Z20Threads_CPP_API_testv+0x130>
    80004cb4:	fc040493          	addi	s1,s0,-64
    80004cb8:	0080006f          	j	80004cc0 <_Z20Threads_CPP_API_testv+0x174>
        Thread::dispatch();
    }

    for (auto thread: threads) {  printString("Obrisao\n"); delete thread; }
    80004cbc:	00848493          	addi	s1,s1,8
    80004cc0:	fe040793          	addi	a5,s0,-32
    80004cc4:	02f48863          	beq	s1,a5,80004cf4 <_Z20Threads_CPP_API_testv+0x1a8>
    80004cc8:	0004b903          	ld	s2,0(s1)
    80004ccc:	00004517          	auipc	a0,0x4
    80004cd0:	9f450513          	addi	a0,a0,-1548 # 800086c0 <_ZTV12ConsumerSync+0x28>
    80004cd4:	ffffe097          	auipc	ra,0xffffe
    80004cd8:	9c4080e7          	jalr	-1596(ra) # 80002698 <_Z11printStringPKc>
    80004cdc:	fe0900e3          	beqz	s2,80004cbc <_Z20Threads_CPP_API_testv+0x170>
    80004ce0:	00093783          	ld	a5,0(s2)
    80004ce4:	0087b783          	ld	a5,8(a5)
    80004ce8:	00090513          	mv	a0,s2
    80004cec:	000780e7          	jalr	a5
    80004cf0:	fcdff06f          	j	80004cbc <_Z20Threads_CPP_API_testv+0x170>
}
    80004cf4:	03813083          	ld	ra,56(sp)
    80004cf8:	03013403          	ld	s0,48(sp)
    80004cfc:	02813483          	ld	s1,40(sp)
    80004d00:	02013903          	ld	s2,32(sp)
    80004d04:	04010113          	addi	sp,sp,64
    80004d08:	00008067          	ret

0000000080004d0c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80004d0c:	ff010113          	addi	sp,sp,-16
    80004d10:	00113423          	sd	ra,8(sp)
    80004d14:	00813023          	sd	s0,0(sp)
    80004d18:	01010413          	addi	s0,sp,16
    virtual ~Thread() { thread_exit();}
    80004d1c:	00004797          	auipc	a5,0x4
    80004d20:	91478793          	addi	a5,a5,-1772 # 80008630 <_ZTV6Thread+0x10>
    80004d24:	00f53023          	sd	a5,0(a0)
    80004d28:	ffffd097          	auipc	ra,0xffffd
    80004d2c:	30c080e7          	jalr	780(ra) # 80002034 <_Z11thread_exitv>
    80004d30:	00813083          	ld	ra,8(sp)
    80004d34:	00013403          	ld	s0,0(sp)
    80004d38:	01010113          	addi	sp,sp,16
    80004d3c:	00008067          	ret

0000000080004d40 <_ZN7WorkerAD0Ev>:
    80004d40:	fe010113          	addi	sp,sp,-32
    80004d44:	00113c23          	sd	ra,24(sp)
    80004d48:	00813823          	sd	s0,16(sp)
    80004d4c:	00913423          	sd	s1,8(sp)
    80004d50:	02010413          	addi	s0,sp,32
    80004d54:	00050493          	mv	s1,a0
    80004d58:	00004797          	auipc	a5,0x4
    80004d5c:	8d878793          	addi	a5,a5,-1832 # 80008630 <_ZTV6Thread+0x10>
    80004d60:	00f53023          	sd	a5,0(a0)
    80004d64:	ffffd097          	auipc	ra,0xffffd
    80004d68:	2d0080e7          	jalr	720(ra) # 80002034 <_Z11thread_exitv>
    80004d6c:	00048513          	mv	a0,s1
    80004d70:	ffffc097          	auipc	ra,0xffffc
    80004d74:	520080e7          	jalr	1312(ra) # 80001290 <_ZdlPv>
    80004d78:	01813083          	ld	ra,24(sp)
    80004d7c:	01013403          	ld	s0,16(sp)
    80004d80:	00813483          	ld	s1,8(sp)
    80004d84:	02010113          	addi	sp,sp,32
    80004d88:	00008067          	ret

0000000080004d8c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80004d8c:	ff010113          	addi	sp,sp,-16
    80004d90:	00113423          	sd	ra,8(sp)
    80004d94:	00813023          	sd	s0,0(sp)
    80004d98:	01010413          	addi	s0,sp,16
    80004d9c:	00004797          	auipc	a5,0x4
    80004da0:	89478793          	addi	a5,a5,-1900 # 80008630 <_ZTV6Thread+0x10>
    80004da4:	00f53023          	sd	a5,0(a0)
    80004da8:	ffffd097          	auipc	ra,0xffffd
    80004dac:	28c080e7          	jalr	652(ra) # 80002034 <_Z11thread_exitv>
    80004db0:	00813083          	ld	ra,8(sp)
    80004db4:	00013403          	ld	s0,0(sp)
    80004db8:	01010113          	addi	sp,sp,16
    80004dbc:	00008067          	ret

0000000080004dc0 <_ZN7WorkerBD0Ev>:
    80004dc0:	fe010113          	addi	sp,sp,-32
    80004dc4:	00113c23          	sd	ra,24(sp)
    80004dc8:	00813823          	sd	s0,16(sp)
    80004dcc:	00913423          	sd	s1,8(sp)
    80004dd0:	02010413          	addi	s0,sp,32
    80004dd4:	00050493          	mv	s1,a0
    80004dd8:	00004797          	auipc	a5,0x4
    80004ddc:	85878793          	addi	a5,a5,-1960 # 80008630 <_ZTV6Thread+0x10>
    80004de0:	00f53023          	sd	a5,0(a0)
    80004de4:	ffffd097          	auipc	ra,0xffffd
    80004de8:	250080e7          	jalr	592(ra) # 80002034 <_Z11thread_exitv>
    80004dec:	00048513          	mv	a0,s1
    80004df0:	ffffc097          	auipc	ra,0xffffc
    80004df4:	4a0080e7          	jalr	1184(ra) # 80001290 <_ZdlPv>
    80004df8:	01813083          	ld	ra,24(sp)
    80004dfc:	01013403          	ld	s0,16(sp)
    80004e00:	00813483          	ld	s1,8(sp)
    80004e04:	02010113          	addi	sp,sp,32
    80004e08:	00008067          	ret

0000000080004e0c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80004e0c:	ff010113          	addi	sp,sp,-16
    80004e10:	00113423          	sd	ra,8(sp)
    80004e14:	00813023          	sd	s0,0(sp)
    80004e18:	01010413          	addi	s0,sp,16
    80004e1c:	00004797          	auipc	a5,0x4
    80004e20:	81478793          	addi	a5,a5,-2028 # 80008630 <_ZTV6Thread+0x10>
    80004e24:	00f53023          	sd	a5,0(a0)
    80004e28:	ffffd097          	auipc	ra,0xffffd
    80004e2c:	20c080e7          	jalr	524(ra) # 80002034 <_Z11thread_exitv>
    80004e30:	00813083          	ld	ra,8(sp)
    80004e34:	00013403          	ld	s0,0(sp)
    80004e38:	01010113          	addi	sp,sp,16
    80004e3c:	00008067          	ret

0000000080004e40 <_ZN7WorkerCD0Ev>:
    80004e40:	fe010113          	addi	sp,sp,-32
    80004e44:	00113c23          	sd	ra,24(sp)
    80004e48:	00813823          	sd	s0,16(sp)
    80004e4c:	00913423          	sd	s1,8(sp)
    80004e50:	02010413          	addi	s0,sp,32
    80004e54:	00050493          	mv	s1,a0
    80004e58:	00003797          	auipc	a5,0x3
    80004e5c:	7d878793          	addi	a5,a5,2008 # 80008630 <_ZTV6Thread+0x10>
    80004e60:	00f53023          	sd	a5,0(a0)
    80004e64:	ffffd097          	auipc	ra,0xffffd
    80004e68:	1d0080e7          	jalr	464(ra) # 80002034 <_Z11thread_exitv>
    80004e6c:	00048513          	mv	a0,s1
    80004e70:	ffffc097          	auipc	ra,0xffffc
    80004e74:	420080e7          	jalr	1056(ra) # 80001290 <_ZdlPv>
    80004e78:	01813083          	ld	ra,24(sp)
    80004e7c:	01013403          	ld	s0,16(sp)
    80004e80:	00813483          	ld	s1,8(sp)
    80004e84:	02010113          	addi	sp,sp,32
    80004e88:	00008067          	ret

0000000080004e8c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80004e8c:	ff010113          	addi	sp,sp,-16
    80004e90:	00113423          	sd	ra,8(sp)
    80004e94:	00813023          	sd	s0,0(sp)
    80004e98:	01010413          	addi	s0,sp,16
    80004e9c:	00003797          	auipc	a5,0x3
    80004ea0:	79478793          	addi	a5,a5,1940 # 80008630 <_ZTV6Thread+0x10>
    80004ea4:	00f53023          	sd	a5,0(a0)
    80004ea8:	ffffd097          	auipc	ra,0xffffd
    80004eac:	18c080e7          	jalr	396(ra) # 80002034 <_Z11thread_exitv>
    80004eb0:	00813083          	ld	ra,8(sp)
    80004eb4:	00013403          	ld	s0,0(sp)
    80004eb8:	01010113          	addi	sp,sp,16
    80004ebc:	00008067          	ret

0000000080004ec0 <_ZN7WorkerDD0Ev>:
    80004ec0:	fe010113          	addi	sp,sp,-32
    80004ec4:	00113c23          	sd	ra,24(sp)
    80004ec8:	00813823          	sd	s0,16(sp)
    80004ecc:	00913423          	sd	s1,8(sp)
    80004ed0:	02010413          	addi	s0,sp,32
    80004ed4:	00050493          	mv	s1,a0
    80004ed8:	00003797          	auipc	a5,0x3
    80004edc:	75878793          	addi	a5,a5,1880 # 80008630 <_ZTV6Thread+0x10>
    80004ee0:	00f53023          	sd	a5,0(a0)
    80004ee4:	ffffd097          	auipc	ra,0xffffd
    80004ee8:	150080e7          	jalr	336(ra) # 80002034 <_Z11thread_exitv>
    80004eec:	00048513          	mv	a0,s1
    80004ef0:	ffffc097          	auipc	ra,0xffffc
    80004ef4:	3a0080e7          	jalr	928(ra) # 80001290 <_ZdlPv>
    80004ef8:	01813083          	ld	ra,24(sp)
    80004efc:	01013403          	ld	s0,16(sp)
    80004f00:	00813483          	ld	s1,8(sp)
    80004f04:	02010113          	addi	sp,sp,32
    80004f08:	00008067          	ret

0000000080004f0c <_ZN7WorkerA3runEv>:
    void run() override {
    80004f0c:	ff010113          	addi	sp,sp,-16
    80004f10:	00113423          	sd	ra,8(sp)
    80004f14:	00813023          	sd	s0,0(sp)
    80004f18:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80004f1c:	00000593          	li	a1,0
    80004f20:	fffff097          	auipc	ra,0xfffff
    80004f24:	7c4080e7          	jalr	1988(ra) # 800046e4 <_ZN7WorkerA11workerBodyAEPv>
    }
    80004f28:	00813083          	ld	ra,8(sp)
    80004f2c:	00013403          	ld	s0,0(sp)
    80004f30:	01010113          	addi	sp,sp,16
    80004f34:	00008067          	ret

0000000080004f38 <_ZN7WorkerB3runEv>:
    void run() override {
    80004f38:	ff010113          	addi	sp,sp,-16
    80004f3c:	00113423          	sd	ra,8(sp)
    80004f40:	00813023          	sd	s0,0(sp)
    80004f44:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80004f48:	00000593          	li	a1,0
    80004f4c:	00000097          	auipc	ra,0x0
    80004f50:	864080e7          	jalr	-1948(ra) # 800047b0 <_ZN7WorkerB11workerBodyBEPv>
    }
    80004f54:	00813083          	ld	ra,8(sp)
    80004f58:	00013403          	ld	s0,0(sp)
    80004f5c:	01010113          	addi	sp,sp,16
    80004f60:	00008067          	ret

0000000080004f64 <_ZN7WorkerC3runEv>:
    void run() override {
    80004f64:	ff010113          	addi	sp,sp,-16
    80004f68:	00113423          	sd	ra,8(sp)
    80004f6c:	00813023          	sd	s0,0(sp)
    80004f70:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80004f74:	00000593          	li	a1,0
    80004f78:	00000097          	auipc	ra,0x0
    80004f7c:	90c080e7          	jalr	-1780(ra) # 80004884 <_ZN7WorkerC11workerBodyCEPv>
    }
    80004f80:	00813083          	ld	ra,8(sp)
    80004f84:	00013403          	ld	s0,0(sp)
    80004f88:	01010113          	addi	sp,sp,16
    80004f8c:	00008067          	ret

0000000080004f90 <_ZN7WorkerD3runEv>:
    void run() override {
    80004f90:	ff010113          	addi	sp,sp,-16
    80004f94:	00113423          	sd	ra,8(sp)
    80004f98:	00813023          	sd	s0,0(sp)
    80004f9c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80004fa0:	00000593          	li	a1,0
    80004fa4:	00000097          	auipc	ra,0x0
    80004fa8:	a60080e7          	jalr	-1440(ra) # 80004a04 <_ZN7WorkerD11workerBodyDEPv>
    }
    80004fac:	00813083          	ld	ra,8(sp)
    80004fb0:	00013403          	ld	s0,0(sp)
    80004fb4:	01010113          	addi	sp,sp,16
    80004fb8:	00008067          	ret

0000000080004fbc <start>:
    80004fbc:	ff010113          	addi	sp,sp,-16
    80004fc0:	00813423          	sd	s0,8(sp)
    80004fc4:	01010413          	addi	s0,sp,16
    80004fc8:	300027f3          	csrr	a5,mstatus
    80004fcc:	ffffe737          	lui	a4,0xffffe
    80004fd0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff36cf>
    80004fd4:	00e7f7b3          	and	a5,a5,a4
    80004fd8:	00001737          	lui	a4,0x1
    80004fdc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004fe0:	00e7e7b3          	or	a5,a5,a4
    80004fe4:	30079073          	csrw	mstatus,a5
    80004fe8:	00000797          	auipc	a5,0x0
    80004fec:	16078793          	addi	a5,a5,352 # 80005148 <system_main>
    80004ff0:	34179073          	csrw	mepc,a5
    80004ff4:	00000793          	li	a5,0
    80004ff8:	18079073          	csrw	satp,a5
    80004ffc:	000107b7          	lui	a5,0x10
    80005000:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005004:	30279073          	csrw	medeleg,a5
    80005008:	30379073          	csrw	mideleg,a5
    8000500c:	104027f3          	csrr	a5,sie
    80005010:	2227e793          	ori	a5,a5,546
    80005014:	10479073          	csrw	sie,a5
    80005018:	fff00793          	li	a5,-1
    8000501c:	00a7d793          	srli	a5,a5,0xa
    80005020:	3b079073          	csrw	pmpaddr0,a5
    80005024:	00f00793          	li	a5,15
    80005028:	3a079073          	csrw	pmpcfg0,a5
    8000502c:	f14027f3          	csrr	a5,mhartid
    80005030:	0200c737          	lui	a4,0x200c
    80005034:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005038:	0007869b          	sext.w	a3,a5
    8000503c:	00269713          	slli	a4,a3,0x2
    80005040:	000f4637          	lui	a2,0xf4
    80005044:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005048:	00d70733          	add	a4,a4,a3
    8000504c:	0037979b          	slliw	a5,a5,0x3
    80005050:	020046b7          	lui	a3,0x2004
    80005054:	00d787b3          	add	a5,a5,a3
    80005058:	00c585b3          	add	a1,a1,a2
    8000505c:	00371693          	slli	a3,a4,0x3
    80005060:	00005717          	auipc	a4,0x5
    80005064:	e7070713          	addi	a4,a4,-400 # 80009ed0 <timer_scratch>
    80005068:	00b7b023          	sd	a1,0(a5)
    8000506c:	00d70733          	add	a4,a4,a3
    80005070:	00f73c23          	sd	a5,24(a4)
    80005074:	02c73023          	sd	a2,32(a4)
    80005078:	34071073          	csrw	mscratch,a4
    8000507c:	00000797          	auipc	a5,0x0
    80005080:	6e478793          	addi	a5,a5,1764 # 80005760 <timervec>
    80005084:	30579073          	csrw	mtvec,a5
    80005088:	300027f3          	csrr	a5,mstatus
    8000508c:	0087e793          	ori	a5,a5,8
    80005090:	30079073          	csrw	mstatus,a5
    80005094:	304027f3          	csrr	a5,mie
    80005098:	0807e793          	ori	a5,a5,128
    8000509c:	30479073          	csrw	mie,a5
    800050a0:	f14027f3          	csrr	a5,mhartid
    800050a4:	0007879b          	sext.w	a5,a5
    800050a8:	00078213          	mv	tp,a5
    800050ac:	30200073          	mret
    800050b0:	00813403          	ld	s0,8(sp)
    800050b4:	01010113          	addi	sp,sp,16
    800050b8:	00008067          	ret

00000000800050bc <timerinit>:
    800050bc:	ff010113          	addi	sp,sp,-16
    800050c0:	00813423          	sd	s0,8(sp)
    800050c4:	01010413          	addi	s0,sp,16
    800050c8:	f14027f3          	csrr	a5,mhartid
    800050cc:	0200c737          	lui	a4,0x200c
    800050d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800050d4:	0007869b          	sext.w	a3,a5
    800050d8:	00269713          	slli	a4,a3,0x2
    800050dc:	000f4637          	lui	a2,0xf4
    800050e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800050e4:	00d70733          	add	a4,a4,a3
    800050e8:	0037979b          	slliw	a5,a5,0x3
    800050ec:	020046b7          	lui	a3,0x2004
    800050f0:	00d787b3          	add	a5,a5,a3
    800050f4:	00c585b3          	add	a1,a1,a2
    800050f8:	00371693          	slli	a3,a4,0x3
    800050fc:	00005717          	auipc	a4,0x5
    80005100:	dd470713          	addi	a4,a4,-556 # 80009ed0 <timer_scratch>
    80005104:	00b7b023          	sd	a1,0(a5)
    80005108:	00d70733          	add	a4,a4,a3
    8000510c:	00f73c23          	sd	a5,24(a4)
    80005110:	02c73023          	sd	a2,32(a4)
    80005114:	34071073          	csrw	mscratch,a4
    80005118:	00000797          	auipc	a5,0x0
    8000511c:	64878793          	addi	a5,a5,1608 # 80005760 <timervec>
    80005120:	30579073          	csrw	mtvec,a5
    80005124:	300027f3          	csrr	a5,mstatus
    80005128:	0087e793          	ori	a5,a5,8
    8000512c:	30079073          	csrw	mstatus,a5
    80005130:	304027f3          	csrr	a5,mie
    80005134:	0807e793          	ori	a5,a5,128
    80005138:	30479073          	csrw	mie,a5
    8000513c:	00813403          	ld	s0,8(sp)
    80005140:	01010113          	addi	sp,sp,16
    80005144:	00008067          	ret

0000000080005148 <system_main>:
    80005148:	fe010113          	addi	sp,sp,-32
    8000514c:	00813823          	sd	s0,16(sp)
    80005150:	00913423          	sd	s1,8(sp)
    80005154:	00113c23          	sd	ra,24(sp)
    80005158:	02010413          	addi	s0,sp,32
    8000515c:	00000097          	auipc	ra,0x0
    80005160:	0c4080e7          	jalr	196(ra) # 80005220 <cpuid>
    80005164:	00005497          	auipc	s1,0x5
    80005168:	d2c48493          	addi	s1,s1,-724 # 80009e90 <started>
    8000516c:	02050263          	beqz	a0,80005190 <system_main+0x48>
    80005170:	0004a783          	lw	a5,0(s1)
    80005174:	0007879b          	sext.w	a5,a5
    80005178:	fe078ce3          	beqz	a5,80005170 <system_main+0x28>
    8000517c:	0ff0000f          	fence
    80005180:	00003517          	auipc	a0,0x3
    80005184:	62050513          	addi	a0,a0,1568 # 800087a0 <_ZTV7WorkerD+0x58>
    80005188:	00001097          	auipc	ra,0x1
    8000518c:	a74080e7          	jalr	-1420(ra) # 80005bfc <panic>
    80005190:	00001097          	auipc	ra,0x1
    80005194:	9c8080e7          	jalr	-1592(ra) # 80005b58 <consoleinit>
    80005198:	00001097          	auipc	ra,0x1
    8000519c:	154080e7          	jalr	340(ra) # 800062ec <printfinit>
    800051a0:	00003517          	auipc	a0,0x3
    800051a4:	19050513          	addi	a0,a0,400 # 80008330 <CONSOLE_STATUS+0x320>
    800051a8:	00001097          	auipc	ra,0x1
    800051ac:	ab0080e7          	jalr	-1360(ra) # 80005c58 <__printf>
    800051b0:	00003517          	auipc	a0,0x3
    800051b4:	5c050513          	addi	a0,a0,1472 # 80008770 <_ZTV7WorkerD+0x28>
    800051b8:	00001097          	auipc	ra,0x1
    800051bc:	aa0080e7          	jalr	-1376(ra) # 80005c58 <__printf>
    800051c0:	00003517          	auipc	a0,0x3
    800051c4:	17050513          	addi	a0,a0,368 # 80008330 <CONSOLE_STATUS+0x320>
    800051c8:	00001097          	auipc	ra,0x1
    800051cc:	a90080e7          	jalr	-1392(ra) # 80005c58 <__printf>
    800051d0:	00001097          	auipc	ra,0x1
    800051d4:	4a8080e7          	jalr	1192(ra) # 80006678 <kinit>
    800051d8:	00000097          	auipc	ra,0x0
    800051dc:	148080e7          	jalr	328(ra) # 80005320 <trapinit>
    800051e0:	00000097          	auipc	ra,0x0
    800051e4:	16c080e7          	jalr	364(ra) # 8000534c <trapinithart>
    800051e8:	00000097          	auipc	ra,0x0
    800051ec:	5b8080e7          	jalr	1464(ra) # 800057a0 <plicinit>
    800051f0:	00000097          	auipc	ra,0x0
    800051f4:	5d8080e7          	jalr	1496(ra) # 800057c8 <plicinithart>
    800051f8:	00000097          	auipc	ra,0x0
    800051fc:	078080e7          	jalr	120(ra) # 80005270 <userinit>
    80005200:	0ff0000f          	fence
    80005204:	00100793          	li	a5,1
    80005208:	00003517          	auipc	a0,0x3
    8000520c:	58050513          	addi	a0,a0,1408 # 80008788 <_ZTV7WorkerD+0x40>
    80005210:	00f4a023          	sw	a5,0(s1)
    80005214:	00001097          	auipc	ra,0x1
    80005218:	a44080e7          	jalr	-1468(ra) # 80005c58 <__printf>
    8000521c:	0000006f          	j	8000521c <system_main+0xd4>

0000000080005220 <cpuid>:
    80005220:	ff010113          	addi	sp,sp,-16
    80005224:	00813423          	sd	s0,8(sp)
    80005228:	01010413          	addi	s0,sp,16
    8000522c:	00020513          	mv	a0,tp
    80005230:	00813403          	ld	s0,8(sp)
    80005234:	0005051b          	sext.w	a0,a0
    80005238:	01010113          	addi	sp,sp,16
    8000523c:	00008067          	ret

0000000080005240 <mycpu>:
    80005240:	ff010113          	addi	sp,sp,-16
    80005244:	00813423          	sd	s0,8(sp)
    80005248:	01010413          	addi	s0,sp,16
    8000524c:	00020793          	mv	a5,tp
    80005250:	00813403          	ld	s0,8(sp)
    80005254:	0007879b          	sext.w	a5,a5
    80005258:	00779793          	slli	a5,a5,0x7
    8000525c:	00006517          	auipc	a0,0x6
    80005260:	ca450513          	addi	a0,a0,-860 # 8000af00 <cpus>
    80005264:	00f50533          	add	a0,a0,a5
    80005268:	01010113          	addi	sp,sp,16
    8000526c:	00008067          	ret

0000000080005270 <userinit>:
    80005270:	ff010113          	addi	sp,sp,-16
    80005274:	00813423          	sd	s0,8(sp)
    80005278:	01010413          	addi	s0,sp,16
    8000527c:	00813403          	ld	s0,8(sp)
    80005280:	01010113          	addi	sp,sp,16
    80005284:	ffffd317          	auipc	t1,0xffffd
    80005288:	c3830067          	jr	-968(t1) # 80001ebc <main>

000000008000528c <either_copyout>:
    8000528c:	ff010113          	addi	sp,sp,-16
    80005290:	00813023          	sd	s0,0(sp)
    80005294:	00113423          	sd	ra,8(sp)
    80005298:	01010413          	addi	s0,sp,16
    8000529c:	02051663          	bnez	a0,800052c8 <either_copyout+0x3c>
    800052a0:	00058513          	mv	a0,a1
    800052a4:	00060593          	mv	a1,a2
    800052a8:	0006861b          	sext.w	a2,a3
    800052ac:	00002097          	auipc	ra,0x2
    800052b0:	c58080e7          	jalr	-936(ra) # 80006f04 <__memmove>
    800052b4:	00813083          	ld	ra,8(sp)
    800052b8:	00013403          	ld	s0,0(sp)
    800052bc:	00000513          	li	a0,0
    800052c0:	01010113          	addi	sp,sp,16
    800052c4:	00008067          	ret
    800052c8:	00003517          	auipc	a0,0x3
    800052cc:	50050513          	addi	a0,a0,1280 # 800087c8 <_ZTV7WorkerD+0x80>
    800052d0:	00001097          	auipc	ra,0x1
    800052d4:	92c080e7          	jalr	-1748(ra) # 80005bfc <panic>

00000000800052d8 <either_copyin>:
    800052d8:	ff010113          	addi	sp,sp,-16
    800052dc:	00813023          	sd	s0,0(sp)
    800052e0:	00113423          	sd	ra,8(sp)
    800052e4:	01010413          	addi	s0,sp,16
    800052e8:	02059463          	bnez	a1,80005310 <either_copyin+0x38>
    800052ec:	00060593          	mv	a1,a2
    800052f0:	0006861b          	sext.w	a2,a3
    800052f4:	00002097          	auipc	ra,0x2
    800052f8:	c10080e7          	jalr	-1008(ra) # 80006f04 <__memmove>
    800052fc:	00813083          	ld	ra,8(sp)
    80005300:	00013403          	ld	s0,0(sp)
    80005304:	00000513          	li	a0,0
    80005308:	01010113          	addi	sp,sp,16
    8000530c:	00008067          	ret
    80005310:	00003517          	auipc	a0,0x3
    80005314:	4e050513          	addi	a0,a0,1248 # 800087f0 <_ZTV7WorkerD+0xa8>
    80005318:	00001097          	auipc	ra,0x1
    8000531c:	8e4080e7          	jalr	-1820(ra) # 80005bfc <panic>

0000000080005320 <trapinit>:
    80005320:	ff010113          	addi	sp,sp,-16
    80005324:	00813423          	sd	s0,8(sp)
    80005328:	01010413          	addi	s0,sp,16
    8000532c:	00813403          	ld	s0,8(sp)
    80005330:	00003597          	auipc	a1,0x3
    80005334:	4e858593          	addi	a1,a1,1256 # 80008818 <_ZTV7WorkerD+0xd0>
    80005338:	00006517          	auipc	a0,0x6
    8000533c:	c4850513          	addi	a0,a0,-952 # 8000af80 <tickslock>
    80005340:	01010113          	addi	sp,sp,16
    80005344:	00001317          	auipc	t1,0x1
    80005348:	5c430067          	jr	1476(t1) # 80006908 <initlock>

000000008000534c <trapinithart>:
    8000534c:	ff010113          	addi	sp,sp,-16
    80005350:	00813423          	sd	s0,8(sp)
    80005354:	01010413          	addi	s0,sp,16
    80005358:	00000797          	auipc	a5,0x0
    8000535c:	2f878793          	addi	a5,a5,760 # 80005650 <kernelvec>
    80005360:	10579073          	csrw	stvec,a5
    80005364:	00813403          	ld	s0,8(sp)
    80005368:	01010113          	addi	sp,sp,16
    8000536c:	00008067          	ret

0000000080005370 <usertrap>:
    80005370:	ff010113          	addi	sp,sp,-16
    80005374:	00813423          	sd	s0,8(sp)
    80005378:	01010413          	addi	s0,sp,16
    8000537c:	00813403          	ld	s0,8(sp)
    80005380:	01010113          	addi	sp,sp,16
    80005384:	00008067          	ret

0000000080005388 <usertrapret>:
    80005388:	ff010113          	addi	sp,sp,-16
    8000538c:	00813423          	sd	s0,8(sp)
    80005390:	01010413          	addi	s0,sp,16
    80005394:	00813403          	ld	s0,8(sp)
    80005398:	01010113          	addi	sp,sp,16
    8000539c:	00008067          	ret

00000000800053a0 <kerneltrap>:
    800053a0:	fe010113          	addi	sp,sp,-32
    800053a4:	00813823          	sd	s0,16(sp)
    800053a8:	00113c23          	sd	ra,24(sp)
    800053ac:	00913423          	sd	s1,8(sp)
    800053b0:	02010413          	addi	s0,sp,32
    800053b4:	142025f3          	csrr	a1,scause
    800053b8:	100027f3          	csrr	a5,sstatus
    800053bc:	0027f793          	andi	a5,a5,2
    800053c0:	10079c63          	bnez	a5,800054d8 <kerneltrap+0x138>
    800053c4:	142027f3          	csrr	a5,scause
    800053c8:	0207ce63          	bltz	a5,80005404 <kerneltrap+0x64>
    800053cc:	00003517          	auipc	a0,0x3
    800053d0:	49450513          	addi	a0,a0,1172 # 80008860 <_ZTV7WorkerD+0x118>
    800053d4:	00001097          	auipc	ra,0x1
    800053d8:	884080e7          	jalr	-1916(ra) # 80005c58 <__printf>
    800053dc:	141025f3          	csrr	a1,sepc
    800053e0:	14302673          	csrr	a2,stval
    800053e4:	00003517          	auipc	a0,0x3
    800053e8:	48c50513          	addi	a0,a0,1164 # 80008870 <_ZTV7WorkerD+0x128>
    800053ec:	00001097          	auipc	ra,0x1
    800053f0:	86c080e7          	jalr	-1940(ra) # 80005c58 <__printf>
    800053f4:	00003517          	auipc	a0,0x3
    800053f8:	49450513          	addi	a0,a0,1172 # 80008888 <_ZTV7WorkerD+0x140>
    800053fc:	00001097          	auipc	ra,0x1
    80005400:	800080e7          	jalr	-2048(ra) # 80005bfc <panic>
    80005404:	0ff7f713          	andi	a4,a5,255
    80005408:	00900693          	li	a3,9
    8000540c:	04d70063          	beq	a4,a3,8000544c <kerneltrap+0xac>
    80005410:	fff00713          	li	a4,-1
    80005414:	03f71713          	slli	a4,a4,0x3f
    80005418:	00170713          	addi	a4,a4,1
    8000541c:	fae798e3          	bne	a5,a4,800053cc <kerneltrap+0x2c>
    80005420:	00000097          	auipc	ra,0x0
    80005424:	e00080e7          	jalr	-512(ra) # 80005220 <cpuid>
    80005428:	06050663          	beqz	a0,80005494 <kerneltrap+0xf4>
    8000542c:	144027f3          	csrr	a5,sip
    80005430:	ffd7f793          	andi	a5,a5,-3
    80005434:	14479073          	csrw	sip,a5
    80005438:	01813083          	ld	ra,24(sp)
    8000543c:	01013403          	ld	s0,16(sp)
    80005440:	00813483          	ld	s1,8(sp)
    80005444:	02010113          	addi	sp,sp,32
    80005448:	00008067          	ret
    8000544c:	00000097          	auipc	ra,0x0
    80005450:	3c8080e7          	jalr	968(ra) # 80005814 <plic_claim>
    80005454:	00a00793          	li	a5,10
    80005458:	00050493          	mv	s1,a0
    8000545c:	06f50863          	beq	a0,a5,800054cc <kerneltrap+0x12c>
    80005460:	fc050ce3          	beqz	a0,80005438 <kerneltrap+0x98>
    80005464:	00050593          	mv	a1,a0
    80005468:	00003517          	auipc	a0,0x3
    8000546c:	3d850513          	addi	a0,a0,984 # 80008840 <_ZTV7WorkerD+0xf8>
    80005470:	00000097          	auipc	ra,0x0
    80005474:	7e8080e7          	jalr	2024(ra) # 80005c58 <__printf>
    80005478:	01013403          	ld	s0,16(sp)
    8000547c:	01813083          	ld	ra,24(sp)
    80005480:	00048513          	mv	a0,s1
    80005484:	00813483          	ld	s1,8(sp)
    80005488:	02010113          	addi	sp,sp,32
    8000548c:	00000317          	auipc	t1,0x0
    80005490:	3c030067          	jr	960(t1) # 8000584c <plic_complete>
    80005494:	00006517          	auipc	a0,0x6
    80005498:	aec50513          	addi	a0,a0,-1300 # 8000af80 <tickslock>
    8000549c:	00001097          	auipc	ra,0x1
    800054a0:	490080e7          	jalr	1168(ra) # 8000692c <acquire>
    800054a4:	00005717          	auipc	a4,0x5
    800054a8:	9f070713          	addi	a4,a4,-1552 # 80009e94 <ticks>
    800054ac:	00072783          	lw	a5,0(a4)
    800054b0:	00006517          	auipc	a0,0x6
    800054b4:	ad050513          	addi	a0,a0,-1328 # 8000af80 <tickslock>
    800054b8:	0017879b          	addiw	a5,a5,1
    800054bc:	00f72023          	sw	a5,0(a4)
    800054c0:	00001097          	auipc	ra,0x1
    800054c4:	538080e7          	jalr	1336(ra) # 800069f8 <release>
    800054c8:	f65ff06f          	j	8000542c <kerneltrap+0x8c>
    800054cc:	00001097          	auipc	ra,0x1
    800054d0:	094080e7          	jalr	148(ra) # 80006560 <uartintr>
    800054d4:	fa5ff06f          	j	80005478 <kerneltrap+0xd8>
    800054d8:	00003517          	auipc	a0,0x3
    800054dc:	34850513          	addi	a0,a0,840 # 80008820 <_ZTV7WorkerD+0xd8>
    800054e0:	00000097          	auipc	ra,0x0
    800054e4:	71c080e7          	jalr	1820(ra) # 80005bfc <panic>

00000000800054e8 <clockintr>:
    800054e8:	fe010113          	addi	sp,sp,-32
    800054ec:	00813823          	sd	s0,16(sp)
    800054f0:	00913423          	sd	s1,8(sp)
    800054f4:	00113c23          	sd	ra,24(sp)
    800054f8:	02010413          	addi	s0,sp,32
    800054fc:	00006497          	auipc	s1,0x6
    80005500:	a8448493          	addi	s1,s1,-1404 # 8000af80 <tickslock>
    80005504:	00048513          	mv	a0,s1
    80005508:	00001097          	auipc	ra,0x1
    8000550c:	424080e7          	jalr	1060(ra) # 8000692c <acquire>
    80005510:	00005717          	auipc	a4,0x5
    80005514:	98470713          	addi	a4,a4,-1660 # 80009e94 <ticks>
    80005518:	00072783          	lw	a5,0(a4)
    8000551c:	01013403          	ld	s0,16(sp)
    80005520:	01813083          	ld	ra,24(sp)
    80005524:	00048513          	mv	a0,s1
    80005528:	0017879b          	addiw	a5,a5,1
    8000552c:	00813483          	ld	s1,8(sp)
    80005530:	00f72023          	sw	a5,0(a4)
    80005534:	02010113          	addi	sp,sp,32
    80005538:	00001317          	auipc	t1,0x1
    8000553c:	4c030067          	jr	1216(t1) # 800069f8 <release>

0000000080005540 <devintr>:
    80005540:	142027f3          	csrr	a5,scause
    80005544:	00000513          	li	a0,0
    80005548:	0007c463          	bltz	a5,80005550 <devintr+0x10>
    8000554c:	00008067          	ret
    80005550:	fe010113          	addi	sp,sp,-32
    80005554:	00813823          	sd	s0,16(sp)
    80005558:	00113c23          	sd	ra,24(sp)
    8000555c:	00913423          	sd	s1,8(sp)
    80005560:	02010413          	addi	s0,sp,32
    80005564:	0ff7f713          	andi	a4,a5,255
    80005568:	00900693          	li	a3,9
    8000556c:	04d70c63          	beq	a4,a3,800055c4 <devintr+0x84>
    80005570:	fff00713          	li	a4,-1
    80005574:	03f71713          	slli	a4,a4,0x3f
    80005578:	00170713          	addi	a4,a4,1
    8000557c:	00e78c63          	beq	a5,a4,80005594 <devintr+0x54>
    80005580:	01813083          	ld	ra,24(sp)
    80005584:	01013403          	ld	s0,16(sp)
    80005588:	00813483          	ld	s1,8(sp)
    8000558c:	02010113          	addi	sp,sp,32
    80005590:	00008067          	ret
    80005594:	00000097          	auipc	ra,0x0
    80005598:	c8c080e7          	jalr	-884(ra) # 80005220 <cpuid>
    8000559c:	06050663          	beqz	a0,80005608 <devintr+0xc8>
    800055a0:	144027f3          	csrr	a5,sip
    800055a4:	ffd7f793          	andi	a5,a5,-3
    800055a8:	14479073          	csrw	sip,a5
    800055ac:	01813083          	ld	ra,24(sp)
    800055b0:	01013403          	ld	s0,16(sp)
    800055b4:	00813483          	ld	s1,8(sp)
    800055b8:	00200513          	li	a0,2
    800055bc:	02010113          	addi	sp,sp,32
    800055c0:	00008067          	ret
    800055c4:	00000097          	auipc	ra,0x0
    800055c8:	250080e7          	jalr	592(ra) # 80005814 <plic_claim>
    800055cc:	00a00793          	li	a5,10
    800055d0:	00050493          	mv	s1,a0
    800055d4:	06f50663          	beq	a0,a5,80005640 <devintr+0x100>
    800055d8:	00100513          	li	a0,1
    800055dc:	fa0482e3          	beqz	s1,80005580 <devintr+0x40>
    800055e0:	00048593          	mv	a1,s1
    800055e4:	00003517          	auipc	a0,0x3
    800055e8:	25c50513          	addi	a0,a0,604 # 80008840 <_ZTV7WorkerD+0xf8>
    800055ec:	00000097          	auipc	ra,0x0
    800055f0:	66c080e7          	jalr	1644(ra) # 80005c58 <__printf>
    800055f4:	00048513          	mv	a0,s1
    800055f8:	00000097          	auipc	ra,0x0
    800055fc:	254080e7          	jalr	596(ra) # 8000584c <plic_complete>
    80005600:	00100513          	li	a0,1
    80005604:	f7dff06f          	j	80005580 <devintr+0x40>
    80005608:	00006517          	auipc	a0,0x6
    8000560c:	97850513          	addi	a0,a0,-1672 # 8000af80 <tickslock>
    80005610:	00001097          	auipc	ra,0x1
    80005614:	31c080e7          	jalr	796(ra) # 8000692c <acquire>
    80005618:	00005717          	auipc	a4,0x5
    8000561c:	87c70713          	addi	a4,a4,-1924 # 80009e94 <ticks>
    80005620:	00072783          	lw	a5,0(a4)
    80005624:	00006517          	auipc	a0,0x6
    80005628:	95c50513          	addi	a0,a0,-1700 # 8000af80 <tickslock>
    8000562c:	0017879b          	addiw	a5,a5,1
    80005630:	00f72023          	sw	a5,0(a4)
    80005634:	00001097          	auipc	ra,0x1
    80005638:	3c4080e7          	jalr	964(ra) # 800069f8 <release>
    8000563c:	f65ff06f          	j	800055a0 <devintr+0x60>
    80005640:	00001097          	auipc	ra,0x1
    80005644:	f20080e7          	jalr	-224(ra) # 80006560 <uartintr>
    80005648:	fadff06f          	j	800055f4 <devintr+0xb4>
    8000564c:	0000                	unimp
	...

0000000080005650 <kernelvec>:
    80005650:	f0010113          	addi	sp,sp,-256
    80005654:	00113023          	sd	ra,0(sp)
    80005658:	00213423          	sd	sp,8(sp)
    8000565c:	00313823          	sd	gp,16(sp)
    80005660:	00413c23          	sd	tp,24(sp)
    80005664:	02513023          	sd	t0,32(sp)
    80005668:	02613423          	sd	t1,40(sp)
    8000566c:	02713823          	sd	t2,48(sp)
    80005670:	02813c23          	sd	s0,56(sp)
    80005674:	04913023          	sd	s1,64(sp)
    80005678:	04a13423          	sd	a0,72(sp)
    8000567c:	04b13823          	sd	a1,80(sp)
    80005680:	04c13c23          	sd	a2,88(sp)
    80005684:	06d13023          	sd	a3,96(sp)
    80005688:	06e13423          	sd	a4,104(sp)
    8000568c:	06f13823          	sd	a5,112(sp)
    80005690:	07013c23          	sd	a6,120(sp)
    80005694:	09113023          	sd	a7,128(sp)
    80005698:	09213423          	sd	s2,136(sp)
    8000569c:	09313823          	sd	s3,144(sp)
    800056a0:	09413c23          	sd	s4,152(sp)
    800056a4:	0b513023          	sd	s5,160(sp)
    800056a8:	0b613423          	sd	s6,168(sp)
    800056ac:	0b713823          	sd	s7,176(sp)
    800056b0:	0b813c23          	sd	s8,184(sp)
    800056b4:	0d913023          	sd	s9,192(sp)
    800056b8:	0da13423          	sd	s10,200(sp)
    800056bc:	0db13823          	sd	s11,208(sp)
    800056c0:	0dc13c23          	sd	t3,216(sp)
    800056c4:	0fd13023          	sd	t4,224(sp)
    800056c8:	0fe13423          	sd	t5,232(sp)
    800056cc:	0ff13823          	sd	t6,240(sp)
    800056d0:	cd1ff0ef          	jal	ra,800053a0 <kerneltrap>
    800056d4:	00013083          	ld	ra,0(sp)
    800056d8:	00813103          	ld	sp,8(sp)
    800056dc:	01013183          	ld	gp,16(sp)
    800056e0:	02013283          	ld	t0,32(sp)
    800056e4:	02813303          	ld	t1,40(sp)
    800056e8:	03013383          	ld	t2,48(sp)
    800056ec:	03813403          	ld	s0,56(sp)
    800056f0:	04013483          	ld	s1,64(sp)
    800056f4:	04813503          	ld	a0,72(sp)
    800056f8:	05013583          	ld	a1,80(sp)
    800056fc:	05813603          	ld	a2,88(sp)
    80005700:	06013683          	ld	a3,96(sp)
    80005704:	06813703          	ld	a4,104(sp)
    80005708:	07013783          	ld	a5,112(sp)
    8000570c:	07813803          	ld	a6,120(sp)
    80005710:	08013883          	ld	a7,128(sp)
    80005714:	08813903          	ld	s2,136(sp)
    80005718:	09013983          	ld	s3,144(sp)
    8000571c:	09813a03          	ld	s4,152(sp)
    80005720:	0a013a83          	ld	s5,160(sp)
    80005724:	0a813b03          	ld	s6,168(sp)
    80005728:	0b013b83          	ld	s7,176(sp)
    8000572c:	0b813c03          	ld	s8,184(sp)
    80005730:	0c013c83          	ld	s9,192(sp)
    80005734:	0c813d03          	ld	s10,200(sp)
    80005738:	0d013d83          	ld	s11,208(sp)
    8000573c:	0d813e03          	ld	t3,216(sp)
    80005740:	0e013e83          	ld	t4,224(sp)
    80005744:	0e813f03          	ld	t5,232(sp)
    80005748:	0f013f83          	ld	t6,240(sp)
    8000574c:	10010113          	addi	sp,sp,256
    80005750:	10200073          	sret
    80005754:	00000013          	nop
    80005758:	00000013          	nop
    8000575c:	00000013          	nop

0000000080005760 <timervec>:
    80005760:	34051573          	csrrw	a0,mscratch,a0
    80005764:	00b53023          	sd	a1,0(a0)
    80005768:	00c53423          	sd	a2,8(a0)
    8000576c:	00d53823          	sd	a3,16(a0)
    80005770:	01853583          	ld	a1,24(a0)
    80005774:	02053603          	ld	a2,32(a0)
    80005778:	0005b683          	ld	a3,0(a1)
    8000577c:	00c686b3          	add	a3,a3,a2
    80005780:	00d5b023          	sd	a3,0(a1)
    80005784:	00200593          	li	a1,2
    80005788:	14459073          	csrw	sip,a1
    8000578c:	01053683          	ld	a3,16(a0)
    80005790:	00853603          	ld	a2,8(a0)
    80005794:	00053583          	ld	a1,0(a0)
    80005798:	34051573          	csrrw	a0,mscratch,a0
    8000579c:	30200073          	mret

00000000800057a0 <plicinit>:
    800057a0:	ff010113          	addi	sp,sp,-16
    800057a4:	00813423          	sd	s0,8(sp)
    800057a8:	01010413          	addi	s0,sp,16
    800057ac:	00813403          	ld	s0,8(sp)
    800057b0:	0c0007b7          	lui	a5,0xc000
    800057b4:	00100713          	li	a4,1
    800057b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800057bc:	00e7a223          	sw	a4,4(a5)
    800057c0:	01010113          	addi	sp,sp,16
    800057c4:	00008067          	ret

00000000800057c8 <plicinithart>:
    800057c8:	ff010113          	addi	sp,sp,-16
    800057cc:	00813023          	sd	s0,0(sp)
    800057d0:	00113423          	sd	ra,8(sp)
    800057d4:	01010413          	addi	s0,sp,16
    800057d8:	00000097          	auipc	ra,0x0
    800057dc:	a48080e7          	jalr	-1464(ra) # 80005220 <cpuid>
    800057e0:	0085171b          	slliw	a4,a0,0x8
    800057e4:	0c0027b7          	lui	a5,0xc002
    800057e8:	00e787b3          	add	a5,a5,a4
    800057ec:	40200713          	li	a4,1026
    800057f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800057f4:	00813083          	ld	ra,8(sp)
    800057f8:	00013403          	ld	s0,0(sp)
    800057fc:	00d5151b          	slliw	a0,a0,0xd
    80005800:	0c2017b7          	lui	a5,0xc201
    80005804:	00a78533          	add	a0,a5,a0
    80005808:	00052023          	sw	zero,0(a0)
    8000580c:	01010113          	addi	sp,sp,16
    80005810:	00008067          	ret

0000000080005814 <plic_claim>:
    80005814:	ff010113          	addi	sp,sp,-16
    80005818:	00813023          	sd	s0,0(sp)
    8000581c:	00113423          	sd	ra,8(sp)
    80005820:	01010413          	addi	s0,sp,16
    80005824:	00000097          	auipc	ra,0x0
    80005828:	9fc080e7          	jalr	-1540(ra) # 80005220 <cpuid>
    8000582c:	00813083          	ld	ra,8(sp)
    80005830:	00013403          	ld	s0,0(sp)
    80005834:	00d5151b          	slliw	a0,a0,0xd
    80005838:	0c2017b7          	lui	a5,0xc201
    8000583c:	00a78533          	add	a0,a5,a0
    80005840:	00452503          	lw	a0,4(a0)
    80005844:	01010113          	addi	sp,sp,16
    80005848:	00008067          	ret

000000008000584c <plic_complete>:
    8000584c:	fe010113          	addi	sp,sp,-32
    80005850:	00813823          	sd	s0,16(sp)
    80005854:	00913423          	sd	s1,8(sp)
    80005858:	00113c23          	sd	ra,24(sp)
    8000585c:	02010413          	addi	s0,sp,32
    80005860:	00050493          	mv	s1,a0
    80005864:	00000097          	auipc	ra,0x0
    80005868:	9bc080e7          	jalr	-1604(ra) # 80005220 <cpuid>
    8000586c:	01813083          	ld	ra,24(sp)
    80005870:	01013403          	ld	s0,16(sp)
    80005874:	00d5179b          	slliw	a5,a0,0xd
    80005878:	0c201737          	lui	a4,0xc201
    8000587c:	00f707b3          	add	a5,a4,a5
    80005880:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005884:	00813483          	ld	s1,8(sp)
    80005888:	02010113          	addi	sp,sp,32
    8000588c:	00008067          	ret

0000000080005890 <consolewrite>:
    80005890:	fb010113          	addi	sp,sp,-80
    80005894:	04813023          	sd	s0,64(sp)
    80005898:	04113423          	sd	ra,72(sp)
    8000589c:	02913c23          	sd	s1,56(sp)
    800058a0:	03213823          	sd	s2,48(sp)
    800058a4:	03313423          	sd	s3,40(sp)
    800058a8:	03413023          	sd	s4,32(sp)
    800058ac:	01513c23          	sd	s5,24(sp)
    800058b0:	05010413          	addi	s0,sp,80
    800058b4:	06c05c63          	blez	a2,8000592c <consolewrite+0x9c>
    800058b8:	00060993          	mv	s3,a2
    800058bc:	00050a13          	mv	s4,a0
    800058c0:	00058493          	mv	s1,a1
    800058c4:	00000913          	li	s2,0
    800058c8:	fff00a93          	li	s5,-1
    800058cc:	01c0006f          	j	800058e8 <consolewrite+0x58>
    800058d0:	fbf44503          	lbu	a0,-65(s0)
    800058d4:	0019091b          	addiw	s2,s2,1
    800058d8:	00148493          	addi	s1,s1,1
    800058dc:	00001097          	auipc	ra,0x1
    800058e0:	a9c080e7          	jalr	-1380(ra) # 80006378 <uartputc>
    800058e4:	03298063          	beq	s3,s2,80005904 <consolewrite+0x74>
    800058e8:	00048613          	mv	a2,s1
    800058ec:	00100693          	li	a3,1
    800058f0:	000a0593          	mv	a1,s4
    800058f4:	fbf40513          	addi	a0,s0,-65
    800058f8:	00000097          	auipc	ra,0x0
    800058fc:	9e0080e7          	jalr	-1568(ra) # 800052d8 <either_copyin>
    80005900:	fd5518e3          	bne	a0,s5,800058d0 <consolewrite+0x40>
    80005904:	04813083          	ld	ra,72(sp)
    80005908:	04013403          	ld	s0,64(sp)
    8000590c:	03813483          	ld	s1,56(sp)
    80005910:	02813983          	ld	s3,40(sp)
    80005914:	02013a03          	ld	s4,32(sp)
    80005918:	01813a83          	ld	s5,24(sp)
    8000591c:	00090513          	mv	a0,s2
    80005920:	03013903          	ld	s2,48(sp)
    80005924:	05010113          	addi	sp,sp,80
    80005928:	00008067          	ret
    8000592c:	00000913          	li	s2,0
    80005930:	fd5ff06f          	j	80005904 <consolewrite+0x74>

0000000080005934 <consoleread>:
    80005934:	f9010113          	addi	sp,sp,-112
    80005938:	06813023          	sd	s0,96(sp)
    8000593c:	04913c23          	sd	s1,88(sp)
    80005940:	05213823          	sd	s2,80(sp)
    80005944:	05313423          	sd	s3,72(sp)
    80005948:	05413023          	sd	s4,64(sp)
    8000594c:	03513c23          	sd	s5,56(sp)
    80005950:	03613823          	sd	s6,48(sp)
    80005954:	03713423          	sd	s7,40(sp)
    80005958:	03813023          	sd	s8,32(sp)
    8000595c:	06113423          	sd	ra,104(sp)
    80005960:	01913c23          	sd	s9,24(sp)
    80005964:	07010413          	addi	s0,sp,112
    80005968:	00060b93          	mv	s7,a2
    8000596c:	00050913          	mv	s2,a0
    80005970:	00058c13          	mv	s8,a1
    80005974:	00060b1b          	sext.w	s6,a2
    80005978:	00005497          	auipc	s1,0x5
    8000597c:	63048493          	addi	s1,s1,1584 # 8000afa8 <cons>
    80005980:	00400993          	li	s3,4
    80005984:	fff00a13          	li	s4,-1
    80005988:	00a00a93          	li	s5,10
    8000598c:	05705e63          	blez	s7,800059e8 <consoleread+0xb4>
    80005990:	09c4a703          	lw	a4,156(s1)
    80005994:	0984a783          	lw	a5,152(s1)
    80005998:	0007071b          	sext.w	a4,a4
    8000599c:	08e78463          	beq	a5,a4,80005a24 <consoleread+0xf0>
    800059a0:	07f7f713          	andi	a4,a5,127
    800059a4:	00e48733          	add	a4,s1,a4
    800059a8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800059ac:	0017869b          	addiw	a3,a5,1
    800059b0:	08d4ac23          	sw	a3,152(s1)
    800059b4:	00070c9b          	sext.w	s9,a4
    800059b8:	0b370663          	beq	a4,s3,80005a64 <consoleread+0x130>
    800059bc:	00100693          	li	a3,1
    800059c0:	f9f40613          	addi	a2,s0,-97
    800059c4:	000c0593          	mv	a1,s8
    800059c8:	00090513          	mv	a0,s2
    800059cc:	f8e40fa3          	sb	a4,-97(s0)
    800059d0:	00000097          	auipc	ra,0x0
    800059d4:	8bc080e7          	jalr	-1860(ra) # 8000528c <either_copyout>
    800059d8:	01450863          	beq	a0,s4,800059e8 <consoleread+0xb4>
    800059dc:	001c0c13          	addi	s8,s8,1
    800059e0:	fffb8b9b          	addiw	s7,s7,-1
    800059e4:	fb5c94e3          	bne	s9,s5,8000598c <consoleread+0x58>
    800059e8:	000b851b          	sext.w	a0,s7
    800059ec:	06813083          	ld	ra,104(sp)
    800059f0:	06013403          	ld	s0,96(sp)
    800059f4:	05813483          	ld	s1,88(sp)
    800059f8:	05013903          	ld	s2,80(sp)
    800059fc:	04813983          	ld	s3,72(sp)
    80005a00:	04013a03          	ld	s4,64(sp)
    80005a04:	03813a83          	ld	s5,56(sp)
    80005a08:	02813b83          	ld	s7,40(sp)
    80005a0c:	02013c03          	ld	s8,32(sp)
    80005a10:	01813c83          	ld	s9,24(sp)
    80005a14:	40ab053b          	subw	a0,s6,a0
    80005a18:	03013b03          	ld	s6,48(sp)
    80005a1c:	07010113          	addi	sp,sp,112
    80005a20:	00008067          	ret
    80005a24:	00001097          	auipc	ra,0x1
    80005a28:	1d8080e7          	jalr	472(ra) # 80006bfc <push_on>
    80005a2c:	0984a703          	lw	a4,152(s1)
    80005a30:	09c4a783          	lw	a5,156(s1)
    80005a34:	0007879b          	sext.w	a5,a5
    80005a38:	fef70ce3          	beq	a4,a5,80005a30 <consoleread+0xfc>
    80005a3c:	00001097          	auipc	ra,0x1
    80005a40:	234080e7          	jalr	564(ra) # 80006c70 <pop_on>
    80005a44:	0984a783          	lw	a5,152(s1)
    80005a48:	07f7f713          	andi	a4,a5,127
    80005a4c:	00e48733          	add	a4,s1,a4
    80005a50:	01874703          	lbu	a4,24(a4)
    80005a54:	0017869b          	addiw	a3,a5,1
    80005a58:	08d4ac23          	sw	a3,152(s1)
    80005a5c:	00070c9b          	sext.w	s9,a4
    80005a60:	f5371ee3          	bne	a4,s3,800059bc <consoleread+0x88>
    80005a64:	000b851b          	sext.w	a0,s7
    80005a68:	f96bf2e3          	bgeu	s7,s6,800059ec <consoleread+0xb8>
    80005a6c:	08f4ac23          	sw	a5,152(s1)
    80005a70:	f7dff06f          	j	800059ec <consoleread+0xb8>

0000000080005a74 <consputc>:
    80005a74:	10000793          	li	a5,256
    80005a78:	00f50663          	beq	a0,a5,80005a84 <consputc+0x10>
    80005a7c:	00001317          	auipc	t1,0x1
    80005a80:	9f430067          	jr	-1548(t1) # 80006470 <uartputc_sync>
    80005a84:	ff010113          	addi	sp,sp,-16
    80005a88:	00113423          	sd	ra,8(sp)
    80005a8c:	00813023          	sd	s0,0(sp)
    80005a90:	01010413          	addi	s0,sp,16
    80005a94:	00800513          	li	a0,8
    80005a98:	00001097          	auipc	ra,0x1
    80005a9c:	9d8080e7          	jalr	-1576(ra) # 80006470 <uartputc_sync>
    80005aa0:	02000513          	li	a0,32
    80005aa4:	00001097          	auipc	ra,0x1
    80005aa8:	9cc080e7          	jalr	-1588(ra) # 80006470 <uartputc_sync>
    80005aac:	00013403          	ld	s0,0(sp)
    80005ab0:	00813083          	ld	ra,8(sp)
    80005ab4:	00800513          	li	a0,8
    80005ab8:	01010113          	addi	sp,sp,16
    80005abc:	00001317          	auipc	t1,0x1
    80005ac0:	9b430067          	jr	-1612(t1) # 80006470 <uartputc_sync>

0000000080005ac4 <consoleintr>:
    80005ac4:	fe010113          	addi	sp,sp,-32
    80005ac8:	00813823          	sd	s0,16(sp)
    80005acc:	00913423          	sd	s1,8(sp)
    80005ad0:	01213023          	sd	s2,0(sp)
    80005ad4:	00113c23          	sd	ra,24(sp)
    80005ad8:	02010413          	addi	s0,sp,32
    80005adc:	00005917          	auipc	s2,0x5
    80005ae0:	4cc90913          	addi	s2,s2,1228 # 8000afa8 <cons>
    80005ae4:	00050493          	mv	s1,a0
    80005ae8:	00090513          	mv	a0,s2
    80005aec:	00001097          	auipc	ra,0x1
    80005af0:	e40080e7          	jalr	-448(ra) # 8000692c <acquire>
    80005af4:	02048c63          	beqz	s1,80005b2c <consoleintr+0x68>
    80005af8:	0a092783          	lw	a5,160(s2)
    80005afc:	09892703          	lw	a4,152(s2)
    80005b00:	07f00693          	li	a3,127
    80005b04:	40e7873b          	subw	a4,a5,a4
    80005b08:	02e6e263          	bltu	a3,a4,80005b2c <consoleintr+0x68>
    80005b0c:	00d00713          	li	a4,13
    80005b10:	04e48063          	beq	s1,a4,80005b50 <consoleintr+0x8c>
    80005b14:	07f7f713          	andi	a4,a5,127
    80005b18:	00e90733          	add	a4,s2,a4
    80005b1c:	0017879b          	addiw	a5,a5,1
    80005b20:	0af92023          	sw	a5,160(s2)
    80005b24:	00970c23          	sb	s1,24(a4)
    80005b28:	08f92e23          	sw	a5,156(s2)
    80005b2c:	01013403          	ld	s0,16(sp)
    80005b30:	01813083          	ld	ra,24(sp)
    80005b34:	00813483          	ld	s1,8(sp)
    80005b38:	00013903          	ld	s2,0(sp)
    80005b3c:	00005517          	auipc	a0,0x5
    80005b40:	46c50513          	addi	a0,a0,1132 # 8000afa8 <cons>
    80005b44:	02010113          	addi	sp,sp,32
    80005b48:	00001317          	auipc	t1,0x1
    80005b4c:	eb030067          	jr	-336(t1) # 800069f8 <release>
    80005b50:	00a00493          	li	s1,10
    80005b54:	fc1ff06f          	j	80005b14 <consoleintr+0x50>

0000000080005b58 <consoleinit>:
    80005b58:	fe010113          	addi	sp,sp,-32
    80005b5c:	00113c23          	sd	ra,24(sp)
    80005b60:	00813823          	sd	s0,16(sp)
    80005b64:	00913423          	sd	s1,8(sp)
    80005b68:	02010413          	addi	s0,sp,32
    80005b6c:	00005497          	auipc	s1,0x5
    80005b70:	43c48493          	addi	s1,s1,1084 # 8000afa8 <cons>
    80005b74:	00048513          	mv	a0,s1
    80005b78:	00003597          	auipc	a1,0x3
    80005b7c:	d2058593          	addi	a1,a1,-736 # 80008898 <_ZTV7WorkerD+0x150>
    80005b80:	00001097          	auipc	ra,0x1
    80005b84:	d88080e7          	jalr	-632(ra) # 80006908 <initlock>
    80005b88:	00000097          	auipc	ra,0x0
    80005b8c:	7ac080e7          	jalr	1964(ra) # 80006334 <uartinit>
    80005b90:	01813083          	ld	ra,24(sp)
    80005b94:	01013403          	ld	s0,16(sp)
    80005b98:	00000797          	auipc	a5,0x0
    80005b9c:	d9c78793          	addi	a5,a5,-612 # 80005934 <consoleread>
    80005ba0:	0af4bc23          	sd	a5,184(s1)
    80005ba4:	00000797          	auipc	a5,0x0
    80005ba8:	cec78793          	addi	a5,a5,-788 # 80005890 <consolewrite>
    80005bac:	0cf4b023          	sd	a5,192(s1)
    80005bb0:	00813483          	ld	s1,8(sp)
    80005bb4:	02010113          	addi	sp,sp,32
    80005bb8:	00008067          	ret

0000000080005bbc <console_read>:
    80005bbc:	ff010113          	addi	sp,sp,-16
    80005bc0:	00813423          	sd	s0,8(sp)
    80005bc4:	01010413          	addi	s0,sp,16
    80005bc8:	00813403          	ld	s0,8(sp)
    80005bcc:	00005317          	auipc	t1,0x5
    80005bd0:	49433303          	ld	t1,1172(t1) # 8000b060 <devsw+0x10>
    80005bd4:	01010113          	addi	sp,sp,16
    80005bd8:	00030067          	jr	t1

0000000080005bdc <console_write>:
    80005bdc:	ff010113          	addi	sp,sp,-16
    80005be0:	00813423          	sd	s0,8(sp)
    80005be4:	01010413          	addi	s0,sp,16
    80005be8:	00813403          	ld	s0,8(sp)
    80005bec:	00005317          	auipc	t1,0x5
    80005bf0:	47c33303          	ld	t1,1148(t1) # 8000b068 <devsw+0x18>
    80005bf4:	01010113          	addi	sp,sp,16
    80005bf8:	00030067          	jr	t1

0000000080005bfc <panic>:
    80005bfc:	fe010113          	addi	sp,sp,-32
    80005c00:	00113c23          	sd	ra,24(sp)
    80005c04:	00813823          	sd	s0,16(sp)
    80005c08:	00913423          	sd	s1,8(sp)
    80005c0c:	02010413          	addi	s0,sp,32
    80005c10:	00050493          	mv	s1,a0
    80005c14:	00003517          	auipc	a0,0x3
    80005c18:	c8c50513          	addi	a0,a0,-884 # 800088a0 <_ZTV7WorkerD+0x158>
    80005c1c:	00005797          	auipc	a5,0x5
    80005c20:	4e07a623          	sw	zero,1260(a5) # 8000b108 <pr+0x18>
    80005c24:	00000097          	auipc	ra,0x0
    80005c28:	034080e7          	jalr	52(ra) # 80005c58 <__printf>
    80005c2c:	00048513          	mv	a0,s1
    80005c30:	00000097          	auipc	ra,0x0
    80005c34:	028080e7          	jalr	40(ra) # 80005c58 <__printf>
    80005c38:	00002517          	auipc	a0,0x2
    80005c3c:	6f850513          	addi	a0,a0,1784 # 80008330 <CONSOLE_STATUS+0x320>
    80005c40:	00000097          	auipc	ra,0x0
    80005c44:	018080e7          	jalr	24(ra) # 80005c58 <__printf>
    80005c48:	00100793          	li	a5,1
    80005c4c:	00004717          	auipc	a4,0x4
    80005c50:	24f72623          	sw	a5,588(a4) # 80009e98 <panicked>
    80005c54:	0000006f          	j	80005c54 <panic+0x58>

0000000080005c58 <__printf>:
    80005c58:	f3010113          	addi	sp,sp,-208
    80005c5c:	08813023          	sd	s0,128(sp)
    80005c60:	07313423          	sd	s3,104(sp)
    80005c64:	09010413          	addi	s0,sp,144
    80005c68:	05813023          	sd	s8,64(sp)
    80005c6c:	08113423          	sd	ra,136(sp)
    80005c70:	06913c23          	sd	s1,120(sp)
    80005c74:	07213823          	sd	s2,112(sp)
    80005c78:	07413023          	sd	s4,96(sp)
    80005c7c:	05513c23          	sd	s5,88(sp)
    80005c80:	05613823          	sd	s6,80(sp)
    80005c84:	05713423          	sd	s7,72(sp)
    80005c88:	03913c23          	sd	s9,56(sp)
    80005c8c:	03a13823          	sd	s10,48(sp)
    80005c90:	03b13423          	sd	s11,40(sp)
    80005c94:	00005317          	auipc	t1,0x5
    80005c98:	45c30313          	addi	t1,t1,1116 # 8000b0f0 <pr>
    80005c9c:	01832c03          	lw	s8,24(t1)
    80005ca0:	00b43423          	sd	a1,8(s0)
    80005ca4:	00c43823          	sd	a2,16(s0)
    80005ca8:	00d43c23          	sd	a3,24(s0)
    80005cac:	02e43023          	sd	a4,32(s0)
    80005cb0:	02f43423          	sd	a5,40(s0)
    80005cb4:	03043823          	sd	a6,48(s0)
    80005cb8:	03143c23          	sd	a7,56(s0)
    80005cbc:	00050993          	mv	s3,a0
    80005cc0:	4a0c1663          	bnez	s8,8000616c <__printf+0x514>
    80005cc4:	60098c63          	beqz	s3,800062dc <__printf+0x684>
    80005cc8:	0009c503          	lbu	a0,0(s3)
    80005ccc:	00840793          	addi	a5,s0,8
    80005cd0:	f6f43c23          	sd	a5,-136(s0)
    80005cd4:	00000493          	li	s1,0
    80005cd8:	22050063          	beqz	a0,80005ef8 <__printf+0x2a0>
    80005cdc:	00002a37          	lui	s4,0x2
    80005ce0:	00018ab7          	lui	s5,0x18
    80005ce4:	000f4b37          	lui	s6,0xf4
    80005ce8:	00989bb7          	lui	s7,0x989
    80005cec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005cf0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005cf4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005cf8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005cfc:	00148c9b          	addiw	s9,s1,1
    80005d00:	02500793          	li	a5,37
    80005d04:	01998933          	add	s2,s3,s9
    80005d08:	38f51263          	bne	a0,a5,8000608c <__printf+0x434>
    80005d0c:	00094783          	lbu	a5,0(s2)
    80005d10:	00078c9b          	sext.w	s9,a5
    80005d14:	1e078263          	beqz	a5,80005ef8 <__printf+0x2a0>
    80005d18:	0024849b          	addiw	s1,s1,2
    80005d1c:	07000713          	li	a4,112
    80005d20:	00998933          	add	s2,s3,s1
    80005d24:	38e78a63          	beq	a5,a4,800060b8 <__printf+0x460>
    80005d28:	20f76863          	bltu	a4,a5,80005f38 <__printf+0x2e0>
    80005d2c:	42a78863          	beq	a5,a0,8000615c <__printf+0x504>
    80005d30:	06400713          	li	a4,100
    80005d34:	40e79663          	bne	a5,a4,80006140 <__printf+0x4e8>
    80005d38:	f7843783          	ld	a5,-136(s0)
    80005d3c:	0007a603          	lw	a2,0(a5)
    80005d40:	00878793          	addi	a5,a5,8
    80005d44:	f6f43c23          	sd	a5,-136(s0)
    80005d48:	42064a63          	bltz	a2,8000617c <__printf+0x524>
    80005d4c:	00a00713          	li	a4,10
    80005d50:	02e677bb          	remuw	a5,a2,a4
    80005d54:	00003d97          	auipc	s11,0x3
    80005d58:	b74d8d93          	addi	s11,s11,-1164 # 800088c8 <digits>
    80005d5c:	00900593          	li	a1,9
    80005d60:	0006051b          	sext.w	a0,a2
    80005d64:	00000c93          	li	s9,0
    80005d68:	02079793          	slli	a5,a5,0x20
    80005d6c:	0207d793          	srli	a5,a5,0x20
    80005d70:	00fd87b3          	add	a5,s11,a5
    80005d74:	0007c783          	lbu	a5,0(a5)
    80005d78:	02e656bb          	divuw	a3,a2,a4
    80005d7c:	f8f40023          	sb	a5,-128(s0)
    80005d80:	14c5d863          	bge	a1,a2,80005ed0 <__printf+0x278>
    80005d84:	06300593          	li	a1,99
    80005d88:	00100c93          	li	s9,1
    80005d8c:	02e6f7bb          	remuw	a5,a3,a4
    80005d90:	02079793          	slli	a5,a5,0x20
    80005d94:	0207d793          	srli	a5,a5,0x20
    80005d98:	00fd87b3          	add	a5,s11,a5
    80005d9c:	0007c783          	lbu	a5,0(a5)
    80005da0:	02e6d73b          	divuw	a4,a3,a4
    80005da4:	f8f400a3          	sb	a5,-127(s0)
    80005da8:	12a5f463          	bgeu	a1,a0,80005ed0 <__printf+0x278>
    80005dac:	00a00693          	li	a3,10
    80005db0:	00900593          	li	a1,9
    80005db4:	02d777bb          	remuw	a5,a4,a3
    80005db8:	02079793          	slli	a5,a5,0x20
    80005dbc:	0207d793          	srli	a5,a5,0x20
    80005dc0:	00fd87b3          	add	a5,s11,a5
    80005dc4:	0007c503          	lbu	a0,0(a5)
    80005dc8:	02d757bb          	divuw	a5,a4,a3
    80005dcc:	f8a40123          	sb	a0,-126(s0)
    80005dd0:	48e5f263          	bgeu	a1,a4,80006254 <__printf+0x5fc>
    80005dd4:	06300513          	li	a0,99
    80005dd8:	02d7f5bb          	remuw	a1,a5,a3
    80005ddc:	02059593          	slli	a1,a1,0x20
    80005de0:	0205d593          	srli	a1,a1,0x20
    80005de4:	00bd85b3          	add	a1,s11,a1
    80005de8:	0005c583          	lbu	a1,0(a1)
    80005dec:	02d7d7bb          	divuw	a5,a5,a3
    80005df0:	f8b401a3          	sb	a1,-125(s0)
    80005df4:	48e57263          	bgeu	a0,a4,80006278 <__printf+0x620>
    80005df8:	3e700513          	li	a0,999
    80005dfc:	02d7f5bb          	remuw	a1,a5,a3
    80005e00:	02059593          	slli	a1,a1,0x20
    80005e04:	0205d593          	srli	a1,a1,0x20
    80005e08:	00bd85b3          	add	a1,s11,a1
    80005e0c:	0005c583          	lbu	a1,0(a1)
    80005e10:	02d7d7bb          	divuw	a5,a5,a3
    80005e14:	f8b40223          	sb	a1,-124(s0)
    80005e18:	46e57663          	bgeu	a0,a4,80006284 <__printf+0x62c>
    80005e1c:	02d7f5bb          	remuw	a1,a5,a3
    80005e20:	02059593          	slli	a1,a1,0x20
    80005e24:	0205d593          	srli	a1,a1,0x20
    80005e28:	00bd85b3          	add	a1,s11,a1
    80005e2c:	0005c583          	lbu	a1,0(a1)
    80005e30:	02d7d7bb          	divuw	a5,a5,a3
    80005e34:	f8b402a3          	sb	a1,-123(s0)
    80005e38:	46ea7863          	bgeu	s4,a4,800062a8 <__printf+0x650>
    80005e3c:	02d7f5bb          	remuw	a1,a5,a3
    80005e40:	02059593          	slli	a1,a1,0x20
    80005e44:	0205d593          	srli	a1,a1,0x20
    80005e48:	00bd85b3          	add	a1,s11,a1
    80005e4c:	0005c583          	lbu	a1,0(a1)
    80005e50:	02d7d7bb          	divuw	a5,a5,a3
    80005e54:	f8b40323          	sb	a1,-122(s0)
    80005e58:	3eeaf863          	bgeu	s5,a4,80006248 <__printf+0x5f0>
    80005e5c:	02d7f5bb          	remuw	a1,a5,a3
    80005e60:	02059593          	slli	a1,a1,0x20
    80005e64:	0205d593          	srli	a1,a1,0x20
    80005e68:	00bd85b3          	add	a1,s11,a1
    80005e6c:	0005c583          	lbu	a1,0(a1)
    80005e70:	02d7d7bb          	divuw	a5,a5,a3
    80005e74:	f8b403a3          	sb	a1,-121(s0)
    80005e78:	42eb7e63          	bgeu	s6,a4,800062b4 <__printf+0x65c>
    80005e7c:	02d7f5bb          	remuw	a1,a5,a3
    80005e80:	02059593          	slli	a1,a1,0x20
    80005e84:	0205d593          	srli	a1,a1,0x20
    80005e88:	00bd85b3          	add	a1,s11,a1
    80005e8c:	0005c583          	lbu	a1,0(a1)
    80005e90:	02d7d7bb          	divuw	a5,a5,a3
    80005e94:	f8b40423          	sb	a1,-120(s0)
    80005e98:	42ebfc63          	bgeu	s7,a4,800062d0 <__printf+0x678>
    80005e9c:	02079793          	slli	a5,a5,0x20
    80005ea0:	0207d793          	srli	a5,a5,0x20
    80005ea4:	00fd8db3          	add	s11,s11,a5
    80005ea8:	000dc703          	lbu	a4,0(s11)
    80005eac:	00a00793          	li	a5,10
    80005eb0:	00900c93          	li	s9,9
    80005eb4:	f8e404a3          	sb	a4,-119(s0)
    80005eb8:	00065c63          	bgez	a2,80005ed0 <__printf+0x278>
    80005ebc:	f9040713          	addi	a4,s0,-112
    80005ec0:	00f70733          	add	a4,a4,a5
    80005ec4:	02d00693          	li	a3,45
    80005ec8:	fed70823          	sb	a3,-16(a4)
    80005ecc:	00078c93          	mv	s9,a5
    80005ed0:	f8040793          	addi	a5,s0,-128
    80005ed4:	01978cb3          	add	s9,a5,s9
    80005ed8:	f7f40d13          	addi	s10,s0,-129
    80005edc:	000cc503          	lbu	a0,0(s9)
    80005ee0:	fffc8c93          	addi	s9,s9,-1
    80005ee4:	00000097          	auipc	ra,0x0
    80005ee8:	b90080e7          	jalr	-1136(ra) # 80005a74 <consputc>
    80005eec:	ffac98e3          	bne	s9,s10,80005edc <__printf+0x284>
    80005ef0:	00094503          	lbu	a0,0(s2)
    80005ef4:	e00514e3          	bnez	a0,80005cfc <__printf+0xa4>
    80005ef8:	1a0c1663          	bnez	s8,800060a4 <__printf+0x44c>
    80005efc:	08813083          	ld	ra,136(sp)
    80005f00:	08013403          	ld	s0,128(sp)
    80005f04:	07813483          	ld	s1,120(sp)
    80005f08:	07013903          	ld	s2,112(sp)
    80005f0c:	06813983          	ld	s3,104(sp)
    80005f10:	06013a03          	ld	s4,96(sp)
    80005f14:	05813a83          	ld	s5,88(sp)
    80005f18:	05013b03          	ld	s6,80(sp)
    80005f1c:	04813b83          	ld	s7,72(sp)
    80005f20:	04013c03          	ld	s8,64(sp)
    80005f24:	03813c83          	ld	s9,56(sp)
    80005f28:	03013d03          	ld	s10,48(sp)
    80005f2c:	02813d83          	ld	s11,40(sp)
    80005f30:	0d010113          	addi	sp,sp,208
    80005f34:	00008067          	ret
    80005f38:	07300713          	li	a4,115
    80005f3c:	1ce78a63          	beq	a5,a4,80006110 <__printf+0x4b8>
    80005f40:	07800713          	li	a4,120
    80005f44:	1ee79e63          	bne	a5,a4,80006140 <__printf+0x4e8>
    80005f48:	f7843783          	ld	a5,-136(s0)
    80005f4c:	0007a703          	lw	a4,0(a5)
    80005f50:	00878793          	addi	a5,a5,8
    80005f54:	f6f43c23          	sd	a5,-136(s0)
    80005f58:	28074263          	bltz	a4,800061dc <__printf+0x584>
    80005f5c:	00003d97          	auipc	s11,0x3
    80005f60:	96cd8d93          	addi	s11,s11,-1684 # 800088c8 <digits>
    80005f64:	00f77793          	andi	a5,a4,15
    80005f68:	00fd87b3          	add	a5,s11,a5
    80005f6c:	0007c683          	lbu	a3,0(a5)
    80005f70:	00f00613          	li	a2,15
    80005f74:	0007079b          	sext.w	a5,a4
    80005f78:	f8d40023          	sb	a3,-128(s0)
    80005f7c:	0047559b          	srliw	a1,a4,0x4
    80005f80:	0047569b          	srliw	a3,a4,0x4
    80005f84:	00000c93          	li	s9,0
    80005f88:	0ee65063          	bge	a2,a4,80006068 <__printf+0x410>
    80005f8c:	00f6f693          	andi	a3,a3,15
    80005f90:	00dd86b3          	add	a3,s11,a3
    80005f94:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005f98:	0087d79b          	srliw	a5,a5,0x8
    80005f9c:	00100c93          	li	s9,1
    80005fa0:	f8d400a3          	sb	a3,-127(s0)
    80005fa4:	0cb67263          	bgeu	a2,a1,80006068 <__printf+0x410>
    80005fa8:	00f7f693          	andi	a3,a5,15
    80005fac:	00dd86b3          	add	a3,s11,a3
    80005fb0:	0006c583          	lbu	a1,0(a3)
    80005fb4:	00f00613          	li	a2,15
    80005fb8:	0047d69b          	srliw	a3,a5,0x4
    80005fbc:	f8b40123          	sb	a1,-126(s0)
    80005fc0:	0047d593          	srli	a1,a5,0x4
    80005fc4:	28f67e63          	bgeu	a2,a5,80006260 <__printf+0x608>
    80005fc8:	00f6f693          	andi	a3,a3,15
    80005fcc:	00dd86b3          	add	a3,s11,a3
    80005fd0:	0006c503          	lbu	a0,0(a3)
    80005fd4:	0087d813          	srli	a6,a5,0x8
    80005fd8:	0087d69b          	srliw	a3,a5,0x8
    80005fdc:	f8a401a3          	sb	a0,-125(s0)
    80005fe0:	28b67663          	bgeu	a2,a1,8000626c <__printf+0x614>
    80005fe4:	00f6f693          	andi	a3,a3,15
    80005fe8:	00dd86b3          	add	a3,s11,a3
    80005fec:	0006c583          	lbu	a1,0(a3)
    80005ff0:	00c7d513          	srli	a0,a5,0xc
    80005ff4:	00c7d69b          	srliw	a3,a5,0xc
    80005ff8:	f8b40223          	sb	a1,-124(s0)
    80005ffc:	29067a63          	bgeu	a2,a6,80006290 <__printf+0x638>
    80006000:	00f6f693          	andi	a3,a3,15
    80006004:	00dd86b3          	add	a3,s11,a3
    80006008:	0006c583          	lbu	a1,0(a3)
    8000600c:	0107d813          	srli	a6,a5,0x10
    80006010:	0107d69b          	srliw	a3,a5,0x10
    80006014:	f8b402a3          	sb	a1,-123(s0)
    80006018:	28a67263          	bgeu	a2,a0,8000629c <__printf+0x644>
    8000601c:	00f6f693          	andi	a3,a3,15
    80006020:	00dd86b3          	add	a3,s11,a3
    80006024:	0006c683          	lbu	a3,0(a3)
    80006028:	0147d79b          	srliw	a5,a5,0x14
    8000602c:	f8d40323          	sb	a3,-122(s0)
    80006030:	21067663          	bgeu	a2,a6,8000623c <__printf+0x5e4>
    80006034:	02079793          	slli	a5,a5,0x20
    80006038:	0207d793          	srli	a5,a5,0x20
    8000603c:	00fd8db3          	add	s11,s11,a5
    80006040:	000dc683          	lbu	a3,0(s11)
    80006044:	00800793          	li	a5,8
    80006048:	00700c93          	li	s9,7
    8000604c:	f8d403a3          	sb	a3,-121(s0)
    80006050:	00075c63          	bgez	a4,80006068 <__printf+0x410>
    80006054:	f9040713          	addi	a4,s0,-112
    80006058:	00f70733          	add	a4,a4,a5
    8000605c:	02d00693          	li	a3,45
    80006060:	fed70823          	sb	a3,-16(a4)
    80006064:	00078c93          	mv	s9,a5
    80006068:	f8040793          	addi	a5,s0,-128
    8000606c:	01978cb3          	add	s9,a5,s9
    80006070:	f7f40d13          	addi	s10,s0,-129
    80006074:	000cc503          	lbu	a0,0(s9)
    80006078:	fffc8c93          	addi	s9,s9,-1
    8000607c:	00000097          	auipc	ra,0x0
    80006080:	9f8080e7          	jalr	-1544(ra) # 80005a74 <consputc>
    80006084:	ff9d18e3          	bne	s10,s9,80006074 <__printf+0x41c>
    80006088:	0100006f          	j	80006098 <__printf+0x440>
    8000608c:	00000097          	auipc	ra,0x0
    80006090:	9e8080e7          	jalr	-1560(ra) # 80005a74 <consputc>
    80006094:	000c8493          	mv	s1,s9
    80006098:	00094503          	lbu	a0,0(s2)
    8000609c:	c60510e3          	bnez	a0,80005cfc <__printf+0xa4>
    800060a0:	e40c0ee3          	beqz	s8,80005efc <__printf+0x2a4>
    800060a4:	00005517          	auipc	a0,0x5
    800060a8:	04c50513          	addi	a0,a0,76 # 8000b0f0 <pr>
    800060ac:	00001097          	auipc	ra,0x1
    800060b0:	94c080e7          	jalr	-1716(ra) # 800069f8 <release>
    800060b4:	e49ff06f          	j	80005efc <__printf+0x2a4>
    800060b8:	f7843783          	ld	a5,-136(s0)
    800060bc:	03000513          	li	a0,48
    800060c0:	01000d13          	li	s10,16
    800060c4:	00878713          	addi	a4,a5,8
    800060c8:	0007bc83          	ld	s9,0(a5)
    800060cc:	f6e43c23          	sd	a4,-136(s0)
    800060d0:	00000097          	auipc	ra,0x0
    800060d4:	9a4080e7          	jalr	-1628(ra) # 80005a74 <consputc>
    800060d8:	07800513          	li	a0,120
    800060dc:	00000097          	auipc	ra,0x0
    800060e0:	998080e7          	jalr	-1640(ra) # 80005a74 <consputc>
    800060e4:	00002d97          	auipc	s11,0x2
    800060e8:	7e4d8d93          	addi	s11,s11,2020 # 800088c8 <digits>
    800060ec:	03ccd793          	srli	a5,s9,0x3c
    800060f0:	00fd87b3          	add	a5,s11,a5
    800060f4:	0007c503          	lbu	a0,0(a5)
    800060f8:	fffd0d1b          	addiw	s10,s10,-1
    800060fc:	004c9c93          	slli	s9,s9,0x4
    80006100:	00000097          	auipc	ra,0x0
    80006104:	974080e7          	jalr	-1676(ra) # 80005a74 <consputc>
    80006108:	fe0d12e3          	bnez	s10,800060ec <__printf+0x494>
    8000610c:	f8dff06f          	j	80006098 <__printf+0x440>
    80006110:	f7843783          	ld	a5,-136(s0)
    80006114:	0007bc83          	ld	s9,0(a5)
    80006118:	00878793          	addi	a5,a5,8
    8000611c:	f6f43c23          	sd	a5,-136(s0)
    80006120:	000c9a63          	bnez	s9,80006134 <__printf+0x4dc>
    80006124:	1080006f          	j	8000622c <__printf+0x5d4>
    80006128:	001c8c93          	addi	s9,s9,1
    8000612c:	00000097          	auipc	ra,0x0
    80006130:	948080e7          	jalr	-1720(ra) # 80005a74 <consputc>
    80006134:	000cc503          	lbu	a0,0(s9)
    80006138:	fe0518e3          	bnez	a0,80006128 <__printf+0x4d0>
    8000613c:	f5dff06f          	j	80006098 <__printf+0x440>
    80006140:	02500513          	li	a0,37
    80006144:	00000097          	auipc	ra,0x0
    80006148:	930080e7          	jalr	-1744(ra) # 80005a74 <consputc>
    8000614c:	000c8513          	mv	a0,s9
    80006150:	00000097          	auipc	ra,0x0
    80006154:	924080e7          	jalr	-1756(ra) # 80005a74 <consputc>
    80006158:	f41ff06f          	j	80006098 <__printf+0x440>
    8000615c:	02500513          	li	a0,37
    80006160:	00000097          	auipc	ra,0x0
    80006164:	914080e7          	jalr	-1772(ra) # 80005a74 <consputc>
    80006168:	f31ff06f          	j	80006098 <__printf+0x440>
    8000616c:	00030513          	mv	a0,t1
    80006170:	00000097          	auipc	ra,0x0
    80006174:	7bc080e7          	jalr	1980(ra) # 8000692c <acquire>
    80006178:	b4dff06f          	j	80005cc4 <__printf+0x6c>
    8000617c:	40c0053b          	negw	a0,a2
    80006180:	00a00713          	li	a4,10
    80006184:	02e576bb          	remuw	a3,a0,a4
    80006188:	00002d97          	auipc	s11,0x2
    8000618c:	740d8d93          	addi	s11,s11,1856 # 800088c8 <digits>
    80006190:	ff700593          	li	a1,-9
    80006194:	02069693          	slli	a3,a3,0x20
    80006198:	0206d693          	srli	a3,a3,0x20
    8000619c:	00dd86b3          	add	a3,s11,a3
    800061a0:	0006c683          	lbu	a3,0(a3)
    800061a4:	02e557bb          	divuw	a5,a0,a4
    800061a8:	f8d40023          	sb	a3,-128(s0)
    800061ac:	10b65e63          	bge	a2,a1,800062c8 <__printf+0x670>
    800061b0:	06300593          	li	a1,99
    800061b4:	02e7f6bb          	remuw	a3,a5,a4
    800061b8:	02069693          	slli	a3,a3,0x20
    800061bc:	0206d693          	srli	a3,a3,0x20
    800061c0:	00dd86b3          	add	a3,s11,a3
    800061c4:	0006c683          	lbu	a3,0(a3)
    800061c8:	02e7d73b          	divuw	a4,a5,a4
    800061cc:	00200793          	li	a5,2
    800061d0:	f8d400a3          	sb	a3,-127(s0)
    800061d4:	bca5ece3          	bltu	a1,a0,80005dac <__printf+0x154>
    800061d8:	ce5ff06f          	j	80005ebc <__printf+0x264>
    800061dc:	40e007bb          	negw	a5,a4
    800061e0:	00002d97          	auipc	s11,0x2
    800061e4:	6e8d8d93          	addi	s11,s11,1768 # 800088c8 <digits>
    800061e8:	00f7f693          	andi	a3,a5,15
    800061ec:	00dd86b3          	add	a3,s11,a3
    800061f0:	0006c583          	lbu	a1,0(a3)
    800061f4:	ff100613          	li	a2,-15
    800061f8:	0047d69b          	srliw	a3,a5,0x4
    800061fc:	f8b40023          	sb	a1,-128(s0)
    80006200:	0047d59b          	srliw	a1,a5,0x4
    80006204:	0ac75e63          	bge	a4,a2,800062c0 <__printf+0x668>
    80006208:	00f6f693          	andi	a3,a3,15
    8000620c:	00dd86b3          	add	a3,s11,a3
    80006210:	0006c603          	lbu	a2,0(a3)
    80006214:	00f00693          	li	a3,15
    80006218:	0087d79b          	srliw	a5,a5,0x8
    8000621c:	f8c400a3          	sb	a2,-127(s0)
    80006220:	d8b6e4e3          	bltu	a3,a1,80005fa8 <__printf+0x350>
    80006224:	00200793          	li	a5,2
    80006228:	e2dff06f          	j	80006054 <__printf+0x3fc>
    8000622c:	00002c97          	auipc	s9,0x2
    80006230:	67cc8c93          	addi	s9,s9,1660 # 800088a8 <_ZTV7WorkerD+0x160>
    80006234:	02800513          	li	a0,40
    80006238:	ef1ff06f          	j	80006128 <__printf+0x4d0>
    8000623c:	00700793          	li	a5,7
    80006240:	00600c93          	li	s9,6
    80006244:	e0dff06f          	j	80006050 <__printf+0x3f8>
    80006248:	00700793          	li	a5,7
    8000624c:	00600c93          	li	s9,6
    80006250:	c69ff06f          	j	80005eb8 <__printf+0x260>
    80006254:	00300793          	li	a5,3
    80006258:	00200c93          	li	s9,2
    8000625c:	c5dff06f          	j	80005eb8 <__printf+0x260>
    80006260:	00300793          	li	a5,3
    80006264:	00200c93          	li	s9,2
    80006268:	de9ff06f          	j	80006050 <__printf+0x3f8>
    8000626c:	00400793          	li	a5,4
    80006270:	00300c93          	li	s9,3
    80006274:	dddff06f          	j	80006050 <__printf+0x3f8>
    80006278:	00400793          	li	a5,4
    8000627c:	00300c93          	li	s9,3
    80006280:	c39ff06f          	j	80005eb8 <__printf+0x260>
    80006284:	00500793          	li	a5,5
    80006288:	00400c93          	li	s9,4
    8000628c:	c2dff06f          	j	80005eb8 <__printf+0x260>
    80006290:	00500793          	li	a5,5
    80006294:	00400c93          	li	s9,4
    80006298:	db9ff06f          	j	80006050 <__printf+0x3f8>
    8000629c:	00600793          	li	a5,6
    800062a0:	00500c93          	li	s9,5
    800062a4:	dadff06f          	j	80006050 <__printf+0x3f8>
    800062a8:	00600793          	li	a5,6
    800062ac:	00500c93          	li	s9,5
    800062b0:	c09ff06f          	j	80005eb8 <__printf+0x260>
    800062b4:	00800793          	li	a5,8
    800062b8:	00700c93          	li	s9,7
    800062bc:	bfdff06f          	j	80005eb8 <__printf+0x260>
    800062c0:	00100793          	li	a5,1
    800062c4:	d91ff06f          	j	80006054 <__printf+0x3fc>
    800062c8:	00100793          	li	a5,1
    800062cc:	bf1ff06f          	j	80005ebc <__printf+0x264>
    800062d0:	00900793          	li	a5,9
    800062d4:	00800c93          	li	s9,8
    800062d8:	be1ff06f          	j	80005eb8 <__printf+0x260>
    800062dc:	00002517          	auipc	a0,0x2
    800062e0:	5d450513          	addi	a0,a0,1492 # 800088b0 <_ZTV7WorkerD+0x168>
    800062e4:	00000097          	auipc	ra,0x0
    800062e8:	918080e7          	jalr	-1768(ra) # 80005bfc <panic>

00000000800062ec <printfinit>:
    800062ec:	fe010113          	addi	sp,sp,-32
    800062f0:	00813823          	sd	s0,16(sp)
    800062f4:	00913423          	sd	s1,8(sp)
    800062f8:	00113c23          	sd	ra,24(sp)
    800062fc:	02010413          	addi	s0,sp,32
    80006300:	00005497          	auipc	s1,0x5
    80006304:	df048493          	addi	s1,s1,-528 # 8000b0f0 <pr>
    80006308:	00048513          	mv	a0,s1
    8000630c:	00002597          	auipc	a1,0x2
    80006310:	5b458593          	addi	a1,a1,1460 # 800088c0 <_ZTV7WorkerD+0x178>
    80006314:	00000097          	auipc	ra,0x0
    80006318:	5f4080e7          	jalr	1524(ra) # 80006908 <initlock>
    8000631c:	01813083          	ld	ra,24(sp)
    80006320:	01013403          	ld	s0,16(sp)
    80006324:	0004ac23          	sw	zero,24(s1)
    80006328:	00813483          	ld	s1,8(sp)
    8000632c:	02010113          	addi	sp,sp,32
    80006330:	00008067          	ret

0000000080006334 <uartinit>:
    80006334:	ff010113          	addi	sp,sp,-16
    80006338:	00813423          	sd	s0,8(sp)
    8000633c:	01010413          	addi	s0,sp,16
    80006340:	100007b7          	lui	a5,0x10000
    80006344:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006348:	f8000713          	li	a4,-128
    8000634c:	00e781a3          	sb	a4,3(a5)
    80006350:	00300713          	li	a4,3
    80006354:	00e78023          	sb	a4,0(a5)
    80006358:	000780a3          	sb	zero,1(a5)
    8000635c:	00e781a3          	sb	a4,3(a5)
    80006360:	00700693          	li	a3,7
    80006364:	00d78123          	sb	a3,2(a5)
    80006368:	00e780a3          	sb	a4,1(a5)
    8000636c:	00813403          	ld	s0,8(sp)
    80006370:	01010113          	addi	sp,sp,16
    80006374:	00008067          	ret

0000000080006378 <uartputc>:
    80006378:	00004797          	auipc	a5,0x4
    8000637c:	b207a783          	lw	a5,-1248(a5) # 80009e98 <panicked>
    80006380:	00078463          	beqz	a5,80006388 <uartputc+0x10>
    80006384:	0000006f          	j	80006384 <uartputc+0xc>
    80006388:	fd010113          	addi	sp,sp,-48
    8000638c:	02813023          	sd	s0,32(sp)
    80006390:	00913c23          	sd	s1,24(sp)
    80006394:	01213823          	sd	s2,16(sp)
    80006398:	01313423          	sd	s3,8(sp)
    8000639c:	02113423          	sd	ra,40(sp)
    800063a0:	03010413          	addi	s0,sp,48
    800063a4:	00004917          	auipc	s2,0x4
    800063a8:	afc90913          	addi	s2,s2,-1284 # 80009ea0 <uart_tx_r>
    800063ac:	00093783          	ld	a5,0(s2)
    800063b0:	00004497          	auipc	s1,0x4
    800063b4:	af848493          	addi	s1,s1,-1288 # 80009ea8 <uart_tx_w>
    800063b8:	0004b703          	ld	a4,0(s1)
    800063bc:	02078693          	addi	a3,a5,32
    800063c0:	00050993          	mv	s3,a0
    800063c4:	02e69c63          	bne	a3,a4,800063fc <uartputc+0x84>
    800063c8:	00001097          	auipc	ra,0x1
    800063cc:	834080e7          	jalr	-1996(ra) # 80006bfc <push_on>
    800063d0:	00093783          	ld	a5,0(s2)
    800063d4:	0004b703          	ld	a4,0(s1)
    800063d8:	02078793          	addi	a5,a5,32
    800063dc:	00e79463          	bne	a5,a4,800063e4 <uartputc+0x6c>
    800063e0:	0000006f          	j	800063e0 <uartputc+0x68>
    800063e4:	00001097          	auipc	ra,0x1
    800063e8:	88c080e7          	jalr	-1908(ra) # 80006c70 <pop_on>
    800063ec:	00093783          	ld	a5,0(s2)
    800063f0:	0004b703          	ld	a4,0(s1)
    800063f4:	02078693          	addi	a3,a5,32
    800063f8:	fce688e3          	beq	a3,a4,800063c8 <uartputc+0x50>
    800063fc:	01f77693          	andi	a3,a4,31
    80006400:	00005597          	auipc	a1,0x5
    80006404:	d1058593          	addi	a1,a1,-752 # 8000b110 <uart_tx_buf>
    80006408:	00d586b3          	add	a3,a1,a3
    8000640c:	00170713          	addi	a4,a4,1
    80006410:	01368023          	sb	s3,0(a3)
    80006414:	00e4b023          	sd	a4,0(s1)
    80006418:	10000637          	lui	a2,0x10000
    8000641c:	02f71063          	bne	a4,a5,8000643c <uartputc+0xc4>
    80006420:	0340006f          	j	80006454 <uartputc+0xdc>
    80006424:	00074703          	lbu	a4,0(a4)
    80006428:	00f93023          	sd	a5,0(s2)
    8000642c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006430:	00093783          	ld	a5,0(s2)
    80006434:	0004b703          	ld	a4,0(s1)
    80006438:	00f70e63          	beq	a4,a5,80006454 <uartputc+0xdc>
    8000643c:	00564683          	lbu	a3,5(a2)
    80006440:	01f7f713          	andi	a4,a5,31
    80006444:	00e58733          	add	a4,a1,a4
    80006448:	0206f693          	andi	a3,a3,32
    8000644c:	00178793          	addi	a5,a5,1
    80006450:	fc069ae3          	bnez	a3,80006424 <uartputc+0xac>
    80006454:	02813083          	ld	ra,40(sp)
    80006458:	02013403          	ld	s0,32(sp)
    8000645c:	01813483          	ld	s1,24(sp)
    80006460:	01013903          	ld	s2,16(sp)
    80006464:	00813983          	ld	s3,8(sp)
    80006468:	03010113          	addi	sp,sp,48
    8000646c:	00008067          	ret

0000000080006470 <uartputc_sync>:
    80006470:	ff010113          	addi	sp,sp,-16
    80006474:	00813423          	sd	s0,8(sp)
    80006478:	01010413          	addi	s0,sp,16
    8000647c:	00004717          	auipc	a4,0x4
    80006480:	a1c72703          	lw	a4,-1508(a4) # 80009e98 <panicked>
    80006484:	02071663          	bnez	a4,800064b0 <uartputc_sync+0x40>
    80006488:	00050793          	mv	a5,a0
    8000648c:	100006b7          	lui	a3,0x10000
    80006490:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006494:	02077713          	andi	a4,a4,32
    80006498:	fe070ce3          	beqz	a4,80006490 <uartputc_sync+0x20>
    8000649c:	0ff7f793          	andi	a5,a5,255
    800064a0:	00f68023          	sb	a5,0(a3)
    800064a4:	00813403          	ld	s0,8(sp)
    800064a8:	01010113          	addi	sp,sp,16
    800064ac:	00008067          	ret
    800064b0:	0000006f          	j	800064b0 <uartputc_sync+0x40>

00000000800064b4 <uartstart>:
    800064b4:	ff010113          	addi	sp,sp,-16
    800064b8:	00813423          	sd	s0,8(sp)
    800064bc:	01010413          	addi	s0,sp,16
    800064c0:	00004617          	auipc	a2,0x4
    800064c4:	9e060613          	addi	a2,a2,-1568 # 80009ea0 <uart_tx_r>
    800064c8:	00004517          	auipc	a0,0x4
    800064cc:	9e050513          	addi	a0,a0,-1568 # 80009ea8 <uart_tx_w>
    800064d0:	00063783          	ld	a5,0(a2)
    800064d4:	00053703          	ld	a4,0(a0)
    800064d8:	04f70263          	beq	a4,a5,8000651c <uartstart+0x68>
    800064dc:	100005b7          	lui	a1,0x10000
    800064e0:	00005817          	auipc	a6,0x5
    800064e4:	c3080813          	addi	a6,a6,-976 # 8000b110 <uart_tx_buf>
    800064e8:	01c0006f          	j	80006504 <uartstart+0x50>
    800064ec:	0006c703          	lbu	a4,0(a3)
    800064f0:	00f63023          	sd	a5,0(a2)
    800064f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800064f8:	00063783          	ld	a5,0(a2)
    800064fc:	00053703          	ld	a4,0(a0)
    80006500:	00f70e63          	beq	a4,a5,8000651c <uartstart+0x68>
    80006504:	01f7f713          	andi	a4,a5,31
    80006508:	00e806b3          	add	a3,a6,a4
    8000650c:	0055c703          	lbu	a4,5(a1)
    80006510:	00178793          	addi	a5,a5,1
    80006514:	02077713          	andi	a4,a4,32
    80006518:	fc071ae3          	bnez	a4,800064ec <uartstart+0x38>
    8000651c:	00813403          	ld	s0,8(sp)
    80006520:	01010113          	addi	sp,sp,16
    80006524:	00008067          	ret

0000000080006528 <uartgetc>:
    80006528:	ff010113          	addi	sp,sp,-16
    8000652c:	00813423          	sd	s0,8(sp)
    80006530:	01010413          	addi	s0,sp,16
    80006534:	10000737          	lui	a4,0x10000
    80006538:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000653c:	0017f793          	andi	a5,a5,1
    80006540:	00078c63          	beqz	a5,80006558 <uartgetc+0x30>
    80006544:	00074503          	lbu	a0,0(a4)
    80006548:	0ff57513          	andi	a0,a0,255
    8000654c:	00813403          	ld	s0,8(sp)
    80006550:	01010113          	addi	sp,sp,16
    80006554:	00008067          	ret
    80006558:	fff00513          	li	a0,-1
    8000655c:	ff1ff06f          	j	8000654c <uartgetc+0x24>

0000000080006560 <uartintr>:
    80006560:	100007b7          	lui	a5,0x10000
    80006564:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006568:	0017f793          	andi	a5,a5,1
    8000656c:	0a078463          	beqz	a5,80006614 <uartintr+0xb4>
    80006570:	fe010113          	addi	sp,sp,-32
    80006574:	00813823          	sd	s0,16(sp)
    80006578:	00913423          	sd	s1,8(sp)
    8000657c:	00113c23          	sd	ra,24(sp)
    80006580:	02010413          	addi	s0,sp,32
    80006584:	100004b7          	lui	s1,0x10000
    80006588:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000658c:	0ff57513          	andi	a0,a0,255
    80006590:	fffff097          	auipc	ra,0xfffff
    80006594:	534080e7          	jalr	1332(ra) # 80005ac4 <consoleintr>
    80006598:	0054c783          	lbu	a5,5(s1)
    8000659c:	0017f793          	andi	a5,a5,1
    800065a0:	fe0794e3          	bnez	a5,80006588 <uartintr+0x28>
    800065a4:	00004617          	auipc	a2,0x4
    800065a8:	8fc60613          	addi	a2,a2,-1796 # 80009ea0 <uart_tx_r>
    800065ac:	00004517          	auipc	a0,0x4
    800065b0:	8fc50513          	addi	a0,a0,-1796 # 80009ea8 <uart_tx_w>
    800065b4:	00063783          	ld	a5,0(a2)
    800065b8:	00053703          	ld	a4,0(a0)
    800065bc:	04f70263          	beq	a4,a5,80006600 <uartintr+0xa0>
    800065c0:	100005b7          	lui	a1,0x10000
    800065c4:	00005817          	auipc	a6,0x5
    800065c8:	b4c80813          	addi	a6,a6,-1204 # 8000b110 <uart_tx_buf>
    800065cc:	01c0006f          	j	800065e8 <uartintr+0x88>
    800065d0:	0006c703          	lbu	a4,0(a3)
    800065d4:	00f63023          	sd	a5,0(a2)
    800065d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800065dc:	00063783          	ld	a5,0(a2)
    800065e0:	00053703          	ld	a4,0(a0)
    800065e4:	00f70e63          	beq	a4,a5,80006600 <uartintr+0xa0>
    800065e8:	01f7f713          	andi	a4,a5,31
    800065ec:	00e806b3          	add	a3,a6,a4
    800065f0:	0055c703          	lbu	a4,5(a1)
    800065f4:	00178793          	addi	a5,a5,1
    800065f8:	02077713          	andi	a4,a4,32
    800065fc:	fc071ae3          	bnez	a4,800065d0 <uartintr+0x70>
    80006600:	01813083          	ld	ra,24(sp)
    80006604:	01013403          	ld	s0,16(sp)
    80006608:	00813483          	ld	s1,8(sp)
    8000660c:	02010113          	addi	sp,sp,32
    80006610:	00008067          	ret
    80006614:	00004617          	auipc	a2,0x4
    80006618:	88c60613          	addi	a2,a2,-1908 # 80009ea0 <uart_tx_r>
    8000661c:	00004517          	auipc	a0,0x4
    80006620:	88c50513          	addi	a0,a0,-1908 # 80009ea8 <uart_tx_w>
    80006624:	00063783          	ld	a5,0(a2)
    80006628:	00053703          	ld	a4,0(a0)
    8000662c:	04f70263          	beq	a4,a5,80006670 <uartintr+0x110>
    80006630:	100005b7          	lui	a1,0x10000
    80006634:	00005817          	auipc	a6,0x5
    80006638:	adc80813          	addi	a6,a6,-1316 # 8000b110 <uart_tx_buf>
    8000663c:	01c0006f          	j	80006658 <uartintr+0xf8>
    80006640:	0006c703          	lbu	a4,0(a3)
    80006644:	00f63023          	sd	a5,0(a2)
    80006648:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000664c:	00063783          	ld	a5,0(a2)
    80006650:	00053703          	ld	a4,0(a0)
    80006654:	02f70063          	beq	a4,a5,80006674 <uartintr+0x114>
    80006658:	01f7f713          	andi	a4,a5,31
    8000665c:	00e806b3          	add	a3,a6,a4
    80006660:	0055c703          	lbu	a4,5(a1)
    80006664:	00178793          	addi	a5,a5,1
    80006668:	02077713          	andi	a4,a4,32
    8000666c:	fc071ae3          	bnez	a4,80006640 <uartintr+0xe0>
    80006670:	00008067          	ret
    80006674:	00008067          	ret

0000000080006678 <kinit>:
    80006678:	fc010113          	addi	sp,sp,-64
    8000667c:	02913423          	sd	s1,40(sp)
    80006680:	fffff7b7          	lui	a5,0xfffff
    80006684:	00006497          	auipc	s1,0x6
    80006688:	aab48493          	addi	s1,s1,-1365 # 8000c12f <end+0xfff>
    8000668c:	02813823          	sd	s0,48(sp)
    80006690:	01313c23          	sd	s3,24(sp)
    80006694:	00f4f4b3          	and	s1,s1,a5
    80006698:	02113c23          	sd	ra,56(sp)
    8000669c:	03213023          	sd	s2,32(sp)
    800066a0:	01413823          	sd	s4,16(sp)
    800066a4:	01513423          	sd	s5,8(sp)
    800066a8:	04010413          	addi	s0,sp,64
    800066ac:	000017b7          	lui	a5,0x1
    800066b0:	01100993          	li	s3,17
    800066b4:	00f487b3          	add	a5,s1,a5
    800066b8:	01b99993          	slli	s3,s3,0x1b
    800066bc:	06f9e063          	bltu	s3,a5,8000671c <kinit+0xa4>
    800066c0:	00005a97          	auipc	s5,0x5
    800066c4:	a70a8a93          	addi	s5,s5,-1424 # 8000b130 <end>
    800066c8:	0754ec63          	bltu	s1,s5,80006740 <kinit+0xc8>
    800066cc:	0734fa63          	bgeu	s1,s3,80006740 <kinit+0xc8>
    800066d0:	00088a37          	lui	s4,0x88
    800066d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800066d8:	00003917          	auipc	s2,0x3
    800066dc:	7d890913          	addi	s2,s2,2008 # 80009eb0 <kmem>
    800066e0:	00ca1a13          	slli	s4,s4,0xc
    800066e4:	0140006f          	j	800066f8 <kinit+0x80>
    800066e8:	000017b7          	lui	a5,0x1
    800066ec:	00f484b3          	add	s1,s1,a5
    800066f0:	0554e863          	bltu	s1,s5,80006740 <kinit+0xc8>
    800066f4:	0534f663          	bgeu	s1,s3,80006740 <kinit+0xc8>
    800066f8:	00001637          	lui	a2,0x1
    800066fc:	00100593          	li	a1,1
    80006700:	00048513          	mv	a0,s1
    80006704:	00000097          	auipc	ra,0x0
    80006708:	5e4080e7          	jalr	1508(ra) # 80006ce8 <__memset>
    8000670c:	00093783          	ld	a5,0(s2)
    80006710:	00f4b023          	sd	a5,0(s1)
    80006714:	00993023          	sd	s1,0(s2)
    80006718:	fd4498e3          	bne	s1,s4,800066e8 <kinit+0x70>
    8000671c:	03813083          	ld	ra,56(sp)
    80006720:	03013403          	ld	s0,48(sp)
    80006724:	02813483          	ld	s1,40(sp)
    80006728:	02013903          	ld	s2,32(sp)
    8000672c:	01813983          	ld	s3,24(sp)
    80006730:	01013a03          	ld	s4,16(sp)
    80006734:	00813a83          	ld	s5,8(sp)
    80006738:	04010113          	addi	sp,sp,64
    8000673c:	00008067          	ret
    80006740:	00002517          	auipc	a0,0x2
    80006744:	1a050513          	addi	a0,a0,416 # 800088e0 <digits+0x18>
    80006748:	fffff097          	auipc	ra,0xfffff
    8000674c:	4b4080e7          	jalr	1204(ra) # 80005bfc <panic>

0000000080006750 <freerange>:
    80006750:	fc010113          	addi	sp,sp,-64
    80006754:	000017b7          	lui	a5,0x1
    80006758:	02913423          	sd	s1,40(sp)
    8000675c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006760:	009504b3          	add	s1,a0,s1
    80006764:	fffff537          	lui	a0,0xfffff
    80006768:	02813823          	sd	s0,48(sp)
    8000676c:	02113c23          	sd	ra,56(sp)
    80006770:	03213023          	sd	s2,32(sp)
    80006774:	01313c23          	sd	s3,24(sp)
    80006778:	01413823          	sd	s4,16(sp)
    8000677c:	01513423          	sd	s5,8(sp)
    80006780:	01613023          	sd	s6,0(sp)
    80006784:	04010413          	addi	s0,sp,64
    80006788:	00a4f4b3          	and	s1,s1,a0
    8000678c:	00f487b3          	add	a5,s1,a5
    80006790:	06f5e463          	bltu	a1,a5,800067f8 <freerange+0xa8>
    80006794:	00005a97          	auipc	s5,0x5
    80006798:	99ca8a93          	addi	s5,s5,-1636 # 8000b130 <end>
    8000679c:	0954e263          	bltu	s1,s5,80006820 <freerange+0xd0>
    800067a0:	01100993          	li	s3,17
    800067a4:	01b99993          	slli	s3,s3,0x1b
    800067a8:	0734fc63          	bgeu	s1,s3,80006820 <freerange+0xd0>
    800067ac:	00058a13          	mv	s4,a1
    800067b0:	00003917          	auipc	s2,0x3
    800067b4:	70090913          	addi	s2,s2,1792 # 80009eb0 <kmem>
    800067b8:	00002b37          	lui	s6,0x2
    800067bc:	0140006f          	j	800067d0 <freerange+0x80>
    800067c0:	000017b7          	lui	a5,0x1
    800067c4:	00f484b3          	add	s1,s1,a5
    800067c8:	0554ec63          	bltu	s1,s5,80006820 <freerange+0xd0>
    800067cc:	0534fa63          	bgeu	s1,s3,80006820 <freerange+0xd0>
    800067d0:	00001637          	lui	a2,0x1
    800067d4:	00100593          	li	a1,1
    800067d8:	00048513          	mv	a0,s1
    800067dc:	00000097          	auipc	ra,0x0
    800067e0:	50c080e7          	jalr	1292(ra) # 80006ce8 <__memset>
    800067e4:	00093703          	ld	a4,0(s2)
    800067e8:	016487b3          	add	a5,s1,s6
    800067ec:	00e4b023          	sd	a4,0(s1)
    800067f0:	00993023          	sd	s1,0(s2)
    800067f4:	fcfa76e3          	bgeu	s4,a5,800067c0 <freerange+0x70>
    800067f8:	03813083          	ld	ra,56(sp)
    800067fc:	03013403          	ld	s0,48(sp)
    80006800:	02813483          	ld	s1,40(sp)
    80006804:	02013903          	ld	s2,32(sp)
    80006808:	01813983          	ld	s3,24(sp)
    8000680c:	01013a03          	ld	s4,16(sp)
    80006810:	00813a83          	ld	s5,8(sp)
    80006814:	00013b03          	ld	s6,0(sp)
    80006818:	04010113          	addi	sp,sp,64
    8000681c:	00008067          	ret
    80006820:	00002517          	auipc	a0,0x2
    80006824:	0c050513          	addi	a0,a0,192 # 800088e0 <digits+0x18>
    80006828:	fffff097          	auipc	ra,0xfffff
    8000682c:	3d4080e7          	jalr	980(ra) # 80005bfc <panic>

0000000080006830 <kfree>:
    80006830:	fe010113          	addi	sp,sp,-32
    80006834:	00813823          	sd	s0,16(sp)
    80006838:	00113c23          	sd	ra,24(sp)
    8000683c:	00913423          	sd	s1,8(sp)
    80006840:	02010413          	addi	s0,sp,32
    80006844:	03451793          	slli	a5,a0,0x34
    80006848:	04079c63          	bnez	a5,800068a0 <kfree+0x70>
    8000684c:	00005797          	auipc	a5,0x5
    80006850:	8e478793          	addi	a5,a5,-1820 # 8000b130 <end>
    80006854:	00050493          	mv	s1,a0
    80006858:	04f56463          	bltu	a0,a5,800068a0 <kfree+0x70>
    8000685c:	01100793          	li	a5,17
    80006860:	01b79793          	slli	a5,a5,0x1b
    80006864:	02f57e63          	bgeu	a0,a5,800068a0 <kfree+0x70>
    80006868:	00001637          	lui	a2,0x1
    8000686c:	00100593          	li	a1,1
    80006870:	00000097          	auipc	ra,0x0
    80006874:	478080e7          	jalr	1144(ra) # 80006ce8 <__memset>
    80006878:	00003797          	auipc	a5,0x3
    8000687c:	63878793          	addi	a5,a5,1592 # 80009eb0 <kmem>
    80006880:	0007b703          	ld	a4,0(a5)
    80006884:	01813083          	ld	ra,24(sp)
    80006888:	01013403          	ld	s0,16(sp)
    8000688c:	00e4b023          	sd	a4,0(s1)
    80006890:	0097b023          	sd	s1,0(a5)
    80006894:	00813483          	ld	s1,8(sp)
    80006898:	02010113          	addi	sp,sp,32
    8000689c:	00008067          	ret
    800068a0:	00002517          	auipc	a0,0x2
    800068a4:	04050513          	addi	a0,a0,64 # 800088e0 <digits+0x18>
    800068a8:	fffff097          	auipc	ra,0xfffff
    800068ac:	354080e7          	jalr	852(ra) # 80005bfc <panic>

00000000800068b0 <kalloc>:
    800068b0:	fe010113          	addi	sp,sp,-32
    800068b4:	00813823          	sd	s0,16(sp)
    800068b8:	00913423          	sd	s1,8(sp)
    800068bc:	00113c23          	sd	ra,24(sp)
    800068c0:	02010413          	addi	s0,sp,32
    800068c4:	00003797          	auipc	a5,0x3
    800068c8:	5ec78793          	addi	a5,a5,1516 # 80009eb0 <kmem>
    800068cc:	0007b483          	ld	s1,0(a5)
    800068d0:	02048063          	beqz	s1,800068f0 <kalloc+0x40>
    800068d4:	0004b703          	ld	a4,0(s1)
    800068d8:	00001637          	lui	a2,0x1
    800068dc:	00500593          	li	a1,5
    800068e0:	00048513          	mv	a0,s1
    800068e4:	00e7b023          	sd	a4,0(a5)
    800068e8:	00000097          	auipc	ra,0x0
    800068ec:	400080e7          	jalr	1024(ra) # 80006ce8 <__memset>
    800068f0:	01813083          	ld	ra,24(sp)
    800068f4:	01013403          	ld	s0,16(sp)
    800068f8:	00048513          	mv	a0,s1
    800068fc:	00813483          	ld	s1,8(sp)
    80006900:	02010113          	addi	sp,sp,32
    80006904:	00008067          	ret

0000000080006908 <initlock>:
    80006908:	ff010113          	addi	sp,sp,-16
    8000690c:	00813423          	sd	s0,8(sp)
    80006910:	01010413          	addi	s0,sp,16
    80006914:	00813403          	ld	s0,8(sp)
    80006918:	00b53423          	sd	a1,8(a0)
    8000691c:	00052023          	sw	zero,0(a0)
    80006920:	00053823          	sd	zero,16(a0)
    80006924:	01010113          	addi	sp,sp,16
    80006928:	00008067          	ret

000000008000692c <acquire>:
    8000692c:	fe010113          	addi	sp,sp,-32
    80006930:	00813823          	sd	s0,16(sp)
    80006934:	00913423          	sd	s1,8(sp)
    80006938:	00113c23          	sd	ra,24(sp)
    8000693c:	01213023          	sd	s2,0(sp)
    80006940:	02010413          	addi	s0,sp,32
    80006944:	00050493          	mv	s1,a0
    80006948:	10002973          	csrr	s2,sstatus
    8000694c:	100027f3          	csrr	a5,sstatus
    80006950:	ffd7f793          	andi	a5,a5,-3
    80006954:	10079073          	csrw	sstatus,a5
    80006958:	fffff097          	auipc	ra,0xfffff
    8000695c:	8e8080e7          	jalr	-1816(ra) # 80005240 <mycpu>
    80006960:	07852783          	lw	a5,120(a0)
    80006964:	06078e63          	beqz	a5,800069e0 <acquire+0xb4>
    80006968:	fffff097          	auipc	ra,0xfffff
    8000696c:	8d8080e7          	jalr	-1832(ra) # 80005240 <mycpu>
    80006970:	07852783          	lw	a5,120(a0)
    80006974:	0004a703          	lw	a4,0(s1)
    80006978:	0017879b          	addiw	a5,a5,1
    8000697c:	06f52c23          	sw	a5,120(a0)
    80006980:	04071063          	bnez	a4,800069c0 <acquire+0x94>
    80006984:	00100713          	li	a4,1
    80006988:	00070793          	mv	a5,a4
    8000698c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006990:	0007879b          	sext.w	a5,a5
    80006994:	fe079ae3          	bnez	a5,80006988 <acquire+0x5c>
    80006998:	0ff0000f          	fence
    8000699c:	fffff097          	auipc	ra,0xfffff
    800069a0:	8a4080e7          	jalr	-1884(ra) # 80005240 <mycpu>
    800069a4:	01813083          	ld	ra,24(sp)
    800069a8:	01013403          	ld	s0,16(sp)
    800069ac:	00a4b823          	sd	a0,16(s1)
    800069b0:	00013903          	ld	s2,0(sp)
    800069b4:	00813483          	ld	s1,8(sp)
    800069b8:	02010113          	addi	sp,sp,32
    800069bc:	00008067          	ret
    800069c0:	0104b903          	ld	s2,16(s1)
    800069c4:	fffff097          	auipc	ra,0xfffff
    800069c8:	87c080e7          	jalr	-1924(ra) # 80005240 <mycpu>
    800069cc:	faa91ce3          	bne	s2,a0,80006984 <acquire+0x58>
    800069d0:	00002517          	auipc	a0,0x2
    800069d4:	f1850513          	addi	a0,a0,-232 # 800088e8 <digits+0x20>
    800069d8:	fffff097          	auipc	ra,0xfffff
    800069dc:	224080e7          	jalr	548(ra) # 80005bfc <panic>
    800069e0:	00195913          	srli	s2,s2,0x1
    800069e4:	fffff097          	auipc	ra,0xfffff
    800069e8:	85c080e7          	jalr	-1956(ra) # 80005240 <mycpu>
    800069ec:	00197913          	andi	s2,s2,1
    800069f0:	07252e23          	sw	s2,124(a0)
    800069f4:	f75ff06f          	j	80006968 <acquire+0x3c>

00000000800069f8 <release>:
    800069f8:	fe010113          	addi	sp,sp,-32
    800069fc:	00813823          	sd	s0,16(sp)
    80006a00:	00113c23          	sd	ra,24(sp)
    80006a04:	00913423          	sd	s1,8(sp)
    80006a08:	01213023          	sd	s2,0(sp)
    80006a0c:	02010413          	addi	s0,sp,32
    80006a10:	00052783          	lw	a5,0(a0)
    80006a14:	00079a63          	bnez	a5,80006a28 <release+0x30>
    80006a18:	00002517          	auipc	a0,0x2
    80006a1c:	ed850513          	addi	a0,a0,-296 # 800088f0 <digits+0x28>
    80006a20:	fffff097          	auipc	ra,0xfffff
    80006a24:	1dc080e7          	jalr	476(ra) # 80005bfc <panic>
    80006a28:	01053903          	ld	s2,16(a0)
    80006a2c:	00050493          	mv	s1,a0
    80006a30:	fffff097          	auipc	ra,0xfffff
    80006a34:	810080e7          	jalr	-2032(ra) # 80005240 <mycpu>
    80006a38:	fea910e3          	bne	s2,a0,80006a18 <release+0x20>
    80006a3c:	0004b823          	sd	zero,16(s1)
    80006a40:	0ff0000f          	fence
    80006a44:	0f50000f          	fence	iorw,ow
    80006a48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006a4c:	ffffe097          	auipc	ra,0xffffe
    80006a50:	7f4080e7          	jalr	2036(ra) # 80005240 <mycpu>
    80006a54:	100027f3          	csrr	a5,sstatus
    80006a58:	0027f793          	andi	a5,a5,2
    80006a5c:	04079a63          	bnez	a5,80006ab0 <release+0xb8>
    80006a60:	07852783          	lw	a5,120(a0)
    80006a64:	02f05e63          	blez	a5,80006aa0 <release+0xa8>
    80006a68:	fff7871b          	addiw	a4,a5,-1
    80006a6c:	06e52c23          	sw	a4,120(a0)
    80006a70:	00071c63          	bnez	a4,80006a88 <release+0x90>
    80006a74:	07c52783          	lw	a5,124(a0)
    80006a78:	00078863          	beqz	a5,80006a88 <release+0x90>
    80006a7c:	100027f3          	csrr	a5,sstatus
    80006a80:	0027e793          	ori	a5,a5,2
    80006a84:	10079073          	csrw	sstatus,a5
    80006a88:	01813083          	ld	ra,24(sp)
    80006a8c:	01013403          	ld	s0,16(sp)
    80006a90:	00813483          	ld	s1,8(sp)
    80006a94:	00013903          	ld	s2,0(sp)
    80006a98:	02010113          	addi	sp,sp,32
    80006a9c:	00008067          	ret
    80006aa0:	00002517          	auipc	a0,0x2
    80006aa4:	e7050513          	addi	a0,a0,-400 # 80008910 <digits+0x48>
    80006aa8:	fffff097          	auipc	ra,0xfffff
    80006aac:	154080e7          	jalr	340(ra) # 80005bfc <panic>
    80006ab0:	00002517          	auipc	a0,0x2
    80006ab4:	e4850513          	addi	a0,a0,-440 # 800088f8 <digits+0x30>
    80006ab8:	fffff097          	auipc	ra,0xfffff
    80006abc:	144080e7          	jalr	324(ra) # 80005bfc <panic>

0000000080006ac0 <holding>:
    80006ac0:	00052783          	lw	a5,0(a0)
    80006ac4:	00079663          	bnez	a5,80006ad0 <holding+0x10>
    80006ac8:	00000513          	li	a0,0
    80006acc:	00008067          	ret
    80006ad0:	fe010113          	addi	sp,sp,-32
    80006ad4:	00813823          	sd	s0,16(sp)
    80006ad8:	00913423          	sd	s1,8(sp)
    80006adc:	00113c23          	sd	ra,24(sp)
    80006ae0:	02010413          	addi	s0,sp,32
    80006ae4:	01053483          	ld	s1,16(a0)
    80006ae8:	ffffe097          	auipc	ra,0xffffe
    80006aec:	758080e7          	jalr	1880(ra) # 80005240 <mycpu>
    80006af0:	01813083          	ld	ra,24(sp)
    80006af4:	01013403          	ld	s0,16(sp)
    80006af8:	40a48533          	sub	a0,s1,a0
    80006afc:	00153513          	seqz	a0,a0
    80006b00:	00813483          	ld	s1,8(sp)
    80006b04:	02010113          	addi	sp,sp,32
    80006b08:	00008067          	ret

0000000080006b0c <push_off>:
    80006b0c:	fe010113          	addi	sp,sp,-32
    80006b10:	00813823          	sd	s0,16(sp)
    80006b14:	00113c23          	sd	ra,24(sp)
    80006b18:	00913423          	sd	s1,8(sp)
    80006b1c:	02010413          	addi	s0,sp,32
    80006b20:	100024f3          	csrr	s1,sstatus
    80006b24:	100027f3          	csrr	a5,sstatus
    80006b28:	ffd7f793          	andi	a5,a5,-3
    80006b2c:	10079073          	csrw	sstatus,a5
    80006b30:	ffffe097          	auipc	ra,0xffffe
    80006b34:	710080e7          	jalr	1808(ra) # 80005240 <mycpu>
    80006b38:	07852783          	lw	a5,120(a0)
    80006b3c:	02078663          	beqz	a5,80006b68 <push_off+0x5c>
    80006b40:	ffffe097          	auipc	ra,0xffffe
    80006b44:	700080e7          	jalr	1792(ra) # 80005240 <mycpu>
    80006b48:	07852783          	lw	a5,120(a0)
    80006b4c:	01813083          	ld	ra,24(sp)
    80006b50:	01013403          	ld	s0,16(sp)
    80006b54:	0017879b          	addiw	a5,a5,1
    80006b58:	06f52c23          	sw	a5,120(a0)
    80006b5c:	00813483          	ld	s1,8(sp)
    80006b60:	02010113          	addi	sp,sp,32
    80006b64:	00008067          	ret
    80006b68:	0014d493          	srli	s1,s1,0x1
    80006b6c:	ffffe097          	auipc	ra,0xffffe
    80006b70:	6d4080e7          	jalr	1748(ra) # 80005240 <mycpu>
    80006b74:	0014f493          	andi	s1,s1,1
    80006b78:	06952e23          	sw	s1,124(a0)
    80006b7c:	fc5ff06f          	j	80006b40 <push_off+0x34>

0000000080006b80 <pop_off>:
    80006b80:	ff010113          	addi	sp,sp,-16
    80006b84:	00813023          	sd	s0,0(sp)
    80006b88:	00113423          	sd	ra,8(sp)
    80006b8c:	01010413          	addi	s0,sp,16
    80006b90:	ffffe097          	auipc	ra,0xffffe
    80006b94:	6b0080e7          	jalr	1712(ra) # 80005240 <mycpu>
    80006b98:	100027f3          	csrr	a5,sstatus
    80006b9c:	0027f793          	andi	a5,a5,2
    80006ba0:	04079663          	bnez	a5,80006bec <pop_off+0x6c>
    80006ba4:	07852783          	lw	a5,120(a0)
    80006ba8:	02f05a63          	blez	a5,80006bdc <pop_off+0x5c>
    80006bac:	fff7871b          	addiw	a4,a5,-1
    80006bb0:	06e52c23          	sw	a4,120(a0)
    80006bb4:	00071c63          	bnez	a4,80006bcc <pop_off+0x4c>
    80006bb8:	07c52783          	lw	a5,124(a0)
    80006bbc:	00078863          	beqz	a5,80006bcc <pop_off+0x4c>
    80006bc0:	100027f3          	csrr	a5,sstatus
    80006bc4:	0027e793          	ori	a5,a5,2
    80006bc8:	10079073          	csrw	sstatus,a5
    80006bcc:	00813083          	ld	ra,8(sp)
    80006bd0:	00013403          	ld	s0,0(sp)
    80006bd4:	01010113          	addi	sp,sp,16
    80006bd8:	00008067          	ret
    80006bdc:	00002517          	auipc	a0,0x2
    80006be0:	d3450513          	addi	a0,a0,-716 # 80008910 <digits+0x48>
    80006be4:	fffff097          	auipc	ra,0xfffff
    80006be8:	018080e7          	jalr	24(ra) # 80005bfc <panic>
    80006bec:	00002517          	auipc	a0,0x2
    80006bf0:	d0c50513          	addi	a0,a0,-756 # 800088f8 <digits+0x30>
    80006bf4:	fffff097          	auipc	ra,0xfffff
    80006bf8:	008080e7          	jalr	8(ra) # 80005bfc <panic>

0000000080006bfc <push_on>:
    80006bfc:	fe010113          	addi	sp,sp,-32
    80006c00:	00813823          	sd	s0,16(sp)
    80006c04:	00113c23          	sd	ra,24(sp)
    80006c08:	00913423          	sd	s1,8(sp)
    80006c0c:	02010413          	addi	s0,sp,32
    80006c10:	100024f3          	csrr	s1,sstatus
    80006c14:	100027f3          	csrr	a5,sstatus
    80006c18:	0027e793          	ori	a5,a5,2
    80006c1c:	10079073          	csrw	sstatus,a5
    80006c20:	ffffe097          	auipc	ra,0xffffe
    80006c24:	620080e7          	jalr	1568(ra) # 80005240 <mycpu>
    80006c28:	07852783          	lw	a5,120(a0)
    80006c2c:	02078663          	beqz	a5,80006c58 <push_on+0x5c>
    80006c30:	ffffe097          	auipc	ra,0xffffe
    80006c34:	610080e7          	jalr	1552(ra) # 80005240 <mycpu>
    80006c38:	07852783          	lw	a5,120(a0)
    80006c3c:	01813083          	ld	ra,24(sp)
    80006c40:	01013403          	ld	s0,16(sp)
    80006c44:	0017879b          	addiw	a5,a5,1
    80006c48:	06f52c23          	sw	a5,120(a0)
    80006c4c:	00813483          	ld	s1,8(sp)
    80006c50:	02010113          	addi	sp,sp,32
    80006c54:	00008067          	ret
    80006c58:	0014d493          	srli	s1,s1,0x1
    80006c5c:	ffffe097          	auipc	ra,0xffffe
    80006c60:	5e4080e7          	jalr	1508(ra) # 80005240 <mycpu>
    80006c64:	0014f493          	andi	s1,s1,1
    80006c68:	06952e23          	sw	s1,124(a0)
    80006c6c:	fc5ff06f          	j	80006c30 <push_on+0x34>

0000000080006c70 <pop_on>:
    80006c70:	ff010113          	addi	sp,sp,-16
    80006c74:	00813023          	sd	s0,0(sp)
    80006c78:	00113423          	sd	ra,8(sp)
    80006c7c:	01010413          	addi	s0,sp,16
    80006c80:	ffffe097          	auipc	ra,0xffffe
    80006c84:	5c0080e7          	jalr	1472(ra) # 80005240 <mycpu>
    80006c88:	100027f3          	csrr	a5,sstatus
    80006c8c:	0027f793          	andi	a5,a5,2
    80006c90:	04078463          	beqz	a5,80006cd8 <pop_on+0x68>
    80006c94:	07852783          	lw	a5,120(a0)
    80006c98:	02f05863          	blez	a5,80006cc8 <pop_on+0x58>
    80006c9c:	fff7879b          	addiw	a5,a5,-1
    80006ca0:	06f52c23          	sw	a5,120(a0)
    80006ca4:	07853783          	ld	a5,120(a0)
    80006ca8:	00079863          	bnez	a5,80006cb8 <pop_on+0x48>
    80006cac:	100027f3          	csrr	a5,sstatus
    80006cb0:	ffd7f793          	andi	a5,a5,-3
    80006cb4:	10079073          	csrw	sstatus,a5
    80006cb8:	00813083          	ld	ra,8(sp)
    80006cbc:	00013403          	ld	s0,0(sp)
    80006cc0:	01010113          	addi	sp,sp,16
    80006cc4:	00008067          	ret
    80006cc8:	00002517          	auipc	a0,0x2
    80006ccc:	c7050513          	addi	a0,a0,-912 # 80008938 <digits+0x70>
    80006cd0:	fffff097          	auipc	ra,0xfffff
    80006cd4:	f2c080e7          	jalr	-212(ra) # 80005bfc <panic>
    80006cd8:	00002517          	auipc	a0,0x2
    80006cdc:	c4050513          	addi	a0,a0,-960 # 80008918 <digits+0x50>
    80006ce0:	fffff097          	auipc	ra,0xfffff
    80006ce4:	f1c080e7          	jalr	-228(ra) # 80005bfc <panic>

0000000080006ce8 <__memset>:
    80006ce8:	ff010113          	addi	sp,sp,-16
    80006cec:	00813423          	sd	s0,8(sp)
    80006cf0:	01010413          	addi	s0,sp,16
    80006cf4:	1a060e63          	beqz	a2,80006eb0 <__memset+0x1c8>
    80006cf8:	40a007b3          	neg	a5,a0
    80006cfc:	0077f793          	andi	a5,a5,7
    80006d00:	00778693          	addi	a3,a5,7
    80006d04:	00b00813          	li	a6,11
    80006d08:	0ff5f593          	andi	a1,a1,255
    80006d0c:	fff6071b          	addiw	a4,a2,-1
    80006d10:	1b06e663          	bltu	a3,a6,80006ebc <__memset+0x1d4>
    80006d14:	1cd76463          	bltu	a4,a3,80006edc <__memset+0x1f4>
    80006d18:	1a078e63          	beqz	a5,80006ed4 <__memset+0x1ec>
    80006d1c:	00b50023          	sb	a1,0(a0)
    80006d20:	00100713          	li	a4,1
    80006d24:	1ae78463          	beq	a5,a4,80006ecc <__memset+0x1e4>
    80006d28:	00b500a3          	sb	a1,1(a0)
    80006d2c:	00200713          	li	a4,2
    80006d30:	1ae78a63          	beq	a5,a4,80006ee4 <__memset+0x1fc>
    80006d34:	00b50123          	sb	a1,2(a0)
    80006d38:	00300713          	li	a4,3
    80006d3c:	18e78463          	beq	a5,a4,80006ec4 <__memset+0x1dc>
    80006d40:	00b501a3          	sb	a1,3(a0)
    80006d44:	00400713          	li	a4,4
    80006d48:	1ae78263          	beq	a5,a4,80006eec <__memset+0x204>
    80006d4c:	00b50223          	sb	a1,4(a0)
    80006d50:	00500713          	li	a4,5
    80006d54:	1ae78063          	beq	a5,a4,80006ef4 <__memset+0x20c>
    80006d58:	00b502a3          	sb	a1,5(a0)
    80006d5c:	00700713          	li	a4,7
    80006d60:	18e79e63          	bne	a5,a4,80006efc <__memset+0x214>
    80006d64:	00b50323          	sb	a1,6(a0)
    80006d68:	00700e93          	li	t4,7
    80006d6c:	00859713          	slli	a4,a1,0x8
    80006d70:	00e5e733          	or	a4,a1,a4
    80006d74:	01059e13          	slli	t3,a1,0x10
    80006d78:	01c76e33          	or	t3,a4,t3
    80006d7c:	01859313          	slli	t1,a1,0x18
    80006d80:	006e6333          	or	t1,t3,t1
    80006d84:	02059893          	slli	a7,a1,0x20
    80006d88:	40f60e3b          	subw	t3,a2,a5
    80006d8c:	011368b3          	or	a7,t1,a7
    80006d90:	02859813          	slli	a6,a1,0x28
    80006d94:	0108e833          	or	a6,a7,a6
    80006d98:	03059693          	slli	a3,a1,0x30
    80006d9c:	003e589b          	srliw	a7,t3,0x3
    80006da0:	00d866b3          	or	a3,a6,a3
    80006da4:	03859713          	slli	a4,a1,0x38
    80006da8:	00389813          	slli	a6,a7,0x3
    80006dac:	00f507b3          	add	a5,a0,a5
    80006db0:	00e6e733          	or	a4,a3,a4
    80006db4:	000e089b          	sext.w	a7,t3
    80006db8:	00f806b3          	add	a3,a6,a5
    80006dbc:	00e7b023          	sd	a4,0(a5)
    80006dc0:	00878793          	addi	a5,a5,8
    80006dc4:	fed79ce3          	bne	a5,a3,80006dbc <__memset+0xd4>
    80006dc8:	ff8e7793          	andi	a5,t3,-8
    80006dcc:	0007871b          	sext.w	a4,a5
    80006dd0:	01d787bb          	addw	a5,a5,t4
    80006dd4:	0ce88e63          	beq	a7,a4,80006eb0 <__memset+0x1c8>
    80006dd8:	00f50733          	add	a4,a0,a5
    80006ddc:	00b70023          	sb	a1,0(a4)
    80006de0:	0017871b          	addiw	a4,a5,1
    80006de4:	0cc77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006de8:	00e50733          	add	a4,a0,a4
    80006dec:	00b70023          	sb	a1,0(a4)
    80006df0:	0027871b          	addiw	a4,a5,2
    80006df4:	0ac77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006df8:	00e50733          	add	a4,a0,a4
    80006dfc:	00b70023          	sb	a1,0(a4)
    80006e00:	0037871b          	addiw	a4,a5,3
    80006e04:	0ac77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e08:	00e50733          	add	a4,a0,a4
    80006e0c:	00b70023          	sb	a1,0(a4)
    80006e10:	0047871b          	addiw	a4,a5,4
    80006e14:	08c77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e18:	00e50733          	add	a4,a0,a4
    80006e1c:	00b70023          	sb	a1,0(a4)
    80006e20:	0057871b          	addiw	a4,a5,5
    80006e24:	08c77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e28:	00e50733          	add	a4,a0,a4
    80006e2c:	00b70023          	sb	a1,0(a4)
    80006e30:	0067871b          	addiw	a4,a5,6
    80006e34:	06c77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e38:	00e50733          	add	a4,a0,a4
    80006e3c:	00b70023          	sb	a1,0(a4)
    80006e40:	0077871b          	addiw	a4,a5,7
    80006e44:	06c77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e48:	00e50733          	add	a4,a0,a4
    80006e4c:	00b70023          	sb	a1,0(a4)
    80006e50:	0087871b          	addiw	a4,a5,8
    80006e54:	04c77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e58:	00e50733          	add	a4,a0,a4
    80006e5c:	00b70023          	sb	a1,0(a4)
    80006e60:	0097871b          	addiw	a4,a5,9
    80006e64:	04c77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e68:	00e50733          	add	a4,a0,a4
    80006e6c:	00b70023          	sb	a1,0(a4)
    80006e70:	00a7871b          	addiw	a4,a5,10
    80006e74:	02c77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e78:	00e50733          	add	a4,a0,a4
    80006e7c:	00b70023          	sb	a1,0(a4)
    80006e80:	00b7871b          	addiw	a4,a5,11
    80006e84:	02c77663          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e88:	00e50733          	add	a4,a0,a4
    80006e8c:	00b70023          	sb	a1,0(a4)
    80006e90:	00c7871b          	addiw	a4,a5,12
    80006e94:	00c77e63          	bgeu	a4,a2,80006eb0 <__memset+0x1c8>
    80006e98:	00e50733          	add	a4,a0,a4
    80006e9c:	00b70023          	sb	a1,0(a4)
    80006ea0:	00d7879b          	addiw	a5,a5,13
    80006ea4:	00c7f663          	bgeu	a5,a2,80006eb0 <__memset+0x1c8>
    80006ea8:	00f507b3          	add	a5,a0,a5
    80006eac:	00b78023          	sb	a1,0(a5)
    80006eb0:	00813403          	ld	s0,8(sp)
    80006eb4:	01010113          	addi	sp,sp,16
    80006eb8:	00008067          	ret
    80006ebc:	00b00693          	li	a3,11
    80006ec0:	e55ff06f          	j	80006d14 <__memset+0x2c>
    80006ec4:	00300e93          	li	t4,3
    80006ec8:	ea5ff06f          	j	80006d6c <__memset+0x84>
    80006ecc:	00100e93          	li	t4,1
    80006ed0:	e9dff06f          	j	80006d6c <__memset+0x84>
    80006ed4:	00000e93          	li	t4,0
    80006ed8:	e95ff06f          	j	80006d6c <__memset+0x84>
    80006edc:	00000793          	li	a5,0
    80006ee0:	ef9ff06f          	j	80006dd8 <__memset+0xf0>
    80006ee4:	00200e93          	li	t4,2
    80006ee8:	e85ff06f          	j	80006d6c <__memset+0x84>
    80006eec:	00400e93          	li	t4,4
    80006ef0:	e7dff06f          	j	80006d6c <__memset+0x84>
    80006ef4:	00500e93          	li	t4,5
    80006ef8:	e75ff06f          	j	80006d6c <__memset+0x84>
    80006efc:	00600e93          	li	t4,6
    80006f00:	e6dff06f          	j	80006d6c <__memset+0x84>

0000000080006f04 <__memmove>:
    80006f04:	ff010113          	addi	sp,sp,-16
    80006f08:	00813423          	sd	s0,8(sp)
    80006f0c:	01010413          	addi	s0,sp,16
    80006f10:	0e060863          	beqz	a2,80007000 <__memmove+0xfc>
    80006f14:	fff6069b          	addiw	a3,a2,-1
    80006f18:	0006881b          	sext.w	a6,a3
    80006f1c:	0ea5e863          	bltu	a1,a0,8000700c <__memmove+0x108>
    80006f20:	00758713          	addi	a4,a1,7
    80006f24:	00a5e7b3          	or	a5,a1,a0
    80006f28:	40a70733          	sub	a4,a4,a0
    80006f2c:	0077f793          	andi	a5,a5,7
    80006f30:	00f73713          	sltiu	a4,a4,15
    80006f34:	00174713          	xori	a4,a4,1
    80006f38:	0017b793          	seqz	a5,a5
    80006f3c:	00e7f7b3          	and	a5,a5,a4
    80006f40:	10078863          	beqz	a5,80007050 <__memmove+0x14c>
    80006f44:	00900793          	li	a5,9
    80006f48:	1107f463          	bgeu	a5,a6,80007050 <__memmove+0x14c>
    80006f4c:	0036581b          	srliw	a6,a2,0x3
    80006f50:	fff8081b          	addiw	a6,a6,-1
    80006f54:	02081813          	slli	a6,a6,0x20
    80006f58:	01d85893          	srli	a7,a6,0x1d
    80006f5c:	00858813          	addi	a6,a1,8
    80006f60:	00058793          	mv	a5,a1
    80006f64:	00050713          	mv	a4,a0
    80006f68:	01088833          	add	a6,a7,a6
    80006f6c:	0007b883          	ld	a7,0(a5)
    80006f70:	00878793          	addi	a5,a5,8
    80006f74:	00870713          	addi	a4,a4,8
    80006f78:	ff173c23          	sd	a7,-8(a4)
    80006f7c:	ff0798e3          	bne	a5,a6,80006f6c <__memmove+0x68>
    80006f80:	ff867713          	andi	a4,a2,-8
    80006f84:	02071793          	slli	a5,a4,0x20
    80006f88:	0207d793          	srli	a5,a5,0x20
    80006f8c:	00f585b3          	add	a1,a1,a5
    80006f90:	40e686bb          	subw	a3,a3,a4
    80006f94:	00f507b3          	add	a5,a0,a5
    80006f98:	06e60463          	beq	a2,a4,80007000 <__memmove+0xfc>
    80006f9c:	0005c703          	lbu	a4,0(a1)
    80006fa0:	00e78023          	sb	a4,0(a5)
    80006fa4:	04068e63          	beqz	a3,80007000 <__memmove+0xfc>
    80006fa8:	0015c603          	lbu	a2,1(a1)
    80006fac:	00100713          	li	a4,1
    80006fb0:	00c780a3          	sb	a2,1(a5)
    80006fb4:	04e68663          	beq	a3,a4,80007000 <__memmove+0xfc>
    80006fb8:	0025c603          	lbu	a2,2(a1)
    80006fbc:	00200713          	li	a4,2
    80006fc0:	00c78123          	sb	a2,2(a5)
    80006fc4:	02e68e63          	beq	a3,a4,80007000 <__memmove+0xfc>
    80006fc8:	0035c603          	lbu	a2,3(a1)
    80006fcc:	00300713          	li	a4,3
    80006fd0:	00c781a3          	sb	a2,3(a5)
    80006fd4:	02e68663          	beq	a3,a4,80007000 <__memmove+0xfc>
    80006fd8:	0045c603          	lbu	a2,4(a1)
    80006fdc:	00400713          	li	a4,4
    80006fe0:	00c78223          	sb	a2,4(a5)
    80006fe4:	00e68e63          	beq	a3,a4,80007000 <__memmove+0xfc>
    80006fe8:	0055c603          	lbu	a2,5(a1)
    80006fec:	00500713          	li	a4,5
    80006ff0:	00c782a3          	sb	a2,5(a5)
    80006ff4:	00e68663          	beq	a3,a4,80007000 <__memmove+0xfc>
    80006ff8:	0065c703          	lbu	a4,6(a1)
    80006ffc:	00e78323          	sb	a4,6(a5)
    80007000:	00813403          	ld	s0,8(sp)
    80007004:	01010113          	addi	sp,sp,16
    80007008:	00008067          	ret
    8000700c:	02061713          	slli	a4,a2,0x20
    80007010:	02075713          	srli	a4,a4,0x20
    80007014:	00e587b3          	add	a5,a1,a4
    80007018:	f0f574e3          	bgeu	a0,a5,80006f20 <__memmove+0x1c>
    8000701c:	02069613          	slli	a2,a3,0x20
    80007020:	02065613          	srli	a2,a2,0x20
    80007024:	fff64613          	not	a2,a2
    80007028:	00e50733          	add	a4,a0,a4
    8000702c:	00c78633          	add	a2,a5,a2
    80007030:	fff7c683          	lbu	a3,-1(a5)
    80007034:	fff78793          	addi	a5,a5,-1
    80007038:	fff70713          	addi	a4,a4,-1
    8000703c:	00d70023          	sb	a3,0(a4)
    80007040:	fec798e3          	bne	a5,a2,80007030 <__memmove+0x12c>
    80007044:	00813403          	ld	s0,8(sp)
    80007048:	01010113          	addi	sp,sp,16
    8000704c:	00008067          	ret
    80007050:	02069713          	slli	a4,a3,0x20
    80007054:	02075713          	srli	a4,a4,0x20
    80007058:	00170713          	addi	a4,a4,1
    8000705c:	00e50733          	add	a4,a0,a4
    80007060:	00050793          	mv	a5,a0
    80007064:	0005c683          	lbu	a3,0(a1)
    80007068:	00178793          	addi	a5,a5,1
    8000706c:	00158593          	addi	a1,a1,1
    80007070:	fed78fa3          	sb	a3,-1(a5)
    80007074:	fee798e3          	bne	a5,a4,80007064 <__memmove+0x160>
    80007078:	f89ff06f          	j	80007000 <__memmove+0xfc>

000000008000707c <__putc>:
    8000707c:	fe010113          	addi	sp,sp,-32
    80007080:	00813823          	sd	s0,16(sp)
    80007084:	00113c23          	sd	ra,24(sp)
    80007088:	02010413          	addi	s0,sp,32
    8000708c:	00050793          	mv	a5,a0
    80007090:	fef40593          	addi	a1,s0,-17
    80007094:	00100613          	li	a2,1
    80007098:	00000513          	li	a0,0
    8000709c:	fef407a3          	sb	a5,-17(s0)
    800070a0:	fffff097          	auipc	ra,0xfffff
    800070a4:	b3c080e7          	jalr	-1220(ra) # 80005bdc <console_write>
    800070a8:	01813083          	ld	ra,24(sp)
    800070ac:	01013403          	ld	s0,16(sp)
    800070b0:	02010113          	addi	sp,sp,32
    800070b4:	00008067          	ret

00000000800070b8 <__getc>:
    800070b8:	fe010113          	addi	sp,sp,-32
    800070bc:	00813823          	sd	s0,16(sp)
    800070c0:	00113c23          	sd	ra,24(sp)
    800070c4:	02010413          	addi	s0,sp,32
    800070c8:	fe840593          	addi	a1,s0,-24
    800070cc:	00100613          	li	a2,1
    800070d0:	00000513          	li	a0,0
    800070d4:	fffff097          	auipc	ra,0xfffff
    800070d8:	ae8080e7          	jalr	-1304(ra) # 80005bbc <console_read>
    800070dc:	fe844503          	lbu	a0,-24(s0)
    800070e0:	01813083          	ld	ra,24(sp)
    800070e4:	01013403          	ld	s0,16(sp)
    800070e8:	02010113          	addi	sp,sp,32
    800070ec:	00008067          	ret

00000000800070f0 <console_handler>:
    800070f0:	fe010113          	addi	sp,sp,-32
    800070f4:	00813823          	sd	s0,16(sp)
    800070f8:	00113c23          	sd	ra,24(sp)
    800070fc:	00913423          	sd	s1,8(sp)
    80007100:	02010413          	addi	s0,sp,32
    80007104:	14202773          	csrr	a4,scause
    80007108:	100027f3          	csrr	a5,sstatus
    8000710c:	0027f793          	andi	a5,a5,2
    80007110:	06079e63          	bnez	a5,8000718c <console_handler+0x9c>
    80007114:	00074c63          	bltz	a4,8000712c <console_handler+0x3c>
    80007118:	01813083          	ld	ra,24(sp)
    8000711c:	01013403          	ld	s0,16(sp)
    80007120:	00813483          	ld	s1,8(sp)
    80007124:	02010113          	addi	sp,sp,32
    80007128:	00008067          	ret
    8000712c:	0ff77713          	andi	a4,a4,255
    80007130:	00900793          	li	a5,9
    80007134:	fef712e3          	bne	a4,a5,80007118 <console_handler+0x28>
    80007138:	ffffe097          	auipc	ra,0xffffe
    8000713c:	6dc080e7          	jalr	1756(ra) # 80005814 <plic_claim>
    80007140:	00a00793          	li	a5,10
    80007144:	00050493          	mv	s1,a0
    80007148:	02f50c63          	beq	a0,a5,80007180 <console_handler+0x90>
    8000714c:	fc0506e3          	beqz	a0,80007118 <console_handler+0x28>
    80007150:	00050593          	mv	a1,a0
    80007154:	00001517          	auipc	a0,0x1
    80007158:	6ec50513          	addi	a0,a0,1772 # 80008840 <_ZTV7WorkerD+0xf8>
    8000715c:	fffff097          	auipc	ra,0xfffff
    80007160:	afc080e7          	jalr	-1284(ra) # 80005c58 <__printf>
    80007164:	01013403          	ld	s0,16(sp)
    80007168:	01813083          	ld	ra,24(sp)
    8000716c:	00048513          	mv	a0,s1
    80007170:	00813483          	ld	s1,8(sp)
    80007174:	02010113          	addi	sp,sp,32
    80007178:	ffffe317          	auipc	t1,0xffffe
    8000717c:	6d430067          	jr	1748(t1) # 8000584c <plic_complete>
    80007180:	fffff097          	auipc	ra,0xfffff
    80007184:	3e0080e7          	jalr	992(ra) # 80006560 <uartintr>
    80007188:	fddff06f          	j	80007164 <console_handler+0x74>
    8000718c:	00001517          	auipc	a0,0x1
    80007190:	7b450513          	addi	a0,a0,1972 # 80008940 <digits+0x78>
    80007194:	fffff097          	auipc	ra,0xfffff
    80007198:	a68080e7          	jalr	-1432(ra) # 80005bfc <panic>
	...
