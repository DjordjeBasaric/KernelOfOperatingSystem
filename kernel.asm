
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a7013103          	ld	sp,-1424(sp) # 80008a70 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	770040ef          	jal	ra,8000478c <start>

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
    800011b0:	298000ef          	jal	ra,80001448 <_ZN5Riscv23interruptRoutineHandlerEv>

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
#include "../lib/mem.h"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00113423          	sd	ra,8(sp)
    80001248:	00813023          	sd	s0,0(sp)
    8000124c:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001250:	00005097          	auipc	ra,0x5
    80001254:	6c8080e7          	jalr	1736(ra) # 80006918 <__mem_alloc>
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
    return __mem_alloc(n);
    80001278:	00005097          	auipc	ra,0x5
    8000127c:	6a0080e7          	jalr	1696(ra) # 80006918 <__mem_alloc>
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
    __mem_free(p);
    800012a0:	00005097          	auipc	ra,0x5
    800012a4:	5ac080e7          	jalr	1452(ra) # 8000684c <__mem_free>
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
    __mem_free(p);
    800012c8:	00005097          	auipc	ra,0x5
    800012cc:	584080e7          	jalr	1412(ra) # 8000684c <__mem_free>
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
    8000130c:	00008797          	auipc	a5,0x8
    80001310:	97478793          	addi	a5,a5,-1676 # 80008c80 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001334:	00008517          	auipc	a0,0x8
    80001338:	94c53503          	ld	a0,-1716(a0) # 80008c80 <_ZN9Scheduler19readyCoroutineQueueE>
    8000133c:	04050263          	beqz	a0,80001380 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001340:	00853783          	ld	a5,8(a0)
    80001344:	00008717          	auipc	a4,0x8
    80001348:	92f73e23          	sd	a5,-1732(a4) # 80008c80 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001374:	00008797          	auipc	a5,0x8
    80001378:	9007ba23          	sd	zero,-1772(a5) # 80008c88 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
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
    800013b4:	00008797          	auipc	a5,0x8
    800013b8:	8d47b783          	ld	a5,-1836(a5) # 80008c88 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013bc:	02078263          	beqz	a5,800013e0 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800013c0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800013c4:	00008797          	auipc	a5,0x8
    800013c8:	8ca7b223          	sd	a0,-1852(a5) # 80008c88 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013cc:	01813083          	ld	ra,24(sp)
    800013d0:	01013403          	ld	s0,16(sp)
    800013d4:	00813483          	ld	s1,8(sp)
    800013d8:	02010113          	addi	sp,sp,32
    800013dc:	00008067          	ret
            head = tail = elem;
    800013e0:	00008797          	auipc	a5,0x8
    800013e4:	8a078793          	addi	a5,a5,-1888 # 80008c80 <_ZN9Scheduler19readyCoroutineQueueE>
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

0000000080001428 <_ZN5Riscv10popSppSpieEv>:
#include "../h/_thread.hpp"
#include "../test/printing.hpp"
#include "../h/_sem.hpp"

void Riscv::popSppSpie()
{
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrw sepc, ra"); // zato ovde upisujem da nas vrati tamo odakle je i ova funkcija bila i pozvana i zbog toga ova funckija nije inline
    80001434:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret"); //ovo sret ce vratiti tamo gde je sepc rekao, i to nam ne odgovara
    80001438:	10200073          	sret

}
    8000143c:	00813403          	ld	s0,8(sp)
    80001440:	01010113          	addi	sp,sp,16
    80001444:	00008067          	ret

0000000080001448 <_ZN5Riscv23interruptRoutineHandlerEv>:

void Riscv::interruptRoutineHandler(){
    80001448:	f8010113          	addi	sp,sp,-128
    8000144c:	06113c23          	sd	ra,120(sp)
    80001450:	06813823          	sd	s0,112(sp)
    80001454:	06913423          	sd	s1,104(sp)
    80001458:	08010413          	addi	s0,sp,128
    uint64 volatile fcode;
    asm volatile("mv %0, a0" : "=r" (fcode));
    8000145c:	00050793          	mv	a5,a0
    80001460:	fcf43c23          	sd	a5,-40(s0)
};

inline uint64 Riscv::r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001464:	142027f3          	csrr	a5,scause
    80001468:	faf43823          	sd	a5,-80(s0)
    return scause;
    8000146c:	fb043483          	ld	s1,-80(s0)
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
    80001470:	ff848713          	addi	a4,s1,-8
    80001474:	00100793          	li	a5,1
    80001478:	0ce7fa63          	bgeu	a5,a4,8000154c <_ZN5Riscv23interruptRoutineHandlerEv+0x104>
        }

        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
        w_sstatus(sstatus);
    }
    else if (scause == 0x8000000000000001UL){
    8000147c:	fff00793          	li	a5,-1
    80001480:	03f79793          	slli	a5,a5,0x3f
    80001484:	00178793          	addi	a5,a5,1
    80001488:	20f48863          	beq	s1,a5,80001698 <_ZN5Riscv23interruptRoutineHandlerEv+0x250>
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
    8000148c:	fff00793          	li	a5,-1
    80001490:	03f79793          	slli	a5,a5,0x3f
    80001494:	00978793          	addi	a5,a5,9
    80001498:	20f48663          	beq	s1,a5,800016a4 <_ZN5Riscv23interruptRoutineHandlerEv+0x25c>
        console_handler();
    }
    else{
        printString("\nPc greske: ");
    8000149c:	00006517          	auipc	a0,0x6
    800014a0:	b6450513          	addi	a0,a0,-1180 # 80007000 <kvmincrease+0x470>
    800014a4:	00001097          	auipc	ra,0x1
    800014a8:	fac080e7          	jalr	-84(ra) # 80002450 <_Z11printStringPKc>
}

inline uint64 Riscv::r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800014ac:	141027f3          	csrr	a5,sepc
    800014b0:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    800014b4:	fd043503          	ld	a0,-48(s0)
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
    800014b8:	00000613          	li	a2,0
    800014bc:	00a00593          	li	a1,10
    800014c0:	0005051b          	sext.w	a0,a0
    800014c4:	00001097          	auipc	ra,0x1
    800014c8:	13c080e7          	jalr	316(ra) # 80002600 <_Z8printIntiii>
        printString("\nStVal greske: ");
    800014cc:	00006517          	auipc	a0,0x6
    800014d0:	b4450513          	addi	a0,a0,-1212 # 80007010 <kvmincrease+0x480>
    800014d4:	00001097          	auipc	ra,0x1
    800014d8:	f7c080e7          	jalr	-132(ra) # 80002450 <_Z11printStringPKc>
}

inline uint64 Riscv::r_stval()
{
    uint64 volatile stval;
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800014dc:	143027f3          	csrr	a5,stval
    800014e0:	fcf43423          	sd	a5,-56(s0)
    return stval;
    800014e4:	fc843503          	ld	a0,-56(s0)
        printInt(r_stval());
    800014e8:	00000613          	li	a2,0
    800014ec:	00a00593          	li	a1,10
    800014f0:	0005051b          	sext.w	a0,a0
    800014f4:	00001097          	auipc	ra,0x1
    800014f8:	10c080e7          	jalr	268(ra) # 80002600 <_Z8printIntiii>
        printString("\nRazlog greske scause: ");
    800014fc:	00006517          	auipc	a0,0x6
    80001500:	b2450513          	addi	a0,a0,-1244 # 80007020 <kvmincrease+0x490>
    80001504:	00001097          	auipc	ra,0x1
    80001508:	f4c080e7          	jalr	-180(ra) # 80002450 <_Z11printStringPKc>
        printInt(scause);
    8000150c:	00000613          	li	a2,0
    80001510:	00a00593          	li	a1,10
    80001514:	0004851b          	sext.w	a0,s1
    80001518:	00001097          	auipc	ra,0x1
    8000151c:	0e8080e7          	jalr	232(ra) # 80002600 <_Z8printIntiii>
        switch(scause) {
    80001520:	00500793          	li	a5,5
    80001524:	1af48063          	beq	s1,a5,800016c4 <_ZN5Riscv23interruptRoutineHandlerEv+0x27c>
    80001528:	00700793          	li	a5,7
    8000152c:	1af48663          	beq	s1,a5,800016d8 <_ZN5Riscv23interruptRoutineHandlerEv+0x290>
    80001530:	00200793          	li	a5,2
    80001534:	16f48e63          	beq	s1,a5,800016b0 <_ZN5Riscv23interruptRoutineHandlerEv+0x268>
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
    80001538:	00006517          	auipc	a0,0x6
    8000153c:	b5850513          	addi	a0,a0,-1192 # 80007090 <kvmincrease+0x500>
    80001540:	00001097          	auipc	ra,0x1
    80001544:	f10080e7          	jalr	-240(ra) # 80002450 <_Z11printStringPKc>
                break;
        }
    }
    80001548:	0a40006f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000154c:	141027f3          	csrr	a5,sepc
    80001550:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    80001554:	fc043783          	ld	a5,-64(s0)
        uint64 volatile sepc = r_sepc() + 4;    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    80001558:	00478793          	addi	a5,a5,4
    8000155c:	f8f43423          	sd	a5,-120(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001560:	100027f3          	csrr	a5,sstatus
    80001564:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    80001568:	fb843783          	ld	a5,-72(s0)
        uint64 volatile sstatus = r_sstatus();
    8000156c:	f8f43823          	sd	a5,-112(s0)
        switch(fcode){
    80001570:	fd843783          	ld	a5,-40(s0)
    80001574:	fef78793          	addi	a5,a5,-17
    80001578:	03000713          	li	a4,48
    8000157c:	06f76063          	bltu	a4,a5,800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
    80001580:	00279793          	slli	a5,a5,0x2
    80001584:	00006717          	auipc	a4,0x6
    80001588:	b1470713          	addi	a4,a4,-1260 # 80007098 <kvmincrease+0x508>
    8000158c:	00e787b3          	add	a5,a5,a4
    80001590:	0007a783          	lw	a5,0(a5)
    80001594:	00e787b3          	add	a5,a5,a4
    80001598:	00078067          	jr	a5
                asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
    8000159c:	00058793          	mv	a5,a1
    800015a0:	f8f43c23          	sd	a5,-104(s0)
                asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
    800015a4:	00060793          	mv	a5,a2
    800015a8:	faf43023          	sd	a5,-96(s0)
                asm volatile("mv %0, a3" : "=r" (arg));
    800015ac:	00068793          	mv	a5,a3
    800015b0:	faf43423          	sd	a5,-88(s0)
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
    800015b4:	00008537          	lui	a0,0x8
    800015b8:	00000097          	auipc	ra,0x0
    800015bc:	cb0080e7          	jalr	-848(ra) # 80001268 <_Znam>
    800015c0:	00050693          	mv	a3,a0
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
    800015c4:	f9843503          	ld	a0,-104(s0)
    800015c8:	fa043583          	ld	a1,-96(s0)
    800015cc:	fa843603          	ld	a2,-88(s0)
    800015d0:	00000097          	auipc	ra,0x0
    800015d4:	3a0080e7          	jalr	928(ra) # 80001970 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>
                asm volatile("mv a0, %0" : : "r" (retval));
    800015d8:	00050513          	mv	a0,a0
        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
    800015dc:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015e0:	14179073          	csrw	sepc,a5
        w_sstatus(sstatus);
    800015e4:	f9043783          	ld	a5,-112(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015e8:	10079073          	csrw	sstatus,a5
    800015ec:	07813083          	ld	ra,120(sp)
    800015f0:	07013403          	ld	s0,112(sp)
    800015f4:	06813483          	ld	s1,104(sp)
    800015f8:	08010113          	addi	sp,sp,128
    800015fc:	00008067          	ret
                retval = _thread::thread_exit();
    80001600:	00000097          	auipc	ra,0x0
    80001604:	520080e7          	jalr	1312(ra) # 80001b20 <_ZN7_thread11thread_exitEv>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001608:	00050513          	mv	a0,a0
                break;
    8000160c:	fd1ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                _thread::thread_dispatch();
    80001610:	00000097          	auipc	ra,0x0
    80001614:	44c080e7          	jalr	1100(ra) # 80001a5c <_ZN7_thread15thread_dispatchEv>
                break;
    80001618:	fc5ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                asm volatile("mv %0, a1" : "=r" (handle));
    8000161c:	00058513          	mv	a0,a1
                asm volatile("mv %0, a2" : "=r" (init));
    80001620:	00060593          	mv	a1,a2
                retval = _sem::open_sem((sem_t*)(handle), init);
    80001624:	0005859b          	sext.w	a1,a1
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	0c4080e7          	jalr	196(ra) # 800016ec <_ZN4_sem8open_semEPPS_j>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001630:	00050513          	mv	a0,a0
                break;
    80001634:	fa9ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001638:	00058513          	mv	a0,a1
                retval = _sem::close_sem((sem_t)handle);
    8000163c:	00000097          	auipc	ra,0x0
    80001640:	114080e7          	jalr	276(ra) # 80001750 <_ZN4_sem9close_semEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001644:	00050513          	mv	a0,a0
                break;
    80001648:	f95ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                asm volatile("mv %0, a1" : "=r" (handle));
    8000164c:	00058513          	mv	a0,a1
                retval = _sem::sem_wait((sem_t)handle);
    80001650:	00000097          	auipc	ra,0x0
    80001654:	214080e7          	jalr	532(ra) # 80001864 <_ZN4_sem8sem_waitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001658:	00050513          	mv	a0,a0
                break;
    8000165c:	f81ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001660:	00058513          	mv	a0,a1
                retval = _sem::sem_signal((sem_t)handle);
    80001664:	00000097          	auipc	ra,0x0
    80001668:	174080e7          	jalr	372(ra) # 800017d8 <_ZN4_sem10sem_signalEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    8000166c:	00050513          	mv	a0,a0
                break;
    80001670:	f6dff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001674:	00058513          	mv	a0,a1
                retval = _sem::sem_trywait((sem_t)handle);
    80001678:	00000097          	auipc	ra,0x0
    8000167c:	2a8080e7          	jalr	680(ra) # 80001920 <_ZN4_sem11sem_trywaitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001680:	00050513          	mv	a0,a0
                break;
    80001684:	f59ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
                char ch = __getc();
    80001688:	00005097          	auipc	ra,0x5
    8000168c:	424080e7          	jalr	1060(ra) # 80006aac <__getc>
                asm volatile("mv a0, %0" : : "r" (ch));
    80001690:	00050513          	mv	a0,a0
                break;
    80001694:	f49ff06f          	j	800015dc <_ZN5Riscv23interruptRoutineHandlerEv+0x194>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001698:	00200793          	li	a5,2
    8000169c:	1447b073          	csrc	sip,a5
}
    800016a0:	f4dff06f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>
        console_handler();
    800016a4:	00005097          	auipc	ra,0x5
    800016a8:	440080e7          	jalr	1088(ra) # 80006ae4 <console_handler>
    800016ac:	f41ff06f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>
                printString(" Nelegelna instrukcija");
    800016b0:	00006517          	auipc	a0,0x6
    800016b4:	98850513          	addi	a0,a0,-1656 # 80007038 <kvmincrease+0x4a8>
    800016b8:	00001097          	auipc	ra,0x1
    800016bc:	d98080e7          	jalr	-616(ra) # 80002450 <_Z11printStringPKc>
                break;
    800016c0:	f2dff06f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>
                printString(" Nedozvoljena adresa citanja");
    800016c4:	00006517          	auipc	a0,0x6
    800016c8:	98c50513          	addi	a0,a0,-1652 # 80007050 <kvmincrease+0x4c0>
    800016cc:	00001097          	auipc	ra,0x1
    800016d0:	d84080e7          	jalr	-636(ra) # 80002450 <_Z11printStringPKc>
                break;
    800016d4:	f19ff06f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>
                printString(" Nedozvoljena adresa upisa");
    800016d8:	00006517          	auipc	a0,0x6
    800016dc:	99850513          	addi	a0,a0,-1640 # 80007070 <kvmincrease+0x4e0>
    800016e0:	00001097          	auipc	ra,0x1
    800016e4:	d70080e7          	jalr	-656(ra) # 80002450 <_Z11printStringPKc>
                break;
    800016e8:	f05ff06f          	j	800015ec <_ZN5Riscv23interruptRoutineHandlerEv+0x1a4>

00000000800016ec <_ZN4_sem8open_semEPPS_j>:
//

#include "../h/_sem.hpp"


int _sem::open_sem(sem_t* handle, unsigned init){
    800016ec:	fe010113          	addi	sp,sp,-32
    800016f0:	00113c23          	sd	ra,24(sp)
    800016f4:	00813823          	sd	s0,16(sp)
    800016f8:	00913423          	sd	s1,8(sp)
    800016fc:	01213023          	sd	s2,0(sp)
    80001700:	02010413          	addi	s0,sp,32
    80001704:	00050493          	mv	s1,a0
    80001708:	00058913          	mv	s2,a1
    *handle = new _sem(init);
    8000170c:	01800513          	li	a0,24
    80001710:	00000097          	auipc	ra,0x0
    80001714:	b30080e7          	jalr	-1232(ra) # 80001240 <_Znwm>
    static int close_sem(sem_t id);
    static int sem_wait(sem_t id);
    static int sem_trywait(sem_t id);
    static int sem_signal(sem_t id);
private:
    _sem(unsigned v):val(v){ }//mozda ce trebati new blocked
    80001718:	01252023          	sw	s2,0(a0)
    List() : head(0), tail(0) {}
    8000171c:	00053423          	sd	zero,8(a0)
    80001720:	00053823          	sd	zero,16(a0)
    80001724:	00a4b023          	sd	a0,0(s1)
    if(*handle != nullptr) return 0;
    80001728:	02050063          	beqz	a0,80001748 <_ZN4_sem8open_semEPPS_j+0x5c>
    8000172c:	00000513          	li	a0,0
    return -1;
}
    80001730:	01813083          	ld	ra,24(sp)
    80001734:	01013403          	ld	s0,16(sp)
    80001738:	00813483          	ld	s1,8(sp)
    8000173c:	00013903          	ld	s2,0(sp)
    80001740:	02010113          	addi	sp,sp,32
    80001744:	00008067          	ret
    return -1;
    80001748:	fff00513          	li	a0,-1
    8000174c:	fe5ff06f          	j	80001730 <_ZN4_sem8open_semEPPS_j+0x44>

0000000080001750 <_ZN4_sem9close_semEPS_>:

int _sem::close_sem(sem_t id) {
    80001750:	fe010113          	addi	sp,sp,-32
    80001754:	00113c23          	sd	ra,24(sp)
    80001758:	00813823          	sd	s0,16(sp)
    8000175c:	00913423          	sd	s1,8(sp)
    80001760:	01213023          	sd	s2,0(sp)
    80001764:	02010413          	addi	s0,sp,32
    80001768:	00050493          	mv	s1,a0
    if(id==nullptr) return -1;
    8000176c:	02051463          	bnez	a0,80001794 <_ZN4_sem9close_semEPS_+0x44>
    80001770:	fff00513          	li	a0,-1
    80001774:	0440006f          	j	800017b8 <_ZN4_sem9close_semEPS_+0x68>
        if (!head) { tail = 0; }
    80001778:	0004b823          	sd	zero,16(s1)
        T *ret = elem->data;
    8000177c:	00053903          	ld	s2,0(a0)
        delete elem;
    80001780:	00000097          	auipc	ra,0x0
    80001784:	b10080e7          	jalr	-1264(ra) # 80001290 <_ZdlPv>
    while(!id->blocked.empty()){
        Scheduler::put(id->blocked.get());
    80001788:	00090513          	mv	a0,s2
    8000178c:	00000097          	auipc	ra,0x0
    80001790:	bfc080e7          	jalr	-1028(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
    80001794:	0084b503          	ld	a0,8(s1)
    80001798:	00050e63          	beqz	a0,800017b4 <_ZN4_sem9close_semEPS_+0x64>
        return head->data;
    8000179c:	00053783          	ld	a5,0(a0)
    while(!id->blocked.empty()){
    800017a0:	02078863          	beqz	a5,800017d0 <_ZN4_sem9close_semEPS_+0x80>
        head = head->next;
    800017a4:	00853783          	ld	a5,8(a0)
    800017a8:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    800017ac:	fc0798e3          	bnez	a5,8000177c <_ZN4_sem9close_semEPS_+0x2c>
    800017b0:	fc9ff06f          	j	80001778 <_ZN4_sem9close_semEPS_+0x28>
    }
  //  delete id;
    id=nullptr;
    return 0;
    800017b4:	00000513          	li	a0,0
}
    800017b8:	01813083          	ld	ra,24(sp)
    800017bc:	01013403          	ld	s0,16(sp)
    800017c0:	00813483          	ld	s1,8(sp)
    800017c4:	00013903          	ld	s2,0(sp)
    800017c8:	02010113          	addi	sp,sp,32
    800017cc:	00008067          	ret
    return 0;
    800017d0:	00000513          	li	a0,0
    800017d4:	fe5ff06f          	j	800017b8 <_ZN4_sem9close_semEPS_+0x68>

00000000800017d8 <_ZN4_sem10sem_signalEPS_>:

int _sem::sem_signal(sem_t id) {
    if(id==nullptr) return -1;
    800017d8:	08050263          	beqz	a0,8000185c <_ZN4_sem10sem_signalEPS_+0x84>
    800017dc:	00050793          	mv	a5,a0
        if (!head) { return 0; }
    800017e0:	00853503          	ld	a0,8(a0)
    800017e4:	06050263          	beqz	a0,80001848 <_ZN4_sem10sem_signalEPS_+0x70>
        return head->data;
    800017e8:	00053703          	ld	a4,0(a0)
    if (!id->blocked.empty()){
    800017ec:	04070e63          	beqz	a4,80001848 <_ZN4_sem10sem_signalEPS_+0x70>
int _sem::sem_signal(sem_t id) {
    800017f0:	fe010113          	addi	sp,sp,-32
    800017f4:	00113c23          	sd	ra,24(sp)
    800017f8:	00813823          	sd	s0,16(sp)
    800017fc:	00913423          	sd	s1,8(sp)
    80001800:	02010413          	addi	s0,sp,32
        head = head->next;
    80001804:	00853703          	ld	a4,8(a0)
    80001808:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    8000180c:	02070a63          	beqz	a4,80001840 <_ZN4_sem10sem_signalEPS_+0x68>
        T *ret = elem->data;
    80001810:	00053483          	ld	s1,0(a0)
        delete elem;
    80001814:	00000097          	auipc	ra,0x0
    80001818:	a7c080e7          	jalr	-1412(ra) # 80001290 <_ZdlPv>
        Scheduler::put(id->blocked.get());
    8000181c:	00048513          	mv	a0,s1
    80001820:	00000097          	auipc	ra,0x0
    80001824:	b68080e7          	jalr	-1176(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    }
    else id->val++;
    return 0;
    80001828:	00000513          	li	a0,0
}
    8000182c:	01813083          	ld	ra,24(sp)
    80001830:	01013403          	ld	s0,16(sp)
    80001834:	00813483          	ld	s1,8(sp)
    80001838:	02010113          	addi	sp,sp,32
    8000183c:	00008067          	ret
        if (!head) { tail = 0; }
    80001840:	0007b823          	sd	zero,16(a5)
    80001844:	fcdff06f          	j	80001810 <_ZN4_sem10sem_signalEPS_+0x38>
    else id->val++;
    80001848:	0007a703          	lw	a4,0(a5)
    8000184c:	0017071b          	addiw	a4,a4,1
    80001850:	00e7a023          	sw	a4,0(a5)
    return 0;
    80001854:	00000513          	li	a0,0
    80001858:	00008067          	ret
    if(id==nullptr) return -1;
    8000185c:	fff00513          	li	a0,-1
}
    80001860:	00008067          	ret

0000000080001864 <_ZN4_sem8sem_waitEPS_>:

int _sem::sem_wait(sem_t id) {
    if(id==nullptr) return -1;
    80001864:	0a050a63          	beqz	a0,80001918 <_ZN4_sem8sem_waitEPS_+0xb4>
int _sem::sem_wait(sem_t id) {
    80001868:	fe010113          	addi	sp,sp,-32
    8000186c:	00113c23          	sd	ra,24(sp)
    80001870:	00813823          	sd	s0,16(sp)
    80001874:	00913423          	sd	s1,8(sp)
    80001878:	01213023          	sd	s2,0(sp)
    8000187c:	02010413          	addi	s0,sp,32
    80001880:	00050493          	mv	s1,a0
    _thread *old = _thread::running;
    80001884:	00007917          	auipc	s2,0x7
    80001888:	37c93903          	ld	s2,892(s2) # 80008c00 <_ZN7_thread7runningE>
    if (id->val>0) id->val--;
    8000188c:	00052783          	lw	a5,0(a0)
    80001890:	02078463          	beqz	a5,800018b8 <_ZN4_sem8sem_waitEPS_+0x54>
    80001894:	fff7879b          	addiw	a5,a5,-1
    80001898:	00f52023          	sw	a5,0(a0)
    }

    if (!id){
        return -1;
    }
    else return 0;
    8000189c:	00000513          	li	a0,0
}
    800018a0:	01813083          	ld	ra,24(sp)
    800018a4:	01013403          	ld	s0,16(sp)
    800018a8:	00813483          	ld	s1,8(sp)
    800018ac:	00013903          	ld	s2,0(sp)
    800018b0:	02010113          	addi	sp,sp,32
    800018b4:	00008067          	ret

    using Body = void (*)(void(*)); //pokazivac na funkciju koja nema argumente ni povratnu vrednost

    ~_thread() {delete[] stack;}

    bool isFinished() const { return finished; }
    800018b8:	02894783          	lbu	a5,40(s2)
        if(!old->isFinished()){
    800018bc:	02078463          	beqz	a5,800018e4 <_ZN4_sem8sem_waitEPS_+0x80>
        _thread::running = Scheduler::get();
    800018c0:	00000097          	auipc	ra,0x0
    800018c4:	a60080e7          	jalr	-1440(ra) # 80001320 <_ZN9Scheduler3getEv>
    800018c8:	00007797          	auipc	a5,0x7
    800018cc:	32a7bc23          	sd	a0,824(a5) # 80008c00 <_ZN7_thread7runningE>
        _thread::contextSwitch(&old->context, &_thread::running->context);
    800018d0:	01050593          	addi	a1,a0,16
    800018d4:	01090513          	addi	a0,s2,16
    800018d8:	00000097          	auipc	ra,0x0
    800018dc:	840080e7          	jalr	-1984(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
    800018e0:	fbdff06f          	j	8000189c <_ZN4_sem8sem_waitEPS_+0x38>
        Elem *elem = new Elem(data, 0);
    800018e4:	01000513          	li	a0,16
    800018e8:	00000097          	auipc	ra,0x0
    800018ec:	958080e7          	jalr	-1704(ra) # 80001240 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800018f0:	01253023          	sd	s2,0(a0)
    800018f4:	00053423          	sd	zero,8(a0)
        if (tail)
    800018f8:	0104b783          	ld	a5,16(s1)
    800018fc:	00078863          	beqz	a5,8000190c <_ZN4_sem8sem_waitEPS_+0xa8>
            tail->next = elem;
    80001900:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001904:	00a4b823          	sd	a0,16(s1)
    80001908:	fb9ff06f          	j	800018c0 <_ZN4_sem8sem_waitEPS_+0x5c>
            head = tail = elem;
    8000190c:	00a4b823          	sd	a0,16(s1)
    80001910:	00a4b423          	sd	a0,8(s1)
    80001914:	fadff06f          	j	800018c0 <_ZN4_sem8sem_waitEPS_+0x5c>
    if(id==nullptr) return -1;
    80001918:	fff00513          	li	a0,-1
}
    8000191c:	00008067          	ret

0000000080001920 <_ZN4_sem11sem_trywaitEPS_>:

int _sem::sem_trywait(sem_t id) {
    80001920:	ff010113          	addi	sp,sp,-16
    80001924:	00813423          	sd	s0,8(sp)
    80001928:	01010413          	addi	s0,sp,16
    if(id==nullptr) return -1;
    8000192c:	02050263          	beqz	a0,80001950 <_ZN4_sem11sem_trywaitEPS_+0x30>
    if (id->val>0) {
    80001930:	00052783          	lw	a5,0(a0)
    80001934:	02078263          	beqz	a5,80001958 <_ZN4_sem11sem_trywaitEPS_+0x38>
        id->val--;
    80001938:	fff7879b          	addiw	a5,a5,-1
    8000193c:	0007871b          	sext.w	a4,a5
    80001940:	00f52023          	sw	a5,0(a0)
        if (id->val > 0) return 0;
    80001944:	02071263          	bnez	a4,80001968 <_ZN4_sem11sem_trywaitEPS_+0x48>
    }
    return 1;
    80001948:	00100513          	li	a0,1
    8000194c:	0100006f          	j	8000195c <_ZN4_sem11sem_trywaitEPS_+0x3c>
    if(id==nullptr) return -1;
    80001950:	fff00513          	li	a0,-1
    80001954:	0080006f          	j	8000195c <_ZN4_sem11sem_trywaitEPS_+0x3c>
    return 1;
    80001958:	00100513          	li	a0,1
    8000195c:	00813403          	ld	s0,8(sp)
    80001960:	01010113          	addi	sp,sp,16
    80001964:	00008067          	ret
        if (id->val > 0) return 0;
    80001968:	00000513          	li	a0,0
    8000196c:	ff1ff06f          	j	8000195c <_ZN4_sem11sem_trywaitEPS_+0x3c>

0000000080001970 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>:
#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread* _thread::running = nullptr;

int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){
    80001970:	fc010113          	addi	sp,sp,-64
    80001974:	02113c23          	sd	ra,56(sp)
    80001978:	02813823          	sd	s0,48(sp)
    8000197c:	02913423          	sd	s1,40(sp)
    80001980:	03213023          	sd	s2,32(sp)
    80001984:	01313c23          	sd	s3,24(sp)
    80001988:	01413823          	sd	s4,16(sp)
    8000198c:	01513423          	sd	s5,8(sp)
    80001990:	04010413          	addi	s0,sp,64
    80001994:	00050a13          	mv	s4,a0
    80001998:	00058993          	mv	s3,a1
    8000199c:	00060a93          	mv	s5,a2
    800019a0:	00068913          	mv	s2,a3

    *handle = new _thread(body, arg, stack_space);
    800019a4:	03000513          	li	a0,48
    800019a8:	00000097          	auipc	ra,0x0
    800019ac:	898080e7          	jalr	-1896(ra) # 80001240 <_Znwm>
    800019b0:	00050493          	mv	s1,a0
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false){
    800019b4:	01353023          	sd	s3,0(a0)
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    800019b8:	04098063          	beqz	s3,800019f8 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x88>
        finished(false){
    800019bc:	0124b423          	sd	s2,8(s1)
    800019c0:	00000797          	auipc	a5,0x0
    800019c4:	10478793          	addi	a5,a5,260 # 80001ac4 <_ZN7_thread13threadWrapperEv>
    800019c8:	00f4b823          	sd	a5,16(s1)
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    800019cc:	02090a63          	beqz	s2,80001a00 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x90>
    800019d0:	000086b7          	lui	a3,0x8
    800019d4:	00d90933          	add	s2,s2,a3
        finished(false){
    800019d8:	0124bc23          	sd	s2,24(s1)
    800019dc:	0354b023          	sd	s5,32(s1)
    800019e0:	02048423          	sb	zero,40(s1)
        if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
    800019e4:	02098263          	beqz	s3,80001a08 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
    800019e8:	00048513          	mv	a0,s1
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	99c080e7          	jalr	-1636(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    800019f4:	0140006f          	j	80001a08 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    800019f8:	00000913          	li	s2,0
    800019fc:	fc1ff06f          	j	800019bc <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x4c>
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001a00:	00000913          	li	s2,0
    80001a04:	fd5ff06f          	j	800019d8 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x68>
    80001a08:	009a3023          	sd	s1,0(s4)
    if(*handle != nullptr) return 0;
    80001a0c:	02048663          	beqz	s1,80001a38 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xc8>
    80001a10:	00000513          	li	a0,0
    return -1;
}
    80001a14:	03813083          	ld	ra,56(sp)
    80001a18:	03013403          	ld	s0,48(sp)
    80001a1c:	02813483          	ld	s1,40(sp)
    80001a20:	02013903          	ld	s2,32(sp)
    80001a24:	01813983          	ld	s3,24(sp)
    80001a28:	01013a03          	ld	s4,16(sp)
    80001a2c:	00813a83          	ld	s5,8(sp)
    80001a30:	04010113          	addi	sp,sp,64
    80001a34:	00008067          	ret
    return -1;
    80001a38:	fff00513          	li	a0,-1
    80001a3c:	fd9ff06f          	j	80001a14 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xa4>
    80001a40:	00050913          	mv	s2,a0
    *handle = new _thread(body, arg, stack_space);
    80001a44:	00048513          	mv	a0,s1
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	848080e7          	jalr	-1976(ra) # 80001290 <_ZdlPv>
    80001a50:	00090513          	mv	a0,s2
    80001a54:	00008097          	auipc	ra,0x8
    80001a58:	304080e7          	jalr	772(ra) # 80009d58 <_Unwind_Resume>

0000000080001a5c <_ZN7_thread15thread_dispatchEv>:


void _thread::thread_dispatch(){
    80001a5c:	fe010113          	addi	sp,sp,-32
    80001a60:	00113c23          	sd	ra,24(sp)
    80001a64:	00813823          	sd	s0,16(sp)
    80001a68:	00913423          	sd	s1,8(sp)
    80001a6c:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001a70:	00007497          	auipc	s1,0x7
    80001a74:	1904b483          	ld	s1,400(s1) # 80008c00 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001a78:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001a7c:	02078c63          	beqz	a5,80001ab4 <_ZN7_thread15thread_dispatchEv+0x58>
    running = Scheduler::get();
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	8a0080e7          	jalr	-1888(ra) # 80001320 <_ZN9Scheduler3getEv>
    80001a88:	00007797          	auipc	a5,0x7
    80001a8c:	16a7bc23          	sd	a0,376(a5) # 80008c00 <_ZN7_thread7runningE>

    //trenutni ra cuvam u old->context, a novi ra uzimam iz running->context i stavljam u ra registar
    _thread::contextSwitch(&old->context, &running->context);
    80001a90:	01050593          	addi	a1,a0,16
    80001a94:	01048513          	addi	a0,s1,16
    80001a98:	fffff097          	auipc	ra,0xfffff
    80001a9c:	680080e7          	jalr	1664(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001aa0:	01813083          	ld	ra,24(sp)
    80001aa4:	01013403          	ld	s0,16(sp)
    80001aa8:	00813483          	ld	s1,8(sp)
    80001aac:	02010113          	addi	sp,sp,32
    80001ab0:	00008067          	ret
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001ab4:	00048513          	mv	a0,s1
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	8d0080e7          	jalr	-1840(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001ac0:	fc1ff06f          	j	80001a80 <_ZN7_thread15thread_dispatchEv+0x24>

0000000080001ac4 <_ZN7_thread13threadWrapperEv>:
    //delete _thread::running;
    _thread::thread_dispatch();
    return 1;
}

void _thread::threadWrapper() {
    80001ac4:	fe010113          	addi	sp,sp,-32
    80001ac8:	00113c23          	sd	ra,24(sp)
    80001acc:	00813823          	sd	s0,16(sp)
    80001ad0:	00913423          	sd	s1,8(sp)
    80001ad4:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80001ad8:	00000097          	auipc	ra,0x0
    80001adc:	950080e7          	jalr	-1712(ra) # 80001428 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80001ae0:	00007497          	auipc	s1,0x7
    80001ae4:	12048493          	addi	s1,s1,288 # 80008c00 <_ZN7_thread7runningE>
    80001ae8:	0004b783          	ld	a5,0(s1)
    80001aec:	0007b703          	ld	a4,0(a5)
    80001af0:	0207b503          	ld	a0,32(a5)
    80001af4:	000700e7          	jalr	a4
    running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    80001af8:	0004b783          	ld	a5,0(s1)
    void setFinished(bool fin) { _thread::finished = fin; }
    80001afc:	00100713          	li	a4,1
    80001b00:	02e78423          	sb	a4,40(a5)
    _thread::thread_dispatch();
    80001b04:	00000097          	auipc	ra,0x0
    80001b08:	f58080e7          	jalr	-168(ra) # 80001a5c <_ZN7_thread15thread_dispatchEv>
}
    80001b0c:	01813083          	ld	ra,24(sp)
    80001b10:	01013403          	ld	s0,16(sp)
    80001b14:	00813483          	ld	s1,8(sp)
    80001b18:	02010113          	addi	sp,sp,32
    80001b1c:	00008067          	ret

0000000080001b20 <_ZN7_thread11thread_exitEv>:
int _thread::thread_exit() {
    80001b20:	ff010113          	addi	sp,sp,-16
    80001b24:	00813423          	sd	s0,8(sp)
    80001b28:	01010413          	addi	s0,sp,16
    80001b2c:	00007797          	auipc	a5,0x7
    80001b30:	0d47b783          	ld	a5,212(a5) # 80008c00 <_ZN7_thread7runningE>
    80001b34:	00100713          	li	a4,1
    80001b38:	02e78423          	sb	a4,40(a5)
}
    80001b3c:	fff00513          	li	a0,-1
    80001b40:	00813403          	ld	s0,8(sp)
    80001b44:	01010113          	addi	sp,sp,16
    80001b48:	00008067          	ret

0000000080001b4c <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80001b4c:	fe010113          	addi	sp,sp,-32
    80001b50:	00113c23          	sd	ra,24(sp)
    80001b54:	00813823          	sd	s0,16(sp)
    80001b58:	00913423          	sd	s1,8(sp)
    80001b5c:	01213023          	sd	s2,0(sp)
    80001b60:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80001b64:	00005517          	auipc	a0,0x5
    80001b68:	5fc50513          	addi	a0,a0,1532 # 80007160 <kvmincrease+0x5d0>
    80001b6c:	00001097          	auipc	ra,0x1
    80001b70:	8e4080e7          	jalr	-1820(ra) # 80002450 <_Z11printStringPKc>
    int test = getc() - '0';
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	2a4080e7          	jalr	676(ra) # 80001e18 <_Z4getcv>
    80001b7c:	00050913          	mv	s2,a0
    80001b80:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	294080e7          	jalr	660(ra) # 80001e18 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001b8c:	fcb9091b          	addiw	s2,s2,-53
    80001b90:	00100793          	li	a5,1
    80001b94:	0327f463          	bgeu	a5,s2,80001bbc <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001b98:	00700793          	li	a5,7
    80001b9c:	0c97ee63          	bltu	a5,s1,80001c78 <_Z8userMainv+0x12c>
    80001ba0:	00249493          	slli	s1,s1,0x2
    80001ba4:	00005717          	auipc	a4,0x5
    80001ba8:	7f070713          	addi	a4,a4,2032 # 80007394 <kvmincrease+0x804>
    80001bac:	00e484b3          	add	s1,s1,a4
    80001bb0:	0004a783          	lw	a5,0(s1)
    80001bb4:	00e787b3          	add	a5,a5,a4
    80001bb8:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001bbc:	00005517          	auipc	a0,0x5
    80001bc0:	5c450513          	addi	a0,a0,1476 # 80007180 <kvmincrease+0x5f0>
    80001bc4:	00001097          	auipc	ra,0x1
    80001bc8:	88c080e7          	jalr	-1908(ra) # 80002450 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80001bcc:	01813083          	ld	ra,24(sp)
    80001bd0:	01013403          	ld	s0,16(sp)
    80001bd4:	00813483          	ld	s1,8(sp)
    80001bd8:	00013903          	ld	s2,0(sp)
    80001bdc:	02010113          	addi	sp,sp,32
    80001be0:	00008067          	ret
            Threads_C_API_test();
    80001be4:	00002097          	auipc	ra,0x2
    80001be8:	160080e7          	jalr	352(ra) # 80003d44 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001bec:	00005517          	auipc	a0,0x5
    80001bf0:	5c450513          	addi	a0,a0,1476 # 800071b0 <kvmincrease+0x620>
    80001bf4:	00001097          	auipc	ra,0x1
    80001bf8:	85c080e7          	jalr	-1956(ra) # 80002450 <_Z11printStringPKc>
            break;
    80001bfc:	fd1ff06f          	j	80001bcc <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001c00:	00002097          	auipc	ra,0x2
    80001c04:	71c080e7          	jalr	1820(ra) # 8000431c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001c08:	00005517          	auipc	a0,0x5
    80001c0c:	5e850513          	addi	a0,a0,1512 # 800071f0 <kvmincrease+0x660>
    80001c10:	00001097          	auipc	ra,0x1
    80001c14:	840080e7          	jalr	-1984(ra) # 80002450 <_Z11printStringPKc>
            break;
    80001c18:	fb5ff06f          	j	80001bcc <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001c1c:	00000097          	auipc	ra,0x0
    80001c20:	568080e7          	jalr	1384(ra) # 80002184 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001c24:	00005517          	auipc	a0,0x5
    80001c28:	60c50513          	addi	a0,a0,1548 # 80007230 <kvmincrease+0x6a0>
    80001c2c:	00001097          	auipc	ra,0x1
    80001c30:	824080e7          	jalr	-2012(ra) # 80002450 <_Z11printStringPKc>
            break;
    80001c34:	f99ff06f          	j	80001bcc <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001c38:	00001097          	auipc	ra,0x1
    80001c3c:	22c080e7          	jalr	556(ra) # 80002e64 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001c40:	00005517          	auipc	a0,0x5
    80001c44:	64050513          	addi	a0,a0,1600 # 80007280 <kvmincrease+0x6f0>
    80001c48:	00001097          	auipc	ra,0x1
    80001c4c:	808080e7          	jalr	-2040(ra) # 80002450 <_Z11printStringPKc>
            break;
    80001c50:	f7dff06f          	j	80001bcc <_Z8userMainv+0x80>
            printString("Test se nije uspesno zavrsio\n");
    80001c54:	00005517          	auipc	a0,0x5
    80001c58:	68450513          	addi	a0,a0,1668 # 800072d8 <kvmincrease+0x748>
    80001c5c:	00000097          	auipc	ra,0x0
    80001c60:	7f4080e7          	jalr	2036(ra) # 80002450 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001c64:	00005517          	auipc	a0,0x5
    80001c68:	69450513          	addi	a0,a0,1684 # 800072f8 <kvmincrease+0x768>
    80001c6c:	00000097          	auipc	ra,0x0
    80001c70:	7e4080e7          	jalr	2020(ra) # 80002450 <_Z11printStringPKc>
            break;
    80001c74:	f59ff06f          	j	80001bcc <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001c78:	00005517          	auipc	a0,0x5
    80001c7c:	6d850513          	addi	a0,a0,1752 # 80007350 <kvmincrease+0x7c0>
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	7d0080e7          	jalr	2000(ra) # 80002450 <_Z11printStringPKc>
    80001c88:	f45ff06f          	j	80001bcc <_Z8userMainv+0x80>

0000000080001c8c <_Z7wrapperPv>:





void wrapper(void* arg){
    80001c8c:	ff010113          	addi	sp,sp,-16
    80001c90:	00113423          	sd	ra,8(sp)
    80001c94:	00813023          	sd	s0,0(sp)
    80001c98:	01010413          	addi	s0,sp,16
    80001c9c:	00c0006f          	j	80001ca8 <_Z7wrapperPv+0x1c>

    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
        thread_dispatch();
    80001ca0:	00000097          	auipc	ra,0x0
    80001ca4:	128080e7          	jalr	296(ra) # 80001dc8 <_Z15thread_dispatchv>
    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
    80001ca8:	00007797          	auipc	a5,0x7
    80001cac:	f707b783          	ld	a5,-144(a5) # 80008c18 <nitA>
    bool isFinished() const { return finished; }
    80001cb0:	0287c783          	lbu	a5,40(a5)
    80001cb4:	fe0786e3          	beqz	a5,80001ca0 <_Z7wrapperPv+0x14>
    80001cb8:	00007797          	auipc	a5,0x7
    80001cbc:	f587b783          	ld	a5,-168(a5) # 80008c10 <nitB>
    80001cc0:	0287c783          	lbu	a5,40(a5)
    80001cc4:	fc078ee3          	beqz	a5,80001ca0 <_Z7wrapperPv+0x14>
    80001cc8:	00007797          	auipc	a5,0x7
    80001ccc:	f407b783          	ld	a5,-192(a5) # 80008c08 <nitC>
    80001cd0:	0287c783          	lbu	a5,40(a5)
    80001cd4:	fc0786e3          	beqz	a5,80001ca0 <_Z7wrapperPv+0x14>
    }

    printString("ZAVRSENA JE WRAPPER FJA\n");
    80001cd8:	00005517          	auipc	a0,0x5
    80001cdc:	6a050513          	addi	a0,a0,1696 # 80007378 <kvmincrease+0x7e8>
    80001ce0:	00000097          	auipc	ra,0x0
    80001ce4:	770080e7          	jalr	1904(ra) # 80002450 <_Z11printStringPKc>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001ce8:	00007797          	auipc	a5,0x7
    80001cec:	f187b783          	ld	a5,-232(a5) # 80008c00 <_ZN7_thread7runningE>
    80001cf0:	00100713          	li	a4,1
    80001cf4:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001cf8:	00000097          	auipc	ra,0x0
    80001cfc:	0d0080e7          	jalr	208(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    80001d00:	00813083          	ld	ra,8(sp)
    80001d04:	00013403          	ld	s0,0(sp)
    80001d08:	01010113          	addi	sp,sp,16
    80001d0c:	00008067          	ret

0000000080001d10 <main>:

int main()
{
    80001d10:	fe010113          	addi	sp,sp,-32
    80001d14:	00113c23          	sd	ra,24(sp)
    80001d18:	00813823          	sd	s0,16(sp)
    80001d1c:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine
    80001d20:	fffff797          	auipc	a5,0xfffff
    80001d24:	41078793          	addi	a5,a5,1040 # 80001130 <_ZN5Riscv16interruptRoutineEv>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001d28:	10579073          	csrw	stvec,a5
    //Riscv: :ms_sstatus (Riscv:: SSTATUS_SIE);
    thread_t thread1;
    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    80001d2c:	00000613          	li	a2,0
    80001d30:	00000593          	li	a1,0
    80001d34:	fe840513          	addi	a0,s0,-24
    80001d38:	00000097          	auipc	ra,0x0
    80001d3c:	058080e7          	jalr	88(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = thread1;
    80001d40:	fe843783          	ld	a5,-24(s0)
    80001d44:	00007717          	auipc	a4,0x7
    80001d48:	eaf73e23          	sd	a5,-324(a4) # 80008c00 <_ZN7_thread7runningE>
    thread_t thread2;
    thread_create(&thread2, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80001d4c:	00000613          	li	a2,0
    80001d50:	00000597          	auipc	a1,0x0
    80001d54:	dfc58593          	addi	a1,a1,-516 # 80001b4c <_Z8userMainv>
    80001d58:	fe040513          	addi	a0,s0,-32
    80001d5c:	00000097          	auipc	ra,0x0
    80001d60:	034080e7          	jalr	52(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>

    while (!(thread2->isFinished())) {
    80001d64:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001d68:	0287c783          	lbu	a5,40(a5)
    80001d6c:	00079863          	bnez	a5,80001d7c <main+0x6c>
        thread_dispatch();
    80001d70:	00000097          	auipc	ra,0x0
    80001d74:	058080e7          	jalr	88(ra) # 80001dc8 <_Z15thread_dispatchv>
    80001d78:	fedff06f          	j	80001d64 <main+0x54>
    }

    return 0;
}
    80001d7c:	00000513          	li	a0,0
    80001d80:	01813083          	ld	ra,24(sp)
    80001d84:	01013403          	ld	s0,16(sp)
    80001d88:	02010113          	addi	sp,sp,32
    80001d8c:	00008067          	ret

0000000080001d90 <_Z13thread_createPP7_threadPFvPvES2_>:

#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/syscall_c.hpp"

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001d90:	ff010113          	addi	sp,sp,-16
    80001d94:	00813423          	sd	s0,8(sp)
    80001d98:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x11;
    int retval;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    80001d9c:	00060693          	mv	a3,a2
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80001da0:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001da4:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001da8:	01100793          	li	a5,17
    80001dac:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001db0:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001db4:	00050513          	mv	a0,a0
    return retval;//PROVERITI DA LI JE UREDU

    //dodati promenljivu za povratnu vrednost
}
    80001db8:	0005051b          	sext.w	a0,a0
    80001dbc:	00813403          	ld	s0,8(sp)
    80001dc0:	01010113          	addi	sp,sp,16
    80001dc4:	00008067          	ret

0000000080001dc8 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001dc8:	ff010113          	addi	sp,sp,-16
    80001dcc:	00813423          	sd	s0,8(sp)
    80001dd0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001dd4:	01300793          	li	a5,19
    80001dd8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001ddc:	00000073          	ecall
}
    80001de0:	00813403          	ld	s0,8(sp)
    80001de4:	01010113          	addi	sp,sp,16
    80001de8:	00008067          	ret

0000000080001dec <_Z11thread_exitv>:

int thread_exit(){
    80001dec:	ff010113          	addi	sp,sp,-16
    80001df0:	00813423          	sd	s0,8(sp)
    80001df4:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x12;
    int retval;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001df8:	01200793          	li	a5,18
    80001dfc:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001e00:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval));
    80001e04:	00050513          	mv	a0,a0
    return retval;
}
    80001e08:	0005051b          	sext.w	a0,a0
    80001e0c:	00813403          	ld	s0,8(sp)
    80001e10:	01010113          	addi	sp,sp,16
    80001e14:	00008067          	ret

0000000080001e18 <_Z4getcv>:

char getc(){
    80001e18:	ff010113          	addi	sp,sp,-16
    80001e1c:	00813423          	sd	s0,8(sp)
    80001e20:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x41;
    char ch;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001e24:	04100793          	li	a5,65
    80001e28:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001e2c:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (ch));
    80001e30:	00050513          	mv	a0,a0
    return ch;
}
    80001e34:	0ff57513          	andi	a0,a0,255
    80001e38:	00813403          	ld	s0,8(sp)
    80001e3c:	01010113          	addi	sp,sp,16
    80001e40:	00008067          	ret

0000000080001e44 <_Z4putcc>:

void putc(char c){
    80001e44:	ff010113          	addi	sp,sp,-16
    80001e48:	00113423          	sd	ra,8(sp)
    80001e4c:	00813023          	sd	s0,0(sp)
    80001e50:	01010413          	addi	s0,sp,16
    __putc(c);
    80001e54:	00005097          	auipc	ra,0x5
    80001e58:	c1c080e7          	jalr	-996(ra) # 80006a70 <__putc>
}
    80001e5c:	00813083          	ld	ra,8(sp)
    80001e60:	00013403          	ld	s0,0(sp)
    80001e64:	01010113          	addi	sp,sp,16
    80001e68:	00008067          	ret

0000000080001e6c <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    80001e6c:	ff010113          	addi	sp,sp,-16
    80001e70:	00813423          	sd	s0,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x21;
    int retval;
    __asm__ volatile("mv a2, %0" : : "r"(init));
    80001e78:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001e7c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001e80:	02100793          	li	a5,33
    80001e84:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001e88:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001e8c:	00050513          	mv	a0,a0
    return retval;
}
    80001e90:	0005051b          	sext.w	a0,a0
    80001e94:	00813403          	ld	s0,8(sp)
    80001e98:	01010113          	addi	sp,sp,16
    80001e9c:	00008067          	ret

0000000080001ea0 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle){
    80001ea0:	ff010113          	addi	sp,sp,-16
    80001ea4:	00813423          	sd	s0,8(sp)
    80001ea8:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x22;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001eac:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001eb0:	02200793          	li	a5,34
    80001eb4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001eb8:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001ebc:	00050513          	mv	a0,a0
    return retval;
}
    80001ec0:	0005051b          	sext.w	a0,a0
    80001ec4:	00813403          	ld	s0,8(sp)
    80001ec8:	01010113          	addi	sp,sp,16
    80001ecc:	00008067          	ret

0000000080001ed0 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t handle){
    80001ed0:	ff010113          	addi	sp,sp,-16
    80001ed4:	00813423          	sd	s0,8(sp)
    80001ed8:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x23;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001edc:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001ee0:	02300793          	li	a5,35
    80001ee4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001ee8:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001eec:	00050513          	mv	a0,a0
    return retval;
}
    80001ef0:	0005051b          	sext.w	a0,a0
    80001ef4:	00813403          	ld	s0,8(sp)
    80001ef8:	01010113          	addi	sp,sp,16
    80001efc:	00008067          	ret

0000000080001f00 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t handle){
    80001f00:	ff010113          	addi	sp,sp,-16
    80001f04:	00813423          	sd	s0,8(sp)
    80001f08:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x24;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001f0c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001f10:	02400793          	li	a5,36
    80001f14:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001f18:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001f1c:	00050513          	mv	a0,a0
    return retval;
}
    80001f20:	0005051b          	sext.w	a0,a0
    80001f24:	00813403          	ld	s0,8(sp)
    80001f28:	01010113          	addi	sp,sp,16
    80001f2c:	00008067          	ret

0000000080001f30 <_Z11sem_trywaitP4_sem>:

int sem_trywait(sem_t handle){
    80001f30:	ff010113          	addi	sp,sp,-16
    80001f34:	00813423          	sd	s0,8(sp)
    80001f38:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x26;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001f3c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001f40:	02600793          	li	a5,38
    80001f44:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001f48:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001f4c:	00050513          	mv	a0,a0
    return retval;
}
    80001f50:	0005051b          	sext.w	a0,a0
    80001f54:	00813403          	ld	s0,8(sp)
    80001f58:	01010113          	addi	sp,sp,16
    80001f5c:	00008067          	ret

0000000080001f60 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80001f60:	fe010113          	addi	sp,sp,-32
    80001f64:	00113c23          	sd	ra,24(sp)
    80001f68:	00813823          	sd	s0,16(sp)
    80001f6c:	00913423          	sd	s1,8(sp)
    80001f70:	01213023          	sd	s2,0(sp)
    80001f74:	02010413          	addi	s0,sp,32
    80001f78:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80001f7c:	00000913          	li	s2,0
    80001f80:	00c0006f          	j	80001f8c <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001f84:	00000097          	auipc	ra,0x0
    80001f88:	e44080e7          	jalr	-444(ra) # 80001dc8 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80001f8c:	00000097          	auipc	ra,0x0
    80001f90:	e8c080e7          	jalr	-372(ra) # 80001e18 <_Z4getcv>
    80001f94:	0005059b          	sext.w	a1,a0
    80001f98:	01b00793          	li	a5,27
    80001f9c:	02f58a63          	beq	a1,a5,80001fd0 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80001fa0:	0084b503          	ld	a0,8(s1)
    80001fa4:	00001097          	auipc	ra,0x1
    80001fa8:	640080e7          	jalr	1600(ra) # 800035e4 <_ZN6Buffer3putEi>
        i++;
    80001fac:	0019071b          	addiw	a4,s2,1
    80001fb0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001fb4:	0004a683          	lw	a3,0(s1)
    80001fb8:	0026979b          	slliw	a5,a3,0x2
    80001fbc:	00d787bb          	addw	a5,a5,a3
    80001fc0:	0017979b          	slliw	a5,a5,0x1
    80001fc4:	02f767bb          	remw	a5,a4,a5
    80001fc8:	fc0792e3          	bnez	a5,80001f8c <_ZL16producerKeyboardPv+0x2c>
    80001fcc:	fb9ff06f          	j	80001f84 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80001fd0:	00100793          	li	a5,1
    80001fd4:	00007717          	auipc	a4,0x7
    80001fd8:	c4f72623          	sw	a5,-948(a4) # 80008c20 <_ZL9threadEnd>
    data->buffer->put('!');
    80001fdc:	02100593          	li	a1,33
    80001fe0:	0084b503          	ld	a0,8(s1)
    80001fe4:	00001097          	auipc	ra,0x1
    80001fe8:	600080e7          	jalr	1536(ra) # 800035e4 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80001fec:	0104b503          	ld	a0,16(s1)
    80001ff0:	00000097          	auipc	ra,0x0
    80001ff4:	f10080e7          	jalr	-240(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    80001ff8:	01813083          	ld	ra,24(sp)
    80001ffc:	01013403          	ld	s0,16(sp)
    80002000:	00813483          	ld	s1,8(sp)
    80002004:	00013903          	ld	s2,0(sp)
    80002008:	02010113          	addi	sp,sp,32
    8000200c:	00008067          	ret

0000000080002010 <_ZL8producerPv>:

static void producer(void *arg) {
    80002010:	fe010113          	addi	sp,sp,-32
    80002014:	00113c23          	sd	ra,24(sp)
    80002018:	00813823          	sd	s0,16(sp)
    8000201c:	00913423          	sd	s1,8(sp)
    80002020:	01213023          	sd	s2,0(sp)
    80002024:	02010413          	addi	s0,sp,32
    80002028:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000202c:	00000913          	li	s2,0
    80002030:	00c0006f          	j	8000203c <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002034:	00000097          	auipc	ra,0x0
    80002038:	d94080e7          	jalr	-620(ra) # 80001dc8 <_Z15thread_dispatchv>
    while (!threadEnd) {
    8000203c:	00007797          	auipc	a5,0x7
    80002040:	be47a783          	lw	a5,-1052(a5) # 80008c20 <_ZL9threadEnd>
    80002044:	02079e63          	bnez	a5,80002080 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002048:	0004a583          	lw	a1,0(s1)
    8000204c:	0305859b          	addiw	a1,a1,48
    80002050:	0084b503          	ld	a0,8(s1)
    80002054:	00001097          	auipc	ra,0x1
    80002058:	590080e7          	jalr	1424(ra) # 800035e4 <_ZN6Buffer3putEi>
        i++;
    8000205c:	0019071b          	addiw	a4,s2,1
    80002060:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002064:	0004a683          	lw	a3,0(s1)
    80002068:	0026979b          	slliw	a5,a3,0x2
    8000206c:	00d787bb          	addw	a5,a5,a3
    80002070:	0017979b          	slliw	a5,a5,0x1
    80002074:	02f767bb          	remw	a5,a4,a5
    80002078:	fc0792e3          	bnez	a5,8000203c <_ZL8producerPv+0x2c>
    8000207c:	fb9ff06f          	j	80002034 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80002080:	0104b503          	ld	a0,16(s1)
    80002084:	00000097          	auipc	ra,0x0
    80002088:	e7c080e7          	jalr	-388(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    8000208c:	01813083          	ld	ra,24(sp)
    80002090:	01013403          	ld	s0,16(sp)
    80002094:	00813483          	ld	s1,8(sp)
    80002098:	00013903          	ld	s2,0(sp)
    8000209c:	02010113          	addi	sp,sp,32
    800020a0:	00008067          	ret

00000000800020a4 <_ZL8consumerPv>:

static void consumer(void *arg) {
    800020a4:	fd010113          	addi	sp,sp,-48
    800020a8:	02113423          	sd	ra,40(sp)
    800020ac:	02813023          	sd	s0,32(sp)
    800020b0:	00913c23          	sd	s1,24(sp)
    800020b4:	01213823          	sd	s2,16(sp)
    800020b8:	01313423          	sd	s3,8(sp)
    800020bc:	03010413          	addi	s0,sp,48
    800020c0:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800020c4:	00000993          	li	s3,0
    800020c8:	01c0006f          	j	800020e4 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800020cc:	00000097          	auipc	ra,0x0
    800020d0:	cfc080e7          	jalr	-772(ra) # 80001dc8 <_Z15thread_dispatchv>
    800020d4:	0500006f          	j	80002124 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800020d8:	00a00513          	li	a0,10
    800020dc:	00000097          	auipc	ra,0x0
    800020e0:	d68080e7          	jalr	-664(ra) # 80001e44 <_Z4putcc>
    while (!threadEnd) {
    800020e4:	00007797          	auipc	a5,0x7
    800020e8:	b3c7a783          	lw	a5,-1220(a5) # 80008c20 <_ZL9threadEnd>
    800020ec:	06079063          	bnez	a5,8000214c <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800020f0:	00893503          	ld	a0,8(s2)
    800020f4:	00001097          	auipc	ra,0x1
    800020f8:	580080e7          	jalr	1408(ra) # 80003674 <_ZN6Buffer3getEv>
        i++;
    800020fc:	0019849b          	addiw	s1,s3,1
    80002100:	0004899b          	sext.w	s3,s1
        putc(key);
    80002104:	0ff57513          	andi	a0,a0,255
    80002108:	00000097          	auipc	ra,0x0
    8000210c:	d3c080e7          	jalr	-708(ra) # 80001e44 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002110:	00092703          	lw	a4,0(s2)
    80002114:	0027179b          	slliw	a5,a4,0x2
    80002118:	00e787bb          	addw	a5,a5,a4
    8000211c:	02f4e7bb          	remw	a5,s1,a5
    80002120:	fa0786e3          	beqz	a5,800020cc <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80002124:	05000793          	li	a5,80
    80002128:	02f4e4bb          	remw	s1,s1,a5
    8000212c:	fa049ce3          	bnez	s1,800020e4 <_ZL8consumerPv+0x40>
    80002130:	fa9ff06f          	j	800020d8 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002134:	00893503          	ld	a0,8(s2)
    80002138:	00001097          	auipc	ra,0x1
    8000213c:	53c080e7          	jalr	1340(ra) # 80003674 <_ZN6Buffer3getEv>
        putc(key);
    80002140:	0ff57513          	andi	a0,a0,255
    80002144:	00000097          	auipc	ra,0x0
    80002148:	d00080e7          	jalr	-768(ra) # 80001e44 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    8000214c:	00893503          	ld	a0,8(s2)
    80002150:	00001097          	auipc	ra,0x1
    80002154:	5b0080e7          	jalr	1456(ra) # 80003700 <_ZN6Buffer6getCntEv>
    80002158:	fca04ee3          	bgtz	a0,80002134 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    8000215c:	01093503          	ld	a0,16(s2)
    80002160:	00000097          	auipc	ra,0x0
    80002164:	da0080e7          	jalr	-608(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    80002168:	02813083          	ld	ra,40(sp)
    8000216c:	02013403          	ld	s0,32(sp)
    80002170:	01813483          	ld	s1,24(sp)
    80002174:	01013903          	ld	s2,16(sp)
    80002178:	00813983          	ld	s3,8(sp)
    8000217c:	03010113          	addi	sp,sp,48
    80002180:	00008067          	ret

0000000080002184 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002184:	f9010113          	addi	sp,sp,-112
    80002188:	06113423          	sd	ra,104(sp)
    8000218c:	06813023          	sd	s0,96(sp)
    80002190:	04913c23          	sd	s1,88(sp)
    80002194:	05213823          	sd	s2,80(sp)
    80002198:	05313423          	sd	s3,72(sp)
    8000219c:	05413023          	sd	s4,64(sp)
    800021a0:	03513c23          	sd	s5,56(sp)
    800021a4:	03613823          	sd	s6,48(sp)
    800021a8:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800021ac:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800021b0:	00005517          	auipc	a0,0x5
    800021b4:	20850513          	addi	a0,a0,520 # 800073b8 <kvmincrease+0x828>
    800021b8:	00000097          	auipc	ra,0x0
    800021bc:	298080e7          	jalr	664(ra) # 80002450 <_Z11printStringPKc>
    getString(input, 30);
    800021c0:	01e00593          	li	a1,30
    800021c4:	fa040513          	addi	a0,s0,-96
    800021c8:	00000097          	auipc	ra,0x0
    800021cc:	310080e7          	jalr	784(ra) # 800024d8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800021d0:	fa040513          	addi	a0,s0,-96
    800021d4:	00000097          	auipc	ra,0x0
    800021d8:	3dc080e7          	jalr	988(ra) # 800025b0 <_Z11stringToIntPKc>
    800021dc:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800021e0:	00005517          	auipc	a0,0x5
    800021e4:	1f850513          	addi	a0,a0,504 # 800073d8 <kvmincrease+0x848>
    800021e8:	00000097          	auipc	ra,0x0
    800021ec:	268080e7          	jalr	616(ra) # 80002450 <_Z11printStringPKc>
    getString(input, 30);
    800021f0:	01e00593          	li	a1,30
    800021f4:	fa040513          	addi	a0,s0,-96
    800021f8:	00000097          	auipc	ra,0x0
    800021fc:	2e0080e7          	jalr	736(ra) # 800024d8 <_Z9getStringPci>
    n = stringToInt(input);
    80002200:	fa040513          	addi	a0,s0,-96
    80002204:	00000097          	auipc	ra,0x0
    80002208:	3ac080e7          	jalr	940(ra) # 800025b0 <_Z11stringToIntPKc>
    8000220c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002210:	00005517          	auipc	a0,0x5
    80002214:	1e850513          	addi	a0,a0,488 # 800073f8 <kvmincrease+0x868>
    80002218:	00000097          	auipc	ra,0x0
    8000221c:	238080e7          	jalr	568(ra) # 80002450 <_Z11printStringPKc>
    80002220:	00000613          	li	a2,0
    80002224:	00a00593          	li	a1,10
    80002228:	00090513          	mv	a0,s2
    8000222c:	00000097          	auipc	ra,0x0
    80002230:	3d4080e7          	jalr	980(ra) # 80002600 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002234:	00005517          	auipc	a0,0x5
    80002238:	1dc50513          	addi	a0,a0,476 # 80007410 <kvmincrease+0x880>
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	214080e7          	jalr	532(ra) # 80002450 <_Z11printStringPKc>
    80002244:	00000613          	li	a2,0
    80002248:	00a00593          	li	a1,10
    8000224c:	00048513          	mv	a0,s1
    80002250:	00000097          	auipc	ra,0x0
    80002254:	3b0080e7          	jalr	944(ra) # 80002600 <_Z8printIntiii>
    printString(".\n");
    80002258:	00005517          	auipc	a0,0x5
    8000225c:	1d050513          	addi	a0,a0,464 # 80007428 <kvmincrease+0x898>
    80002260:	00000097          	auipc	ra,0x0
    80002264:	1f0080e7          	jalr	496(ra) # 80002450 <_Z11printStringPKc>
    if(threadNum > n) {
    80002268:	0324c463          	blt	s1,s2,80002290 <_Z22producerConsumer_C_APIv+0x10c>
    } else if (threadNum < 1) {
    8000226c:	03205c63          	blez	s2,800022a4 <_Z22producerConsumer_C_APIv+0x120>
    Buffer *buffer = new Buffer(n);
    80002270:	03800513          	li	a0,56
    80002274:	fffff097          	auipc	ra,0xfffff
    80002278:	fcc080e7          	jalr	-52(ra) # 80001240 <_Znwm>
    8000227c:	00050a13          	mv	s4,a0
    80002280:	00048593          	mv	a1,s1
    80002284:	00001097          	auipc	ra,0x1
    80002288:	2c4080e7          	jalr	708(ra) # 80003548 <_ZN6BufferC1Ei>
    8000228c:	0300006f          	j	800022bc <_Z22producerConsumer_C_APIv+0x138>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002290:	00005517          	auipc	a0,0x5
    80002294:	1a050513          	addi	a0,a0,416 # 80007430 <kvmincrease+0x8a0>
    80002298:	00000097          	auipc	ra,0x0
    8000229c:	1b8080e7          	jalr	440(ra) # 80002450 <_Z11printStringPKc>
        return;
    800022a0:	0140006f          	j	800022b4 <_Z22producerConsumer_C_APIv+0x130>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800022a4:	00005517          	auipc	a0,0x5
    800022a8:	1cc50513          	addi	a0,a0,460 # 80007470 <kvmincrease+0x8e0>
    800022ac:	00000097          	auipc	ra,0x0
    800022b0:	1a4080e7          	jalr	420(ra) # 80002450 <_Z11printStringPKc>
        return;
    800022b4:	000b0113          	mv	sp,s6
    800022b8:	1500006f          	j	80002408 <_Z22producerConsumer_C_APIv+0x284>
    sem_open(&waitForAll, 0);
    800022bc:	00000593          	li	a1,0
    800022c0:	00007517          	auipc	a0,0x7
    800022c4:	96850513          	addi	a0,a0,-1688 # 80008c28 <_ZL10waitForAll>
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	ba4080e7          	jalr	-1116(ra) # 80001e6c <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800022d0:	00391793          	slli	a5,s2,0x3
    800022d4:	00f78793          	addi	a5,a5,15
    800022d8:	ff07f793          	andi	a5,a5,-16
    800022dc:	40f10133          	sub	sp,sp,a5
    800022e0:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800022e4:	0019071b          	addiw	a4,s2,1
    800022e8:	00171793          	slli	a5,a4,0x1
    800022ec:	00e787b3          	add	a5,a5,a4
    800022f0:	00379793          	slli	a5,a5,0x3
    800022f4:	00f78793          	addi	a5,a5,15
    800022f8:	ff07f793          	andi	a5,a5,-16
    800022fc:	40f10133          	sub	sp,sp,a5
    80002300:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002304:	00191613          	slli	a2,s2,0x1
    80002308:	012607b3          	add	a5,a2,s2
    8000230c:	00379793          	slli	a5,a5,0x3
    80002310:	00f987b3          	add	a5,s3,a5
    80002314:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002318:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    8000231c:	00007717          	auipc	a4,0x7
    80002320:	90c73703          	ld	a4,-1780(a4) # 80008c28 <_ZL10waitForAll>
    80002324:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002328:	00078613          	mv	a2,a5
    8000232c:	00000597          	auipc	a1,0x0
    80002330:	d7858593          	addi	a1,a1,-648 # 800020a4 <_ZL8consumerPv>
    80002334:	f9840513          	addi	a0,s0,-104
    80002338:	00000097          	auipc	ra,0x0
    8000233c:	a58080e7          	jalr	-1448(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002340:	00000493          	li	s1,0
    80002344:	0280006f          	j	8000236c <_Z22producerConsumer_C_APIv+0x1e8>
        thread_create(threads + i,
    80002348:	00000597          	auipc	a1,0x0
    8000234c:	c1858593          	addi	a1,a1,-1000 # 80001f60 <_ZL16producerKeyboardPv>
                      data + i);
    80002350:	00179613          	slli	a2,a5,0x1
    80002354:	00f60633          	add	a2,a2,a5
    80002358:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    8000235c:	00c98633          	add	a2,s3,a2
    80002360:	00000097          	auipc	ra,0x0
    80002364:	a30080e7          	jalr	-1488(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002368:	0014849b          	addiw	s1,s1,1
    8000236c:	0524d263          	bge	s1,s2,800023b0 <_Z22producerConsumer_C_APIv+0x22c>
        data[i].id = i;
    80002370:	00149793          	slli	a5,s1,0x1
    80002374:	009787b3          	add	a5,a5,s1
    80002378:	00379793          	slli	a5,a5,0x3
    8000237c:	00f987b3          	add	a5,s3,a5
    80002380:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002384:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002388:	00007717          	auipc	a4,0x7
    8000238c:	8a073703          	ld	a4,-1888(a4) # 80008c28 <_ZL10waitForAll>
    80002390:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002394:	00048793          	mv	a5,s1
    80002398:	00349513          	slli	a0,s1,0x3
    8000239c:	00aa8533          	add	a0,s5,a0
    800023a0:	fa9054e3          	blez	s1,80002348 <_Z22producerConsumer_C_APIv+0x1c4>
    800023a4:	00000597          	auipc	a1,0x0
    800023a8:	c6c58593          	addi	a1,a1,-916 # 80002010 <_ZL8producerPv>
    800023ac:	fa5ff06f          	j	80002350 <_Z22producerConsumer_C_APIv+0x1cc>
    thread_dispatch();
    800023b0:	00000097          	auipc	ra,0x0
    800023b4:	a18080e7          	jalr	-1512(ra) # 80001dc8 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800023b8:	00000493          	li	s1,0
    800023bc:	00994e63          	blt	s2,s1,800023d8 <_Z22producerConsumer_C_APIv+0x254>
        sem_wait(waitForAll);
    800023c0:	00007517          	auipc	a0,0x7
    800023c4:	86853503          	ld	a0,-1944(a0) # 80008c28 <_ZL10waitForAll>
    800023c8:	00000097          	auipc	ra,0x0
    800023cc:	b08080e7          	jalr	-1272(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800023d0:	0014849b          	addiw	s1,s1,1
    800023d4:	fe9ff06f          	j	800023bc <_Z22producerConsumer_C_APIv+0x238>
    sem_close(waitForAll);
    800023d8:	00007517          	auipc	a0,0x7
    800023dc:	85053503          	ld	a0,-1968(a0) # 80008c28 <_ZL10waitForAll>
    800023e0:	00000097          	auipc	ra,0x0
    800023e4:	ac0080e7          	jalr	-1344(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    delete buffer;
    800023e8:	000a0e63          	beqz	s4,80002404 <_Z22producerConsumer_C_APIv+0x280>
    800023ec:	000a0513          	mv	a0,s4
    800023f0:	00001097          	auipc	ra,0x1
    800023f4:	398080e7          	jalr	920(ra) # 80003788 <_ZN6BufferD1Ev>
    800023f8:	000a0513          	mv	a0,s4
    800023fc:	fffff097          	auipc	ra,0xfffff
    80002400:	e94080e7          	jalr	-364(ra) # 80001290 <_ZdlPv>
    80002404:	000b0113          	mv	sp,s6

}
    80002408:	f9040113          	addi	sp,s0,-112
    8000240c:	06813083          	ld	ra,104(sp)
    80002410:	06013403          	ld	s0,96(sp)
    80002414:	05813483          	ld	s1,88(sp)
    80002418:	05013903          	ld	s2,80(sp)
    8000241c:	04813983          	ld	s3,72(sp)
    80002420:	04013a03          	ld	s4,64(sp)
    80002424:	03813a83          	ld	s5,56(sp)
    80002428:	03013b03          	ld	s6,48(sp)
    8000242c:	07010113          	addi	sp,sp,112
    80002430:	00008067          	ret
    80002434:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002438:	000a0513          	mv	a0,s4
    8000243c:	fffff097          	auipc	ra,0xfffff
    80002440:	e54080e7          	jalr	-428(ra) # 80001290 <_ZdlPv>
    80002444:	00048513          	mv	a0,s1
    80002448:	00008097          	auipc	ra,0x8
    8000244c:	910080e7          	jalr	-1776(ra) # 80009d58 <_Unwind_Resume>

0000000080002450 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002450:	fe010113          	addi	sp,sp,-32
    80002454:	00113c23          	sd	ra,24(sp)
    80002458:	00813823          	sd	s0,16(sp)
    8000245c:	00913423          	sd	s1,8(sp)
    80002460:	02010413          	addi	s0,sp,32
    80002464:	00050493          	mv	s1,a0
    LOCK();
    80002468:	00100613          	li	a2,1
    8000246c:	00000593          	li	a1,0
    80002470:	00006517          	auipc	a0,0x6
    80002474:	7c050513          	addi	a0,a0,1984 # 80008c30 <lockPrint>
    80002478:	fffff097          	auipc	ra,0xfffff
    8000247c:	b88080e7          	jalr	-1144(ra) # 80001000 <copy_and_swap>
    80002480:	00050863          	beqz	a0,80002490 <_Z11printStringPKc+0x40>
    80002484:	00000097          	auipc	ra,0x0
    80002488:	944080e7          	jalr	-1724(ra) # 80001dc8 <_Z15thread_dispatchv>
    8000248c:	fddff06f          	j	80002468 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002490:	0004c503          	lbu	a0,0(s1)
    80002494:	00050a63          	beqz	a0,800024a8 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	9ac080e7          	jalr	-1620(ra) # 80001e44 <_Z4putcc>
        string++;
    800024a0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800024a4:	fedff06f          	j	80002490 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    800024a8:	00000613          	li	a2,0
    800024ac:	00100593          	li	a1,1
    800024b0:	00006517          	auipc	a0,0x6
    800024b4:	78050513          	addi	a0,a0,1920 # 80008c30 <lockPrint>
    800024b8:	fffff097          	auipc	ra,0xfffff
    800024bc:	b48080e7          	jalr	-1208(ra) # 80001000 <copy_and_swap>
    800024c0:	fe0514e3          	bnez	a0,800024a8 <_Z11printStringPKc+0x58>
}
    800024c4:	01813083          	ld	ra,24(sp)
    800024c8:	01013403          	ld	s0,16(sp)
    800024cc:	00813483          	ld	s1,8(sp)
    800024d0:	02010113          	addi	sp,sp,32
    800024d4:	00008067          	ret

00000000800024d8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800024d8:	fd010113          	addi	sp,sp,-48
    800024dc:	02113423          	sd	ra,40(sp)
    800024e0:	02813023          	sd	s0,32(sp)
    800024e4:	00913c23          	sd	s1,24(sp)
    800024e8:	01213823          	sd	s2,16(sp)
    800024ec:	01313423          	sd	s3,8(sp)
    800024f0:	01413023          	sd	s4,0(sp)
    800024f4:	03010413          	addi	s0,sp,48
    800024f8:	00050993          	mv	s3,a0
    800024fc:	00058a13          	mv	s4,a1
    LOCK();
    80002500:	00100613          	li	a2,1
    80002504:	00000593          	li	a1,0
    80002508:	00006517          	auipc	a0,0x6
    8000250c:	72850513          	addi	a0,a0,1832 # 80008c30 <lockPrint>
    80002510:	fffff097          	auipc	ra,0xfffff
    80002514:	af0080e7          	jalr	-1296(ra) # 80001000 <copy_and_swap>
    80002518:	00050863          	beqz	a0,80002528 <_Z9getStringPci+0x50>
    8000251c:	00000097          	auipc	ra,0x0
    80002520:	8ac080e7          	jalr	-1876(ra) # 80001dc8 <_Z15thread_dispatchv>
    80002524:	fddff06f          	j	80002500 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002528:	00000913          	li	s2,0
    8000252c:	00090493          	mv	s1,s2
    80002530:	0019091b          	addiw	s2,s2,1
    80002534:	03495a63          	bge	s2,s4,80002568 <_Z9getStringPci+0x90>
        cc = getc();
    80002538:	00000097          	auipc	ra,0x0
    8000253c:	8e0080e7          	jalr	-1824(ra) # 80001e18 <_Z4getcv>
        if(cc < 1)
    80002540:	02050463          	beqz	a0,80002568 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80002544:	009984b3          	add	s1,s3,s1
    80002548:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000254c:	00a00793          	li	a5,10
    80002550:	00f50a63          	beq	a0,a5,80002564 <_Z9getStringPci+0x8c>
    80002554:	00d00793          	li	a5,13
    80002558:	fcf51ae3          	bne	a0,a5,8000252c <_Z9getStringPci+0x54>
        buf[i++] = c;
    8000255c:	00090493          	mv	s1,s2
    80002560:	0080006f          	j	80002568 <_Z9getStringPci+0x90>
    80002564:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002568:	009984b3          	add	s1,s3,s1
    8000256c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002570:	00000613          	li	a2,0
    80002574:	00100593          	li	a1,1
    80002578:	00006517          	auipc	a0,0x6
    8000257c:	6b850513          	addi	a0,a0,1720 # 80008c30 <lockPrint>
    80002580:	fffff097          	auipc	ra,0xfffff
    80002584:	a80080e7          	jalr	-1408(ra) # 80001000 <copy_and_swap>
    80002588:	fe0514e3          	bnez	a0,80002570 <_Z9getStringPci+0x98>
    return buf;
}
    8000258c:	00098513          	mv	a0,s3
    80002590:	02813083          	ld	ra,40(sp)
    80002594:	02013403          	ld	s0,32(sp)
    80002598:	01813483          	ld	s1,24(sp)
    8000259c:	01013903          	ld	s2,16(sp)
    800025a0:	00813983          	ld	s3,8(sp)
    800025a4:	00013a03          	ld	s4,0(sp)
    800025a8:	03010113          	addi	sp,sp,48
    800025ac:	00008067          	ret

00000000800025b0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800025b0:	ff010113          	addi	sp,sp,-16
    800025b4:	00813423          	sd	s0,8(sp)
    800025b8:	01010413          	addi	s0,sp,16
    800025bc:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800025c0:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800025c4:	0006c603          	lbu	a2,0(a3) # 8000 <_entry-0x7fff8000>
    800025c8:	fd06071b          	addiw	a4,a2,-48
    800025cc:	0ff77713          	andi	a4,a4,255
    800025d0:	00900793          	li	a5,9
    800025d4:	02e7e063          	bltu	a5,a4,800025f4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800025d8:	0025179b          	slliw	a5,a0,0x2
    800025dc:	00a787bb          	addw	a5,a5,a0
    800025e0:	0017979b          	slliw	a5,a5,0x1
    800025e4:	00168693          	addi	a3,a3,1
    800025e8:	00c787bb          	addw	a5,a5,a2
    800025ec:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800025f0:	fd5ff06f          	j	800025c4 <_Z11stringToIntPKc+0x14>
    return n;
}
    800025f4:	00813403          	ld	s0,8(sp)
    800025f8:	01010113          	addi	sp,sp,16
    800025fc:	00008067          	ret

0000000080002600 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002600:	fc010113          	addi	sp,sp,-64
    80002604:	02113c23          	sd	ra,56(sp)
    80002608:	02813823          	sd	s0,48(sp)
    8000260c:	02913423          	sd	s1,40(sp)
    80002610:	03213023          	sd	s2,32(sp)
    80002614:	01313c23          	sd	s3,24(sp)
    80002618:	04010413          	addi	s0,sp,64
    8000261c:	00050493          	mv	s1,a0
    80002620:	00058913          	mv	s2,a1
    80002624:	00060993          	mv	s3,a2
    LOCK();
    80002628:	00100613          	li	a2,1
    8000262c:	00000593          	li	a1,0
    80002630:	00006517          	auipc	a0,0x6
    80002634:	60050513          	addi	a0,a0,1536 # 80008c30 <lockPrint>
    80002638:	fffff097          	auipc	ra,0xfffff
    8000263c:	9c8080e7          	jalr	-1592(ra) # 80001000 <copy_and_swap>
    80002640:	00050863          	beqz	a0,80002650 <_Z8printIntiii+0x50>
    80002644:	fffff097          	auipc	ra,0xfffff
    80002648:	784080e7          	jalr	1924(ra) # 80001dc8 <_Z15thread_dispatchv>
    8000264c:	fddff06f          	j	80002628 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002650:	00098463          	beqz	s3,80002658 <_Z8printIntiii+0x58>
    80002654:	0804c463          	bltz	s1,800026dc <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002658:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000265c:	00000593          	li	a1,0
    }

    i = 0;
    80002660:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002664:	0009079b          	sext.w	a5,s2
    80002668:	0325773b          	remuw	a4,a0,s2
    8000266c:	00048613          	mv	a2,s1
    80002670:	0014849b          	addiw	s1,s1,1
    80002674:	02071693          	slli	a3,a4,0x20
    80002678:	0206d693          	srli	a3,a3,0x20
    8000267c:	00006717          	auipc	a4,0x6
    80002680:	3d470713          	addi	a4,a4,980 # 80008a50 <digits>
    80002684:	00d70733          	add	a4,a4,a3
    80002688:	00074683          	lbu	a3,0(a4)
    8000268c:	fd040713          	addi	a4,s0,-48
    80002690:	00c70733          	add	a4,a4,a2
    80002694:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002698:	0005071b          	sext.w	a4,a0
    8000269c:	0325553b          	divuw	a0,a0,s2
    800026a0:	fcf772e3          	bgeu	a4,a5,80002664 <_Z8printIntiii+0x64>
    if(neg)
    800026a4:	00058c63          	beqz	a1,800026bc <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    800026a8:	fd040793          	addi	a5,s0,-48
    800026ac:	009784b3          	add	s1,a5,s1
    800026b0:	02d00793          	li	a5,45
    800026b4:	fef48823          	sb	a5,-16(s1)
    800026b8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800026bc:	fff4849b          	addiw	s1,s1,-1
    800026c0:	0204c463          	bltz	s1,800026e8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    800026c4:	fd040793          	addi	a5,s0,-48
    800026c8:	009787b3          	add	a5,a5,s1
    800026cc:	ff07c503          	lbu	a0,-16(a5)
    800026d0:	fffff097          	auipc	ra,0xfffff
    800026d4:	774080e7          	jalr	1908(ra) # 80001e44 <_Z4putcc>
    800026d8:	fe5ff06f          	j	800026bc <_Z8printIntiii+0xbc>
        x = -xx;
    800026dc:	4090053b          	negw	a0,s1
        neg = 1;
    800026e0:	00100593          	li	a1,1
        x = -xx;
    800026e4:	f7dff06f          	j	80002660 <_Z8printIntiii+0x60>

    UNLOCK();
    800026e8:	00000613          	li	a2,0
    800026ec:	00100593          	li	a1,1
    800026f0:	00006517          	auipc	a0,0x6
    800026f4:	54050513          	addi	a0,a0,1344 # 80008c30 <lockPrint>
    800026f8:	fffff097          	auipc	ra,0xfffff
    800026fc:	908080e7          	jalr	-1784(ra) # 80001000 <copy_and_swap>
    80002700:	fe0514e3          	bnez	a0,800026e8 <_Z8printIntiii+0xe8>
    80002704:	03813083          	ld	ra,56(sp)
    80002708:	03013403          	ld	s0,48(sp)
    8000270c:	02813483          	ld	s1,40(sp)
    80002710:	02013903          	ld	s2,32(sp)
    80002714:	01813983          	ld	s3,24(sp)
    80002718:	04010113          	addi	sp,sp,64
    8000271c:	00008067          	ret

0000000080002720 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80002720:	fd010113          	addi	sp,sp,-48
    80002724:	02113423          	sd	ra,40(sp)
    80002728:	02813023          	sd	s0,32(sp)
    8000272c:	00913c23          	sd	s1,24(sp)
    80002730:	01213823          	sd	s2,16(sp)
    80002734:	01313423          	sd	s3,8(sp)
    80002738:	03010413          	addi	s0,sp,48
    8000273c:	00050493          	mv	s1,a0
    80002740:	00058993          	mv	s3,a1
    80002744:	0015879b          	addiw	a5,a1,1
    80002748:	0007851b          	sext.w	a0,a5
    8000274c:	00f4a023          	sw	a5,0(s1)
    80002750:	0004a823          	sw	zero,16(s1)
    80002754:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)__mem_alloc(sizeof(int) * cap);
    80002758:	00251513          	slli	a0,a0,0x2
    8000275c:	00004097          	auipc	ra,0x4
    80002760:	1bc080e7          	jalr	444(ra) # 80006918 <__mem_alloc>
    80002764:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80002768:	01000513          	li	a0,16
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	ad4080e7          	jalr	-1324(ra) # 80001240 <_Znwm>
    80002774:	00050913          	mv	s2,a0
};


class Semaphore{
public:
    Semaphore(unsigned init=1){
    80002778:	00005797          	auipc	a5,0x5
    8000277c:	d5078793          	addi	a5,a5,-688 # 800074c8 <_ZTV9Semaphore+0x10>
    80002780:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002784:	00000593          	li	a1,0
    80002788:	00850513          	addi	a0,a0,8
    8000278c:	fffff097          	auipc	ra,0xfffff
    80002790:	6e0080e7          	jalr	1760(ra) # 80001e6c <_Z8sem_openPP4_semj>
    80002794:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80002798:	01000513          	li	a0,16
    8000279c:	fffff097          	auipc	ra,0xfffff
    800027a0:	aa4080e7          	jalr	-1372(ra) # 80001240 <_Znwm>
    800027a4:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    800027a8:	00005797          	auipc	a5,0x5
    800027ac:	d2078793          	addi	a5,a5,-736 # 800074c8 <_ZTV9Semaphore+0x10>
    800027b0:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    800027b4:	00098593          	mv	a1,s3
    800027b8:	00850513          	addi	a0,a0,8
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	6b0080e7          	jalr	1712(ra) # 80001e6c <_Z8sem_openPP4_semj>
    800027c4:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    800027c8:	01000513          	li	a0,16
    800027cc:	fffff097          	auipc	ra,0xfffff
    800027d0:	a74080e7          	jalr	-1420(ra) # 80001240 <_Znwm>
    800027d4:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    800027d8:	00005797          	auipc	a5,0x5
    800027dc:	cf078793          	addi	a5,a5,-784 # 800074c8 <_ZTV9Semaphore+0x10>
    800027e0:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    800027e4:	00100593          	li	a1,1
    800027e8:	00850513          	addi	a0,a0,8
    800027ec:	fffff097          	auipc	ra,0xfffff
    800027f0:	680080e7          	jalr	1664(ra) # 80001e6c <_Z8sem_openPP4_semj>
    800027f4:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800027f8:	01000513          	li	a0,16
    800027fc:	fffff097          	auipc	ra,0xfffff
    80002800:	a44080e7          	jalr	-1468(ra) # 80001240 <_Znwm>
    80002804:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002808:	00005797          	auipc	a5,0x5
    8000280c:	cc078793          	addi	a5,a5,-832 # 800074c8 <_ZTV9Semaphore+0x10>
    80002810:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002814:	00100593          	li	a1,1
    80002818:	00850513          	addi	a0,a0,8
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	650080e7          	jalr	1616(ra) # 80001e6c <_Z8sem_openPP4_semj>
    80002824:	0324b823          	sd	s2,48(s1)
}
    80002828:	02813083          	ld	ra,40(sp)
    8000282c:	02013403          	ld	s0,32(sp)
    80002830:	01813483          	ld	s1,24(sp)
    80002834:	01013903          	ld	s2,16(sp)
    80002838:	00813983          	ld	s3,8(sp)
    8000283c:	03010113          	addi	sp,sp,48
    80002840:	00008067          	ret
    80002844:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80002848:	00090513          	mv	a0,s2
    8000284c:	fffff097          	auipc	ra,0xfffff
    80002850:	a44080e7          	jalr	-1468(ra) # 80001290 <_ZdlPv>
    80002854:	00048513          	mv	a0,s1
    80002858:	00007097          	auipc	ra,0x7
    8000285c:	500080e7          	jalr	1280(ra) # 80009d58 <_Unwind_Resume>
    80002860:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80002864:	00090513          	mv	a0,s2
    80002868:	fffff097          	auipc	ra,0xfffff
    8000286c:	a28080e7          	jalr	-1496(ra) # 80001290 <_ZdlPv>
    80002870:	00048513          	mv	a0,s1
    80002874:	00007097          	auipc	ra,0x7
    80002878:	4e4080e7          	jalr	1252(ra) # 80009d58 <_Unwind_Resume>
    8000287c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80002880:	00090513          	mv	a0,s2
    80002884:	fffff097          	auipc	ra,0xfffff
    80002888:	a0c080e7          	jalr	-1524(ra) # 80001290 <_ZdlPv>
    8000288c:	00048513          	mv	a0,s1
    80002890:	00007097          	auipc	ra,0x7
    80002894:	4c8080e7          	jalr	1224(ra) # 80009d58 <_Unwind_Resume>
    80002898:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000289c:	00090513          	mv	a0,s2
    800028a0:	fffff097          	auipc	ra,0xfffff
    800028a4:	9f0080e7          	jalr	-1552(ra) # 80001290 <_ZdlPv>
    800028a8:	00048513          	mv	a0,s1
    800028ac:	00007097          	auipc	ra,0x7
    800028b0:	4ac080e7          	jalr	1196(ra) # 80009d58 <_Unwind_Resume>

00000000800028b4 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800028b4:	fe010113          	addi	sp,sp,-32
    800028b8:	00113c23          	sd	ra,24(sp)
    800028bc:	00813823          	sd	s0,16(sp)
    800028c0:	00913423          	sd	s1,8(sp)
    800028c4:	01213023          	sd	s2,0(sp)
    800028c8:	02010413          	addi	s0,sp,32
    800028cc:	00050493          	mv	s1,a0
    800028d0:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800028d4:	01853783          	ld	a5,24(a0)
    virtual ~Semaphore(){
        sem_close(myHandle);
    };

    int wait(){
        return sem_wait(myHandle);
    800028d8:	0087b503          	ld	a0,8(a5)
    800028dc:	fffff097          	auipc	ra,0xfffff
    800028e0:	5f4080e7          	jalr	1524(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    mutexTail->wait();
    800028e4:	0304b783          	ld	a5,48(s1)
    800028e8:	0087b503          	ld	a0,8(a5)
    800028ec:	fffff097          	auipc	ra,0xfffff
    800028f0:	5e4080e7          	jalr	1508(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    800028f4:	0084b783          	ld	a5,8(s1)
    800028f8:	0144a703          	lw	a4,20(s1)
    800028fc:	00271713          	slli	a4,a4,0x2
    80002900:	00e787b3          	add	a5,a5,a4
    80002904:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002908:	0144a783          	lw	a5,20(s1)
    8000290c:	0017879b          	addiw	a5,a5,1
    80002910:	0004a703          	lw	a4,0(s1)
    80002914:	02e7e7bb          	remw	a5,a5,a4
    80002918:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    8000291c:	0304b783          	ld	a5,48(s1)
    }
    int signal(){
        return sem_signal(myHandle);
    80002920:	0087b503          	ld	a0,8(a5)
    80002924:	fffff097          	auipc	ra,0xfffff
    80002928:	5dc080e7          	jalr	1500(ra) # 80001f00 <_Z10sem_signalP4_sem>

    itemAvailable->signal();
    8000292c:	0204b783          	ld	a5,32(s1)
    80002930:	0087b503          	ld	a0,8(a5)
    80002934:	fffff097          	auipc	ra,0xfffff
    80002938:	5cc080e7          	jalr	1484(ra) # 80001f00 <_Z10sem_signalP4_sem>

}
    8000293c:	01813083          	ld	ra,24(sp)
    80002940:	01013403          	ld	s0,16(sp)
    80002944:	00813483          	ld	s1,8(sp)
    80002948:	00013903          	ld	s2,0(sp)
    8000294c:	02010113          	addi	sp,sp,32
    80002950:	00008067          	ret

0000000080002954 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80002954:	fe010113          	addi	sp,sp,-32
    80002958:	00113c23          	sd	ra,24(sp)
    8000295c:	00813823          	sd	s0,16(sp)
    80002960:	00913423          	sd	s1,8(sp)
    80002964:	01213023          	sd	s2,0(sp)
    80002968:	02010413          	addi	s0,sp,32
    8000296c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80002970:	02053783          	ld	a5,32(a0)
        return sem_wait(myHandle);
    80002974:	0087b503          	ld	a0,8(a5)
    80002978:	fffff097          	auipc	ra,0xfffff
    8000297c:	558080e7          	jalr	1368(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    mutexHead->wait();
    80002980:	0284b783          	ld	a5,40(s1)
    80002984:	0087b503          	ld	a0,8(a5)
    80002988:	fffff097          	auipc	ra,0xfffff
    8000298c:	548080e7          	jalr	1352(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80002990:	0084b703          	ld	a4,8(s1)
    80002994:	0104a783          	lw	a5,16(s1)
    80002998:	00279693          	slli	a3,a5,0x2
    8000299c:	00d70733          	add	a4,a4,a3
    800029a0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800029a4:	0017879b          	addiw	a5,a5,1
    800029a8:	0004a703          	lw	a4,0(s1)
    800029ac:	02e7e7bb          	remw	a5,a5,a4
    800029b0:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800029b4:	0284b783          	ld	a5,40(s1)
        return sem_signal(myHandle);
    800029b8:	0087b503          	ld	a0,8(a5)
    800029bc:	fffff097          	auipc	ra,0xfffff
    800029c0:	544080e7          	jalr	1348(ra) # 80001f00 <_Z10sem_signalP4_sem>

    spaceAvailable->signal();
    800029c4:	0184b783          	ld	a5,24(s1)
    800029c8:	0087b503          	ld	a0,8(a5)
    800029cc:	fffff097          	auipc	ra,0xfffff
    800029d0:	534080e7          	jalr	1332(ra) # 80001f00 <_Z10sem_signalP4_sem>

    return ret;
}
    800029d4:	00090513          	mv	a0,s2
    800029d8:	01813083          	ld	ra,24(sp)
    800029dc:	01013403          	ld	s0,16(sp)
    800029e0:	00813483          	ld	s1,8(sp)
    800029e4:	00013903          	ld	s2,0(sp)
    800029e8:	02010113          	addi	sp,sp,32
    800029ec:	00008067          	ret

00000000800029f0 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800029f0:	fe010113          	addi	sp,sp,-32
    800029f4:	00113c23          	sd	ra,24(sp)
    800029f8:	00813823          	sd	s0,16(sp)
    800029fc:	00913423          	sd	s1,8(sp)
    80002a00:	01213023          	sd	s2,0(sp)
    80002a04:	02010413          	addi	s0,sp,32
    80002a08:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80002a0c:	02853783          	ld	a5,40(a0)
        return sem_wait(myHandle);
    80002a10:	0087b503          	ld	a0,8(a5)
    80002a14:	fffff097          	auipc	ra,0xfffff
    80002a18:	4bc080e7          	jalr	1212(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    mutexTail->wait();
    80002a1c:	0304b783          	ld	a5,48(s1)
    80002a20:	0087b503          	ld	a0,8(a5)
    80002a24:	fffff097          	auipc	ra,0xfffff
    80002a28:	4ac080e7          	jalr	1196(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80002a2c:	0144a783          	lw	a5,20(s1)
    80002a30:	0104a903          	lw	s2,16(s1)
    80002a34:	0527c263          	blt	a5,s2,80002a78 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80002a38:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80002a3c:	0304b783          	ld	a5,48(s1)
        return sem_signal(myHandle);
    80002a40:	0087b503          	ld	a0,8(a5)
    80002a44:	fffff097          	auipc	ra,0xfffff
    80002a48:	4bc080e7          	jalr	1212(ra) # 80001f00 <_Z10sem_signalP4_sem>
    mutexHead->signal();
    80002a4c:	0284b783          	ld	a5,40(s1)
    80002a50:	0087b503          	ld	a0,8(a5)
    80002a54:	fffff097          	auipc	ra,0xfffff
    80002a58:	4ac080e7          	jalr	1196(ra) # 80001f00 <_Z10sem_signalP4_sem>

    return ret;
}
    80002a5c:	00090513          	mv	a0,s2
    80002a60:	01813083          	ld	ra,24(sp)
    80002a64:	01013403          	ld	s0,16(sp)
    80002a68:	00813483          	ld	s1,8(sp)
    80002a6c:	00013903          	ld	s2,0(sp)
    80002a70:	02010113          	addi	sp,sp,32
    80002a74:	00008067          	ret
        ret = cap - head + tail;
    80002a78:	0004a703          	lw	a4,0(s1)
    80002a7c:	4127093b          	subw	s2,a4,s2
    80002a80:	00f9093b          	addw	s2,s2,a5
    80002a84:	fb9ff06f          	j	80002a3c <_ZN9BufferCPP6getCntEv+0x4c>

0000000080002a88 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80002a88:	fe010113          	addi	sp,sp,-32
    80002a8c:	00113c23          	sd	ra,24(sp)
    80002a90:	00813823          	sd	s0,16(sp)
    80002a94:	00913423          	sd	s1,8(sp)
    80002a98:	02010413          	addi	s0,sp,32
    80002a9c:	00050493          	mv	s1,a0
    putc('\n');
    80002aa0:	00a00513          	li	a0,10
    80002aa4:	fffff097          	auipc	ra,0xfffff
    80002aa8:	3a0080e7          	jalr	928(ra) # 80001e44 <_Z4putcc>
    printString("Buffer deleted!\n");
    80002aac:	00005517          	auipc	a0,0x5
    80002ab0:	9f450513          	addi	a0,a0,-1548 # 800074a0 <kvmincrease+0x910>
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	99c080e7          	jalr	-1636(ra) # 80002450 <_Z11printStringPKc>
    while (getCnt()) {
    80002abc:	00048513          	mv	a0,s1
    80002ac0:	00000097          	auipc	ra,0x0
    80002ac4:	f30080e7          	jalr	-208(ra) # 800029f0 <_ZN9BufferCPP6getCntEv>
    80002ac8:	02050c63          	beqz	a0,80002b00 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80002acc:	0084b783          	ld	a5,8(s1)
    80002ad0:	0104a703          	lw	a4,16(s1)
    80002ad4:	00271713          	slli	a4,a4,0x2
    80002ad8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80002adc:	0007c503          	lbu	a0,0(a5)
    80002ae0:	fffff097          	auipc	ra,0xfffff
    80002ae4:	364080e7          	jalr	868(ra) # 80001e44 <_Z4putcc>
        head = (head + 1) % cap;
    80002ae8:	0104a783          	lw	a5,16(s1)
    80002aec:	0017879b          	addiw	a5,a5,1
    80002af0:	0004a703          	lw	a4,0(s1)
    80002af4:	02e7e7bb          	remw	a5,a5,a4
    80002af8:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80002afc:	fc1ff06f          	j	80002abc <_ZN9BufferCPPD1Ev+0x34>
    putc('!');
    80002b00:	02100513          	li	a0,33
    80002b04:	fffff097          	auipc	ra,0xfffff
    80002b08:	340080e7          	jalr	832(ra) # 80001e44 <_Z4putcc>
    putc('\n');
    80002b0c:	00a00513          	li	a0,10
    80002b10:	fffff097          	auipc	ra,0xfffff
    80002b14:	334080e7          	jalr	820(ra) # 80001e44 <_Z4putcc>
    __mem_free(buffer);
    80002b18:	0084b503          	ld	a0,8(s1)
    80002b1c:	00004097          	auipc	ra,0x4
    80002b20:	d30080e7          	jalr	-720(ra) # 8000684c <__mem_free>
    delete itemAvailable;
    80002b24:	0204b503          	ld	a0,32(s1)
    80002b28:	00050863          	beqz	a0,80002b38 <_ZN9BufferCPPD1Ev+0xb0>
    80002b2c:	00053783          	ld	a5,0(a0)
    80002b30:	0087b783          	ld	a5,8(a5)
    80002b34:	000780e7          	jalr	a5
    delete spaceAvailable;
    80002b38:	0184b503          	ld	a0,24(s1)
    80002b3c:	00050863          	beqz	a0,80002b4c <_ZN9BufferCPPD1Ev+0xc4>
    80002b40:	00053783          	ld	a5,0(a0)
    80002b44:	0087b783          	ld	a5,8(a5)
    80002b48:	000780e7          	jalr	a5
    delete mutexTail;
    80002b4c:	0304b503          	ld	a0,48(s1)
    80002b50:	00050863          	beqz	a0,80002b60 <_ZN9BufferCPPD1Ev+0xd8>
    80002b54:	00053783          	ld	a5,0(a0)
    80002b58:	0087b783          	ld	a5,8(a5)
    80002b5c:	000780e7          	jalr	a5
    delete mutexHead;
    80002b60:	0284b503          	ld	a0,40(s1)
    80002b64:	00050863          	beqz	a0,80002b74 <_ZN9BufferCPPD1Ev+0xec>
    80002b68:	00053783          	ld	a5,0(a0)
    80002b6c:	0087b783          	ld	a5,8(a5)
    80002b70:	000780e7          	jalr	a5
}
    80002b74:	01813083          	ld	ra,24(sp)
    80002b78:	01013403          	ld	s0,16(sp)
    80002b7c:	00813483          	ld	s1,8(sp)
    80002b80:	02010113          	addi	sp,sp,32
    80002b84:	00008067          	ret

0000000080002b88 <_ZN9SemaphoreD1Ev>:
    virtual ~Semaphore(){
    80002b88:	ff010113          	addi	sp,sp,-16
    80002b8c:	00113423          	sd	ra,8(sp)
    80002b90:	00813023          	sd	s0,0(sp)
    80002b94:	01010413          	addi	s0,sp,16
    80002b98:	00005797          	auipc	a5,0x5
    80002b9c:	93078793          	addi	a5,a5,-1744 # 800074c8 <_ZTV9Semaphore+0x10>
    80002ba0:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002ba4:	00853503          	ld	a0,8(a0)
    80002ba8:	fffff097          	auipc	ra,0xfffff
    80002bac:	2f8080e7          	jalr	760(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    };
    80002bb0:	00813083          	ld	ra,8(sp)
    80002bb4:	00013403          	ld	s0,0(sp)
    80002bb8:	01010113          	addi	sp,sp,16
    80002bbc:	00008067          	ret

0000000080002bc0 <_ZN9SemaphoreD0Ev>:
    virtual ~Semaphore(){
    80002bc0:	fe010113          	addi	sp,sp,-32
    80002bc4:	00113c23          	sd	ra,24(sp)
    80002bc8:	00813823          	sd	s0,16(sp)
    80002bcc:	00913423          	sd	s1,8(sp)
    80002bd0:	02010413          	addi	s0,sp,32
    80002bd4:	00050493          	mv	s1,a0
    80002bd8:	00005797          	auipc	a5,0x5
    80002bdc:	8f078793          	addi	a5,a5,-1808 # 800074c8 <_ZTV9Semaphore+0x10>
    80002be0:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002be4:	00853503          	ld	a0,8(a0)
    80002be8:	fffff097          	auipc	ra,0xfffff
    80002bec:	2b8080e7          	jalr	696(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    };
    80002bf0:	00048513          	mv	a0,s1
    80002bf4:	ffffe097          	auipc	ra,0xffffe
    80002bf8:	69c080e7          	jalr	1692(ra) # 80001290 <_ZdlPv>
    80002bfc:	01813083          	ld	ra,24(sp)
    80002c00:	01013403          	ld	s0,16(sp)
    80002c04:	00813483          	ld	s1,8(sp)
    80002c08:	02010113          	addi	sp,sp,32
    80002c0c:	00008067          	ret

0000000080002c10 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80002c10:	fd010113          	addi	sp,sp,-48
    80002c14:	02113423          	sd	ra,40(sp)
    80002c18:	02813023          	sd	s0,32(sp)
    80002c1c:	00913c23          	sd	s1,24(sp)
    80002c20:	01213823          	sd	s2,16(sp)
    80002c24:	01313423          	sd	s3,8(sp)
    80002c28:	03010413          	addi	s0,sp,48
    80002c2c:	00050993          	mv	s3,a0
    80002c30:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002c34:	00000913          	li	s2,0
    80002c38:	00c0006f          	j	80002c44 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    static void dispatch() {thread_dispatch();}
    80002c3c:	fffff097          	auipc	ra,0xfffff
    80002c40:	18c080e7          	jalr	396(ra) # 80001dc8 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002c44:	fffff097          	auipc	ra,0xfffff
    80002c48:	1d4080e7          	jalr	468(ra) # 80001e18 <_Z4getcv>
    80002c4c:	0005059b          	sext.w	a1,a0
    80002c50:	01b00793          	li	a5,27
    80002c54:	02f58a63          	beq	a1,a5,80002c88 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80002c58:	0084b503          	ld	a0,8(s1)
    80002c5c:	00000097          	auipc	ra,0x0
    80002c60:	c58080e7          	jalr	-936(ra) # 800028b4 <_ZN9BufferCPP3putEi>
        i++;
    80002c64:	0019071b          	addiw	a4,s2,1
    80002c68:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80002c6c:	0004a683          	lw	a3,0(s1)
    80002c70:	0026979b          	slliw	a5,a3,0x2
    80002c74:	00d787bb          	addw	a5,a5,a3
    80002c78:	0017979b          	slliw	a5,a5,0x1
    80002c7c:	02f767bb          	remw	a5,a4,a5
    80002c80:	fc0792e3          	bnez	a5,80002c44 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80002c84:	fb9ff06f          	j	80002c3c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    80002c88:	00100793          	li	a5,1
    80002c8c:	00006717          	auipc	a4,0x6
    80002c90:	faf72623          	sw	a5,-84(a4) # 80008c38 <_ZL9threadEnd>
    td->buffer->put('!');
    80002c94:	0209b783          	ld	a5,32(s3)
    80002c98:	02100593          	li	a1,33
    80002c9c:	0087b503          	ld	a0,8(a5)
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	c14080e7          	jalr	-1004(ra) # 800028b4 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80002ca8:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    80002cac:	0087b503          	ld	a0,8(a5)
    80002cb0:	fffff097          	auipc	ra,0xfffff
    80002cb4:	250080e7          	jalr	592(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    80002cb8:	02813083          	ld	ra,40(sp)
    80002cbc:	02013403          	ld	s0,32(sp)
    80002cc0:	01813483          	ld	s1,24(sp)
    80002cc4:	01013903          	ld	s2,16(sp)
    80002cc8:	00813983          	ld	s3,8(sp)
    80002ccc:	03010113          	addi	sp,sp,48
    80002cd0:	00008067          	ret

0000000080002cd4 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80002cd4:	fe010113          	addi	sp,sp,-32
    80002cd8:	00113c23          	sd	ra,24(sp)
    80002cdc:	00813823          	sd	s0,16(sp)
    80002ce0:	00913423          	sd	s1,8(sp)
    80002ce4:	01213023          	sd	s2,0(sp)
    80002ce8:	02010413          	addi	s0,sp,32
    80002cec:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002cf0:	00000913          	li	s2,0
    80002cf4:	00c0006f          	j	80002d00 <_ZN12ProducerSync8producerEPv+0x2c>
    static void dispatch() {thread_dispatch();}
    80002cf8:	fffff097          	auipc	ra,0xfffff
    80002cfc:	0d0080e7          	jalr	208(ra) # 80001dc8 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002d00:	00006797          	auipc	a5,0x6
    80002d04:	f387a783          	lw	a5,-200(a5) # 80008c38 <_ZL9threadEnd>
    80002d08:	02079e63          	bnez	a5,80002d44 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80002d0c:	0004a583          	lw	a1,0(s1)
    80002d10:	0305859b          	addiw	a1,a1,48
    80002d14:	0084b503          	ld	a0,8(s1)
    80002d18:	00000097          	auipc	ra,0x0
    80002d1c:	b9c080e7          	jalr	-1124(ra) # 800028b4 <_ZN9BufferCPP3putEi>
        i++;
    80002d20:	0019071b          	addiw	a4,s2,1
    80002d24:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80002d28:	0004a683          	lw	a3,0(s1)
    80002d2c:	0026979b          	slliw	a5,a3,0x2
    80002d30:	00d787bb          	addw	a5,a5,a3
    80002d34:	0017979b          	slliw	a5,a5,0x1
    80002d38:	02f767bb          	remw	a5,a4,a5
    80002d3c:	fc0792e3          	bnez	a5,80002d00 <_ZN12ProducerSync8producerEPv+0x2c>
    80002d40:	fb9ff06f          	j	80002cf8 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80002d44:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    80002d48:	0087b503          	ld	a0,8(a5)
    80002d4c:	fffff097          	auipc	ra,0xfffff
    80002d50:	1b4080e7          	jalr	436(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    80002d54:	01813083          	ld	ra,24(sp)
    80002d58:	01013403          	ld	s0,16(sp)
    80002d5c:	00813483          	ld	s1,8(sp)
    80002d60:	00013903          	ld	s2,0(sp)
    80002d64:	02010113          	addi	sp,sp,32
    80002d68:	00008067          	ret

0000000080002d6c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80002d6c:	fd010113          	addi	sp,sp,-48
    80002d70:	02113423          	sd	ra,40(sp)
    80002d74:	02813023          	sd	s0,32(sp)
    80002d78:	00913c23          	sd	s1,24(sp)
    80002d7c:	01213823          	sd	s2,16(sp)
    80002d80:	01313423          	sd	s3,8(sp)
    80002d84:	01413023          	sd	s4,0(sp)
    80002d88:	03010413          	addi	s0,sp,48
    80002d8c:	00050993          	mv	s3,a0
    80002d90:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002d94:	00000a13          	li	s4,0
    80002d98:	01c0006f          	j	80002db4 <_ZN12ConsumerSync8consumerEPv+0x48>
    static void dispatch() {thread_dispatch();}
    80002d9c:	fffff097          	auipc	ra,0xfffff
    80002da0:	02c080e7          	jalr	44(ra) # 80001dc8 <_Z15thread_dispatchv>
    80002da4:	0500006f          	j	80002df4 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    80002da8:	00a00513          	li	a0,10
    80002dac:	fffff097          	auipc	ra,0xfffff
    80002db0:	098080e7          	jalr	152(ra) # 80001e44 <_Z4putcc>
    while (!threadEnd) {
    80002db4:	00006797          	auipc	a5,0x6
    80002db8:	e847a783          	lw	a5,-380(a5) # 80008c38 <_ZL9threadEnd>
    80002dbc:	06079263          	bnez	a5,80002e20 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80002dc0:	00893503          	ld	a0,8(s2)
    80002dc4:	00000097          	auipc	ra,0x0
    80002dc8:	b90080e7          	jalr	-1136(ra) # 80002954 <_ZN9BufferCPP3getEv>
        i++;
    80002dcc:	001a049b          	addiw	s1,s4,1
    80002dd0:	00048a1b          	sext.w	s4,s1
        putc(key);
    80002dd4:	0ff57513          	andi	a0,a0,255
    80002dd8:	fffff097          	auipc	ra,0xfffff
    80002ddc:	06c080e7          	jalr	108(ra) # 80001e44 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002de0:	00092703          	lw	a4,0(s2)
    80002de4:	0027179b          	slliw	a5,a4,0x2
    80002de8:	00e787bb          	addw	a5,a5,a4
    80002dec:	02f4e7bb          	remw	a5,s1,a5
    80002df0:	fa0786e3          	beqz	a5,80002d9c <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80002df4:	05000793          	li	a5,80
    80002df8:	02f4e4bb          	remw	s1,s1,a5
    80002dfc:	fa049ce3          	bnez	s1,80002db4 <_ZN12ConsumerSync8consumerEPv+0x48>
    80002e00:	fa9ff06f          	j	80002da8 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80002e04:	0209b783          	ld	a5,32(s3)
    80002e08:	0087b503          	ld	a0,8(a5)
    80002e0c:	00000097          	auipc	ra,0x0
    80002e10:	b48080e7          	jalr	-1208(ra) # 80002954 <_ZN9BufferCPP3getEv>
        //Console::putc(key);
        putc(key);
    80002e14:	0ff57513          	andi	a0,a0,255
    80002e18:	fffff097          	auipc	ra,0xfffff
    80002e1c:	02c080e7          	jalr	44(ra) # 80001e44 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    80002e20:	0209b783          	ld	a5,32(s3)
    80002e24:	0087b503          	ld	a0,8(a5)
    80002e28:	00000097          	auipc	ra,0x0
    80002e2c:	bc8080e7          	jalr	-1080(ra) # 800029f0 <_ZN9BufferCPP6getCntEv>
    80002e30:	fca04ae3          	bgtz	a0,80002e04 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80002e34:	01093783          	ld	a5,16(s2)
        return sem_signal(myHandle);
    80002e38:	0087b503          	ld	a0,8(a5)
    80002e3c:	fffff097          	auipc	ra,0xfffff
    80002e40:	0c4080e7          	jalr	196(ra) # 80001f00 <_Z10sem_signalP4_sem>
}
    80002e44:	02813083          	ld	ra,40(sp)
    80002e48:	02013403          	ld	s0,32(sp)
    80002e4c:	01813483          	ld	s1,24(sp)
    80002e50:	01013903          	ld	s2,16(sp)
    80002e54:	00813983          	ld	s3,8(sp)
    80002e58:	00013a03          	ld	s4,0(sp)
    80002e5c:	03010113          	addi	sp,sp,48
    80002e60:	00008067          	ret

0000000080002e64 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80002e64:	f9010113          	addi	sp,sp,-112
    80002e68:	06113423          	sd	ra,104(sp)
    80002e6c:	06813023          	sd	s0,96(sp)
    80002e70:	04913c23          	sd	s1,88(sp)
    80002e74:	05213823          	sd	s2,80(sp)
    80002e78:	05313423          	sd	s3,72(sp)
    80002e7c:	05413023          	sd	s4,64(sp)
    80002e80:	03513c23          	sd	s5,56(sp)
    80002e84:	03613823          	sd	s6,48(sp)
    80002e88:	03713423          	sd	s7,40(sp)
    80002e8c:	03813023          	sd	s8,32(sp)
    80002e90:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80002e94:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80002e98:	00004517          	auipc	a0,0x4
    80002e9c:	52050513          	addi	a0,a0,1312 # 800073b8 <kvmincrease+0x828>
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	5b0080e7          	jalr	1456(ra) # 80002450 <_Z11printStringPKc>
    getString(input, 30);
    80002ea8:	01e00593          	li	a1,30
    80002eac:	f9040513          	addi	a0,s0,-112
    80002eb0:	fffff097          	auipc	ra,0xfffff
    80002eb4:	628080e7          	jalr	1576(ra) # 800024d8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002eb8:	f9040513          	addi	a0,s0,-112
    80002ebc:	fffff097          	auipc	ra,0xfffff
    80002ec0:	6f4080e7          	jalr	1780(ra) # 800025b0 <_Z11stringToIntPKc>
    80002ec4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002ec8:	00004517          	auipc	a0,0x4
    80002ecc:	51050513          	addi	a0,a0,1296 # 800073d8 <kvmincrease+0x848>
    80002ed0:	fffff097          	auipc	ra,0xfffff
    80002ed4:	580080e7          	jalr	1408(ra) # 80002450 <_Z11printStringPKc>
    getString(input, 30);
    80002ed8:	01e00593          	li	a1,30
    80002edc:	f9040513          	addi	a0,s0,-112
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	5f8080e7          	jalr	1528(ra) # 800024d8 <_Z9getStringPci>
    n = stringToInt(input);
    80002ee8:	f9040513          	addi	a0,s0,-112
    80002eec:	fffff097          	auipc	ra,0xfffff
    80002ef0:	6c4080e7          	jalr	1732(ra) # 800025b0 <_Z11stringToIntPKc>
    80002ef4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002ef8:	00004517          	auipc	a0,0x4
    80002efc:	50050513          	addi	a0,a0,1280 # 800073f8 <kvmincrease+0x868>
    80002f00:	fffff097          	auipc	ra,0xfffff
    80002f04:	550080e7          	jalr	1360(ra) # 80002450 <_Z11printStringPKc>
    80002f08:	00000613          	li	a2,0
    80002f0c:	00a00593          	li	a1,10
    80002f10:	00090513          	mv	a0,s2
    80002f14:	fffff097          	auipc	ra,0xfffff
    80002f18:	6ec080e7          	jalr	1772(ra) # 80002600 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002f1c:	00004517          	auipc	a0,0x4
    80002f20:	4f450513          	addi	a0,a0,1268 # 80007410 <kvmincrease+0x880>
    80002f24:	fffff097          	auipc	ra,0xfffff
    80002f28:	52c080e7          	jalr	1324(ra) # 80002450 <_Z11printStringPKc>
    80002f2c:	00000613          	li	a2,0
    80002f30:	00a00593          	li	a1,10
    80002f34:	00048513          	mv	a0,s1
    80002f38:	fffff097          	auipc	ra,0xfffff
    80002f3c:	6c8080e7          	jalr	1736(ra) # 80002600 <_Z8printIntiii>
    printString(".\n");
    80002f40:	00004517          	auipc	a0,0x4
    80002f44:	4e850513          	addi	a0,a0,1256 # 80007428 <kvmincrease+0x898>
    80002f48:	fffff097          	auipc	ra,0xfffff
    80002f4c:	508080e7          	jalr	1288(ra) # 80002450 <_Z11printStringPKc>
    if(threadNum > n) {
    80002f50:	0324c463          	blt	s1,s2,80002f78 <_Z29producerConsumer_CPP_Sync_APIv+0x114>
    } else if (threadNum < 1) {
    80002f54:	03205c63          	blez	s2,80002f8c <_Z29producerConsumer_CPP_Sync_APIv+0x128>
    BufferCPP *buffer = new BufferCPP(n);
    80002f58:	03800513          	li	a0,56
    80002f5c:	ffffe097          	auipc	ra,0xffffe
    80002f60:	2e4080e7          	jalr	740(ra) # 80001240 <_Znwm>
    80002f64:	00050a93          	mv	s5,a0
    80002f68:	00048593          	mv	a1,s1
    80002f6c:	fffff097          	auipc	ra,0xfffff
    80002f70:	7b4080e7          	jalr	1972(ra) # 80002720 <_ZN9BufferCPPC1Ei>
    80002f74:	0300006f          	j	80002fa4 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002f78:	00004517          	auipc	a0,0x4
    80002f7c:	4b850513          	addi	a0,a0,1208 # 80007430 <kvmincrease+0x8a0>
    80002f80:	fffff097          	auipc	ra,0xfffff
    80002f84:	4d0080e7          	jalr	1232(ra) # 80002450 <_Z11printStringPKc>
        return;
    80002f88:	0140006f          	j	80002f9c <_Z29producerConsumer_CPP_Sync_APIv+0x138>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002f8c:	00004517          	auipc	a0,0x4
    80002f90:	4e450513          	addi	a0,a0,1252 # 80007470 <kvmincrease+0x8e0>
    80002f94:	fffff097          	auipc	ra,0xfffff
    80002f98:	4bc080e7          	jalr	1212(ra) # 80002450 <_Z11printStringPKc>
        return;
    80002f9c:	000b8113          	mv	sp,s7
    80002fa0:	26c0006f          	j	8000320c <_Z29producerConsumer_CPP_Sync_APIv+0x3a8>
    waitForAll = new Semaphore(0);
    80002fa4:	01000513          	li	a0,16
    80002fa8:	ffffe097          	auipc	ra,0xffffe
    80002fac:	298080e7          	jalr	664(ra) # 80001240 <_Znwm>
    80002fb0:	00050493          	mv	s1,a0
    Semaphore(unsigned init=1){
    80002fb4:	00004797          	auipc	a5,0x4
    80002fb8:	51478793          	addi	a5,a5,1300 # 800074c8 <_ZTV9Semaphore+0x10>
    80002fbc:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002fc0:	00000593          	li	a1,0
    80002fc4:	00850513          	addi	a0,a0,8
    80002fc8:	fffff097          	auipc	ra,0xfffff
    80002fcc:	ea4080e7          	jalr	-348(ra) # 80001e6c <_Z8sem_openPP4_semj>
    80002fd0:	00006797          	auipc	a5,0x6
    80002fd4:	c697b823          	sd	s1,-912(a5) # 80008c40 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80002fd8:	00391793          	slli	a5,s2,0x3
    80002fdc:	00f78793          	addi	a5,a5,15
    80002fe0:	ff07f793          	andi	a5,a5,-16
    80002fe4:	40f10133          	sub	sp,sp,a5
    80002fe8:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80002fec:	0019071b          	addiw	a4,s2,1
    80002ff0:	00171793          	slli	a5,a4,0x1
    80002ff4:	00e787b3          	add	a5,a5,a4
    80002ff8:	00379793          	slli	a5,a5,0x3
    80002ffc:	00f78793          	addi	a5,a5,15
    80003000:	ff07f793          	andi	a5,a5,-16
    80003004:	40f10133          	sub	sp,sp,a5
    80003008:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000300c:	00191c13          	slli	s8,s2,0x1
    80003010:	012c07b3          	add	a5,s8,s2
    80003014:	00379793          	slli	a5,a5,0x3
    80003018:	00fa07b3          	add	a5,s4,a5
    8000301c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003020:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003024:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003028:	02800513          	li	a0,40
    8000302c:	ffffe097          	auipc	ra,0xffffe
    80003030:	214080e7          	jalr	532(ra) # 80001240 <_Znwm>
    80003034:	00050b13          	mv	s6,a0
    80003038:	012c0c33          	add	s8,s8,s2
    8000303c:	003c1c13          	slli	s8,s8,0x3
    80003040:	018a0c33          	add	s8,s4,s8
    Thread(){};
    80003044:	00053823          	sd	zero,16(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003048:	00004797          	auipc	a5,0x4
    8000304c:	51878793          	addi	a5,a5,1304 # 80007560 <_ZTV12ConsumerSync+0x10>
    80003050:	00f53023          	sd	a5,0(a0)
    80003054:	03853023          	sd	s8,32(a0)
            thread_create(&myhandle, &threadWrapper,this);
    80003058:	00050613          	mv	a2,a0
    8000305c:	00000597          	auipc	a1,0x0
    80003060:	23458593          	addi	a1,a1,564 # 80003290 <_ZN6Thread13threadWrapperEPv>
    80003064:	00850513          	addi	a0,a0,8
    80003068:	fffff097          	auipc	ra,0xfffff
    8000306c:	d28080e7          	jalr	-728(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003070:	00000493          	li	s1,0
        return 0;
    80003074:	0600006f          	j	800030d4 <_Z29producerConsumer_CPP_Sync_APIv+0x270>
            threads[i] = new ProducerKeyboard(data+i);
    80003078:	02800513          	li	a0,40
    8000307c:	ffffe097          	auipc	ra,0xffffe
    80003080:	1c4080e7          	jalr	452(ra) # 80001240 <_Znwm>
    80003084:	00149793          	slli	a5,s1,0x1
    80003088:	009787b3          	add	a5,a5,s1
    8000308c:	00379793          	slli	a5,a5,0x3
    80003090:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    80003094:	00053823          	sd	zero,16(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003098:	00004717          	auipc	a4,0x4
    8000309c:	47870713          	addi	a4,a4,1144 # 80007510 <_ZTV16ProducerKeyboard+0x10>
    800030a0:	00e53023          	sd	a4,0(a0)
    800030a4:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    800030a8:	00349793          	slli	a5,s1,0x3
    800030ac:	00f987b3          	add	a5,s3,a5
    800030b0:	00a7b023          	sd	a0,0(a5)
    800030b4:	0880006f          	j	8000313c <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
            thread_create(&myhandle, &threadWrapper,this);
    800030b8:	00050613          	mv	a2,a0
    800030bc:	00000597          	auipc	a1,0x0
    800030c0:	1d458593          	addi	a1,a1,468 # 80003290 <_ZN6Thread13threadWrapperEPv>
    800030c4:	00850513          	addi	a0,a0,8
    800030c8:	fffff097          	auipc	ra,0xfffff
    800030cc:	cc8080e7          	jalr	-824(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800030d0:	0014849b          	addiw	s1,s1,1
    800030d4:	0924d863          	bge	s1,s2,80003164 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        data[i].id = i;
    800030d8:	00149793          	slli	a5,s1,0x1
    800030dc:	009787b3          	add	a5,a5,s1
    800030e0:	00379793          	slli	a5,a5,0x3
    800030e4:	00fa07b3          	add	a5,s4,a5
    800030e8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800030ec:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800030f0:	00006717          	auipc	a4,0x6
    800030f4:	b5073703          	ld	a4,-1200(a4) # 80008c40 <_ZL10waitForAll>
    800030f8:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800030fc:	f6905ee3          	blez	s1,80003078 <_Z29producerConsumer_CPP_Sync_APIv+0x214>
            threads[i] = new ProducerSync(data+i);
    80003100:	02800513          	li	a0,40
    80003104:	ffffe097          	auipc	ra,0xffffe
    80003108:	13c080e7          	jalr	316(ra) # 80001240 <_Znwm>
    8000310c:	00149793          	slli	a5,s1,0x1
    80003110:	009787b3          	add	a5,a5,s1
    80003114:	00379793          	slli	a5,a5,0x3
    80003118:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    8000311c:	00053823          	sd	zero,16(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003120:	00004717          	auipc	a4,0x4
    80003124:	41870713          	addi	a4,a4,1048 # 80007538 <_ZTV12ProducerSync+0x10>
    80003128:	00e53023          	sd	a4,0(a0)
    8000312c:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    80003130:	00349793          	slli	a5,s1,0x3
    80003134:	00f987b3          	add	a5,s3,a5
    80003138:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    8000313c:	00349793          	slli	a5,s1,0x3
    80003140:	00f987b3          	add	a5,s3,a5
    80003144:	0007b503          	ld	a0,0(a5)
        if (body == nullptr){
    80003148:	01053583          	ld	a1,16(a0)
    8000314c:	f60586e3          	beqz	a1,800030b8 <_Z29producerConsumer_CPP_Sync_APIv+0x254>
            thread_create(&myhandle, body,arg);
    80003150:	01853603          	ld	a2,24(a0)
    80003154:	00850513          	addi	a0,a0,8
    80003158:	fffff097          	auipc	ra,0xfffff
    8000315c:	c38080e7          	jalr	-968(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    80003160:	f71ff06f          	j	800030d0 <_Z29producerConsumer_CPP_Sync_APIv+0x26c>
    static void dispatch() {thread_dispatch();}
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	c64080e7          	jalr	-924(ra) # 80001dc8 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    8000316c:	00000493          	li	s1,0
    80003170:	02994063          	blt	s2,s1,80003190 <_Z29producerConsumer_CPP_Sync_APIv+0x32c>
        return sem_wait(myHandle);
    80003174:	00006797          	auipc	a5,0x6
    80003178:	acc7b783          	ld	a5,-1332(a5) # 80008c40 <_ZL10waitForAll>
    8000317c:	0087b503          	ld	a0,8(a5)
    80003180:	fffff097          	auipc	ra,0xfffff
    80003184:	d50080e7          	jalr	-688(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    80003188:	0014849b          	addiw	s1,s1,1
    8000318c:	fe5ff06f          	j	80003170 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    for (int i = 0; i < threadNum; i++) {
    80003190:	00000493          	li	s1,0
    80003194:	0080006f          	j	8000319c <_Z29producerConsumer_CPP_Sync_APIv+0x338>
    80003198:	0014849b          	addiw	s1,s1,1
    8000319c:	0324d263          	bge	s1,s2,800031c0 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
        delete threads[i];
    800031a0:	00349793          	slli	a5,s1,0x3
    800031a4:	00f987b3          	add	a5,s3,a5
    800031a8:	0007b503          	ld	a0,0(a5)
    800031ac:	fe0506e3          	beqz	a0,80003198 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    800031b0:	00053783          	ld	a5,0(a0)
    800031b4:	0087b783          	ld	a5,8(a5)
    800031b8:	000780e7          	jalr	a5
    800031bc:	fddff06f          	j	80003198 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    delete consumerThread;
    800031c0:	000b0a63          	beqz	s6,800031d4 <_Z29producerConsumer_CPP_Sync_APIv+0x370>
    800031c4:	000b3783          	ld	a5,0(s6)
    800031c8:	0087b783          	ld	a5,8(a5)
    800031cc:	000b0513          	mv	a0,s6
    800031d0:	000780e7          	jalr	a5
    delete waitForAll;
    800031d4:	00006517          	auipc	a0,0x6
    800031d8:	a6c53503          	ld	a0,-1428(a0) # 80008c40 <_ZL10waitForAll>
    800031dc:	00050863          	beqz	a0,800031ec <_Z29producerConsumer_CPP_Sync_APIv+0x388>
    800031e0:	00053783          	ld	a5,0(a0)
    800031e4:	0087b783          	ld	a5,8(a5)
    800031e8:	000780e7          	jalr	a5
    delete buffer;
    800031ec:	000a8e63          	beqz	s5,80003208 <_Z29producerConsumer_CPP_Sync_APIv+0x3a4>
    800031f0:	000a8513          	mv	a0,s5
    800031f4:	00000097          	auipc	ra,0x0
    800031f8:	894080e7          	jalr	-1900(ra) # 80002a88 <_ZN9BufferCPPD1Ev>
    800031fc:	000a8513          	mv	a0,s5
    80003200:	ffffe097          	auipc	ra,0xffffe
    80003204:	090080e7          	jalr	144(ra) # 80001290 <_ZdlPv>
    80003208:	000b8113          	mv	sp,s7

}
    8000320c:	f9040113          	addi	sp,s0,-112
    80003210:	06813083          	ld	ra,104(sp)
    80003214:	06013403          	ld	s0,96(sp)
    80003218:	05813483          	ld	s1,88(sp)
    8000321c:	05013903          	ld	s2,80(sp)
    80003220:	04813983          	ld	s3,72(sp)
    80003224:	04013a03          	ld	s4,64(sp)
    80003228:	03813a83          	ld	s5,56(sp)
    8000322c:	03013b03          	ld	s6,48(sp)
    80003230:	02813b83          	ld	s7,40(sp)
    80003234:	02013c03          	ld	s8,32(sp)
    80003238:	07010113          	addi	sp,sp,112
    8000323c:	00008067          	ret
    80003240:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003244:	000a8513          	mv	a0,s5
    80003248:	ffffe097          	auipc	ra,0xffffe
    8000324c:	048080e7          	jalr	72(ra) # 80001290 <_ZdlPv>
    80003250:	00048513          	mv	a0,s1
    80003254:	00007097          	auipc	ra,0x7
    80003258:	b04080e7          	jalr	-1276(ra) # 80009d58 <_Unwind_Resume>
    8000325c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003260:	00048513          	mv	a0,s1
    80003264:	ffffe097          	auipc	ra,0xffffe
    80003268:	02c080e7          	jalr	44(ra) # 80001290 <_ZdlPv>
    8000326c:	00090513          	mv	a0,s2
    80003270:	00007097          	auipc	ra,0x7
    80003274:	ae8080e7          	jalr	-1304(ra) # 80009d58 <_Unwind_Resume>

0000000080003278 <_ZN6Thread3runEv>:
    virtual void run(){}
    80003278:	ff010113          	addi	sp,sp,-16
    8000327c:	00813423          	sd	s0,8(sp)
    80003280:	01010413          	addi	s0,sp,16
    80003284:	00813403          	ld	s0,8(sp)
    80003288:	01010113          	addi	sp,sp,16
    8000328c:	00008067          	ret

0000000080003290 <_ZN6Thread13threadWrapperEPv>:
        if (thr) thr->run();
    80003290:	02050863          	beqz	a0,800032c0 <_ZN6Thread13threadWrapperEPv+0x30>
    static void threadWrapper(void* p){
    80003294:	ff010113          	addi	sp,sp,-16
    80003298:	00113423          	sd	ra,8(sp)
    8000329c:	00813023          	sd	s0,0(sp)
    800032a0:	01010413          	addi	s0,sp,16
        if (thr) thr->run();
    800032a4:	00053783          	ld	a5,0(a0)
    800032a8:	0107b783          	ld	a5,16(a5)
    800032ac:	000780e7          	jalr	a5
    }
    800032b0:	00813083          	ld	ra,8(sp)
    800032b4:	00013403          	ld	s0,0(sp)
    800032b8:	01010113          	addi	sp,sp,16
    800032bc:	00008067          	ret
    800032c0:	00008067          	ret

00000000800032c4 <_ZN6ThreadD1Ev>:
    virtual ~Thread() { thread_exit();}
    800032c4:	ff010113          	addi	sp,sp,-16
    800032c8:	00113423          	sd	ra,8(sp)
    800032cc:	00813023          	sd	s0,0(sp)
    800032d0:	01010413          	addi	s0,sp,16
    800032d4:	00004797          	auipc	a5,0x4
    800032d8:	21478793          	addi	a5,a5,532 # 800074e8 <_ZTV6Thread+0x10>
    800032dc:	00f53023          	sd	a5,0(a0)
    800032e0:	fffff097          	auipc	ra,0xfffff
    800032e4:	b0c080e7          	jalr	-1268(ra) # 80001dec <_Z11thread_exitv>
    800032e8:	00813083          	ld	ra,8(sp)
    800032ec:	00013403          	ld	s0,0(sp)
    800032f0:	01010113          	addi	sp,sp,16
    800032f4:	00008067          	ret

00000000800032f8 <_ZN6ThreadD0Ev>:
    800032f8:	fe010113          	addi	sp,sp,-32
    800032fc:	00113c23          	sd	ra,24(sp)
    80003300:	00813823          	sd	s0,16(sp)
    80003304:	00913423          	sd	s1,8(sp)
    80003308:	02010413          	addi	s0,sp,32
    8000330c:	00050493          	mv	s1,a0
    80003310:	00004797          	auipc	a5,0x4
    80003314:	1d878793          	addi	a5,a5,472 # 800074e8 <_ZTV6Thread+0x10>
    80003318:	00f53023          	sd	a5,0(a0)
    8000331c:	fffff097          	auipc	ra,0xfffff
    80003320:	ad0080e7          	jalr	-1328(ra) # 80001dec <_Z11thread_exitv>
    80003324:	00048513          	mv	a0,s1
    80003328:	ffffe097          	auipc	ra,0xffffe
    8000332c:	f68080e7          	jalr	-152(ra) # 80001290 <_ZdlPv>
    80003330:	01813083          	ld	ra,24(sp)
    80003334:	01013403          	ld	s0,16(sp)
    80003338:	00813483          	ld	s1,8(sp)
    8000333c:	02010113          	addi	sp,sp,32
    80003340:	00008067          	ret

0000000080003344 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003344:	ff010113          	addi	sp,sp,-16
    80003348:	00113423          	sd	ra,8(sp)
    8000334c:	00813023          	sd	s0,0(sp)
    80003350:	01010413          	addi	s0,sp,16
    80003354:	00004797          	auipc	a5,0x4
    80003358:	19478793          	addi	a5,a5,404 # 800074e8 <_ZTV6Thread+0x10>
    8000335c:	00f53023          	sd	a5,0(a0)
    80003360:	fffff097          	auipc	ra,0xfffff
    80003364:	a8c080e7          	jalr	-1396(ra) # 80001dec <_Z11thread_exitv>
    80003368:	00813083          	ld	ra,8(sp)
    8000336c:	00013403          	ld	s0,0(sp)
    80003370:	01010113          	addi	sp,sp,16
    80003374:	00008067          	ret

0000000080003378 <_ZN12ConsumerSyncD0Ev>:
    80003378:	fe010113          	addi	sp,sp,-32
    8000337c:	00113c23          	sd	ra,24(sp)
    80003380:	00813823          	sd	s0,16(sp)
    80003384:	00913423          	sd	s1,8(sp)
    80003388:	02010413          	addi	s0,sp,32
    8000338c:	00050493          	mv	s1,a0
    80003390:	00004797          	auipc	a5,0x4
    80003394:	15878793          	addi	a5,a5,344 # 800074e8 <_ZTV6Thread+0x10>
    80003398:	00f53023          	sd	a5,0(a0)
    8000339c:	fffff097          	auipc	ra,0xfffff
    800033a0:	a50080e7          	jalr	-1456(ra) # 80001dec <_Z11thread_exitv>
    800033a4:	00048513          	mv	a0,s1
    800033a8:	ffffe097          	auipc	ra,0xffffe
    800033ac:	ee8080e7          	jalr	-280(ra) # 80001290 <_ZdlPv>
    800033b0:	01813083          	ld	ra,24(sp)
    800033b4:	01013403          	ld	s0,16(sp)
    800033b8:	00813483          	ld	s1,8(sp)
    800033bc:	02010113          	addi	sp,sp,32
    800033c0:	00008067          	ret

00000000800033c4 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    800033c4:	ff010113          	addi	sp,sp,-16
    800033c8:	00113423          	sd	ra,8(sp)
    800033cc:	00813023          	sd	s0,0(sp)
    800033d0:	01010413          	addi	s0,sp,16
    800033d4:	00004797          	auipc	a5,0x4
    800033d8:	11478793          	addi	a5,a5,276 # 800074e8 <_ZTV6Thread+0x10>
    800033dc:	00f53023          	sd	a5,0(a0)
    800033e0:	fffff097          	auipc	ra,0xfffff
    800033e4:	a0c080e7          	jalr	-1524(ra) # 80001dec <_Z11thread_exitv>
    800033e8:	00813083          	ld	ra,8(sp)
    800033ec:	00013403          	ld	s0,0(sp)
    800033f0:	01010113          	addi	sp,sp,16
    800033f4:	00008067          	ret

00000000800033f8 <_ZN12ProducerSyncD0Ev>:
    800033f8:	fe010113          	addi	sp,sp,-32
    800033fc:	00113c23          	sd	ra,24(sp)
    80003400:	00813823          	sd	s0,16(sp)
    80003404:	00913423          	sd	s1,8(sp)
    80003408:	02010413          	addi	s0,sp,32
    8000340c:	00050493          	mv	s1,a0
    80003410:	00004797          	auipc	a5,0x4
    80003414:	0d878793          	addi	a5,a5,216 # 800074e8 <_ZTV6Thread+0x10>
    80003418:	00f53023          	sd	a5,0(a0)
    8000341c:	fffff097          	auipc	ra,0xfffff
    80003420:	9d0080e7          	jalr	-1584(ra) # 80001dec <_Z11thread_exitv>
    80003424:	00048513          	mv	a0,s1
    80003428:	ffffe097          	auipc	ra,0xffffe
    8000342c:	e68080e7          	jalr	-408(ra) # 80001290 <_ZdlPv>
    80003430:	01813083          	ld	ra,24(sp)
    80003434:	01013403          	ld	s0,16(sp)
    80003438:	00813483          	ld	s1,8(sp)
    8000343c:	02010113          	addi	sp,sp,32
    80003440:	00008067          	ret

0000000080003444 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003444:	ff010113          	addi	sp,sp,-16
    80003448:	00113423          	sd	ra,8(sp)
    8000344c:	00813023          	sd	s0,0(sp)
    80003450:	01010413          	addi	s0,sp,16
    80003454:	00004797          	auipc	a5,0x4
    80003458:	09478793          	addi	a5,a5,148 # 800074e8 <_ZTV6Thread+0x10>
    8000345c:	00f53023          	sd	a5,0(a0)
    80003460:	fffff097          	auipc	ra,0xfffff
    80003464:	98c080e7          	jalr	-1652(ra) # 80001dec <_Z11thread_exitv>
    80003468:	00813083          	ld	ra,8(sp)
    8000346c:	00013403          	ld	s0,0(sp)
    80003470:	01010113          	addi	sp,sp,16
    80003474:	00008067          	ret

0000000080003478 <_ZN16ProducerKeyboardD0Ev>:
    80003478:	fe010113          	addi	sp,sp,-32
    8000347c:	00113c23          	sd	ra,24(sp)
    80003480:	00813823          	sd	s0,16(sp)
    80003484:	00913423          	sd	s1,8(sp)
    80003488:	02010413          	addi	s0,sp,32
    8000348c:	00050493          	mv	s1,a0
    80003490:	00004797          	auipc	a5,0x4
    80003494:	05878793          	addi	a5,a5,88 # 800074e8 <_ZTV6Thread+0x10>
    80003498:	00f53023          	sd	a5,0(a0)
    8000349c:	fffff097          	auipc	ra,0xfffff
    800034a0:	950080e7          	jalr	-1712(ra) # 80001dec <_Z11thread_exitv>
    800034a4:	00048513          	mv	a0,s1
    800034a8:	ffffe097          	auipc	ra,0xffffe
    800034ac:	de8080e7          	jalr	-536(ra) # 80001290 <_ZdlPv>
    800034b0:	01813083          	ld	ra,24(sp)
    800034b4:	01013403          	ld	s0,16(sp)
    800034b8:	00813483          	ld	s1,8(sp)
    800034bc:	02010113          	addi	sp,sp,32
    800034c0:	00008067          	ret

00000000800034c4 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    800034c4:	ff010113          	addi	sp,sp,-16
    800034c8:	00113423          	sd	ra,8(sp)
    800034cc:	00813023          	sd	s0,0(sp)
    800034d0:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    800034d4:	02053583          	ld	a1,32(a0)
    800034d8:	fffff097          	auipc	ra,0xfffff
    800034dc:	738080e7          	jalr	1848(ra) # 80002c10 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    800034e0:	00813083          	ld	ra,8(sp)
    800034e4:	00013403          	ld	s0,0(sp)
    800034e8:	01010113          	addi	sp,sp,16
    800034ec:	00008067          	ret

00000000800034f0 <_ZN12ProducerSync3runEv>:
    void run() override {
    800034f0:	ff010113          	addi	sp,sp,-16
    800034f4:	00113423          	sd	ra,8(sp)
    800034f8:	00813023          	sd	s0,0(sp)
    800034fc:	01010413          	addi	s0,sp,16
        producer(td);
    80003500:	02053583          	ld	a1,32(a0)
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	7d0080e7          	jalr	2000(ra) # 80002cd4 <_ZN12ProducerSync8producerEPv>
    }
    8000350c:	00813083          	ld	ra,8(sp)
    80003510:	00013403          	ld	s0,0(sp)
    80003514:	01010113          	addi	sp,sp,16
    80003518:	00008067          	ret

000000008000351c <_ZN12ConsumerSync3runEv>:
    void run() override {
    8000351c:	ff010113          	addi	sp,sp,-16
    80003520:	00113423          	sd	ra,8(sp)
    80003524:	00813023          	sd	s0,0(sp)
    80003528:	01010413          	addi	s0,sp,16
        consumer(td);
    8000352c:	02053583          	ld	a1,32(a0)
    80003530:	00000097          	auipc	ra,0x0
    80003534:	83c080e7          	jalr	-1988(ra) # 80002d6c <_ZN12ConsumerSync8consumerEPv>
    }
    80003538:	00813083          	ld	ra,8(sp)
    8000353c:	00013403          	ld	s0,0(sp)
    80003540:	01010113          	addi	sp,sp,16
    80003544:	00008067          	ret

0000000080003548 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003548:	fe010113          	addi	sp,sp,-32
    8000354c:	00113c23          	sd	ra,24(sp)
    80003550:	00813823          	sd	s0,16(sp)
    80003554:	00913423          	sd	s1,8(sp)
    80003558:	01213023          	sd	s2,0(sp)
    8000355c:	02010413          	addi	s0,sp,32
    80003560:	00050493          	mv	s1,a0
    80003564:	00058913          	mv	s2,a1
    80003568:	0015879b          	addiw	a5,a1,1
    8000356c:	0007851b          	sext.w	a0,a5
    80003570:	00f4a023          	sw	a5,0(s1)
    80003574:	0004a823          	sw	zero,16(s1)
    80003578:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)__mem_alloc(sizeof(int) * cap);
    8000357c:	00251513          	slli	a0,a0,0x2
    80003580:	00003097          	auipc	ra,0x3
    80003584:	398080e7          	jalr	920(ra) # 80006918 <__mem_alloc>
    80003588:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000358c:	00000593          	li	a1,0
    80003590:	02048513          	addi	a0,s1,32
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	8d8080e7          	jalr	-1832(ra) # 80001e6c <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    8000359c:	00090593          	mv	a1,s2
    800035a0:	01848513          	addi	a0,s1,24
    800035a4:	fffff097          	auipc	ra,0xfffff
    800035a8:	8c8080e7          	jalr	-1848(ra) # 80001e6c <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    800035ac:	00100593          	li	a1,1
    800035b0:	02848513          	addi	a0,s1,40
    800035b4:	fffff097          	auipc	ra,0xfffff
    800035b8:	8b8080e7          	jalr	-1864(ra) # 80001e6c <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    800035bc:	00100593          	li	a1,1
    800035c0:	03048513          	addi	a0,s1,48
    800035c4:	fffff097          	auipc	ra,0xfffff
    800035c8:	8a8080e7          	jalr	-1880(ra) # 80001e6c <_Z8sem_openPP4_semj>
}
    800035cc:	01813083          	ld	ra,24(sp)
    800035d0:	01013403          	ld	s0,16(sp)
    800035d4:	00813483          	ld	s1,8(sp)
    800035d8:	00013903          	ld	s2,0(sp)
    800035dc:	02010113          	addi	sp,sp,32
    800035e0:	00008067          	ret

00000000800035e4 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800035e4:	fe010113          	addi	sp,sp,-32
    800035e8:	00113c23          	sd	ra,24(sp)
    800035ec:	00813823          	sd	s0,16(sp)
    800035f0:	00913423          	sd	s1,8(sp)
    800035f4:	01213023          	sd	s2,0(sp)
    800035f8:	02010413          	addi	s0,sp,32
    800035fc:	00050493          	mv	s1,a0
    80003600:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003604:	01853503          	ld	a0,24(a0)
    80003608:	fffff097          	auipc	ra,0xfffff
    8000360c:	8c8080e7          	jalr	-1848(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80003610:	0304b503          	ld	a0,48(s1)
    80003614:	fffff097          	auipc	ra,0xfffff
    80003618:	8bc080e7          	jalr	-1860(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    8000361c:	0084b783          	ld	a5,8(s1)
    80003620:	0144a703          	lw	a4,20(s1)
    80003624:	00271713          	slli	a4,a4,0x2
    80003628:	00e787b3          	add	a5,a5,a4
    8000362c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80003630:	0144a783          	lw	a5,20(s1)
    80003634:	0017879b          	addiw	a5,a5,1
    80003638:	0004a703          	lw	a4,0(s1)
    8000363c:	02e7e7bb          	remw	a5,a5,a4
    80003640:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80003644:	0304b503          	ld	a0,48(s1)
    80003648:	fffff097          	auipc	ra,0xfffff
    8000364c:	8b8080e7          	jalr	-1864(ra) # 80001f00 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80003650:	0204b503          	ld	a0,32(s1)
    80003654:	fffff097          	auipc	ra,0xfffff
    80003658:	8ac080e7          	jalr	-1876(ra) # 80001f00 <_Z10sem_signalP4_sem>

}
    8000365c:	01813083          	ld	ra,24(sp)
    80003660:	01013403          	ld	s0,16(sp)
    80003664:	00813483          	ld	s1,8(sp)
    80003668:	00013903          	ld	s2,0(sp)
    8000366c:	02010113          	addi	sp,sp,32
    80003670:	00008067          	ret

0000000080003674 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003674:	fe010113          	addi	sp,sp,-32
    80003678:	00113c23          	sd	ra,24(sp)
    8000367c:	00813823          	sd	s0,16(sp)
    80003680:	00913423          	sd	s1,8(sp)
    80003684:	01213023          	sd	s2,0(sp)
    80003688:	02010413          	addi	s0,sp,32
    8000368c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003690:	02053503          	ld	a0,32(a0)
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	83c080e7          	jalr	-1988(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    8000369c:	0284b503          	ld	a0,40(s1)
    800036a0:	fffff097          	auipc	ra,0xfffff
    800036a4:	830080e7          	jalr	-2000(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    800036a8:	0084b703          	ld	a4,8(s1)
    800036ac:	0104a783          	lw	a5,16(s1)
    800036b0:	00279693          	slli	a3,a5,0x2
    800036b4:	00d70733          	add	a4,a4,a3
    800036b8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800036bc:	0017879b          	addiw	a5,a5,1
    800036c0:	0004a703          	lw	a4,0(s1)
    800036c4:	02e7e7bb          	remw	a5,a5,a4
    800036c8:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800036cc:	0284b503          	ld	a0,40(s1)
    800036d0:	fffff097          	auipc	ra,0xfffff
    800036d4:	830080e7          	jalr	-2000(ra) # 80001f00 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    800036d8:	0184b503          	ld	a0,24(s1)
    800036dc:	fffff097          	auipc	ra,0xfffff
    800036e0:	824080e7          	jalr	-2012(ra) # 80001f00 <_Z10sem_signalP4_sem>

    return ret;
}
    800036e4:	00090513          	mv	a0,s2
    800036e8:	01813083          	ld	ra,24(sp)
    800036ec:	01013403          	ld	s0,16(sp)
    800036f0:	00813483          	ld	s1,8(sp)
    800036f4:	00013903          	ld	s2,0(sp)
    800036f8:	02010113          	addi	sp,sp,32
    800036fc:	00008067          	ret

0000000080003700 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003700:	fe010113          	addi	sp,sp,-32
    80003704:	00113c23          	sd	ra,24(sp)
    80003708:	00813823          	sd	s0,16(sp)
    8000370c:	00913423          	sd	s1,8(sp)
    80003710:	01213023          	sd	s2,0(sp)
    80003714:	02010413          	addi	s0,sp,32
    80003718:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    8000371c:	02853503          	ld	a0,40(a0)
    80003720:	ffffe097          	auipc	ra,0xffffe
    80003724:	7b0080e7          	jalr	1968(ra) # 80001ed0 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80003728:	0304b503          	ld	a0,48(s1)
    8000372c:	ffffe097          	auipc	ra,0xffffe
    80003730:	7a4080e7          	jalr	1956(ra) # 80001ed0 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80003734:	0144a783          	lw	a5,20(s1)
    80003738:	0104a903          	lw	s2,16(s1)
    8000373c:	0327ce63          	blt	a5,s2,80003778 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80003740:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80003744:	0304b503          	ld	a0,48(s1)
    80003748:	ffffe097          	auipc	ra,0xffffe
    8000374c:	7b8080e7          	jalr	1976(ra) # 80001f00 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80003750:	0284b503          	ld	a0,40(s1)
    80003754:	ffffe097          	auipc	ra,0xffffe
    80003758:	7ac080e7          	jalr	1964(ra) # 80001f00 <_Z10sem_signalP4_sem>

    return ret;
}
    8000375c:	00090513          	mv	a0,s2
    80003760:	01813083          	ld	ra,24(sp)
    80003764:	01013403          	ld	s0,16(sp)
    80003768:	00813483          	ld	s1,8(sp)
    8000376c:	00013903          	ld	s2,0(sp)
    80003770:	02010113          	addi	sp,sp,32
    80003774:	00008067          	ret
        ret = cap - head + tail;
    80003778:	0004a703          	lw	a4,0(s1)
    8000377c:	4127093b          	subw	s2,a4,s2
    80003780:	00f9093b          	addw	s2,s2,a5
    80003784:	fc1ff06f          	j	80003744 <_ZN6Buffer6getCntEv+0x44>

0000000080003788 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003788:	fe010113          	addi	sp,sp,-32
    8000378c:	00113c23          	sd	ra,24(sp)
    80003790:	00813823          	sd	s0,16(sp)
    80003794:	00913423          	sd	s1,8(sp)
    80003798:	02010413          	addi	s0,sp,32
    8000379c:	00050493          	mv	s1,a0
    putc('\n');
    800037a0:	00a00513          	li	a0,10
    800037a4:	ffffe097          	auipc	ra,0xffffe
    800037a8:	6a0080e7          	jalr	1696(ra) # 80001e44 <_Z4putcc>
    printString("Buffer deleted!\n");
    800037ac:	00004517          	auipc	a0,0x4
    800037b0:	cf450513          	addi	a0,a0,-780 # 800074a0 <kvmincrease+0x910>
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	c9c080e7          	jalr	-868(ra) # 80002450 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800037bc:	00048513          	mv	a0,s1
    800037c0:	00000097          	auipc	ra,0x0
    800037c4:	f40080e7          	jalr	-192(ra) # 80003700 <_ZN6Buffer6getCntEv>
    800037c8:	02a05c63          	blez	a0,80003800 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800037cc:	0084b783          	ld	a5,8(s1)
    800037d0:	0104a703          	lw	a4,16(s1)
    800037d4:	00271713          	slli	a4,a4,0x2
    800037d8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800037dc:	0007c503          	lbu	a0,0(a5)
    800037e0:	ffffe097          	auipc	ra,0xffffe
    800037e4:	664080e7          	jalr	1636(ra) # 80001e44 <_Z4putcc>
        head = (head + 1) % cap;
    800037e8:	0104a783          	lw	a5,16(s1)
    800037ec:	0017879b          	addiw	a5,a5,1
    800037f0:	0004a703          	lw	a4,0(s1)
    800037f4:	02e7e7bb          	remw	a5,a5,a4
    800037f8:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800037fc:	fc1ff06f          	j	800037bc <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003800:	02100513          	li	a0,33
    80003804:	ffffe097          	auipc	ra,0xffffe
    80003808:	640080e7          	jalr	1600(ra) # 80001e44 <_Z4putcc>
    putc('\n');
    8000380c:	00a00513          	li	a0,10
    80003810:	ffffe097          	auipc	ra,0xffffe
    80003814:	634080e7          	jalr	1588(ra) # 80001e44 <_Z4putcc>
    __mem_free(buffer);
    80003818:	0084b503          	ld	a0,8(s1)
    8000381c:	00003097          	auipc	ra,0x3
    80003820:	030080e7          	jalr	48(ra) # 8000684c <__mem_free>
    sem_close(itemAvailable);
    80003824:	0204b503          	ld	a0,32(s1)
    80003828:	ffffe097          	auipc	ra,0xffffe
    8000382c:	678080e7          	jalr	1656(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80003830:	0184b503          	ld	a0,24(s1)
    80003834:	ffffe097          	auipc	ra,0xffffe
    80003838:	66c080e7          	jalr	1644(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    8000383c:	0304b503          	ld	a0,48(s1)
    80003840:	ffffe097          	auipc	ra,0xffffe
    80003844:	660080e7          	jalr	1632(ra) # 80001ea0 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80003848:	0284b503          	ld	a0,40(s1)
    8000384c:	ffffe097          	auipc	ra,0xffffe
    80003850:	654080e7          	jalr	1620(ra) # 80001ea0 <_Z9sem_closeP4_sem>
}
    80003854:	01813083          	ld	ra,24(sp)
    80003858:	01013403          	ld	s0,16(sp)
    8000385c:	00813483          	ld	s1,8(sp)
    80003860:	02010113          	addi	sp,sp,32
    80003864:	00008067          	ret

0000000080003868 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003868:	fe010113          	addi	sp,sp,-32
    8000386c:	00113c23          	sd	ra,24(sp)
    80003870:	00813823          	sd	s0,16(sp)
    80003874:	00913423          	sd	s1,8(sp)
    80003878:	01213023          	sd	s2,0(sp)
    8000387c:	02010413          	addi	s0,sp,32
    80003880:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003884:	00100793          	li	a5,1
    80003888:	02a7f863          	bgeu	a5,a0,800038b8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000388c:	00a00793          	li	a5,10
    80003890:	02f577b3          	remu	a5,a0,a5
    80003894:	02078e63          	beqz	a5,800038d0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003898:	fff48513          	addi	a0,s1,-1
    8000389c:	00000097          	auipc	ra,0x0
    800038a0:	fcc080e7          	jalr	-52(ra) # 80003868 <_ZL9fibonaccim>
    800038a4:	00050913          	mv	s2,a0
    800038a8:	ffe48513          	addi	a0,s1,-2
    800038ac:	00000097          	auipc	ra,0x0
    800038b0:	fbc080e7          	jalr	-68(ra) # 80003868 <_ZL9fibonaccim>
    800038b4:	00a90533          	add	a0,s2,a0
}
    800038b8:	01813083          	ld	ra,24(sp)
    800038bc:	01013403          	ld	s0,16(sp)
    800038c0:	00813483          	ld	s1,8(sp)
    800038c4:	00013903          	ld	s2,0(sp)
    800038c8:	02010113          	addi	sp,sp,32
    800038cc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800038d0:	ffffe097          	auipc	ra,0xffffe
    800038d4:	4f8080e7          	jalr	1272(ra) # 80001dc8 <_Z15thread_dispatchv>
    800038d8:	fc1ff06f          	j	80003898 <_ZL9fibonaccim+0x30>

00000000800038dc <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800038dc:	fe010113          	addi	sp,sp,-32
    800038e0:	00113c23          	sd	ra,24(sp)
    800038e4:	00813823          	sd	s0,16(sp)
    800038e8:	00913423          	sd	s1,8(sp)
    800038ec:	01213023          	sd	s2,0(sp)
    800038f0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800038f4:	00a00493          	li	s1,10
    800038f8:	0400006f          	j	80003938 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800038fc:	00004517          	auipc	a0,0x4
    80003900:	c7c50513          	addi	a0,a0,-900 # 80007578 <_ZTV12ConsumerSync+0x28>
    80003904:	fffff097          	auipc	ra,0xfffff
    80003908:	b4c080e7          	jalr	-1204(ra) # 80002450 <_Z11printStringPKc>
    8000390c:	00000613          	li	a2,0
    80003910:	00a00593          	li	a1,10
    80003914:	00048513          	mv	a0,s1
    80003918:	fffff097          	auipc	ra,0xfffff
    8000391c:	ce8080e7          	jalr	-792(ra) # 80002600 <_Z8printIntiii>
    80003920:	00004517          	auipc	a0,0x4
    80003924:	9b050513          	addi	a0,a0,-1616 # 800072d0 <kvmincrease+0x740>
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	b28080e7          	jalr	-1240(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003930:	0014849b          	addiw	s1,s1,1
    80003934:	0ff4f493          	andi	s1,s1,255
    80003938:	00c00793          	li	a5,12
    8000393c:	fc97f0e3          	bgeu	a5,s1,800038fc <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003940:	00004517          	auipc	a0,0x4
    80003944:	c4050513          	addi	a0,a0,-960 # 80007580 <_ZTV12ConsumerSync+0x30>
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	b08080e7          	jalr	-1272(ra) # 80002450 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003950:	00500313          	li	t1,5
    thread_dispatch();
    80003954:	ffffe097          	auipc	ra,0xffffe
    80003958:	474080e7          	jalr	1140(ra) # 80001dc8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000395c:	01000513          	li	a0,16
    80003960:	00000097          	auipc	ra,0x0
    80003964:	f08080e7          	jalr	-248(ra) # 80003868 <_ZL9fibonaccim>
    80003968:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000396c:	00004517          	auipc	a0,0x4
    80003970:	c2450513          	addi	a0,a0,-988 # 80007590 <_ZTV12ConsumerSync+0x40>
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	adc080e7          	jalr	-1316(ra) # 80002450 <_Z11printStringPKc>
    8000397c:	00000613          	li	a2,0
    80003980:	00a00593          	li	a1,10
    80003984:	0009051b          	sext.w	a0,s2
    80003988:	fffff097          	auipc	ra,0xfffff
    8000398c:	c78080e7          	jalr	-904(ra) # 80002600 <_Z8printIntiii>
    80003990:	00004517          	auipc	a0,0x4
    80003994:	94050513          	addi	a0,a0,-1728 # 800072d0 <kvmincrease+0x740>
    80003998:	fffff097          	auipc	ra,0xfffff
    8000399c:	ab8080e7          	jalr	-1352(ra) # 80002450 <_Z11printStringPKc>
    800039a0:	0400006f          	j	800039e0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800039a4:	00004517          	auipc	a0,0x4
    800039a8:	bd450513          	addi	a0,a0,-1068 # 80007578 <_ZTV12ConsumerSync+0x28>
    800039ac:	fffff097          	auipc	ra,0xfffff
    800039b0:	aa4080e7          	jalr	-1372(ra) # 80002450 <_Z11printStringPKc>
    800039b4:	00000613          	li	a2,0
    800039b8:	00a00593          	li	a1,10
    800039bc:	00048513          	mv	a0,s1
    800039c0:	fffff097          	auipc	ra,0xfffff
    800039c4:	c40080e7          	jalr	-960(ra) # 80002600 <_Z8printIntiii>
    800039c8:	00004517          	auipc	a0,0x4
    800039cc:	90850513          	addi	a0,a0,-1784 # 800072d0 <kvmincrease+0x740>
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	a80080e7          	jalr	-1408(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800039d8:	0014849b          	addiw	s1,s1,1
    800039dc:	0ff4f493          	andi	s1,s1,255
    800039e0:	00f00793          	li	a5,15
    800039e4:	fc97f0e3          	bgeu	a5,s1,800039a4 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800039e8:	00004517          	auipc	a0,0x4
    800039ec:	bb850513          	addi	a0,a0,-1096 # 800075a0 <_ZTV12ConsumerSync+0x50>
    800039f0:	fffff097          	auipc	ra,0xfffff
    800039f4:	a60080e7          	jalr	-1440(ra) # 80002450 <_Z11printStringPKc>
    finishedD = true;
    800039f8:	00100793          	li	a5,1
    800039fc:	00005717          	auipc	a4,0x5
    80003a00:	24f70623          	sb	a5,588(a4) # 80008c48 <_ZL9finishedD>
    thread_dispatch();
    80003a04:	ffffe097          	auipc	ra,0xffffe
    80003a08:	3c4080e7          	jalr	964(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    80003a0c:	01813083          	ld	ra,24(sp)
    80003a10:	01013403          	ld	s0,16(sp)
    80003a14:	00813483          	ld	s1,8(sp)
    80003a18:	00013903          	ld	s2,0(sp)
    80003a1c:	02010113          	addi	sp,sp,32
    80003a20:	00008067          	ret

0000000080003a24 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003a24:	fe010113          	addi	sp,sp,-32
    80003a28:	00113c23          	sd	ra,24(sp)
    80003a2c:	00813823          	sd	s0,16(sp)
    80003a30:	00913423          	sd	s1,8(sp)
    80003a34:	01213023          	sd	s2,0(sp)
    80003a38:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003a3c:	00000493          	li	s1,0
    80003a40:	0400006f          	j	80003a80 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003a44:	00004517          	auipc	a0,0x4
    80003a48:	b6c50513          	addi	a0,a0,-1172 # 800075b0 <_ZTV12ConsumerSync+0x60>
    80003a4c:	fffff097          	auipc	ra,0xfffff
    80003a50:	a04080e7          	jalr	-1532(ra) # 80002450 <_Z11printStringPKc>
    80003a54:	00000613          	li	a2,0
    80003a58:	00a00593          	li	a1,10
    80003a5c:	00048513          	mv	a0,s1
    80003a60:	fffff097          	auipc	ra,0xfffff
    80003a64:	ba0080e7          	jalr	-1120(ra) # 80002600 <_Z8printIntiii>
    80003a68:	00004517          	auipc	a0,0x4
    80003a6c:	86850513          	addi	a0,a0,-1944 # 800072d0 <kvmincrease+0x740>
    80003a70:	fffff097          	auipc	ra,0xfffff
    80003a74:	9e0080e7          	jalr	-1568(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003a78:	0014849b          	addiw	s1,s1,1
    80003a7c:	0ff4f493          	andi	s1,s1,255
    80003a80:	00200793          	li	a5,2
    80003a84:	fc97f0e3          	bgeu	a5,s1,80003a44 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003a88:	00004517          	auipc	a0,0x4
    80003a8c:	b3050513          	addi	a0,a0,-1232 # 800075b8 <_ZTV12ConsumerSync+0x68>
    80003a90:	fffff097          	auipc	ra,0xfffff
    80003a94:	9c0080e7          	jalr	-1600(ra) # 80002450 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003a98:	00700313          	li	t1,7
    thread_dispatch();
    80003a9c:	ffffe097          	auipc	ra,0xffffe
    80003aa0:	32c080e7          	jalr	812(ra) # 80001dc8 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003aa4:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003aa8:	00004517          	auipc	a0,0x4
    80003aac:	b2050513          	addi	a0,a0,-1248 # 800075c8 <_ZTV12ConsumerSync+0x78>
    80003ab0:	fffff097          	auipc	ra,0xfffff
    80003ab4:	9a0080e7          	jalr	-1632(ra) # 80002450 <_Z11printStringPKc>
    80003ab8:	00000613          	li	a2,0
    80003abc:	00a00593          	li	a1,10
    80003ac0:	0009051b          	sext.w	a0,s2
    80003ac4:	fffff097          	auipc	ra,0xfffff
    80003ac8:	b3c080e7          	jalr	-1220(ra) # 80002600 <_Z8printIntiii>
    80003acc:	00004517          	auipc	a0,0x4
    80003ad0:	80450513          	addi	a0,a0,-2044 # 800072d0 <kvmincrease+0x740>
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	97c080e7          	jalr	-1668(ra) # 80002450 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003adc:	00c00513          	li	a0,12
    80003ae0:	00000097          	auipc	ra,0x0
    80003ae4:	d88080e7          	jalr	-632(ra) # 80003868 <_ZL9fibonaccim>
    80003ae8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003aec:	00004517          	auipc	a0,0x4
    80003af0:	ae450513          	addi	a0,a0,-1308 # 800075d0 <_ZTV12ConsumerSync+0x80>
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	95c080e7          	jalr	-1700(ra) # 80002450 <_Z11printStringPKc>
    80003afc:	00000613          	li	a2,0
    80003b00:	00a00593          	li	a1,10
    80003b04:	0009051b          	sext.w	a0,s2
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	af8080e7          	jalr	-1288(ra) # 80002600 <_Z8printIntiii>
    80003b10:	00003517          	auipc	a0,0x3
    80003b14:	7c050513          	addi	a0,a0,1984 # 800072d0 <kvmincrease+0x740>
    80003b18:	fffff097          	auipc	ra,0xfffff
    80003b1c:	938080e7          	jalr	-1736(ra) # 80002450 <_Z11printStringPKc>
    80003b20:	0400006f          	j	80003b60 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003b24:	00004517          	auipc	a0,0x4
    80003b28:	a8c50513          	addi	a0,a0,-1396 # 800075b0 <_ZTV12ConsumerSync+0x60>
    80003b2c:	fffff097          	auipc	ra,0xfffff
    80003b30:	924080e7          	jalr	-1756(ra) # 80002450 <_Z11printStringPKc>
    80003b34:	00000613          	li	a2,0
    80003b38:	00a00593          	li	a1,10
    80003b3c:	00048513          	mv	a0,s1
    80003b40:	fffff097          	auipc	ra,0xfffff
    80003b44:	ac0080e7          	jalr	-1344(ra) # 80002600 <_Z8printIntiii>
    80003b48:	00003517          	auipc	a0,0x3
    80003b4c:	78850513          	addi	a0,a0,1928 # 800072d0 <kvmincrease+0x740>
    80003b50:	fffff097          	auipc	ra,0xfffff
    80003b54:	900080e7          	jalr	-1792(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003b58:	0014849b          	addiw	s1,s1,1
    80003b5c:	0ff4f493          	andi	s1,s1,255
    80003b60:	00500793          	li	a5,5
    80003b64:	fc97f0e3          	bgeu	a5,s1,80003b24 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80003b68:	00004517          	auipc	a0,0x4
    80003b6c:	a7850513          	addi	a0,a0,-1416 # 800075e0 <_ZTV12ConsumerSync+0x90>
    80003b70:	fffff097          	auipc	ra,0xfffff
    80003b74:	8e0080e7          	jalr	-1824(ra) # 80002450 <_Z11printStringPKc>
    finishedC = true;
    80003b78:	00100793          	li	a5,1
    80003b7c:	00005717          	auipc	a4,0x5
    80003b80:	0cf706a3          	sb	a5,205(a4) # 80008c49 <_ZL9finishedC>
    thread_dispatch();
    80003b84:	ffffe097          	auipc	ra,0xffffe
    80003b88:	244080e7          	jalr	580(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    80003b8c:	01813083          	ld	ra,24(sp)
    80003b90:	01013403          	ld	s0,16(sp)
    80003b94:	00813483          	ld	s1,8(sp)
    80003b98:	00013903          	ld	s2,0(sp)
    80003b9c:	02010113          	addi	sp,sp,32
    80003ba0:	00008067          	ret

0000000080003ba4 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003ba4:	fe010113          	addi	sp,sp,-32
    80003ba8:	00113c23          	sd	ra,24(sp)
    80003bac:	00813823          	sd	s0,16(sp)
    80003bb0:	00913423          	sd	s1,8(sp)
    80003bb4:	01213023          	sd	s2,0(sp)
    80003bb8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003bbc:	00000913          	li	s2,0
    80003bc0:	0380006f          	j	80003bf8 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003bc4:	ffffe097          	auipc	ra,0xffffe
    80003bc8:	204080e7          	jalr	516(ra) # 80001dc8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003bcc:	00148493          	addi	s1,s1,1
    80003bd0:	000027b7          	lui	a5,0x2
    80003bd4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003bd8:	0097ee63          	bltu	a5,s1,80003bf4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003bdc:	00000713          	li	a4,0
    80003be0:	000077b7          	lui	a5,0x7
    80003be4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003be8:	fce7eee3          	bltu	a5,a4,80003bc4 <_ZL11workerBodyBPv+0x20>
    80003bec:	00170713          	addi	a4,a4,1
    80003bf0:	ff1ff06f          	j	80003be0 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003bf4:	00190913          	addi	s2,s2,1
    80003bf8:	00f00793          	li	a5,15
    80003bfc:	0527e063          	bltu	a5,s2,80003c3c <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003c00:	00004517          	auipc	a0,0x4
    80003c04:	9f050513          	addi	a0,a0,-1552 # 800075f0 <_ZTV12ConsumerSync+0xa0>
    80003c08:	fffff097          	auipc	ra,0xfffff
    80003c0c:	848080e7          	jalr	-1976(ra) # 80002450 <_Z11printStringPKc>
    80003c10:	00000613          	li	a2,0
    80003c14:	00a00593          	li	a1,10
    80003c18:	0009051b          	sext.w	a0,s2
    80003c1c:	fffff097          	auipc	ra,0xfffff
    80003c20:	9e4080e7          	jalr	-1564(ra) # 80002600 <_Z8printIntiii>
    80003c24:	00003517          	auipc	a0,0x3
    80003c28:	6ac50513          	addi	a0,a0,1708 # 800072d0 <kvmincrease+0x740>
    80003c2c:	fffff097          	auipc	ra,0xfffff
    80003c30:	824080e7          	jalr	-2012(ra) # 80002450 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003c34:	00000493          	li	s1,0
    80003c38:	f99ff06f          	j	80003bd0 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003c3c:	00004517          	auipc	a0,0x4
    80003c40:	9bc50513          	addi	a0,a0,-1604 # 800075f8 <_ZTV12ConsumerSync+0xa8>
    80003c44:	fffff097          	auipc	ra,0xfffff
    80003c48:	80c080e7          	jalr	-2036(ra) # 80002450 <_Z11printStringPKc>
    finishedB = true;
    80003c4c:	00100793          	li	a5,1
    80003c50:	00005717          	auipc	a4,0x5
    80003c54:	fef70d23          	sb	a5,-6(a4) # 80008c4a <_ZL9finishedB>
    thread_dispatch();
    80003c58:	ffffe097          	auipc	ra,0xffffe
    80003c5c:	170080e7          	jalr	368(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    80003c60:	01813083          	ld	ra,24(sp)
    80003c64:	01013403          	ld	s0,16(sp)
    80003c68:	00813483          	ld	s1,8(sp)
    80003c6c:	00013903          	ld	s2,0(sp)
    80003c70:	02010113          	addi	sp,sp,32
    80003c74:	00008067          	ret

0000000080003c78 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003c78:	fe010113          	addi	sp,sp,-32
    80003c7c:	00113c23          	sd	ra,24(sp)
    80003c80:	00813823          	sd	s0,16(sp)
    80003c84:	00913423          	sd	s1,8(sp)
    80003c88:	01213023          	sd	s2,0(sp)
    80003c8c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003c90:	00000913          	li	s2,0
    80003c94:	0380006f          	j	80003ccc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003c98:	ffffe097          	auipc	ra,0xffffe
    80003c9c:	130080e7          	jalr	304(ra) # 80001dc8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003ca0:	00148493          	addi	s1,s1,1
    80003ca4:	000027b7          	lui	a5,0x2
    80003ca8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003cac:	0097ee63          	bltu	a5,s1,80003cc8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003cb0:	00000713          	li	a4,0
    80003cb4:	000077b7          	lui	a5,0x7
    80003cb8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003cbc:	fce7eee3          	bltu	a5,a4,80003c98 <_ZL11workerBodyAPv+0x20>
    80003cc0:	00170713          	addi	a4,a4,1
    80003cc4:	ff1ff06f          	j	80003cb4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003cc8:	00190913          	addi	s2,s2,1
    80003ccc:	00900793          	li	a5,9
    80003cd0:	0527e063          	bltu	a5,s2,80003d10 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003cd4:	00004517          	auipc	a0,0x4
    80003cd8:	93450513          	addi	a0,a0,-1740 # 80007608 <_ZTV12ConsumerSync+0xb8>
    80003cdc:	ffffe097          	auipc	ra,0xffffe
    80003ce0:	774080e7          	jalr	1908(ra) # 80002450 <_Z11printStringPKc>
    80003ce4:	00000613          	li	a2,0
    80003ce8:	00a00593          	li	a1,10
    80003cec:	0009051b          	sext.w	a0,s2
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	910080e7          	jalr	-1776(ra) # 80002600 <_Z8printIntiii>
    80003cf8:	00003517          	auipc	a0,0x3
    80003cfc:	5d850513          	addi	a0,a0,1496 # 800072d0 <kvmincrease+0x740>
    80003d00:	ffffe097          	auipc	ra,0xffffe
    80003d04:	750080e7          	jalr	1872(ra) # 80002450 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003d08:	00000493          	li	s1,0
    80003d0c:	f99ff06f          	j	80003ca4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003d10:	00004517          	auipc	a0,0x4
    80003d14:	8d050513          	addi	a0,a0,-1840 # 800075e0 <_ZTV12ConsumerSync+0x90>
    80003d18:	ffffe097          	auipc	ra,0xffffe
    80003d1c:	738080e7          	jalr	1848(ra) # 80002450 <_Z11printStringPKc>
    finishedA = true;
    80003d20:	00100793          	li	a5,1
    80003d24:	00005717          	auipc	a4,0x5
    80003d28:	f2f703a3          	sb	a5,-217(a4) # 80008c4b <_ZL9finishedA>
}
    80003d2c:	01813083          	ld	ra,24(sp)
    80003d30:	01013403          	ld	s0,16(sp)
    80003d34:	00813483          	ld	s1,8(sp)
    80003d38:	00013903          	ld	s2,0(sp)
    80003d3c:	02010113          	addi	sp,sp,32
    80003d40:	00008067          	ret

0000000080003d44 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003d44:	fd010113          	addi	sp,sp,-48
    80003d48:	02113423          	sd	ra,40(sp)
    80003d4c:	02813023          	sd	s0,32(sp)
    80003d50:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80003d54:	00000613          	li	a2,0
    80003d58:	00000597          	auipc	a1,0x0
    80003d5c:	f2058593          	addi	a1,a1,-224 # 80003c78 <_ZL11workerBodyAPv>
    80003d60:	fd040513          	addi	a0,s0,-48
    80003d64:	ffffe097          	auipc	ra,0xffffe
    80003d68:	02c080e7          	jalr	44(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80003d6c:	00004517          	auipc	a0,0x4
    80003d70:	8a450513          	addi	a0,a0,-1884 # 80007610 <_ZTV12ConsumerSync+0xc0>
    80003d74:	ffffe097          	auipc	ra,0xffffe
    80003d78:	6dc080e7          	jalr	1756(ra) # 80002450 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80003d7c:	00000613          	li	a2,0
    80003d80:	00000597          	auipc	a1,0x0
    80003d84:	e2458593          	addi	a1,a1,-476 # 80003ba4 <_ZL11workerBodyBPv>
    80003d88:	fd840513          	addi	a0,s0,-40
    80003d8c:	ffffe097          	auipc	ra,0xffffe
    80003d90:	004080e7          	jalr	4(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80003d94:	00004517          	auipc	a0,0x4
    80003d98:	89450513          	addi	a0,a0,-1900 # 80007628 <_ZTV12ConsumerSync+0xd8>
    80003d9c:	ffffe097          	auipc	ra,0xffffe
    80003da0:	6b4080e7          	jalr	1716(ra) # 80002450 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80003da4:	00000613          	li	a2,0
    80003da8:	00000597          	auipc	a1,0x0
    80003dac:	c7c58593          	addi	a1,a1,-900 # 80003a24 <_ZL11workerBodyCPv>
    80003db0:	fe040513          	addi	a0,s0,-32
    80003db4:	ffffe097          	auipc	ra,0xffffe
    80003db8:	fdc080e7          	jalr	-36(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003dbc:	00004517          	auipc	a0,0x4
    80003dc0:	88450513          	addi	a0,a0,-1916 # 80007640 <_ZTV12ConsumerSync+0xf0>
    80003dc4:	ffffe097          	auipc	ra,0xffffe
    80003dc8:	68c080e7          	jalr	1676(ra) # 80002450 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003dcc:	00000613          	li	a2,0
    80003dd0:	00000597          	auipc	a1,0x0
    80003dd4:	b0c58593          	addi	a1,a1,-1268 # 800038dc <_ZL11workerBodyDPv>
    80003dd8:	fe840513          	addi	a0,s0,-24
    80003ddc:	ffffe097          	auipc	ra,0xffffe
    80003de0:	fb4080e7          	jalr	-76(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80003de4:	00004517          	auipc	a0,0x4
    80003de8:	87450513          	addi	a0,a0,-1932 # 80007658 <_ZTV12ConsumerSync+0x108>
    80003dec:	ffffe097          	auipc	ra,0xffffe
    80003df0:	664080e7          	jalr	1636(ra) # 80002450 <_Z11printStringPKc>
    80003df4:	00c0006f          	j	80003e00 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80003df8:	ffffe097          	auipc	ra,0xffffe
    80003dfc:	fd0080e7          	jalr	-48(ra) # 80001dc8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003e00:	00005797          	auipc	a5,0x5
    80003e04:	e4b7c783          	lbu	a5,-437(a5) # 80008c4b <_ZL9finishedA>
    80003e08:	fe0788e3          	beqz	a5,80003df8 <_Z18Threads_C_API_testv+0xb4>
    80003e0c:	00005797          	auipc	a5,0x5
    80003e10:	e3e7c783          	lbu	a5,-450(a5) # 80008c4a <_ZL9finishedB>
    80003e14:	fe0782e3          	beqz	a5,80003df8 <_Z18Threads_C_API_testv+0xb4>
    80003e18:	00005797          	auipc	a5,0x5
    80003e1c:	e317c783          	lbu	a5,-463(a5) # 80008c49 <_ZL9finishedC>
    80003e20:	fc078ce3          	beqz	a5,80003df8 <_Z18Threads_C_API_testv+0xb4>
    80003e24:	00005797          	auipc	a5,0x5
    80003e28:	e247c783          	lbu	a5,-476(a5) # 80008c48 <_ZL9finishedD>
    80003e2c:	fc0786e3          	beqz	a5,80003df8 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80003e30:	02813083          	ld	ra,40(sp)
    80003e34:	02013403          	ld	s0,32(sp)
    80003e38:	03010113          	addi	sp,sp,48
    80003e3c:	00008067          	ret

0000000080003e40 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003e40:	fe010113          	addi	sp,sp,-32
    80003e44:	00113c23          	sd	ra,24(sp)
    80003e48:	00813823          	sd	s0,16(sp)
    80003e4c:	00913423          	sd	s1,8(sp)
    80003e50:	01213023          	sd	s2,0(sp)
    80003e54:	02010413          	addi	s0,sp,32
    80003e58:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003e5c:	00100793          	li	a5,1
    80003e60:	02a7f863          	bgeu	a5,a0,80003e90 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80003e64:	00a00793          	li	a5,10
    80003e68:	02f577b3          	remu	a5,a0,a5
    80003e6c:	02078e63          	beqz	a5,80003ea8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003e70:	fff48513          	addi	a0,s1,-1
    80003e74:	00000097          	auipc	ra,0x0
    80003e78:	fcc080e7          	jalr	-52(ra) # 80003e40 <_ZL9fibonaccim>
    80003e7c:	00050913          	mv	s2,a0
    80003e80:	ffe48513          	addi	a0,s1,-2
    80003e84:	00000097          	auipc	ra,0x0
    80003e88:	fbc080e7          	jalr	-68(ra) # 80003e40 <_ZL9fibonaccim>
    80003e8c:	00a90533          	add	a0,s2,a0
}
    80003e90:	01813083          	ld	ra,24(sp)
    80003e94:	01013403          	ld	s0,16(sp)
    80003e98:	00813483          	ld	s1,8(sp)
    80003e9c:	00013903          	ld	s2,0(sp)
    80003ea0:	02010113          	addi	sp,sp,32
    80003ea4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003ea8:	ffffe097          	auipc	ra,0xffffe
    80003eac:	f20080e7          	jalr	-224(ra) # 80001dc8 <_Z15thread_dispatchv>
    80003eb0:	fc1ff06f          	j	80003e70 <_ZL9fibonaccim+0x30>

0000000080003eb4 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80003eb4:	fe010113          	addi	sp,sp,-32
    80003eb8:	00113c23          	sd	ra,24(sp)
    80003ebc:	00813823          	sd	s0,16(sp)
    80003ec0:	00913423          	sd	s1,8(sp)
    80003ec4:	01213023          	sd	s2,0(sp)
    80003ec8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003ecc:	00000913          	li	s2,0
    80003ed0:	0380006f          	j	80003f08 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003ed4:	ffffe097          	auipc	ra,0xffffe
    80003ed8:	ef4080e7          	jalr	-268(ra) # 80001dc8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003edc:	00148493          	addi	s1,s1,1
    80003ee0:	000027b7          	lui	a5,0x2
    80003ee4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003ee8:	0097ee63          	bltu	a5,s1,80003f04 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003eec:	00000713          	li	a4,0
    80003ef0:	000077b7          	lui	a5,0x7
    80003ef4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003ef8:	fce7eee3          	bltu	a5,a4,80003ed4 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80003efc:	00170713          	addi	a4,a4,1
    80003f00:	ff1ff06f          	j	80003ef0 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003f04:	00190913          	addi	s2,s2,1
    80003f08:	00900793          	li	a5,9
    80003f0c:	0527e063          	bltu	a5,s2,80003f4c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003f10:	00003517          	auipc	a0,0x3
    80003f14:	6f850513          	addi	a0,a0,1784 # 80007608 <_ZTV12ConsumerSync+0xb8>
    80003f18:	ffffe097          	auipc	ra,0xffffe
    80003f1c:	538080e7          	jalr	1336(ra) # 80002450 <_Z11printStringPKc>
    80003f20:	00000613          	li	a2,0
    80003f24:	00a00593          	li	a1,10
    80003f28:	0009051b          	sext.w	a0,s2
    80003f2c:	ffffe097          	auipc	ra,0xffffe
    80003f30:	6d4080e7          	jalr	1748(ra) # 80002600 <_Z8printIntiii>
    80003f34:	00003517          	auipc	a0,0x3
    80003f38:	39c50513          	addi	a0,a0,924 # 800072d0 <kvmincrease+0x740>
    80003f3c:	ffffe097          	auipc	ra,0xffffe
    80003f40:	514080e7          	jalr	1300(ra) # 80002450 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003f44:	00000493          	li	s1,0
    80003f48:	f99ff06f          	j	80003ee0 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80003f4c:	00003517          	auipc	a0,0x3
    80003f50:	69450513          	addi	a0,a0,1684 # 800075e0 <_ZTV12ConsumerSync+0x90>
    80003f54:	ffffe097          	auipc	ra,0xffffe
    80003f58:	4fc080e7          	jalr	1276(ra) # 80002450 <_Z11printStringPKc>
    finishedA = true;
    80003f5c:	00100793          	li	a5,1
    80003f60:	00005717          	auipc	a4,0x5
    80003f64:	cef707a3          	sb	a5,-785(a4) # 80008c4f <_ZL9finishedA>
}
    80003f68:	01813083          	ld	ra,24(sp)
    80003f6c:	01013403          	ld	s0,16(sp)
    80003f70:	00813483          	ld	s1,8(sp)
    80003f74:	00013903          	ld	s2,0(sp)
    80003f78:	02010113          	addi	sp,sp,32
    80003f7c:	00008067          	ret

0000000080003f80 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80003f80:	fe010113          	addi	sp,sp,-32
    80003f84:	00113c23          	sd	ra,24(sp)
    80003f88:	00813823          	sd	s0,16(sp)
    80003f8c:	00913423          	sd	s1,8(sp)
    80003f90:	01213023          	sd	s2,0(sp)
    80003f94:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003f98:	00000913          	li	s2,0
    80003f9c:	0380006f          	j	80003fd4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003fa0:	ffffe097          	auipc	ra,0xffffe
    80003fa4:	e28080e7          	jalr	-472(ra) # 80001dc8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003fa8:	00148493          	addi	s1,s1,1
    80003fac:	000027b7          	lui	a5,0x2
    80003fb0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003fb4:	0097ee63          	bltu	a5,s1,80003fd0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003fb8:	00000713          	li	a4,0
    80003fbc:	000077b7          	lui	a5,0x7
    80003fc0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003fc4:	fce7eee3          	bltu	a5,a4,80003fa0 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80003fc8:	00170713          	addi	a4,a4,1
    80003fcc:	ff1ff06f          	j	80003fbc <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003fd0:	00190913          	addi	s2,s2,1
    80003fd4:	00f00793          	li	a5,15
    80003fd8:	0527e063          	bltu	a5,s2,80004018 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003fdc:	00003517          	auipc	a0,0x3
    80003fe0:	61450513          	addi	a0,a0,1556 # 800075f0 <_ZTV12ConsumerSync+0xa0>
    80003fe4:	ffffe097          	auipc	ra,0xffffe
    80003fe8:	46c080e7          	jalr	1132(ra) # 80002450 <_Z11printStringPKc>
    80003fec:	00000613          	li	a2,0
    80003ff0:	00a00593          	li	a1,10
    80003ff4:	0009051b          	sext.w	a0,s2
    80003ff8:	ffffe097          	auipc	ra,0xffffe
    80003ffc:	608080e7          	jalr	1544(ra) # 80002600 <_Z8printIntiii>
    80004000:	00003517          	auipc	a0,0x3
    80004004:	2d050513          	addi	a0,a0,720 # 800072d0 <kvmincrease+0x740>
    80004008:	ffffe097          	auipc	ra,0xffffe
    8000400c:	448080e7          	jalr	1096(ra) # 80002450 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004010:	00000493          	li	s1,0
    80004014:	f99ff06f          	j	80003fac <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004018:	00003517          	auipc	a0,0x3
    8000401c:	5e050513          	addi	a0,a0,1504 # 800075f8 <_ZTV12ConsumerSync+0xa8>
    80004020:	ffffe097          	auipc	ra,0xffffe
    80004024:	430080e7          	jalr	1072(ra) # 80002450 <_Z11printStringPKc>
    finishedB = true;
    80004028:	00100793          	li	a5,1
    8000402c:	00005717          	auipc	a4,0x5
    80004030:	c2f70123          	sb	a5,-990(a4) # 80008c4e <_ZL9finishedB>
    thread_dispatch();
    80004034:	ffffe097          	auipc	ra,0xffffe
    80004038:	d94080e7          	jalr	-620(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    8000403c:	01813083          	ld	ra,24(sp)
    80004040:	01013403          	ld	s0,16(sp)
    80004044:	00813483          	ld	s1,8(sp)
    80004048:	00013903          	ld	s2,0(sp)
    8000404c:	02010113          	addi	sp,sp,32
    80004050:	00008067          	ret

0000000080004054 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80004054:	fe010113          	addi	sp,sp,-32
    80004058:	00113c23          	sd	ra,24(sp)
    8000405c:	00813823          	sd	s0,16(sp)
    80004060:	00913423          	sd	s1,8(sp)
    80004064:	01213023          	sd	s2,0(sp)
    80004068:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000406c:	00000493          	li	s1,0
    80004070:	0400006f          	j	800040b0 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004074:	00003517          	auipc	a0,0x3
    80004078:	53c50513          	addi	a0,a0,1340 # 800075b0 <_ZTV12ConsumerSync+0x60>
    8000407c:	ffffe097          	auipc	ra,0xffffe
    80004080:	3d4080e7          	jalr	980(ra) # 80002450 <_Z11printStringPKc>
    80004084:	00000613          	li	a2,0
    80004088:	00a00593          	li	a1,10
    8000408c:	00048513          	mv	a0,s1
    80004090:	ffffe097          	auipc	ra,0xffffe
    80004094:	570080e7          	jalr	1392(ra) # 80002600 <_Z8printIntiii>
    80004098:	00003517          	auipc	a0,0x3
    8000409c:	23850513          	addi	a0,a0,568 # 800072d0 <kvmincrease+0x740>
    800040a0:	ffffe097          	auipc	ra,0xffffe
    800040a4:	3b0080e7          	jalr	944(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800040a8:	0014849b          	addiw	s1,s1,1
    800040ac:	0ff4f493          	andi	s1,s1,255
    800040b0:	00200793          	li	a5,2
    800040b4:	fc97f0e3          	bgeu	a5,s1,80004074 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800040b8:	00003517          	auipc	a0,0x3
    800040bc:	50050513          	addi	a0,a0,1280 # 800075b8 <_ZTV12ConsumerSync+0x68>
    800040c0:	ffffe097          	auipc	ra,0xffffe
    800040c4:	390080e7          	jalr	912(ra) # 80002450 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800040c8:	00700313          	li	t1,7
    thread_dispatch();
    800040cc:	ffffe097          	auipc	ra,0xffffe
    800040d0:	cfc080e7          	jalr	-772(ra) # 80001dc8 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800040d4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800040d8:	00003517          	auipc	a0,0x3
    800040dc:	4f050513          	addi	a0,a0,1264 # 800075c8 <_ZTV12ConsumerSync+0x78>
    800040e0:	ffffe097          	auipc	ra,0xffffe
    800040e4:	370080e7          	jalr	880(ra) # 80002450 <_Z11printStringPKc>
    800040e8:	00000613          	li	a2,0
    800040ec:	00a00593          	li	a1,10
    800040f0:	0009051b          	sext.w	a0,s2
    800040f4:	ffffe097          	auipc	ra,0xffffe
    800040f8:	50c080e7          	jalr	1292(ra) # 80002600 <_Z8printIntiii>
    800040fc:	00003517          	auipc	a0,0x3
    80004100:	1d450513          	addi	a0,a0,468 # 800072d0 <kvmincrease+0x740>
    80004104:	ffffe097          	auipc	ra,0xffffe
    80004108:	34c080e7          	jalr	844(ra) # 80002450 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000410c:	00c00513          	li	a0,12
    80004110:	00000097          	auipc	ra,0x0
    80004114:	d30080e7          	jalr	-720(ra) # 80003e40 <_ZL9fibonaccim>
    80004118:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000411c:	00003517          	auipc	a0,0x3
    80004120:	4b450513          	addi	a0,a0,1204 # 800075d0 <_ZTV12ConsumerSync+0x80>
    80004124:	ffffe097          	auipc	ra,0xffffe
    80004128:	32c080e7          	jalr	812(ra) # 80002450 <_Z11printStringPKc>
    8000412c:	00000613          	li	a2,0
    80004130:	00a00593          	li	a1,10
    80004134:	0009051b          	sext.w	a0,s2
    80004138:	ffffe097          	auipc	ra,0xffffe
    8000413c:	4c8080e7          	jalr	1224(ra) # 80002600 <_Z8printIntiii>
    80004140:	00003517          	auipc	a0,0x3
    80004144:	19050513          	addi	a0,a0,400 # 800072d0 <kvmincrease+0x740>
    80004148:	ffffe097          	auipc	ra,0xffffe
    8000414c:	308080e7          	jalr	776(ra) # 80002450 <_Z11printStringPKc>
    80004150:	0400006f          	j	80004190 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004154:	00003517          	auipc	a0,0x3
    80004158:	45c50513          	addi	a0,a0,1116 # 800075b0 <_ZTV12ConsumerSync+0x60>
    8000415c:	ffffe097          	auipc	ra,0xffffe
    80004160:	2f4080e7          	jalr	756(ra) # 80002450 <_Z11printStringPKc>
    80004164:	00000613          	li	a2,0
    80004168:	00a00593          	li	a1,10
    8000416c:	00048513          	mv	a0,s1
    80004170:	ffffe097          	auipc	ra,0xffffe
    80004174:	490080e7          	jalr	1168(ra) # 80002600 <_Z8printIntiii>
    80004178:	00003517          	auipc	a0,0x3
    8000417c:	15850513          	addi	a0,a0,344 # 800072d0 <kvmincrease+0x740>
    80004180:	ffffe097          	auipc	ra,0xffffe
    80004184:	2d0080e7          	jalr	720(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004188:	0014849b          	addiw	s1,s1,1
    8000418c:	0ff4f493          	andi	s1,s1,255
    80004190:	00500793          	li	a5,5
    80004194:	fc97f0e3          	bgeu	a5,s1,80004154 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80004198:	00003517          	auipc	a0,0x3
    8000419c:	44850513          	addi	a0,a0,1096 # 800075e0 <_ZTV12ConsumerSync+0x90>
    800041a0:	ffffe097          	auipc	ra,0xffffe
    800041a4:	2b0080e7          	jalr	688(ra) # 80002450 <_Z11printStringPKc>
    finishedC = true;
    800041a8:	00100793          	li	a5,1
    800041ac:	00005717          	auipc	a4,0x5
    800041b0:	aaf700a3          	sb	a5,-1375(a4) # 80008c4d <_ZL9finishedC>
    thread_dispatch();
    800041b4:	ffffe097          	auipc	ra,0xffffe
    800041b8:	c14080e7          	jalr	-1004(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    800041bc:	01813083          	ld	ra,24(sp)
    800041c0:	01013403          	ld	s0,16(sp)
    800041c4:	00813483          	ld	s1,8(sp)
    800041c8:	00013903          	ld	s2,0(sp)
    800041cc:	02010113          	addi	sp,sp,32
    800041d0:	00008067          	ret

00000000800041d4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800041d4:	fe010113          	addi	sp,sp,-32
    800041d8:	00113c23          	sd	ra,24(sp)
    800041dc:	00813823          	sd	s0,16(sp)
    800041e0:	00913423          	sd	s1,8(sp)
    800041e4:	01213023          	sd	s2,0(sp)
    800041e8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800041ec:	00a00493          	li	s1,10
    800041f0:	0400006f          	j	80004230 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800041f4:	00003517          	auipc	a0,0x3
    800041f8:	38450513          	addi	a0,a0,900 # 80007578 <_ZTV12ConsumerSync+0x28>
    800041fc:	ffffe097          	auipc	ra,0xffffe
    80004200:	254080e7          	jalr	596(ra) # 80002450 <_Z11printStringPKc>
    80004204:	00000613          	li	a2,0
    80004208:	00a00593          	li	a1,10
    8000420c:	00048513          	mv	a0,s1
    80004210:	ffffe097          	auipc	ra,0xffffe
    80004214:	3f0080e7          	jalr	1008(ra) # 80002600 <_Z8printIntiii>
    80004218:	00003517          	auipc	a0,0x3
    8000421c:	0b850513          	addi	a0,a0,184 # 800072d0 <kvmincrease+0x740>
    80004220:	ffffe097          	auipc	ra,0xffffe
    80004224:	230080e7          	jalr	560(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004228:	0014849b          	addiw	s1,s1,1
    8000422c:	0ff4f493          	andi	s1,s1,255
    80004230:	00c00793          	li	a5,12
    80004234:	fc97f0e3          	bgeu	a5,s1,800041f4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80004238:	00003517          	auipc	a0,0x3
    8000423c:	34850513          	addi	a0,a0,840 # 80007580 <_ZTV12ConsumerSync+0x30>
    80004240:	ffffe097          	auipc	ra,0xffffe
    80004244:	210080e7          	jalr	528(ra) # 80002450 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004248:	00500313          	li	t1,5
    thread_dispatch();
    8000424c:	ffffe097          	auipc	ra,0xffffe
    80004250:	b7c080e7          	jalr	-1156(ra) # 80001dc8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004254:	01000513          	li	a0,16
    80004258:	00000097          	auipc	ra,0x0
    8000425c:	be8080e7          	jalr	-1048(ra) # 80003e40 <_ZL9fibonaccim>
    80004260:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004264:	00003517          	auipc	a0,0x3
    80004268:	32c50513          	addi	a0,a0,812 # 80007590 <_ZTV12ConsumerSync+0x40>
    8000426c:	ffffe097          	auipc	ra,0xffffe
    80004270:	1e4080e7          	jalr	484(ra) # 80002450 <_Z11printStringPKc>
    80004274:	00000613          	li	a2,0
    80004278:	00a00593          	li	a1,10
    8000427c:	0009051b          	sext.w	a0,s2
    80004280:	ffffe097          	auipc	ra,0xffffe
    80004284:	380080e7          	jalr	896(ra) # 80002600 <_Z8printIntiii>
    80004288:	00003517          	auipc	a0,0x3
    8000428c:	04850513          	addi	a0,a0,72 # 800072d0 <kvmincrease+0x740>
    80004290:	ffffe097          	auipc	ra,0xffffe
    80004294:	1c0080e7          	jalr	448(ra) # 80002450 <_Z11printStringPKc>
    80004298:	0400006f          	j	800042d8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000429c:	00003517          	auipc	a0,0x3
    800042a0:	2dc50513          	addi	a0,a0,732 # 80007578 <_ZTV12ConsumerSync+0x28>
    800042a4:	ffffe097          	auipc	ra,0xffffe
    800042a8:	1ac080e7          	jalr	428(ra) # 80002450 <_Z11printStringPKc>
    800042ac:	00000613          	li	a2,0
    800042b0:	00a00593          	li	a1,10
    800042b4:	00048513          	mv	a0,s1
    800042b8:	ffffe097          	auipc	ra,0xffffe
    800042bc:	348080e7          	jalr	840(ra) # 80002600 <_Z8printIntiii>
    800042c0:	00003517          	auipc	a0,0x3
    800042c4:	01050513          	addi	a0,a0,16 # 800072d0 <kvmincrease+0x740>
    800042c8:	ffffe097          	auipc	ra,0xffffe
    800042cc:	188080e7          	jalr	392(ra) # 80002450 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800042d0:	0014849b          	addiw	s1,s1,1
    800042d4:	0ff4f493          	andi	s1,s1,255
    800042d8:	00f00793          	li	a5,15
    800042dc:	fc97f0e3          	bgeu	a5,s1,8000429c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800042e0:	00003517          	auipc	a0,0x3
    800042e4:	2c050513          	addi	a0,a0,704 # 800075a0 <_ZTV12ConsumerSync+0x50>
    800042e8:	ffffe097          	auipc	ra,0xffffe
    800042ec:	168080e7          	jalr	360(ra) # 80002450 <_Z11printStringPKc>
    finishedD = true;
    800042f0:	00100793          	li	a5,1
    800042f4:	00005717          	auipc	a4,0x5
    800042f8:	94f70c23          	sb	a5,-1704(a4) # 80008c4c <_ZL9finishedD>
    thread_dispatch();
    800042fc:	ffffe097          	auipc	ra,0xffffe
    80004300:	acc080e7          	jalr	-1332(ra) # 80001dc8 <_Z15thread_dispatchv>
}
    80004304:	01813083          	ld	ra,24(sp)
    80004308:	01013403          	ld	s0,16(sp)
    8000430c:	00813483          	ld	s1,8(sp)
    80004310:	00013903          	ld	s2,0(sp)
    80004314:	02010113          	addi	sp,sp,32
    80004318:	00008067          	ret

000000008000431c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    8000431c:	fc010113          	addi	sp,sp,-64
    80004320:	02113c23          	sd	ra,56(sp)
    80004324:	02813823          	sd	s0,48(sp)
    80004328:	02913423          	sd	s1,40(sp)
    8000432c:	03213023          	sd	s2,32(sp)
    80004330:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80004334:	02000513          	li	a0,32
    80004338:	ffffd097          	auipc	ra,0xffffd
    8000433c:	f08080e7          	jalr	-248(ra) # 80001240 <_Znwm>
    Thread(){};
    80004340:	00053823          	sd	zero,16(a0)
    WorkerA():Thread() {}
    80004344:	00003797          	auipc	a5,0x3
    80004348:	34c78793          	addi	a5,a5,844 # 80007690 <_ZTV7WorkerA+0x10>
    8000434c:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80004350:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80004354:	00003517          	auipc	a0,0x3
    80004358:	2bc50513          	addi	a0,a0,700 # 80007610 <_ZTV12ConsumerSync+0xc0>
    8000435c:	ffffe097          	auipc	ra,0xffffe
    80004360:	0f4080e7          	jalr	244(ra) # 80002450 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80004364:	02000513          	li	a0,32
    80004368:	ffffd097          	auipc	ra,0xffffd
    8000436c:	ed8080e7          	jalr	-296(ra) # 80001240 <_Znwm>
    80004370:	00053823          	sd	zero,16(a0)
    WorkerB():Thread() {}
    80004374:	00003797          	auipc	a5,0x3
    80004378:	34478793          	addi	a5,a5,836 # 800076b8 <_ZTV7WorkerB+0x10>
    8000437c:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80004380:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80004384:	00003517          	auipc	a0,0x3
    80004388:	2a450513          	addi	a0,a0,676 # 80007628 <_ZTV12ConsumerSync+0xd8>
    8000438c:	ffffe097          	auipc	ra,0xffffe
    80004390:	0c4080e7          	jalr	196(ra) # 80002450 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80004394:	02000513          	li	a0,32
    80004398:	ffffd097          	auipc	ra,0xffffd
    8000439c:	ea8080e7          	jalr	-344(ra) # 80001240 <_Znwm>
    800043a0:	00053823          	sd	zero,16(a0)
    WorkerC():Thread() {}
    800043a4:	00003797          	auipc	a5,0x3
    800043a8:	33c78793          	addi	a5,a5,828 # 800076e0 <_ZTV7WorkerC+0x10>
    800043ac:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    800043b0:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    800043b4:	00003517          	auipc	a0,0x3
    800043b8:	28c50513          	addi	a0,a0,652 # 80007640 <_ZTV12ConsumerSync+0xf0>
    800043bc:	ffffe097          	auipc	ra,0xffffe
    800043c0:	094080e7          	jalr	148(ra) # 80002450 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    800043c4:	02000513          	li	a0,32
    800043c8:	ffffd097          	auipc	ra,0xffffd
    800043cc:	e78080e7          	jalr	-392(ra) # 80001240 <_Znwm>
    800043d0:	00053823          	sd	zero,16(a0)
    WorkerD():Thread() {}
    800043d4:	00003797          	auipc	a5,0x3
    800043d8:	33478793          	addi	a5,a5,820 # 80007708 <_ZTV7WorkerD+0x10>
    800043dc:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    800043e0:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    800043e4:	00003517          	auipc	a0,0x3
    800043e8:	27450513          	addi	a0,a0,628 # 80007658 <_ZTV12ConsumerSync+0x108>
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	064080e7          	jalr	100(ra) # 80002450 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800043f4:	00000493          	li	s1,0
    800043f8:	0200006f          	j	80004418 <_Z20Threads_CPP_API_testv+0xfc>
            thread_create(&myhandle, &threadWrapper,this);
    800043fc:	00050613          	mv	a2,a0
    80004400:	fffff597          	auipc	a1,0xfffff
    80004404:	e9058593          	addi	a1,a1,-368 # 80003290 <_ZN6Thread13threadWrapperEPv>
    80004408:	00850513          	addi	a0,a0,8
    8000440c:	ffffe097          	auipc	ra,0xffffe
    80004410:	984080e7          	jalr	-1660(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    80004414:	0014849b          	addiw	s1,s1,1
    80004418:	00300793          	li	a5,3
    8000441c:	0297cc63          	blt	a5,s1,80004454 <_Z20Threads_CPP_API_testv+0x138>
        threads[i]->start();
    80004420:	00349793          	slli	a5,s1,0x3
    80004424:	fe040713          	addi	a4,s0,-32
    80004428:	00f707b3          	add	a5,a4,a5
    8000442c:	fe07b503          	ld	a0,-32(a5)
        if (body == nullptr){
    80004430:	01053583          	ld	a1,16(a0)
    80004434:	fc0584e3          	beqz	a1,800043fc <_Z20Threads_CPP_API_testv+0xe0>
            thread_create(&myhandle, body,arg);
    80004438:	01853603          	ld	a2,24(a0)
    8000443c:	00850513          	addi	a0,a0,8
    80004440:	ffffe097          	auipc	ra,0xffffe
    80004444:	950080e7          	jalr	-1712(ra) # 80001d90 <_Z13thread_createPP7_threadPFvPvES2_>
    80004448:	fcdff06f          	j	80004414 <_Z20Threads_CPP_API_testv+0xf8>
    static void dispatch() {thread_dispatch();}
    8000444c:	ffffe097          	auipc	ra,0xffffe
    80004450:	97c080e7          	jalr	-1668(ra) # 80001dc8 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004454:	00004797          	auipc	a5,0x4
    80004458:	7fb7c783          	lbu	a5,2043(a5) # 80008c4f <_ZL9finishedA>
    8000445c:	fe0788e3          	beqz	a5,8000444c <_Z20Threads_CPP_API_testv+0x130>
    80004460:	00004797          	auipc	a5,0x4
    80004464:	7ee7c783          	lbu	a5,2030(a5) # 80008c4e <_ZL9finishedB>
    80004468:	fe0782e3          	beqz	a5,8000444c <_Z20Threads_CPP_API_testv+0x130>
    8000446c:	00004797          	auipc	a5,0x4
    80004470:	7e17c783          	lbu	a5,2017(a5) # 80008c4d <_ZL9finishedC>
    80004474:	fc078ce3          	beqz	a5,8000444c <_Z20Threads_CPP_API_testv+0x130>
    80004478:	00004797          	auipc	a5,0x4
    8000447c:	7d47c783          	lbu	a5,2004(a5) # 80008c4c <_ZL9finishedD>
    80004480:	fc0786e3          	beqz	a5,8000444c <_Z20Threads_CPP_API_testv+0x130>
    80004484:	fc040493          	addi	s1,s0,-64
    80004488:	0080006f          	j	80004490 <_Z20Threads_CPP_API_testv+0x174>
        Thread::dispatch();
    }

    for (auto thread: threads) {  printString("Obrisao\n"); delete thread; }
    8000448c:	00848493          	addi	s1,s1,8
    80004490:	fe040793          	addi	a5,s0,-32
    80004494:	02f48863          	beq	s1,a5,800044c4 <_Z20Threads_CPP_API_testv+0x1a8>
    80004498:	0004b903          	ld	s2,0(s1)
    8000449c:	00003517          	auipc	a0,0x3
    800044a0:	1d450513          	addi	a0,a0,468 # 80007670 <_ZTV12ConsumerSync+0x120>
    800044a4:	ffffe097          	auipc	ra,0xffffe
    800044a8:	fac080e7          	jalr	-84(ra) # 80002450 <_Z11printStringPKc>
    800044ac:	fe0900e3          	beqz	s2,8000448c <_Z20Threads_CPP_API_testv+0x170>
    800044b0:	00093783          	ld	a5,0(s2)
    800044b4:	0087b783          	ld	a5,8(a5)
    800044b8:	00090513          	mv	a0,s2
    800044bc:	000780e7          	jalr	a5
    800044c0:	fcdff06f          	j	8000448c <_Z20Threads_CPP_API_testv+0x170>
}
    800044c4:	03813083          	ld	ra,56(sp)
    800044c8:	03013403          	ld	s0,48(sp)
    800044cc:	02813483          	ld	s1,40(sp)
    800044d0:	02013903          	ld	s2,32(sp)
    800044d4:	04010113          	addi	sp,sp,64
    800044d8:	00008067          	ret

00000000800044dc <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800044dc:	ff010113          	addi	sp,sp,-16
    800044e0:	00113423          	sd	ra,8(sp)
    800044e4:	00813023          	sd	s0,0(sp)
    800044e8:	01010413          	addi	s0,sp,16
    virtual ~Thread() { thread_exit();}
    800044ec:	00003797          	auipc	a5,0x3
    800044f0:	ffc78793          	addi	a5,a5,-4 # 800074e8 <_ZTV6Thread+0x10>
    800044f4:	00f53023          	sd	a5,0(a0)
    800044f8:	ffffe097          	auipc	ra,0xffffe
    800044fc:	8f4080e7          	jalr	-1804(ra) # 80001dec <_Z11thread_exitv>
    80004500:	00813083          	ld	ra,8(sp)
    80004504:	00013403          	ld	s0,0(sp)
    80004508:	01010113          	addi	sp,sp,16
    8000450c:	00008067          	ret

0000000080004510 <_ZN7WorkerAD0Ev>:
    80004510:	fe010113          	addi	sp,sp,-32
    80004514:	00113c23          	sd	ra,24(sp)
    80004518:	00813823          	sd	s0,16(sp)
    8000451c:	00913423          	sd	s1,8(sp)
    80004520:	02010413          	addi	s0,sp,32
    80004524:	00050493          	mv	s1,a0
    80004528:	00003797          	auipc	a5,0x3
    8000452c:	fc078793          	addi	a5,a5,-64 # 800074e8 <_ZTV6Thread+0x10>
    80004530:	00f53023          	sd	a5,0(a0)
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	8b8080e7          	jalr	-1864(ra) # 80001dec <_Z11thread_exitv>
    8000453c:	00048513          	mv	a0,s1
    80004540:	ffffd097          	auipc	ra,0xffffd
    80004544:	d50080e7          	jalr	-688(ra) # 80001290 <_ZdlPv>
    80004548:	01813083          	ld	ra,24(sp)
    8000454c:	01013403          	ld	s0,16(sp)
    80004550:	00813483          	ld	s1,8(sp)
    80004554:	02010113          	addi	sp,sp,32
    80004558:	00008067          	ret

000000008000455c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    8000455c:	ff010113          	addi	sp,sp,-16
    80004560:	00113423          	sd	ra,8(sp)
    80004564:	00813023          	sd	s0,0(sp)
    80004568:	01010413          	addi	s0,sp,16
    8000456c:	00003797          	auipc	a5,0x3
    80004570:	f7c78793          	addi	a5,a5,-132 # 800074e8 <_ZTV6Thread+0x10>
    80004574:	00f53023          	sd	a5,0(a0)
    80004578:	ffffe097          	auipc	ra,0xffffe
    8000457c:	874080e7          	jalr	-1932(ra) # 80001dec <_Z11thread_exitv>
    80004580:	00813083          	ld	ra,8(sp)
    80004584:	00013403          	ld	s0,0(sp)
    80004588:	01010113          	addi	sp,sp,16
    8000458c:	00008067          	ret

0000000080004590 <_ZN7WorkerBD0Ev>:
    80004590:	fe010113          	addi	sp,sp,-32
    80004594:	00113c23          	sd	ra,24(sp)
    80004598:	00813823          	sd	s0,16(sp)
    8000459c:	00913423          	sd	s1,8(sp)
    800045a0:	02010413          	addi	s0,sp,32
    800045a4:	00050493          	mv	s1,a0
    800045a8:	00003797          	auipc	a5,0x3
    800045ac:	f4078793          	addi	a5,a5,-192 # 800074e8 <_ZTV6Thread+0x10>
    800045b0:	00f53023          	sd	a5,0(a0)
    800045b4:	ffffe097          	auipc	ra,0xffffe
    800045b8:	838080e7          	jalr	-1992(ra) # 80001dec <_Z11thread_exitv>
    800045bc:	00048513          	mv	a0,s1
    800045c0:	ffffd097          	auipc	ra,0xffffd
    800045c4:	cd0080e7          	jalr	-816(ra) # 80001290 <_ZdlPv>
    800045c8:	01813083          	ld	ra,24(sp)
    800045cc:	01013403          	ld	s0,16(sp)
    800045d0:	00813483          	ld	s1,8(sp)
    800045d4:	02010113          	addi	sp,sp,32
    800045d8:	00008067          	ret

00000000800045dc <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800045dc:	ff010113          	addi	sp,sp,-16
    800045e0:	00113423          	sd	ra,8(sp)
    800045e4:	00813023          	sd	s0,0(sp)
    800045e8:	01010413          	addi	s0,sp,16
    800045ec:	00003797          	auipc	a5,0x3
    800045f0:	efc78793          	addi	a5,a5,-260 # 800074e8 <_ZTV6Thread+0x10>
    800045f4:	00f53023          	sd	a5,0(a0)
    800045f8:	ffffd097          	auipc	ra,0xffffd
    800045fc:	7f4080e7          	jalr	2036(ra) # 80001dec <_Z11thread_exitv>
    80004600:	00813083          	ld	ra,8(sp)
    80004604:	00013403          	ld	s0,0(sp)
    80004608:	01010113          	addi	sp,sp,16
    8000460c:	00008067          	ret

0000000080004610 <_ZN7WorkerCD0Ev>:
    80004610:	fe010113          	addi	sp,sp,-32
    80004614:	00113c23          	sd	ra,24(sp)
    80004618:	00813823          	sd	s0,16(sp)
    8000461c:	00913423          	sd	s1,8(sp)
    80004620:	02010413          	addi	s0,sp,32
    80004624:	00050493          	mv	s1,a0
    80004628:	00003797          	auipc	a5,0x3
    8000462c:	ec078793          	addi	a5,a5,-320 # 800074e8 <_ZTV6Thread+0x10>
    80004630:	00f53023          	sd	a5,0(a0)
    80004634:	ffffd097          	auipc	ra,0xffffd
    80004638:	7b8080e7          	jalr	1976(ra) # 80001dec <_Z11thread_exitv>
    8000463c:	00048513          	mv	a0,s1
    80004640:	ffffd097          	auipc	ra,0xffffd
    80004644:	c50080e7          	jalr	-944(ra) # 80001290 <_ZdlPv>
    80004648:	01813083          	ld	ra,24(sp)
    8000464c:	01013403          	ld	s0,16(sp)
    80004650:	00813483          	ld	s1,8(sp)
    80004654:	02010113          	addi	sp,sp,32
    80004658:	00008067          	ret

000000008000465c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    8000465c:	ff010113          	addi	sp,sp,-16
    80004660:	00113423          	sd	ra,8(sp)
    80004664:	00813023          	sd	s0,0(sp)
    80004668:	01010413          	addi	s0,sp,16
    8000466c:	00003797          	auipc	a5,0x3
    80004670:	e7c78793          	addi	a5,a5,-388 # 800074e8 <_ZTV6Thread+0x10>
    80004674:	00f53023          	sd	a5,0(a0)
    80004678:	ffffd097          	auipc	ra,0xffffd
    8000467c:	774080e7          	jalr	1908(ra) # 80001dec <_Z11thread_exitv>
    80004680:	00813083          	ld	ra,8(sp)
    80004684:	00013403          	ld	s0,0(sp)
    80004688:	01010113          	addi	sp,sp,16
    8000468c:	00008067          	ret

0000000080004690 <_ZN7WorkerDD0Ev>:
    80004690:	fe010113          	addi	sp,sp,-32
    80004694:	00113c23          	sd	ra,24(sp)
    80004698:	00813823          	sd	s0,16(sp)
    8000469c:	00913423          	sd	s1,8(sp)
    800046a0:	02010413          	addi	s0,sp,32
    800046a4:	00050493          	mv	s1,a0
    800046a8:	00003797          	auipc	a5,0x3
    800046ac:	e4078793          	addi	a5,a5,-448 # 800074e8 <_ZTV6Thread+0x10>
    800046b0:	00f53023          	sd	a5,0(a0)
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	738080e7          	jalr	1848(ra) # 80001dec <_Z11thread_exitv>
    800046bc:	00048513          	mv	a0,s1
    800046c0:	ffffd097          	auipc	ra,0xffffd
    800046c4:	bd0080e7          	jalr	-1072(ra) # 80001290 <_ZdlPv>
    800046c8:	01813083          	ld	ra,24(sp)
    800046cc:	01013403          	ld	s0,16(sp)
    800046d0:	00813483          	ld	s1,8(sp)
    800046d4:	02010113          	addi	sp,sp,32
    800046d8:	00008067          	ret

00000000800046dc <_ZN7WorkerA3runEv>:
    void run() override {
    800046dc:	ff010113          	addi	sp,sp,-16
    800046e0:	00113423          	sd	ra,8(sp)
    800046e4:	00813023          	sd	s0,0(sp)
    800046e8:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    800046ec:	00000593          	li	a1,0
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	7c4080e7          	jalr	1988(ra) # 80003eb4 <_ZN7WorkerA11workerBodyAEPv>
    }
    800046f8:	00813083          	ld	ra,8(sp)
    800046fc:	00013403          	ld	s0,0(sp)
    80004700:	01010113          	addi	sp,sp,16
    80004704:	00008067          	ret

0000000080004708 <_ZN7WorkerB3runEv>:
    void run() override {
    80004708:	ff010113          	addi	sp,sp,-16
    8000470c:	00113423          	sd	ra,8(sp)
    80004710:	00813023          	sd	s0,0(sp)
    80004714:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80004718:	00000593          	li	a1,0
    8000471c:	00000097          	auipc	ra,0x0
    80004720:	864080e7          	jalr	-1948(ra) # 80003f80 <_ZN7WorkerB11workerBodyBEPv>
    }
    80004724:	00813083          	ld	ra,8(sp)
    80004728:	00013403          	ld	s0,0(sp)
    8000472c:	01010113          	addi	sp,sp,16
    80004730:	00008067          	ret

0000000080004734 <_ZN7WorkerC3runEv>:
    void run() override {
    80004734:	ff010113          	addi	sp,sp,-16
    80004738:	00113423          	sd	ra,8(sp)
    8000473c:	00813023          	sd	s0,0(sp)
    80004740:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80004744:	00000593          	li	a1,0
    80004748:	00000097          	auipc	ra,0x0
    8000474c:	90c080e7          	jalr	-1780(ra) # 80004054 <_ZN7WorkerC11workerBodyCEPv>
    }
    80004750:	00813083          	ld	ra,8(sp)
    80004754:	00013403          	ld	s0,0(sp)
    80004758:	01010113          	addi	sp,sp,16
    8000475c:	00008067          	ret

0000000080004760 <_ZN7WorkerD3runEv>:
    void run() override {
    80004760:	ff010113          	addi	sp,sp,-16
    80004764:	00113423          	sd	ra,8(sp)
    80004768:	00813023          	sd	s0,0(sp)
    8000476c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80004770:	00000593          	li	a1,0
    80004774:	00000097          	auipc	ra,0x0
    80004778:	a60080e7          	jalr	-1440(ra) # 800041d4 <_ZN7WorkerD11workerBodyDEPv>
    }
    8000477c:	00813083          	ld	ra,8(sp)
    80004780:	00013403          	ld	s0,0(sp)
    80004784:	01010113          	addi	sp,sp,16
    80004788:	00008067          	ret

000000008000478c <start>:
    8000478c:	ff010113          	addi	sp,sp,-16
    80004790:	00813423          	sd	s0,8(sp)
    80004794:	01010413          	addi	s0,sp,16
    80004798:	300027f3          	csrr	a5,mstatus
    8000479c:	ffffe737          	lui	a4,0xffffe
    800047a0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff48ff>
    800047a4:	00e7f7b3          	and	a5,a5,a4
    800047a8:	00001737          	lui	a4,0x1
    800047ac:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800047b0:	00e7e7b3          	or	a5,a5,a4
    800047b4:	30079073          	csrw	mstatus,a5
    800047b8:	00000797          	auipc	a5,0x0
    800047bc:	16078793          	addi	a5,a5,352 # 80004918 <system_main>
    800047c0:	34179073          	csrw	mepc,a5
    800047c4:	00000793          	li	a5,0
    800047c8:	18079073          	csrw	satp,a5
    800047cc:	000107b7          	lui	a5,0x10
    800047d0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800047d4:	30279073          	csrw	medeleg,a5
    800047d8:	30379073          	csrw	mideleg,a5
    800047dc:	104027f3          	csrr	a5,sie
    800047e0:	2227e793          	ori	a5,a5,546
    800047e4:	10479073          	csrw	sie,a5
    800047e8:	fff00793          	li	a5,-1
    800047ec:	00a7d793          	srli	a5,a5,0xa
    800047f0:	3b079073          	csrw	pmpaddr0,a5
    800047f4:	00f00793          	li	a5,15
    800047f8:	3a079073          	csrw	pmpcfg0,a5
    800047fc:	f14027f3          	csrr	a5,mhartid
    80004800:	0200c737          	lui	a4,0x200c
    80004804:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004808:	0007869b          	sext.w	a3,a5
    8000480c:	00269713          	slli	a4,a3,0x2
    80004810:	000f4637          	lui	a2,0xf4
    80004814:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004818:	00d70733          	add	a4,a4,a3
    8000481c:	0037979b          	slliw	a5,a5,0x3
    80004820:	020046b7          	lui	a3,0x2004
    80004824:	00d787b3          	add	a5,a5,a3
    80004828:	00c585b3          	add	a1,a1,a2
    8000482c:	00371693          	slli	a3,a4,0x3
    80004830:	00004717          	auipc	a4,0x4
    80004834:	46070713          	addi	a4,a4,1120 # 80008c90 <timer_scratch>
    80004838:	00b7b023          	sd	a1,0(a5)
    8000483c:	00d70733          	add	a4,a4,a3
    80004840:	00f73c23          	sd	a5,24(a4)
    80004844:	02c73023          	sd	a2,32(a4)
    80004848:	34071073          	csrw	mscratch,a4
    8000484c:	00000797          	auipc	a5,0x0
    80004850:	6e478793          	addi	a5,a5,1764 # 80004f30 <timervec>
    80004854:	30579073          	csrw	mtvec,a5
    80004858:	300027f3          	csrr	a5,mstatus
    8000485c:	0087e793          	ori	a5,a5,8
    80004860:	30079073          	csrw	mstatus,a5
    80004864:	304027f3          	csrr	a5,mie
    80004868:	0807e793          	ori	a5,a5,128
    8000486c:	30479073          	csrw	mie,a5
    80004870:	f14027f3          	csrr	a5,mhartid
    80004874:	0007879b          	sext.w	a5,a5
    80004878:	00078213          	mv	tp,a5
    8000487c:	30200073          	mret
    80004880:	00813403          	ld	s0,8(sp)
    80004884:	01010113          	addi	sp,sp,16
    80004888:	00008067          	ret

000000008000488c <timerinit>:
    8000488c:	ff010113          	addi	sp,sp,-16
    80004890:	00813423          	sd	s0,8(sp)
    80004894:	01010413          	addi	s0,sp,16
    80004898:	f14027f3          	csrr	a5,mhartid
    8000489c:	0200c737          	lui	a4,0x200c
    800048a0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800048a4:	0007869b          	sext.w	a3,a5
    800048a8:	00269713          	slli	a4,a3,0x2
    800048ac:	000f4637          	lui	a2,0xf4
    800048b0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800048b4:	00d70733          	add	a4,a4,a3
    800048b8:	0037979b          	slliw	a5,a5,0x3
    800048bc:	020046b7          	lui	a3,0x2004
    800048c0:	00d787b3          	add	a5,a5,a3
    800048c4:	00c585b3          	add	a1,a1,a2
    800048c8:	00371693          	slli	a3,a4,0x3
    800048cc:	00004717          	auipc	a4,0x4
    800048d0:	3c470713          	addi	a4,a4,964 # 80008c90 <timer_scratch>
    800048d4:	00b7b023          	sd	a1,0(a5)
    800048d8:	00d70733          	add	a4,a4,a3
    800048dc:	00f73c23          	sd	a5,24(a4)
    800048e0:	02c73023          	sd	a2,32(a4)
    800048e4:	34071073          	csrw	mscratch,a4
    800048e8:	00000797          	auipc	a5,0x0
    800048ec:	64878793          	addi	a5,a5,1608 # 80004f30 <timervec>
    800048f0:	30579073          	csrw	mtvec,a5
    800048f4:	300027f3          	csrr	a5,mstatus
    800048f8:	0087e793          	ori	a5,a5,8
    800048fc:	30079073          	csrw	mstatus,a5
    80004900:	304027f3          	csrr	a5,mie
    80004904:	0807e793          	ori	a5,a5,128
    80004908:	30479073          	csrw	mie,a5
    8000490c:	00813403          	ld	s0,8(sp)
    80004910:	01010113          	addi	sp,sp,16
    80004914:	00008067          	ret

0000000080004918 <system_main>:
    80004918:	fe010113          	addi	sp,sp,-32
    8000491c:	00813823          	sd	s0,16(sp)
    80004920:	00913423          	sd	s1,8(sp)
    80004924:	00113c23          	sd	ra,24(sp)
    80004928:	02010413          	addi	s0,sp,32
    8000492c:	00000097          	auipc	ra,0x0
    80004930:	0c4080e7          	jalr	196(ra) # 800049f0 <cpuid>
    80004934:	00004497          	auipc	s1,0x4
    80004938:	31c48493          	addi	s1,s1,796 # 80008c50 <started>
    8000493c:	02050263          	beqz	a0,80004960 <system_main+0x48>
    80004940:	0004a783          	lw	a5,0(s1)
    80004944:	0007879b          	sext.w	a5,a5
    80004948:	fe078ce3          	beqz	a5,80004940 <system_main+0x28>
    8000494c:	0ff0000f          	fence
    80004950:	00003517          	auipc	a0,0x3
    80004954:	e0050513          	addi	a0,a0,-512 # 80007750 <_ZTV7WorkerD+0x58>
    80004958:	00001097          	auipc	ra,0x1
    8000495c:	a74080e7          	jalr	-1420(ra) # 800053cc <panic>
    80004960:	00001097          	auipc	ra,0x1
    80004964:	9c8080e7          	jalr	-1592(ra) # 80005328 <consoleinit>
    80004968:	00001097          	auipc	ra,0x1
    8000496c:	154080e7          	jalr	340(ra) # 80005abc <printfinit>
    80004970:	00003517          	auipc	a0,0x3
    80004974:	96050513          	addi	a0,a0,-1696 # 800072d0 <kvmincrease+0x740>
    80004978:	00001097          	auipc	ra,0x1
    8000497c:	ab0080e7          	jalr	-1360(ra) # 80005428 <__printf>
    80004980:	00003517          	auipc	a0,0x3
    80004984:	da050513          	addi	a0,a0,-608 # 80007720 <_ZTV7WorkerD+0x28>
    80004988:	00001097          	auipc	ra,0x1
    8000498c:	aa0080e7          	jalr	-1376(ra) # 80005428 <__printf>
    80004990:	00003517          	auipc	a0,0x3
    80004994:	94050513          	addi	a0,a0,-1728 # 800072d0 <kvmincrease+0x740>
    80004998:	00001097          	auipc	ra,0x1
    8000499c:	a90080e7          	jalr	-1392(ra) # 80005428 <__printf>
    800049a0:	00001097          	auipc	ra,0x1
    800049a4:	4a8080e7          	jalr	1192(ra) # 80005e48 <kinit>
    800049a8:	00000097          	auipc	ra,0x0
    800049ac:	148080e7          	jalr	328(ra) # 80004af0 <trapinit>
    800049b0:	00000097          	auipc	ra,0x0
    800049b4:	16c080e7          	jalr	364(ra) # 80004b1c <trapinithart>
    800049b8:	00000097          	auipc	ra,0x0
    800049bc:	5b8080e7          	jalr	1464(ra) # 80004f70 <plicinit>
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	5d8080e7          	jalr	1496(ra) # 80004f98 <plicinithart>
    800049c8:	00000097          	auipc	ra,0x0
    800049cc:	078080e7          	jalr	120(ra) # 80004a40 <userinit>
    800049d0:	0ff0000f          	fence
    800049d4:	00100793          	li	a5,1
    800049d8:	00003517          	auipc	a0,0x3
    800049dc:	d6050513          	addi	a0,a0,-672 # 80007738 <_ZTV7WorkerD+0x40>
    800049e0:	00f4a023          	sw	a5,0(s1)
    800049e4:	00001097          	auipc	ra,0x1
    800049e8:	a44080e7          	jalr	-1468(ra) # 80005428 <__printf>
    800049ec:	0000006f          	j	800049ec <system_main+0xd4>

00000000800049f0 <cpuid>:
    800049f0:	ff010113          	addi	sp,sp,-16
    800049f4:	00813423          	sd	s0,8(sp)
    800049f8:	01010413          	addi	s0,sp,16
    800049fc:	00020513          	mv	a0,tp
    80004a00:	00813403          	ld	s0,8(sp)
    80004a04:	0005051b          	sext.w	a0,a0
    80004a08:	01010113          	addi	sp,sp,16
    80004a0c:	00008067          	ret

0000000080004a10 <mycpu>:
    80004a10:	ff010113          	addi	sp,sp,-16
    80004a14:	00813423          	sd	s0,8(sp)
    80004a18:	01010413          	addi	s0,sp,16
    80004a1c:	00020793          	mv	a5,tp
    80004a20:	00813403          	ld	s0,8(sp)
    80004a24:	0007879b          	sext.w	a5,a5
    80004a28:	00779793          	slli	a5,a5,0x7
    80004a2c:	00005517          	auipc	a0,0x5
    80004a30:	29450513          	addi	a0,a0,660 # 80009cc0 <cpus>
    80004a34:	00f50533          	add	a0,a0,a5
    80004a38:	01010113          	addi	sp,sp,16
    80004a3c:	00008067          	ret

0000000080004a40 <userinit>:
    80004a40:	ff010113          	addi	sp,sp,-16
    80004a44:	00813423          	sd	s0,8(sp)
    80004a48:	01010413          	addi	s0,sp,16
    80004a4c:	00813403          	ld	s0,8(sp)
    80004a50:	01010113          	addi	sp,sp,16
    80004a54:	ffffd317          	auipc	t1,0xffffd
    80004a58:	2bc30067          	jr	700(t1) # 80001d10 <main>

0000000080004a5c <either_copyout>:
    80004a5c:	ff010113          	addi	sp,sp,-16
    80004a60:	00813023          	sd	s0,0(sp)
    80004a64:	00113423          	sd	ra,8(sp)
    80004a68:	01010413          	addi	s0,sp,16
    80004a6c:	02051663          	bnez	a0,80004a98 <either_copyout+0x3c>
    80004a70:	00058513          	mv	a0,a1
    80004a74:	00060593          	mv	a1,a2
    80004a78:	0006861b          	sext.w	a2,a3
    80004a7c:	00002097          	auipc	ra,0x2
    80004a80:	c58080e7          	jalr	-936(ra) # 800066d4 <__memmove>
    80004a84:	00813083          	ld	ra,8(sp)
    80004a88:	00013403          	ld	s0,0(sp)
    80004a8c:	00000513          	li	a0,0
    80004a90:	01010113          	addi	sp,sp,16
    80004a94:	00008067          	ret
    80004a98:	00003517          	auipc	a0,0x3
    80004a9c:	ce050513          	addi	a0,a0,-800 # 80007778 <_ZTV7WorkerD+0x80>
    80004aa0:	00001097          	auipc	ra,0x1
    80004aa4:	92c080e7          	jalr	-1748(ra) # 800053cc <panic>

0000000080004aa8 <either_copyin>:
    80004aa8:	ff010113          	addi	sp,sp,-16
    80004aac:	00813023          	sd	s0,0(sp)
    80004ab0:	00113423          	sd	ra,8(sp)
    80004ab4:	01010413          	addi	s0,sp,16
    80004ab8:	02059463          	bnez	a1,80004ae0 <either_copyin+0x38>
    80004abc:	00060593          	mv	a1,a2
    80004ac0:	0006861b          	sext.w	a2,a3
    80004ac4:	00002097          	auipc	ra,0x2
    80004ac8:	c10080e7          	jalr	-1008(ra) # 800066d4 <__memmove>
    80004acc:	00813083          	ld	ra,8(sp)
    80004ad0:	00013403          	ld	s0,0(sp)
    80004ad4:	00000513          	li	a0,0
    80004ad8:	01010113          	addi	sp,sp,16
    80004adc:	00008067          	ret
    80004ae0:	00003517          	auipc	a0,0x3
    80004ae4:	cc050513          	addi	a0,a0,-832 # 800077a0 <_ZTV7WorkerD+0xa8>
    80004ae8:	00001097          	auipc	ra,0x1
    80004aec:	8e4080e7          	jalr	-1820(ra) # 800053cc <panic>

0000000080004af0 <trapinit>:
    80004af0:	ff010113          	addi	sp,sp,-16
    80004af4:	00813423          	sd	s0,8(sp)
    80004af8:	01010413          	addi	s0,sp,16
    80004afc:	00813403          	ld	s0,8(sp)
    80004b00:	00003597          	auipc	a1,0x3
    80004b04:	cc858593          	addi	a1,a1,-824 # 800077c8 <_ZTV7WorkerD+0xd0>
    80004b08:	00005517          	auipc	a0,0x5
    80004b0c:	23850513          	addi	a0,a0,568 # 80009d40 <tickslock>
    80004b10:	01010113          	addi	sp,sp,16
    80004b14:	00001317          	auipc	t1,0x1
    80004b18:	5c430067          	jr	1476(t1) # 800060d8 <initlock>

0000000080004b1c <trapinithart>:
    80004b1c:	ff010113          	addi	sp,sp,-16
    80004b20:	00813423          	sd	s0,8(sp)
    80004b24:	01010413          	addi	s0,sp,16
    80004b28:	00000797          	auipc	a5,0x0
    80004b2c:	2f878793          	addi	a5,a5,760 # 80004e20 <kernelvec>
    80004b30:	10579073          	csrw	stvec,a5
    80004b34:	00813403          	ld	s0,8(sp)
    80004b38:	01010113          	addi	sp,sp,16
    80004b3c:	00008067          	ret

0000000080004b40 <usertrap>:
    80004b40:	ff010113          	addi	sp,sp,-16
    80004b44:	00813423          	sd	s0,8(sp)
    80004b48:	01010413          	addi	s0,sp,16
    80004b4c:	00813403          	ld	s0,8(sp)
    80004b50:	01010113          	addi	sp,sp,16
    80004b54:	00008067          	ret

0000000080004b58 <usertrapret>:
    80004b58:	ff010113          	addi	sp,sp,-16
    80004b5c:	00813423          	sd	s0,8(sp)
    80004b60:	01010413          	addi	s0,sp,16
    80004b64:	00813403          	ld	s0,8(sp)
    80004b68:	01010113          	addi	sp,sp,16
    80004b6c:	00008067          	ret

0000000080004b70 <kerneltrap>:
    80004b70:	fe010113          	addi	sp,sp,-32
    80004b74:	00813823          	sd	s0,16(sp)
    80004b78:	00113c23          	sd	ra,24(sp)
    80004b7c:	00913423          	sd	s1,8(sp)
    80004b80:	02010413          	addi	s0,sp,32
    80004b84:	142025f3          	csrr	a1,scause
    80004b88:	100027f3          	csrr	a5,sstatus
    80004b8c:	0027f793          	andi	a5,a5,2
    80004b90:	10079c63          	bnez	a5,80004ca8 <kerneltrap+0x138>
    80004b94:	142027f3          	csrr	a5,scause
    80004b98:	0207ce63          	bltz	a5,80004bd4 <kerneltrap+0x64>
    80004b9c:	00003517          	auipc	a0,0x3
    80004ba0:	c7450513          	addi	a0,a0,-908 # 80007810 <_ZTV7WorkerD+0x118>
    80004ba4:	00001097          	auipc	ra,0x1
    80004ba8:	884080e7          	jalr	-1916(ra) # 80005428 <__printf>
    80004bac:	141025f3          	csrr	a1,sepc
    80004bb0:	14302673          	csrr	a2,stval
    80004bb4:	00003517          	auipc	a0,0x3
    80004bb8:	c6c50513          	addi	a0,a0,-916 # 80007820 <_ZTV7WorkerD+0x128>
    80004bbc:	00001097          	auipc	ra,0x1
    80004bc0:	86c080e7          	jalr	-1940(ra) # 80005428 <__printf>
    80004bc4:	00003517          	auipc	a0,0x3
    80004bc8:	c7450513          	addi	a0,a0,-908 # 80007838 <_ZTV7WorkerD+0x140>
    80004bcc:	00001097          	auipc	ra,0x1
    80004bd0:	800080e7          	jalr	-2048(ra) # 800053cc <panic>
    80004bd4:	0ff7f713          	andi	a4,a5,255
    80004bd8:	00900693          	li	a3,9
    80004bdc:	04d70063          	beq	a4,a3,80004c1c <kerneltrap+0xac>
    80004be0:	fff00713          	li	a4,-1
    80004be4:	03f71713          	slli	a4,a4,0x3f
    80004be8:	00170713          	addi	a4,a4,1
    80004bec:	fae798e3          	bne	a5,a4,80004b9c <kerneltrap+0x2c>
    80004bf0:	00000097          	auipc	ra,0x0
    80004bf4:	e00080e7          	jalr	-512(ra) # 800049f0 <cpuid>
    80004bf8:	06050663          	beqz	a0,80004c64 <kerneltrap+0xf4>
    80004bfc:	144027f3          	csrr	a5,sip
    80004c00:	ffd7f793          	andi	a5,a5,-3
    80004c04:	14479073          	csrw	sip,a5
    80004c08:	01813083          	ld	ra,24(sp)
    80004c0c:	01013403          	ld	s0,16(sp)
    80004c10:	00813483          	ld	s1,8(sp)
    80004c14:	02010113          	addi	sp,sp,32
    80004c18:	00008067          	ret
    80004c1c:	00000097          	auipc	ra,0x0
    80004c20:	3c8080e7          	jalr	968(ra) # 80004fe4 <plic_claim>
    80004c24:	00a00793          	li	a5,10
    80004c28:	00050493          	mv	s1,a0
    80004c2c:	06f50863          	beq	a0,a5,80004c9c <kerneltrap+0x12c>
    80004c30:	fc050ce3          	beqz	a0,80004c08 <kerneltrap+0x98>
    80004c34:	00050593          	mv	a1,a0
    80004c38:	00003517          	auipc	a0,0x3
    80004c3c:	bb850513          	addi	a0,a0,-1096 # 800077f0 <_ZTV7WorkerD+0xf8>
    80004c40:	00000097          	auipc	ra,0x0
    80004c44:	7e8080e7          	jalr	2024(ra) # 80005428 <__printf>
    80004c48:	01013403          	ld	s0,16(sp)
    80004c4c:	01813083          	ld	ra,24(sp)
    80004c50:	00048513          	mv	a0,s1
    80004c54:	00813483          	ld	s1,8(sp)
    80004c58:	02010113          	addi	sp,sp,32
    80004c5c:	00000317          	auipc	t1,0x0
    80004c60:	3c030067          	jr	960(t1) # 8000501c <plic_complete>
    80004c64:	00005517          	auipc	a0,0x5
    80004c68:	0dc50513          	addi	a0,a0,220 # 80009d40 <tickslock>
    80004c6c:	00001097          	auipc	ra,0x1
    80004c70:	490080e7          	jalr	1168(ra) # 800060fc <acquire>
    80004c74:	00004717          	auipc	a4,0x4
    80004c78:	fe070713          	addi	a4,a4,-32 # 80008c54 <ticks>
    80004c7c:	00072783          	lw	a5,0(a4)
    80004c80:	00005517          	auipc	a0,0x5
    80004c84:	0c050513          	addi	a0,a0,192 # 80009d40 <tickslock>
    80004c88:	0017879b          	addiw	a5,a5,1
    80004c8c:	00f72023          	sw	a5,0(a4)
    80004c90:	00001097          	auipc	ra,0x1
    80004c94:	538080e7          	jalr	1336(ra) # 800061c8 <release>
    80004c98:	f65ff06f          	j	80004bfc <kerneltrap+0x8c>
    80004c9c:	00001097          	auipc	ra,0x1
    80004ca0:	094080e7          	jalr	148(ra) # 80005d30 <uartintr>
    80004ca4:	fa5ff06f          	j	80004c48 <kerneltrap+0xd8>
    80004ca8:	00003517          	auipc	a0,0x3
    80004cac:	b2850513          	addi	a0,a0,-1240 # 800077d0 <_ZTV7WorkerD+0xd8>
    80004cb0:	00000097          	auipc	ra,0x0
    80004cb4:	71c080e7          	jalr	1820(ra) # 800053cc <panic>

0000000080004cb8 <clockintr>:
    80004cb8:	fe010113          	addi	sp,sp,-32
    80004cbc:	00813823          	sd	s0,16(sp)
    80004cc0:	00913423          	sd	s1,8(sp)
    80004cc4:	00113c23          	sd	ra,24(sp)
    80004cc8:	02010413          	addi	s0,sp,32
    80004ccc:	00005497          	auipc	s1,0x5
    80004cd0:	07448493          	addi	s1,s1,116 # 80009d40 <tickslock>
    80004cd4:	00048513          	mv	a0,s1
    80004cd8:	00001097          	auipc	ra,0x1
    80004cdc:	424080e7          	jalr	1060(ra) # 800060fc <acquire>
    80004ce0:	00004717          	auipc	a4,0x4
    80004ce4:	f7470713          	addi	a4,a4,-140 # 80008c54 <ticks>
    80004ce8:	00072783          	lw	a5,0(a4)
    80004cec:	01013403          	ld	s0,16(sp)
    80004cf0:	01813083          	ld	ra,24(sp)
    80004cf4:	00048513          	mv	a0,s1
    80004cf8:	0017879b          	addiw	a5,a5,1
    80004cfc:	00813483          	ld	s1,8(sp)
    80004d00:	00f72023          	sw	a5,0(a4)
    80004d04:	02010113          	addi	sp,sp,32
    80004d08:	00001317          	auipc	t1,0x1
    80004d0c:	4c030067          	jr	1216(t1) # 800061c8 <release>

0000000080004d10 <devintr>:
    80004d10:	142027f3          	csrr	a5,scause
    80004d14:	00000513          	li	a0,0
    80004d18:	0007c463          	bltz	a5,80004d20 <devintr+0x10>
    80004d1c:	00008067          	ret
    80004d20:	fe010113          	addi	sp,sp,-32
    80004d24:	00813823          	sd	s0,16(sp)
    80004d28:	00113c23          	sd	ra,24(sp)
    80004d2c:	00913423          	sd	s1,8(sp)
    80004d30:	02010413          	addi	s0,sp,32
    80004d34:	0ff7f713          	andi	a4,a5,255
    80004d38:	00900693          	li	a3,9
    80004d3c:	04d70c63          	beq	a4,a3,80004d94 <devintr+0x84>
    80004d40:	fff00713          	li	a4,-1
    80004d44:	03f71713          	slli	a4,a4,0x3f
    80004d48:	00170713          	addi	a4,a4,1
    80004d4c:	00e78c63          	beq	a5,a4,80004d64 <devintr+0x54>
    80004d50:	01813083          	ld	ra,24(sp)
    80004d54:	01013403          	ld	s0,16(sp)
    80004d58:	00813483          	ld	s1,8(sp)
    80004d5c:	02010113          	addi	sp,sp,32
    80004d60:	00008067          	ret
    80004d64:	00000097          	auipc	ra,0x0
    80004d68:	c8c080e7          	jalr	-884(ra) # 800049f0 <cpuid>
    80004d6c:	06050663          	beqz	a0,80004dd8 <devintr+0xc8>
    80004d70:	144027f3          	csrr	a5,sip
    80004d74:	ffd7f793          	andi	a5,a5,-3
    80004d78:	14479073          	csrw	sip,a5
    80004d7c:	01813083          	ld	ra,24(sp)
    80004d80:	01013403          	ld	s0,16(sp)
    80004d84:	00813483          	ld	s1,8(sp)
    80004d88:	00200513          	li	a0,2
    80004d8c:	02010113          	addi	sp,sp,32
    80004d90:	00008067          	ret
    80004d94:	00000097          	auipc	ra,0x0
    80004d98:	250080e7          	jalr	592(ra) # 80004fe4 <plic_claim>
    80004d9c:	00a00793          	li	a5,10
    80004da0:	00050493          	mv	s1,a0
    80004da4:	06f50663          	beq	a0,a5,80004e10 <devintr+0x100>
    80004da8:	00100513          	li	a0,1
    80004dac:	fa0482e3          	beqz	s1,80004d50 <devintr+0x40>
    80004db0:	00048593          	mv	a1,s1
    80004db4:	00003517          	auipc	a0,0x3
    80004db8:	a3c50513          	addi	a0,a0,-1476 # 800077f0 <_ZTV7WorkerD+0xf8>
    80004dbc:	00000097          	auipc	ra,0x0
    80004dc0:	66c080e7          	jalr	1644(ra) # 80005428 <__printf>
    80004dc4:	00048513          	mv	a0,s1
    80004dc8:	00000097          	auipc	ra,0x0
    80004dcc:	254080e7          	jalr	596(ra) # 8000501c <plic_complete>
    80004dd0:	00100513          	li	a0,1
    80004dd4:	f7dff06f          	j	80004d50 <devintr+0x40>
    80004dd8:	00005517          	auipc	a0,0x5
    80004ddc:	f6850513          	addi	a0,a0,-152 # 80009d40 <tickslock>
    80004de0:	00001097          	auipc	ra,0x1
    80004de4:	31c080e7          	jalr	796(ra) # 800060fc <acquire>
    80004de8:	00004717          	auipc	a4,0x4
    80004dec:	e6c70713          	addi	a4,a4,-404 # 80008c54 <ticks>
    80004df0:	00072783          	lw	a5,0(a4)
    80004df4:	00005517          	auipc	a0,0x5
    80004df8:	f4c50513          	addi	a0,a0,-180 # 80009d40 <tickslock>
    80004dfc:	0017879b          	addiw	a5,a5,1
    80004e00:	00f72023          	sw	a5,0(a4)
    80004e04:	00001097          	auipc	ra,0x1
    80004e08:	3c4080e7          	jalr	964(ra) # 800061c8 <release>
    80004e0c:	f65ff06f          	j	80004d70 <devintr+0x60>
    80004e10:	00001097          	auipc	ra,0x1
    80004e14:	f20080e7          	jalr	-224(ra) # 80005d30 <uartintr>
    80004e18:	fadff06f          	j	80004dc4 <devintr+0xb4>
    80004e1c:	0000                	unimp
	...

0000000080004e20 <kernelvec>:
    80004e20:	f0010113          	addi	sp,sp,-256
    80004e24:	00113023          	sd	ra,0(sp)
    80004e28:	00213423          	sd	sp,8(sp)
    80004e2c:	00313823          	sd	gp,16(sp)
    80004e30:	00413c23          	sd	tp,24(sp)
    80004e34:	02513023          	sd	t0,32(sp)
    80004e38:	02613423          	sd	t1,40(sp)
    80004e3c:	02713823          	sd	t2,48(sp)
    80004e40:	02813c23          	sd	s0,56(sp)
    80004e44:	04913023          	sd	s1,64(sp)
    80004e48:	04a13423          	sd	a0,72(sp)
    80004e4c:	04b13823          	sd	a1,80(sp)
    80004e50:	04c13c23          	sd	a2,88(sp)
    80004e54:	06d13023          	sd	a3,96(sp)
    80004e58:	06e13423          	sd	a4,104(sp)
    80004e5c:	06f13823          	sd	a5,112(sp)
    80004e60:	07013c23          	sd	a6,120(sp)
    80004e64:	09113023          	sd	a7,128(sp)
    80004e68:	09213423          	sd	s2,136(sp)
    80004e6c:	09313823          	sd	s3,144(sp)
    80004e70:	09413c23          	sd	s4,152(sp)
    80004e74:	0b513023          	sd	s5,160(sp)
    80004e78:	0b613423          	sd	s6,168(sp)
    80004e7c:	0b713823          	sd	s7,176(sp)
    80004e80:	0b813c23          	sd	s8,184(sp)
    80004e84:	0d913023          	sd	s9,192(sp)
    80004e88:	0da13423          	sd	s10,200(sp)
    80004e8c:	0db13823          	sd	s11,208(sp)
    80004e90:	0dc13c23          	sd	t3,216(sp)
    80004e94:	0fd13023          	sd	t4,224(sp)
    80004e98:	0fe13423          	sd	t5,232(sp)
    80004e9c:	0ff13823          	sd	t6,240(sp)
    80004ea0:	cd1ff0ef          	jal	ra,80004b70 <kerneltrap>
    80004ea4:	00013083          	ld	ra,0(sp)
    80004ea8:	00813103          	ld	sp,8(sp)
    80004eac:	01013183          	ld	gp,16(sp)
    80004eb0:	02013283          	ld	t0,32(sp)
    80004eb4:	02813303          	ld	t1,40(sp)
    80004eb8:	03013383          	ld	t2,48(sp)
    80004ebc:	03813403          	ld	s0,56(sp)
    80004ec0:	04013483          	ld	s1,64(sp)
    80004ec4:	04813503          	ld	a0,72(sp)
    80004ec8:	05013583          	ld	a1,80(sp)
    80004ecc:	05813603          	ld	a2,88(sp)
    80004ed0:	06013683          	ld	a3,96(sp)
    80004ed4:	06813703          	ld	a4,104(sp)
    80004ed8:	07013783          	ld	a5,112(sp)
    80004edc:	07813803          	ld	a6,120(sp)
    80004ee0:	08013883          	ld	a7,128(sp)
    80004ee4:	08813903          	ld	s2,136(sp)
    80004ee8:	09013983          	ld	s3,144(sp)
    80004eec:	09813a03          	ld	s4,152(sp)
    80004ef0:	0a013a83          	ld	s5,160(sp)
    80004ef4:	0a813b03          	ld	s6,168(sp)
    80004ef8:	0b013b83          	ld	s7,176(sp)
    80004efc:	0b813c03          	ld	s8,184(sp)
    80004f00:	0c013c83          	ld	s9,192(sp)
    80004f04:	0c813d03          	ld	s10,200(sp)
    80004f08:	0d013d83          	ld	s11,208(sp)
    80004f0c:	0d813e03          	ld	t3,216(sp)
    80004f10:	0e013e83          	ld	t4,224(sp)
    80004f14:	0e813f03          	ld	t5,232(sp)
    80004f18:	0f013f83          	ld	t6,240(sp)
    80004f1c:	10010113          	addi	sp,sp,256
    80004f20:	10200073          	sret
    80004f24:	00000013          	nop
    80004f28:	00000013          	nop
    80004f2c:	00000013          	nop

0000000080004f30 <timervec>:
    80004f30:	34051573          	csrrw	a0,mscratch,a0
    80004f34:	00b53023          	sd	a1,0(a0)
    80004f38:	00c53423          	sd	a2,8(a0)
    80004f3c:	00d53823          	sd	a3,16(a0)
    80004f40:	01853583          	ld	a1,24(a0)
    80004f44:	02053603          	ld	a2,32(a0)
    80004f48:	0005b683          	ld	a3,0(a1)
    80004f4c:	00c686b3          	add	a3,a3,a2
    80004f50:	00d5b023          	sd	a3,0(a1)
    80004f54:	00200593          	li	a1,2
    80004f58:	14459073          	csrw	sip,a1
    80004f5c:	01053683          	ld	a3,16(a0)
    80004f60:	00853603          	ld	a2,8(a0)
    80004f64:	00053583          	ld	a1,0(a0)
    80004f68:	34051573          	csrrw	a0,mscratch,a0
    80004f6c:	30200073          	mret

0000000080004f70 <plicinit>:
    80004f70:	ff010113          	addi	sp,sp,-16
    80004f74:	00813423          	sd	s0,8(sp)
    80004f78:	01010413          	addi	s0,sp,16
    80004f7c:	00813403          	ld	s0,8(sp)
    80004f80:	0c0007b7          	lui	a5,0xc000
    80004f84:	00100713          	li	a4,1
    80004f88:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80004f8c:	00e7a223          	sw	a4,4(a5)
    80004f90:	01010113          	addi	sp,sp,16
    80004f94:	00008067          	ret

0000000080004f98 <plicinithart>:
    80004f98:	ff010113          	addi	sp,sp,-16
    80004f9c:	00813023          	sd	s0,0(sp)
    80004fa0:	00113423          	sd	ra,8(sp)
    80004fa4:	01010413          	addi	s0,sp,16
    80004fa8:	00000097          	auipc	ra,0x0
    80004fac:	a48080e7          	jalr	-1464(ra) # 800049f0 <cpuid>
    80004fb0:	0085171b          	slliw	a4,a0,0x8
    80004fb4:	0c0027b7          	lui	a5,0xc002
    80004fb8:	00e787b3          	add	a5,a5,a4
    80004fbc:	40200713          	li	a4,1026
    80004fc0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80004fc4:	00813083          	ld	ra,8(sp)
    80004fc8:	00013403          	ld	s0,0(sp)
    80004fcc:	00d5151b          	slliw	a0,a0,0xd
    80004fd0:	0c2017b7          	lui	a5,0xc201
    80004fd4:	00a78533          	add	a0,a5,a0
    80004fd8:	00052023          	sw	zero,0(a0)
    80004fdc:	01010113          	addi	sp,sp,16
    80004fe0:	00008067          	ret

0000000080004fe4 <plic_claim>:
    80004fe4:	ff010113          	addi	sp,sp,-16
    80004fe8:	00813023          	sd	s0,0(sp)
    80004fec:	00113423          	sd	ra,8(sp)
    80004ff0:	01010413          	addi	s0,sp,16
    80004ff4:	00000097          	auipc	ra,0x0
    80004ff8:	9fc080e7          	jalr	-1540(ra) # 800049f0 <cpuid>
    80004ffc:	00813083          	ld	ra,8(sp)
    80005000:	00013403          	ld	s0,0(sp)
    80005004:	00d5151b          	slliw	a0,a0,0xd
    80005008:	0c2017b7          	lui	a5,0xc201
    8000500c:	00a78533          	add	a0,a5,a0
    80005010:	00452503          	lw	a0,4(a0)
    80005014:	01010113          	addi	sp,sp,16
    80005018:	00008067          	ret

000000008000501c <plic_complete>:
    8000501c:	fe010113          	addi	sp,sp,-32
    80005020:	00813823          	sd	s0,16(sp)
    80005024:	00913423          	sd	s1,8(sp)
    80005028:	00113c23          	sd	ra,24(sp)
    8000502c:	02010413          	addi	s0,sp,32
    80005030:	00050493          	mv	s1,a0
    80005034:	00000097          	auipc	ra,0x0
    80005038:	9bc080e7          	jalr	-1604(ra) # 800049f0 <cpuid>
    8000503c:	01813083          	ld	ra,24(sp)
    80005040:	01013403          	ld	s0,16(sp)
    80005044:	00d5179b          	slliw	a5,a0,0xd
    80005048:	0c201737          	lui	a4,0xc201
    8000504c:	00f707b3          	add	a5,a4,a5
    80005050:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005054:	00813483          	ld	s1,8(sp)
    80005058:	02010113          	addi	sp,sp,32
    8000505c:	00008067          	ret

0000000080005060 <consolewrite>:
    80005060:	fb010113          	addi	sp,sp,-80
    80005064:	04813023          	sd	s0,64(sp)
    80005068:	04113423          	sd	ra,72(sp)
    8000506c:	02913c23          	sd	s1,56(sp)
    80005070:	03213823          	sd	s2,48(sp)
    80005074:	03313423          	sd	s3,40(sp)
    80005078:	03413023          	sd	s4,32(sp)
    8000507c:	01513c23          	sd	s5,24(sp)
    80005080:	05010413          	addi	s0,sp,80
    80005084:	06c05c63          	blez	a2,800050fc <consolewrite+0x9c>
    80005088:	00060993          	mv	s3,a2
    8000508c:	00050a13          	mv	s4,a0
    80005090:	00058493          	mv	s1,a1
    80005094:	00000913          	li	s2,0
    80005098:	fff00a93          	li	s5,-1
    8000509c:	01c0006f          	j	800050b8 <consolewrite+0x58>
    800050a0:	fbf44503          	lbu	a0,-65(s0)
    800050a4:	0019091b          	addiw	s2,s2,1
    800050a8:	00148493          	addi	s1,s1,1
    800050ac:	00001097          	auipc	ra,0x1
    800050b0:	a9c080e7          	jalr	-1380(ra) # 80005b48 <uartputc>
    800050b4:	03298063          	beq	s3,s2,800050d4 <consolewrite+0x74>
    800050b8:	00048613          	mv	a2,s1
    800050bc:	00100693          	li	a3,1
    800050c0:	000a0593          	mv	a1,s4
    800050c4:	fbf40513          	addi	a0,s0,-65
    800050c8:	00000097          	auipc	ra,0x0
    800050cc:	9e0080e7          	jalr	-1568(ra) # 80004aa8 <either_copyin>
    800050d0:	fd5518e3          	bne	a0,s5,800050a0 <consolewrite+0x40>
    800050d4:	04813083          	ld	ra,72(sp)
    800050d8:	04013403          	ld	s0,64(sp)
    800050dc:	03813483          	ld	s1,56(sp)
    800050e0:	02813983          	ld	s3,40(sp)
    800050e4:	02013a03          	ld	s4,32(sp)
    800050e8:	01813a83          	ld	s5,24(sp)
    800050ec:	00090513          	mv	a0,s2
    800050f0:	03013903          	ld	s2,48(sp)
    800050f4:	05010113          	addi	sp,sp,80
    800050f8:	00008067          	ret
    800050fc:	00000913          	li	s2,0
    80005100:	fd5ff06f          	j	800050d4 <consolewrite+0x74>

0000000080005104 <consoleread>:
    80005104:	f9010113          	addi	sp,sp,-112
    80005108:	06813023          	sd	s0,96(sp)
    8000510c:	04913c23          	sd	s1,88(sp)
    80005110:	05213823          	sd	s2,80(sp)
    80005114:	05313423          	sd	s3,72(sp)
    80005118:	05413023          	sd	s4,64(sp)
    8000511c:	03513c23          	sd	s5,56(sp)
    80005120:	03613823          	sd	s6,48(sp)
    80005124:	03713423          	sd	s7,40(sp)
    80005128:	03813023          	sd	s8,32(sp)
    8000512c:	06113423          	sd	ra,104(sp)
    80005130:	01913c23          	sd	s9,24(sp)
    80005134:	07010413          	addi	s0,sp,112
    80005138:	00060b93          	mv	s7,a2
    8000513c:	00050913          	mv	s2,a0
    80005140:	00058c13          	mv	s8,a1
    80005144:	00060b1b          	sext.w	s6,a2
    80005148:	00005497          	auipc	s1,0x5
    8000514c:	c2048493          	addi	s1,s1,-992 # 80009d68 <cons>
    80005150:	00400993          	li	s3,4
    80005154:	fff00a13          	li	s4,-1
    80005158:	00a00a93          	li	s5,10
    8000515c:	05705e63          	blez	s7,800051b8 <consoleread+0xb4>
    80005160:	09c4a703          	lw	a4,156(s1)
    80005164:	0984a783          	lw	a5,152(s1)
    80005168:	0007071b          	sext.w	a4,a4
    8000516c:	08e78463          	beq	a5,a4,800051f4 <consoleread+0xf0>
    80005170:	07f7f713          	andi	a4,a5,127
    80005174:	00e48733          	add	a4,s1,a4
    80005178:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000517c:	0017869b          	addiw	a3,a5,1
    80005180:	08d4ac23          	sw	a3,152(s1)
    80005184:	00070c9b          	sext.w	s9,a4
    80005188:	0b370663          	beq	a4,s3,80005234 <consoleread+0x130>
    8000518c:	00100693          	li	a3,1
    80005190:	f9f40613          	addi	a2,s0,-97
    80005194:	000c0593          	mv	a1,s8
    80005198:	00090513          	mv	a0,s2
    8000519c:	f8e40fa3          	sb	a4,-97(s0)
    800051a0:	00000097          	auipc	ra,0x0
    800051a4:	8bc080e7          	jalr	-1860(ra) # 80004a5c <either_copyout>
    800051a8:	01450863          	beq	a0,s4,800051b8 <consoleread+0xb4>
    800051ac:	001c0c13          	addi	s8,s8,1
    800051b0:	fffb8b9b          	addiw	s7,s7,-1
    800051b4:	fb5c94e3          	bne	s9,s5,8000515c <consoleread+0x58>
    800051b8:	000b851b          	sext.w	a0,s7
    800051bc:	06813083          	ld	ra,104(sp)
    800051c0:	06013403          	ld	s0,96(sp)
    800051c4:	05813483          	ld	s1,88(sp)
    800051c8:	05013903          	ld	s2,80(sp)
    800051cc:	04813983          	ld	s3,72(sp)
    800051d0:	04013a03          	ld	s4,64(sp)
    800051d4:	03813a83          	ld	s5,56(sp)
    800051d8:	02813b83          	ld	s7,40(sp)
    800051dc:	02013c03          	ld	s8,32(sp)
    800051e0:	01813c83          	ld	s9,24(sp)
    800051e4:	40ab053b          	subw	a0,s6,a0
    800051e8:	03013b03          	ld	s6,48(sp)
    800051ec:	07010113          	addi	sp,sp,112
    800051f0:	00008067          	ret
    800051f4:	00001097          	auipc	ra,0x1
    800051f8:	1d8080e7          	jalr	472(ra) # 800063cc <push_on>
    800051fc:	0984a703          	lw	a4,152(s1)
    80005200:	09c4a783          	lw	a5,156(s1)
    80005204:	0007879b          	sext.w	a5,a5
    80005208:	fef70ce3          	beq	a4,a5,80005200 <consoleread+0xfc>
    8000520c:	00001097          	auipc	ra,0x1
    80005210:	234080e7          	jalr	564(ra) # 80006440 <pop_on>
    80005214:	0984a783          	lw	a5,152(s1)
    80005218:	07f7f713          	andi	a4,a5,127
    8000521c:	00e48733          	add	a4,s1,a4
    80005220:	01874703          	lbu	a4,24(a4)
    80005224:	0017869b          	addiw	a3,a5,1
    80005228:	08d4ac23          	sw	a3,152(s1)
    8000522c:	00070c9b          	sext.w	s9,a4
    80005230:	f5371ee3          	bne	a4,s3,8000518c <consoleread+0x88>
    80005234:	000b851b          	sext.w	a0,s7
    80005238:	f96bf2e3          	bgeu	s7,s6,800051bc <consoleread+0xb8>
    8000523c:	08f4ac23          	sw	a5,152(s1)
    80005240:	f7dff06f          	j	800051bc <consoleread+0xb8>

0000000080005244 <consputc>:
    80005244:	10000793          	li	a5,256
    80005248:	00f50663          	beq	a0,a5,80005254 <consputc+0x10>
    8000524c:	00001317          	auipc	t1,0x1
    80005250:	9f430067          	jr	-1548(t1) # 80005c40 <uartputc_sync>
    80005254:	ff010113          	addi	sp,sp,-16
    80005258:	00113423          	sd	ra,8(sp)
    8000525c:	00813023          	sd	s0,0(sp)
    80005260:	01010413          	addi	s0,sp,16
    80005264:	00800513          	li	a0,8
    80005268:	00001097          	auipc	ra,0x1
    8000526c:	9d8080e7          	jalr	-1576(ra) # 80005c40 <uartputc_sync>
    80005270:	02000513          	li	a0,32
    80005274:	00001097          	auipc	ra,0x1
    80005278:	9cc080e7          	jalr	-1588(ra) # 80005c40 <uartputc_sync>
    8000527c:	00013403          	ld	s0,0(sp)
    80005280:	00813083          	ld	ra,8(sp)
    80005284:	00800513          	li	a0,8
    80005288:	01010113          	addi	sp,sp,16
    8000528c:	00001317          	auipc	t1,0x1
    80005290:	9b430067          	jr	-1612(t1) # 80005c40 <uartputc_sync>

0000000080005294 <consoleintr>:
    80005294:	fe010113          	addi	sp,sp,-32
    80005298:	00813823          	sd	s0,16(sp)
    8000529c:	00913423          	sd	s1,8(sp)
    800052a0:	01213023          	sd	s2,0(sp)
    800052a4:	00113c23          	sd	ra,24(sp)
    800052a8:	02010413          	addi	s0,sp,32
    800052ac:	00005917          	auipc	s2,0x5
    800052b0:	abc90913          	addi	s2,s2,-1348 # 80009d68 <cons>
    800052b4:	00050493          	mv	s1,a0
    800052b8:	00090513          	mv	a0,s2
    800052bc:	00001097          	auipc	ra,0x1
    800052c0:	e40080e7          	jalr	-448(ra) # 800060fc <acquire>
    800052c4:	02048c63          	beqz	s1,800052fc <consoleintr+0x68>
    800052c8:	0a092783          	lw	a5,160(s2)
    800052cc:	09892703          	lw	a4,152(s2)
    800052d0:	07f00693          	li	a3,127
    800052d4:	40e7873b          	subw	a4,a5,a4
    800052d8:	02e6e263          	bltu	a3,a4,800052fc <consoleintr+0x68>
    800052dc:	00d00713          	li	a4,13
    800052e0:	04e48063          	beq	s1,a4,80005320 <consoleintr+0x8c>
    800052e4:	07f7f713          	andi	a4,a5,127
    800052e8:	00e90733          	add	a4,s2,a4
    800052ec:	0017879b          	addiw	a5,a5,1
    800052f0:	0af92023          	sw	a5,160(s2)
    800052f4:	00970c23          	sb	s1,24(a4)
    800052f8:	08f92e23          	sw	a5,156(s2)
    800052fc:	01013403          	ld	s0,16(sp)
    80005300:	01813083          	ld	ra,24(sp)
    80005304:	00813483          	ld	s1,8(sp)
    80005308:	00013903          	ld	s2,0(sp)
    8000530c:	00005517          	auipc	a0,0x5
    80005310:	a5c50513          	addi	a0,a0,-1444 # 80009d68 <cons>
    80005314:	02010113          	addi	sp,sp,32
    80005318:	00001317          	auipc	t1,0x1
    8000531c:	eb030067          	jr	-336(t1) # 800061c8 <release>
    80005320:	00a00493          	li	s1,10
    80005324:	fc1ff06f          	j	800052e4 <consoleintr+0x50>

0000000080005328 <consoleinit>:
    80005328:	fe010113          	addi	sp,sp,-32
    8000532c:	00113c23          	sd	ra,24(sp)
    80005330:	00813823          	sd	s0,16(sp)
    80005334:	00913423          	sd	s1,8(sp)
    80005338:	02010413          	addi	s0,sp,32
    8000533c:	00005497          	auipc	s1,0x5
    80005340:	a2c48493          	addi	s1,s1,-1492 # 80009d68 <cons>
    80005344:	00048513          	mv	a0,s1
    80005348:	00002597          	auipc	a1,0x2
    8000534c:	50058593          	addi	a1,a1,1280 # 80007848 <_ZTV7WorkerD+0x150>
    80005350:	00001097          	auipc	ra,0x1
    80005354:	d88080e7          	jalr	-632(ra) # 800060d8 <initlock>
    80005358:	00000097          	auipc	ra,0x0
    8000535c:	7ac080e7          	jalr	1964(ra) # 80005b04 <uartinit>
    80005360:	01813083          	ld	ra,24(sp)
    80005364:	01013403          	ld	s0,16(sp)
    80005368:	00000797          	auipc	a5,0x0
    8000536c:	d9c78793          	addi	a5,a5,-612 # 80005104 <consoleread>
    80005370:	0af4bc23          	sd	a5,184(s1)
    80005374:	00000797          	auipc	a5,0x0
    80005378:	cec78793          	addi	a5,a5,-788 # 80005060 <consolewrite>
    8000537c:	0cf4b023          	sd	a5,192(s1)
    80005380:	00813483          	ld	s1,8(sp)
    80005384:	02010113          	addi	sp,sp,32
    80005388:	00008067          	ret

000000008000538c <console_read>:
    8000538c:	ff010113          	addi	sp,sp,-16
    80005390:	00813423          	sd	s0,8(sp)
    80005394:	01010413          	addi	s0,sp,16
    80005398:	00813403          	ld	s0,8(sp)
    8000539c:	00005317          	auipc	t1,0x5
    800053a0:	a8433303          	ld	t1,-1404(t1) # 80009e20 <devsw+0x10>
    800053a4:	01010113          	addi	sp,sp,16
    800053a8:	00030067          	jr	t1

00000000800053ac <console_write>:
    800053ac:	ff010113          	addi	sp,sp,-16
    800053b0:	00813423          	sd	s0,8(sp)
    800053b4:	01010413          	addi	s0,sp,16
    800053b8:	00813403          	ld	s0,8(sp)
    800053bc:	00005317          	auipc	t1,0x5
    800053c0:	a6c33303          	ld	t1,-1428(t1) # 80009e28 <devsw+0x18>
    800053c4:	01010113          	addi	sp,sp,16
    800053c8:	00030067          	jr	t1

00000000800053cc <panic>:
    800053cc:	fe010113          	addi	sp,sp,-32
    800053d0:	00113c23          	sd	ra,24(sp)
    800053d4:	00813823          	sd	s0,16(sp)
    800053d8:	00913423          	sd	s1,8(sp)
    800053dc:	02010413          	addi	s0,sp,32
    800053e0:	00050493          	mv	s1,a0
    800053e4:	00002517          	auipc	a0,0x2
    800053e8:	46c50513          	addi	a0,a0,1132 # 80007850 <_ZTV7WorkerD+0x158>
    800053ec:	00005797          	auipc	a5,0x5
    800053f0:	ac07ae23          	sw	zero,-1316(a5) # 80009ec8 <pr+0x18>
    800053f4:	00000097          	auipc	ra,0x0
    800053f8:	034080e7          	jalr	52(ra) # 80005428 <__printf>
    800053fc:	00048513          	mv	a0,s1
    80005400:	00000097          	auipc	ra,0x0
    80005404:	028080e7          	jalr	40(ra) # 80005428 <__printf>
    80005408:	00002517          	auipc	a0,0x2
    8000540c:	ec850513          	addi	a0,a0,-312 # 800072d0 <kvmincrease+0x740>
    80005410:	00000097          	auipc	ra,0x0
    80005414:	018080e7          	jalr	24(ra) # 80005428 <__printf>
    80005418:	00100793          	li	a5,1
    8000541c:	00004717          	auipc	a4,0x4
    80005420:	82f72e23          	sw	a5,-1988(a4) # 80008c58 <panicked>
    80005424:	0000006f          	j	80005424 <panic+0x58>

0000000080005428 <__printf>:
    80005428:	f3010113          	addi	sp,sp,-208
    8000542c:	08813023          	sd	s0,128(sp)
    80005430:	07313423          	sd	s3,104(sp)
    80005434:	09010413          	addi	s0,sp,144
    80005438:	05813023          	sd	s8,64(sp)
    8000543c:	08113423          	sd	ra,136(sp)
    80005440:	06913c23          	sd	s1,120(sp)
    80005444:	07213823          	sd	s2,112(sp)
    80005448:	07413023          	sd	s4,96(sp)
    8000544c:	05513c23          	sd	s5,88(sp)
    80005450:	05613823          	sd	s6,80(sp)
    80005454:	05713423          	sd	s7,72(sp)
    80005458:	03913c23          	sd	s9,56(sp)
    8000545c:	03a13823          	sd	s10,48(sp)
    80005460:	03b13423          	sd	s11,40(sp)
    80005464:	00005317          	auipc	t1,0x5
    80005468:	a4c30313          	addi	t1,t1,-1460 # 80009eb0 <pr>
    8000546c:	01832c03          	lw	s8,24(t1)
    80005470:	00b43423          	sd	a1,8(s0)
    80005474:	00c43823          	sd	a2,16(s0)
    80005478:	00d43c23          	sd	a3,24(s0)
    8000547c:	02e43023          	sd	a4,32(s0)
    80005480:	02f43423          	sd	a5,40(s0)
    80005484:	03043823          	sd	a6,48(s0)
    80005488:	03143c23          	sd	a7,56(s0)
    8000548c:	00050993          	mv	s3,a0
    80005490:	4a0c1663          	bnez	s8,8000593c <__printf+0x514>
    80005494:	60098c63          	beqz	s3,80005aac <__printf+0x684>
    80005498:	0009c503          	lbu	a0,0(s3)
    8000549c:	00840793          	addi	a5,s0,8
    800054a0:	f6f43c23          	sd	a5,-136(s0)
    800054a4:	00000493          	li	s1,0
    800054a8:	22050063          	beqz	a0,800056c8 <__printf+0x2a0>
    800054ac:	00002a37          	lui	s4,0x2
    800054b0:	00018ab7          	lui	s5,0x18
    800054b4:	000f4b37          	lui	s6,0xf4
    800054b8:	00989bb7          	lui	s7,0x989
    800054bc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800054c0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800054c4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800054c8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800054cc:	00148c9b          	addiw	s9,s1,1
    800054d0:	02500793          	li	a5,37
    800054d4:	01998933          	add	s2,s3,s9
    800054d8:	38f51263          	bne	a0,a5,8000585c <__printf+0x434>
    800054dc:	00094783          	lbu	a5,0(s2)
    800054e0:	00078c9b          	sext.w	s9,a5
    800054e4:	1e078263          	beqz	a5,800056c8 <__printf+0x2a0>
    800054e8:	0024849b          	addiw	s1,s1,2
    800054ec:	07000713          	li	a4,112
    800054f0:	00998933          	add	s2,s3,s1
    800054f4:	38e78a63          	beq	a5,a4,80005888 <__printf+0x460>
    800054f8:	20f76863          	bltu	a4,a5,80005708 <__printf+0x2e0>
    800054fc:	42a78863          	beq	a5,a0,8000592c <__printf+0x504>
    80005500:	06400713          	li	a4,100
    80005504:	40e79663          	bne	a5,a4,80005910 <__printf+0x4e8>
    80005508:	f7843783          	ld	a5,-136(s0)
    8000550c:	0007a603          	lw	a2,0(a5)
    80005510:	00878793          	addi	a5,a5,8
    80005514:	f6f43c23          	sd	a5,-136(s0)
    80005518:	42064a63          	bltz	a2,8000594c <__printf+0x524>
    8000551c:	00a00713          	li	a4,10
    80005520:	02e677bb          	remuw	a5,a2,a4
    80005524:	00002d97          	auipc	s11,0x2
    80005528:	354d8d93          	addi	s11,s11,852 # 80007878 <digits>
    8000552c:	00900593          	li	a1,9
    80005530:	0006051b          	sext.w	a0,a2
    80005534:	00000c93          	li	s9,0
    80005538:	02079793          	slli	a5,a5,0x20
    8000553c:	0207d793          	srli	a5,a5,0x20
    80005540:	00fd87b3          	add	a5,s11,a5
    80005544:	0007c783          	lbu	a5,0(a5)
    80005548:	02e656bb          	divuw	a3,a2,a4
    8000554c:	f8f40023          	sb	a5,-128(s0)
    80005550:	14c5d863          	bge	a1,a2,800056a0 <__printf+0x278>
    80005554:	06300593          	li	a1,99
    80005558:	00100c93          	li	s9,1
    8000555c:	02e6f7bb          	remuw	a5,a3,a4
    80005560:	02079793          	slli	a5,a5,0x20
    80005564:	0207d793          	srli	a5,a5,0x20
    80005568:	00fd87b3          	add	a5,s11,a5
    8000556c:	0007c783          	lbu	a5,0(a5)
    80005570:	02e6d73b          	divuw	a4,a3,a4
    80005574:	f8f400a3          	sb	a5,-127(s0)
    80005578:	12a5f463          	bgeu	a1,a0,800056a0 <__printf+0x278>
    8000557c:	00a00693          	li	a3,10
    80005580:	00900593          	li	a1,9
    80005584:	02d777bb          	remuw	a5,a4,a3
    80005588:	02079793          	slli	a5,a5,0x20
    8000558c:	0207d793          	srli	a5,a5,0x20
    80005590:	00fd87b3          	add	a5,s11,a5
    80005594:	0007c503          	lbu	a0,0(a5)
    80005598:	02d757bb          	divuw	a5,a4,a3
    8000559c:	f8a40123          	sb	a0,-126(s0)
    800055a0:	48e5f263          	bgeu	a1,a4,80005a24 <__printf+0x5fc>
    800055a4:	06300513          	li	a0,99
    800055a8:	02d7f5bb          	remuw	a1,a5,a3
    800055ac:	02059593          	slli	a1,a1,0x20
    800055b0:	0205d593          	srli	a1,a1,0x20
    800055b4:	00bd85b3          	add	a1,s11,a1
    800055b8:	0005c583          	lbu	a1,0(a1)
    800055bc:	02d7d7bb          	divuw	a5,a5,a3
    800055c0:	f8b401a3          	sb	a1,-125(s0)
    800055c4:	48e57263          	bgeu	a0,a4,80005a48 <__printf+0x620>
    800055c8:	3e700513          	li	a0,999
    800055cc:	02d7f5bb          	remuw	a1,a5,a3
    800055d0:	02059593          	slli	a1,a1,0x20
    800055d4:	0205d593          	srli	a1,a1,0x20
    800055d8:	00bd85b3          	add	a1,s11,a1
    800055dc:	0005c583          	lbu	a1,0(a1)
    800055e0:	02d7d7bb          	divuw	a5,a5,a3
    800055e4:	f8b40223          	sb	a1,-124(s0)
    800055e8:	46e57663          	bgeu	a0,a4,80005a54 <__printf+0x62c>
    800055ec:	02d7f5bb          	remuw	a1,a5,a3
    800055f0:	02059593          	slli	a1,a1,0x20
    800055f4:	0205d593          	srli	a1,a1,0x20
    800055f8:	00bd85b3          	add	a1,s11,a1
    800055fc:	0005c583          	lbu	a1,0(a1)
    80005600:	02d7d7bb          	divuw	a5,a5,a3
    80005604:	f8b402a3          	sb	a1,-123(s0)
    80005608:	46ea7863          	bgeu	s4,a4,80005a78 <__printf+0x650>
    8000560c:	02d7f5bb          	remuw	a1,a5,a3
    80005610:	02059593          	slli	a1,a1,0x20
    80005614:	0205d593          	srli	a1,a1,0x20
    80005618:	00bd85b3          	add	a1,s11,a1
    8000561c:	0005c583          	lbu	a1,0(a1)
    80005620:	02d7d7bb          	divuw	a5,a5,a3
    80005624:	f8b40323          	sb	a1,-122(s0)
    80005628:	3eeaf863          	bgeu	s5,a4,80005a18 <__printf+0x5f0>
    8000562c:	02d7f5bb          	remuw	a1,a5,a3
    80005630:	02059593          	slli	a1,a1,0x20
    80005634:	0205d593          	srli	a1,a1,0x20
    80005638:	00bd85b3          	add	a1,s11,a1
    8000563c:	0005c583          	lbu	a1,0(a1)
    80005640:	02d7d7bb          	divuw	a5,a5,a3
    80005644:	f8b403a3          	sb	a1,-121(s0)
    80005648:	42eb7e63          	bgeu	s6,a4,80005a84 <__printf+0x65c>
    8000564c:	02d7f5bb          	remuw	a1,a5,a3
    80005650:	02059593          	slli	a1,a1,0x20
    80005654:	0205d593          	srli	a1,a1,0x20
    80005658:	00bd85b3          	add	a1,s11,a1
    8000565c:	0005c583          	lbu	a1,0(a1)
    80005660:	02d7d7bb          	divuw	a5,a5,a3
    80005664:	f8b40423          	sb	a1,-120(s0)
    80005668:	42ebfc63          	bgeu	s7,a4,80005aa0 <__printf+0x678>
    8000566c:	02079793          	slli	a5,a5,0x20
    80005670:	0207d793          	srli	a5,a5,0x20
    80005674:	00fd8db3          	add	s11,s11,a5
    80005678:	000dc703          	lbu	a4,0(s11)
    8000567c:	00a00793          	li	a5,10
    80005680:	00900c93          	li	s9,9
    80005684:	f8e404a3          	sb	a4,-119(s0)
    80005688:	00065c63          	bgez	a2,800056a0 <__printf+0x278>
    8000568c:	f9040713          	addi	a4,s0,-112
    80005690:	00f70733          	add	a4,a4,a5
    80005694:	02d00693          	li	a3,45
    80005698:	fed70823          	sb	a3,-16(a4)
    8000569c:	00078c93          	mv	s9,a5
    800056a0:	f8040793          	addi	a5,s0,-128
    800056a4:	01978cb3          	add	s9,a5,s9
    800056a8:	f7f40d13          	addi	s10,s0,-129
    800056ac:	000cc503          	lbu	a0,0(s9)
    800056b0:	fffc8c93          	addi	s9,s9,-1
    800056b4:	00000097          	auipc	ra,0x0
    800056b8:	b90080e7          	jalr	-1136(ra) # 80005244 <consputc>
    800056bc:	ffac98e3          	bne	s9,s10,800056ac <__printf+0x284>
    800056c0:	00094503          	lbu	a0,0(s2)
    800056c4:	e00514e3          	bnez	a0,800054cc <__printf+0xa4>
    800056c8:	1a0c1663          	bnez	s8,80005874 <__printf+0x44c>
    800056cc:	08813083          	ld	ra,136(sp)
    800056d0:	08013403          	ld	s0,128(sp)
    800056d4:	07813483          	ld	s1,120(sp)
    800056d8:	07013903          	ld	s2,112(sp)
    800056dc:	06813983          	ld	s3,104(sp)
    800056e0:	06013a03          	ld	s4,96(sp)
    800056e4:	05813a83          	ld	s5,88(sp)
    800056e8:	05013b03          	ld	s6,80(sp)
    800056ec:	04813b83          	ld	s7,72(sp)
    800056f0:	04013c03          	ld	s8,64(sp)
    800056f4:	03813c83          	ld	s9,56(sp)
    800056f8:	03013d03          	ld	s10,48(sp)
    800056fc:	02813d83          	ld	s11,40(sp)
    80005700:	0d010113          	addi	sp,sp,208
    80005704:	00008067          	ret
    80005708:	07300713          	li	a4,115
    8000570c:	1ce78a63          	beq	a5,a4,800058e0 <__printf+0x4b8>
    80005710:	07800713          	li	a4,120
    80005714:	1ee79e63          	bne	a5,a4,80005910 <__printf+0x4e8>
    80005718:	f7843783          	ld	a5,-136(s0)
    8000571c:	0007a703          	lw	a4,0(a5)
    80005720:	00878793          	addi	a5,a5,8
    80005724:	f6f43c23          	sd	a5,-136(s0)
    80005728:	28074263          	bltz	a4,800059ac <__printf+0x584>
    8000572c:	00002d97          	auipc	s11,0x2
    80005730:	14cd8d93          	addi	s11,s11,332 # 80007878 <digits>
    80005734:	00f77793          	andi	a5,a4,15
    80005738:	00fd87b3          	add	a5,s11,a5
    8000573c:	0007c683          	lbu	a3,0(a5)
    80005740:	00f00613          	li	a2,15
    80005744:	0007079b          	sext.w	a5,a4
    80005748:	f8d40023          	sb	a3,-128(s0)
    8000574c:	0047559b          	srliw	a1,a4,0x4
    80005750:	0047569b          	srliw	a3,a4,0x4
    80005754:	00000c93          	li	s9,0
    80005758:	0ee65063          	bge	a2,a4,80005838 <__printf+0x410>
    8000575c:	00f6f693          	andi	a3,a3,15
    80005760:	00dd86b3          	add	a3,s11,a3
    80005764:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005768:	0087d79b          	srliw	a5,a5,0x8
    8000576c:	00100c93          	li	s9,1
    80005770:	f8d400a3          	sb	a3,-127(s0)
    80005774:	0cb67263          	bgeu	a2,a1,80005838 <__printf+0x410>
    80005778:	00f7f693          	andi	a3,a5,15
    8000577c:	00dd86b3          	add	a3,s11,a3
    80005780:	0006c583          	lbu	a1,0(a3)
    80005784:	00f00613          	li	a2,15
    80005788:	0047d69b          	srliw	a3,a5,0x4
    8000578c:	f8b40123          	sb	a1,-126(s0)
    80005790:	0047d593          	srli	a1,a5,0x4
    80005794:	28f67e63          	bgeu	a2,a5,80005a30 <__printf+0x608>
    80005798:	00f6f693          	andi	a3,a3,15
    8000579c:	00dd86b3          	add	a3,s11,a3
    800057a0:	0006c503          	lbu	a0,0(a3)
    800057a4:	0087d813          	srli	a6,a5,0x8
    800057a8:	0087d69b          	srliw	a3,a5,0x8
    800057ac:	f8a401a3          	sb	a0,-125(s0)
    800057b0:	28b67663          	bgeu	a2,a1,80005a3c <__printf+0x614>
    800057b4:	00f6f693          	andi	a3,a3,15
    800057b8:	00dd86b3          	add	a3,s11,a3
    800057bc:	0006c583          	lbu	a1,0(a3)
    800057c0:	00c7d513          	srli	a0,a5,0xc
    800057c4:	00c7d69b          	srliw	a3,a5,0xc
    800057c8:	f8b40223          	sb	a1,-124(s0)
    800057cc:	29067a63          	bgeu	a2,a6,80005a60 <__printf+0x638>
    800057d0:	00f6f693          	andi	a3,a3,15
    800057d4:	00dd86b3          	add	a3,s11,a3
    800057d8:	0006c583          	lbu	a1,0(a3)
    800057dc:	0107d813          	srli	a6,a5,0x10
    800057e0:	0107d69b          	srliw	a3,a5,0x10
    800057e4:	f8b402a3          	sb	a1,-123(s0)
    800057e8:	28a67263          	bgeu	a2,a0,80005a6c <__printf+0x644>
    800057ec:	00f6f693          	andi	a3,a3,15
    800057f0:	00dd86b3          	add	a3,s11,a3
    800057f4:	0006c683          	lbu	a3,0(a3)
    800057f8:	0147d79b          	srliw	a5,a5,0x14
    800057fc:	f8d40323          	sb	a3,-122(s0)
    80005800:	21067663          	bgeu	a2,a6,80005a0c <__printf+0x5e4>
    80005804:	02079793          	slli	a5,a5,0x20
    80005808:	0207d793          	srli	a5,a5,0x20
    8000580c:	00fd8db3          	add	s11,s11,a5
    80005810:	000dc683          	lbu	a3,0(s11)
    80005814:	00800793          	li	a5,8
    80005818:	00700c93          	li	s9,7
    8000581c:	f8d403a3          	sb	a3,-121(s0)
    80005820:	00075c63          	bgez	a4,80005838 <__printf+0x410>
    80005824:	f9040713          	addi	a4,s0,-112
    80005828:	00f70733          	add	a4,a4,a5
    8000582c:	02d00693          	li	a3,45
    80005830:	fed70823          	sb	a3,-16(a4)
    80005834:	00078c93          	mv	s9,a5
    80005838:	f8040793          	addi	a5,s0,-128
    8000583c:	01978cb3          	add	s9,a5,s9
    80005840:	f7f40d13          	addi	s10,s0,-129
    80005844:	000cc503          	lbu	a0,0(s9)
    80005848:	fffc8c93          	addi	s9,s9,-1
    8000584c:	00000097          	auipc	ra,0x0
    80005850:	9f8080e7          	jalr	-1544(ra) # 80005244 <consputc>
    80005854:	ff9d18e3          	bne	s10,s9,80005844 <__printf+0x41c>
    80005858:	0100006f          	j	80005868 <__printf+0x440>
    8000585c:	00000097          	auipc	ra,0x0
    80005860:	9e8080e7          	jalr	-1560(ra) # 80005244 <consputc>
    80005864:	000c8493          	mv	s1,s9
    80005868:	00094503          	lbu	a0,0(s2)
    8000586c:	c60510e3          	bnez	a0,800054cc <__printf+0xa4>
    80005870:	e40c0ee3          	beqz	s8,800056cc <__printf+0x2a4>
    80005874:	00004517          	auipc	a0,0x4
    80005878:	63c50513          	addi	a0,a0,1596 # 80009eb0 <pr>
    8000587c:	00001097          	auipc	ra,0x1
    80005880:	94c080e7          	jalr	-1716(ra) # 800061c8 <release>
    80005884:	e49ff06f          	j	800056cc <__printf+0x2a4>
    80005888:	f7843783          	ld	a5,-136(s0)
    8000588c:	03000513          	li	a0,48
    80005890:	01000d13          	li	s10,16
    80005894:	00878713          	addi	a4,a5,8
    80005898:	0007bc83          	ld	s9,0(a5)
    8000589c:	f6e43c23          	sd	a4,-136(s0)
    800058a0:	00000097          	auipc	ra,0x0
    800058a4:	9a4080e7          	jalr	-1628(ra) # 80005244 <consputc>
    800058a8:	07800513          	li	a0,120
    800058ac:	00000097          	auipc	ra,0x0
    800058b0:	998080e7          	jalr	-1640(ra) # 80005244 <consputc>
    800058b4:	00002d97          	auipc	s11,0x2
    800058b8:	fc4d8d93          	addi	s11,s11,-60 # 80007878 <digits>
    800058bc:	03ccd793          	srli	a5,s9,0x3c
    800058c0:	00fd87b3          	add	a5,s11,a5
    800058c4:	0007c503          	lbu	a0,0(a5)
    800058c8:	fffd0d1b          	addiw	s10,s10,-1
    800058cc:	004c9c93          	slli	s9,s9,0x4
    800058d0:	00000097          	auipc	ra,0x0
    800058d4:	974080e7          	jalr	-1676(ra) # 80005244 <consputc>
    800058d8:	fe0d12e3          	bnez	s10,800058bc <__printf+0x494>
    800058dc:	f8dff06f          	j	80005868 <__printf+0x440>
    800058e0:	f7843783          	ld	a5,-136(s0)
    800058e4:	0007bc83          	ld	s9,0(a5)
    800058e8:	00878793          	addi	a5,a5,8
    800058ec:	f6f43c23          	sd	a5,-136(s0)
    800058f0:	000c9a63          	bnez	s9,80005904 <__printf+0x4dc>
    800058f4:	1080006f          	j	800059fc <__printf+0x5d4>
    800058f8:	001c8c93          	addi	s9,s9,1
    800058fc:	00000097          	auipc	ra,0x0
    80005900:	948080e7          	jalr	-1720(ra) # 80005244 <consputc>
    80005904:	000cc503          	lbu	a0,0(s9)
    80005908:	fe0518e3          	bnez	a0,800058f8 <__printf+0x4d0>
    8000590c:	f5dff06f          	j	80005868 <__printf+0x440>
    80005910:	02500513          	li	a0,37
    80005914:	00000097          	auipc	ra,0x0
    80005918:	930080e7          	jalr	-1744(ra) # 80005244 <consputc>
    8000591c:	000c8513          	mv	a0,s9
    80005920:	00000097          	auipc	ra,0x0
    80005924:	924080e7          	jalr	-1756(ra) # 80005244 <consputc>
    80005928:	f41ff06f          	j	80005868 <__printf+0x440>
    8000592c:	02500513          	li	a0,37
    80005930:	00000097          	auipc	ra,0x0
    80005934:	914080e7          	jalr	-1772(ra) # 80005244 <consputc>
    80005938:	f31ff06f          	j	80005868 <__printf+0x440>
    8000593c:	00030513          	mv	a0,t1
    80005940:	00000097          	auipc	ra,0x0
    80005944:	7bc080e7          	jalr	1980(ra) # 800060fc <acquire>
    80005948:	b4dff06f          	j	80005494 <__printf+0x6c>
    8000594c:	40c0053b          	negw	a0,a2
    80005950:	00a00713          	li	a4,10
    80005954:	02e576bb          	remuw	a3,a0,a4
    80005958:	00002d97          	auipc	s11,0x2
    8000595c:	f20d8d93          	addi	s11,s11,-224 # 80007878 <digits>
    80005960:	ff700593          	li	a1,-9
    80005964:	02069693          	slli	a3,a3,0x20
    80005968:	0206d693          	srli	a3,a3,0x20
    8000596c:	00dd86b3          	add	a3,s11,a3
    80005970:	0006c683          	lbu	a3,0(a3)
    80005974:	02e557bb          	divuw	a5,a0,a4
    80005978:	f8d40023          	sb	a3,-128(s0)
    8000597c:	10b65e63          	bge	a2,a1,80005a98 <__printf+0x670>
    80005980:	06300593          	li	a1,99
    80005984:	02e7f6bb          	remuw	a3,a5,a4
    80005988:	02069693          	slli	a3,a3,0x20
    8000598c:	0206d693          	srli	a3,a3,0x20
    80005990:	00dd86b3          	add	a3,s11,a3
    80005994:	0006c683          	lbu	a3,0(a3)
    80005998:	02e7d73b          	divuw	a4,a5,a4
    8000599c:	00200793          	li	a5,2
    800059a0:	f8d400a3          	sb	a3,-127(s0)
    800059a4:	bca5ece3          	bltu	a1,a0,8000557c <__printf+0x154>
    800059a8:	ce5ff06f          	j	8000568c <__printf+0x264>
    800059ac:	40e007bb          	negw	a5,a4
    800059b0:	00002d97          	auipc	s11,0x2
    800059b4:	ec8d8d93          	addi	s11,s11,-312 # 80007878 <digits>
    800059b8:	00f7f693          	andi	a3,a5,15
    800059bc:	00dd86b3          	add	a3,s11,a3
    800059c0:	0006c583          	lbu	a1,0(a3)
    800059c4:	ff100613          	li	a2,-15
    800059c8:	0047d69b          	srliw	a3,a5,0x4
    800059cc:	f8b40023          	sb	a1,-128(s0)
    800059d0:	0047d59b          	srliw	a1,a5,0x4
    800059d4:	0ac75e63          	bge	a4,a2,80005a90 <__printf+0x668>
    800059d8:	00f6f693          	andi	a3,a3,15
    800059dc:	00dd86b3          	add	a3,s11,a3
    800059e0:	0006c603          	lbu	a2,0(a3)
    800059e4:	00f00693          	li	a3,15
    800059e8:	0087d79b          	srliw	a5,a5,0x8
    800059ec:	f8c400a3          	sb	a2,-127(s0)
    800059f0:	d8b6e4e3          	bltu	a3,a1,80005778 <__printf+0x350>
    800059f4:	00200793          	li	a5,2
    800059f8:	e2dff06f          	j	80005824 <__printf+0x3fc>
    800059fc:	00002c97          	auipc	s9,0x2
    80005a00:	e5cc8c93          	addi	s9,s9,-420 # 80007858 <_ZTV7WorkerD+0x160>
    80005a04:	02800513          	li	a0,40
    80005a08:	ef1ff06f          	j	800058f8 <__printf+0x4d0>
    80005a0c:	00700793          	li	a5,7
    80005a10:	00600c93          	li	s9,6
    80005a14:	e0dff06f          	j	80005820 <__printf+0x3f8>
    80005a18:	00700793          	li	a5,7
    80005a1c:	00600c93          	li	s9,6
    80005a20:	c69ff06f          	j	80005688 <__printf+0x260>
    80005a24:	00300793          	li	a5,3
    80005a28:	00200c93          	li	s9,2
    80005a2c:	c5dff06f          	j	80005688 <__printf+0x260>
    80005a30:	00300793          	li	a5,3
    80005a34:	00200c93          	li	s9,2
    80005a38:	de9ff06f          	j	80005820 <__printf+0x3f8>
    80005a3c:	00400793          	li	a5,4
    80005a40:	00300c93          	li	s9,3
    80005a44:	dddff06f          	j	80005820 <__printf+0x3f8>
    80005a48:	00400793          	li	a5,4
    80005a4c:	00300c93          	li	s9,3
    80005a50:	c39ff06f          	j	80005688 <__printf+0x260>
    80005a54:	00500793          	li	a5,5
    80005a58:	00400c93          	li	s9,4
    80005a5c:	c2dff06f          	j	80005688 <__printf+0x260>
    80005a60:	00500793          	li	a5,5
    80005a64:	00400c93          	li	s9,4
    80005a68:	db9ff06f          	j	80005820 <__printf+0x3f8>
    80005a6c:	00600793          	li	a5,6
    80005a70:	00500c93          	li	s9,5
    80005a74:	dadff06f          	j	80005820 <__printf+0x3f8>
    80005a78:	00600793          	li	a5,6
    80005a7c:	00500c93          	li	s9,5
    80005a80:	c09ff06f          	j	80005688 <__printf+0x260>
    80005a84:	00800793          	li	a5,8
    80005a88:	00700c93          	li	s9,7
    80005a8c:	bfdff06f          	j	80005688 <__printf+0x260>
    80005a90:	00100793          	li	a5,1
    80005a94:	d91ff06f          	j	80005824 <__printf+0x3fc>
    80005a98:	00100793          	li	a5,1
    80005a9c:	bf1ff06f          	j	8000568c <__printf+0x264>
    80005aa0:	00900793          	li	a5,9
    80005aa4:	00800c93          	li	s9,8
    80005aa8:	be1ff06f          	j	80005688 <__printf+0x260>
    80005aac:	00002517          	auipc	a0,0x2
    80005ab0:	db450513          	addi	a0,a0,-588 # 80007860 <_ZTV7WorkerD+0x168>
    80005ab4:	00000097          	auipc	ra,0x0
    80005ab8:	918080e7          	jalr	-1768(ra) # 800053cc <panic>

0000000080005abc <printfinit>:
    80005abc:	fe010113          	addi	sp,sp,-32
    80005ac0:	00813823          	sd	s0,16(sp)
    80005ac4:	00913423          	sd	s1,8(sp)
    80005ac8:	00113c23          	sd	ra,24(sp)
    80005acc:	02010413          	addi	s0,sp,32
    80005ad0:	00004497          	auipc	s1,0x4
    80005ad4:	3e048493          	addi	s1,s1,992 # 80009eb0 <pr>
    80005ad8:	00048513          	mv	a0,s1
    80005adc:	00002597          	auipc	a1,0x2
    80005ae0:	d9458593          	addi	a1,a1,-620 # 80007870 <_ZTV7WorkerD+0x178>
    80005ae4:	00000097          	auipc	ra,0x0
    80005ae8:	5f4080e7          	jalr	1524(ra) # 800060d8 <initlock>
    80005aec:	01813083          	ld	ra,24(sp)
    80005af0:	01013403          	ld	s0,16(sp)
    80005af4:	0004ac23          	sw	zero,24(s1)
    80005af8:	00813483          	ld	s1,8(sp)
    80005afc:	02010113          	addi	sp,sp,32
    80005b00:	00008067          	ret

0000000080005b04 <uartinit>:
    80005b04:	ff010113          	addi	sp,sp,-16
    80005b08:	00813423          	sd	s0,8(sp)
    80005b0c:	01010413          	addi	s0,sp,16
    80005b10:	100007b7          	lui	a5,0x10000
    80005b14:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005b18:	f8000713          	li	a4,-128
    80005b1c:	00e781a3          	sb	a4,3(a5)
    80005b20:	00300713          	li	a4,3
    80005b24:	00e78023          	sb	a4,0(a5)
    80005b28:	000780a3          	sb	zero,1(a5)
    80005b2c:	00e781a3          	sb	a4,3(a5)
    80005b30:	00700693          	li	a3,7
    80005b34:	00d78123          	sb	a3,2(a5)
    80005b38:	00e780a3          	sb	a4,1(a5)
    80005b3c:	00813403          	ld	s0,8(sp)
    80005b40:	01010113          	addi	sp,sp,16
    80005b44:	00008067          	ret

0000000080005b48 <uartputc>:
    80005b48:	00003797          	auipc	a5,0x3
    80005b4c:	1107a783          	lw	a5,272(a5) # 80008c58 <panicked>
    80005b50:	00078463          	beqz	a5,80005b58 <uartputc+0x10>
    80005b54:	0000006f          	j	80005b54 <uartputc+0xc>
    80005b58:	fd010113          	addi	sp,sp,-48
    80005b5c:	02813023          	sd	s0,32(sp)
    80005b60:	00913c23          	sd	s1,24(sp)
    80005b64:	01213823          	sd	s2,16(sp)
    80005b68:	01313423          	sd	s3,8(sp)
    80005b6c:	02113423          	sd	ra,40(sp)
    80005b70:	03010413          	addi	s0,sp,48
    80005b74:	00003917          	auipc	s2,0x3
    80005b78:	0ec90913          	addi	s2,s2,236 # 80008c60 <uart_tx_r>
    80005b7c:	00093783          	ld	a5,0(s2)
    80005b80:	00003497          	auipc	s1,0x3
    80005b84:	0e848493          	addi	s1,s1,232 # 80008c68 <uart_tx_w>
    80005b88:	0004b703          	ld	a4,0(s1)
    80005b8c:	02078693          	addi	a3,a5,32
    80005b90:	00050993          	mv	s3,a0
    80005b94:	02e69c63          	bne	a3,a4,80005bcc <uartputc+0x84>
    80005b98:	00001097          	auipc	ra,0x1
    80005b9c:	834080e7          	jalr	-1996(ra) # 800063cc <push_on>
    80005ba0:	00093783          	ld	a5,0(s2)
    80005ba4:	0004b703          	ld	a4,0(s1)
    80005ba8:	02078793          	addi	a5,a5,32
    80005bac:	00e79463          	bne	a5,a4,80005bb4 <uartputc+0x6c>
    80005bb0:	0000006f          	j	80005bb0 <uartputc+0x68>
    80005bb4:	00001097          	auipc	ra,0x1
    80005bb8:	88c080e7          	jalr	-1908(ra) # 80006440 <pop_on>
    80005bbc:	00093783          	ld	a5,0(s2)
    80005bc0:	0004b703          	ld	a4,0(s1)
    80005bc4:	02078693          	addi	a3,a5,32
    80005bc8:	fce688e3          	beq	a3,a4,80005b98 <uartputc+0x50>
    80005bcc:	01f77693          	andi	a3,a4,31
    80005bd0:	00004597          	auipc	a1,0x4
    80005bd4:	30058593          	addi	a1,a1,768 # 80009ed0 <uart_tx_buf>
    80005bd8:	00d586b3          	add	a3,a1,a3
    80005bdc:	00170713          	addi	a4,a4,1
    80005be0:	01368023          	sb	s3,0(a3)
    80005be4:	00e4b023          	sd	a4,0(s1)
    80005be8:	10000637          	lui	a2,0x10000
    80005bec:	02f71063          	bne	a4,a5,80005c0c <uartputc+0xc4>
    80005bf0:	0340006f          	j	80005c24 <uartputc+0xdc>
    80005bf4:	00074703          	lbu	a4,0(a4)
    80005bf8:	00f93023          	sd	a5,0(s2)
    80005bfc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005c00:	00093783          	ld	a5,0(s2)
    80005c04:	0004b703          	ld	a4,0(s1)
    80005c08:	00f70e63          	beq	a4,a5,80005c24 <uartputc+0xdc>
    80005c0c:	00564683          	lbu	a3,5(a2)
    80005c10:	01f7f713          	andi	a4,a5,31
    80005c14:	00e58733          	add	a4,a1,a4
    80005c18:	0206f693          	andi	a3,a3,32
    80005c1c:	00178793          	addi	a5,a5,1
    80005c20:	fc069ae3          	bnez	a3,80005bf4 <uartputc+0xac>
    80005c24:	02813083          	ld	ra,40(sp)
    80005c28:	02013403          	ld	s0,32(sp)
    80005c2c:	01813483          	ld	s1,24(sp)
    80005c30:	01013903          	ld	s2,16(sp)
    80005c34:	00813983          	ld	s3,8(sp)
    80005c38:	03010113          	addi	sp,sp,48
    80005c3c:	00008067          	ret

0000000080005c40 <uartputc_sync>:
    80005c40:	ff010113          	addi	sp,sp,-16
    80005c44:	00813423          	sd	s0,8(sp)
    80005c48:	01010413          	addi	s0,sp,16
    80005c4c:	00003717          	auipc	a4,0x3
    80005c50:	00c72703          	lw	a4,12(a4) # 80008c58 <panicked>
    80005c54:	02071663          	bnez	a4,80005c80 <uartputc_sync+0x40>
    80005c58:	00050793          	mv	a5,a0
    80005c5c:	100006b7          	lui	a3,0x10000
    80005c60:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005c64:	02077713          	andi	a4,a4,32
    80005c68:	fe070ce3          	beqz	a4,80005c60 <uartputc_sync+0x20>
    80005c6c:	0ff7f793          	andi	a5,a5,255
    80005c70:	00f68023          	sb	a5,0(a3)
    80005c74:	00813403          	ld	s0,8(sp)
    80005c78:	01010113          	addi	sp,sp,16
    80005c7c:	00008067          	ret
    80005c80:	0000006f          	j	80005c80 <uartputc_sync+0x40>

0000000080005c84 <uartstart>:
    80005c84:	ff010113          	addi	sp,sp,-16
    80005c88:	00813423          	sd	s0,8(sp)
    80005c8c:	01010413          	addi	s0,sp,16
    80005c90:	00003617          	auipc	a2,0x3
    80005c94:	fd060613          	addi	a2,a2,-48 # 80008c60 <uart_tx_r>
    80005c98:	00003517          	auipc	a0,0x3
    80005c9c:	fd050513          	addi	a0,a0,-48 # 80008c68 <uart_tx_w>
    80005ca0:	00063783          	ld	a5,0(a2)
    80005ca4:	00053703          	ld	a4,0(a0)
    80005ca8:	04f70263          	beq	a4,a5,80005cec <uartstart+0x68>
    80005cac:	100005b7          	lui	a1,0x10000
    80005cb0:	00004817          	auipc	a6,0x4
    80005cb4:	22080813          	addi	a6,a6,544 # 80009ed0 <uart_tx_buf>
    80005cb8:	01c0006f          	j	80005cd4 <uartstart+0x50>
    80005cbc:	0006c703          	lbu	a4,0(a3)
    80005cc0:	00f63023          	sd	a5,0(a2)
    80005cc4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005cc8:	00063783          	ld	a5,0(a2)
    80005ccc:	00053703          	ld	a4,0(a0)
    80005cd0:	00f70e63          	beq	a4,a5,80005cec <uartstart+0x68>
    80005cd4:	01f7f713          	andi	a4,a5,31
    80005cd8:	00e806b3          	add	a3,a6,a4
    80005cdc:	0055c703          	lbu	a4,5(a1)
    80005ce0:	00178793          	addi	a5,a5,1
    80005ce4:	02077713          	andi	a4,a4,32
    80005ce8:	fc071ae3          	bnez	a4,80005cbc <uartstart+0x38>
    80005cec:	00813403          	ld	s0,8(sp)
    80005cf0:	01010113          	addi	sp,sp,16
    80005cf4:	00008067          	ret

0000000080005cf8 <uartgetc>:
    80005cf8:	ff010113          	addi	sp,sp,-16
    80005cfc:	00813423          	sd	s0,8(sp)
    80005d00:	01010413          	addi	s0,sp,16
    80005d04:	10000737          	lui	a4,0x10000
    80005d08:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005d0c:	0017f793          	andi	a5,a5,1
    80005d10:	00078c63          	beqz	a5,80005d28 <uartgetc+0x30>
    80005d14:	00074503          	lbu	a0,0(a4)
    80005d18:	0ff57513          	andi	a0,a0,255
    80005d1c:	00813403          	ld	s0,8(sp)
    80005d20:	01010113          	addi	sp,sp,16
    80005d24:	00008067          	ret
    80005d28:	fff00513          	li	a0,-1
    80005d2c:	ff1ff06f          	j	80005d1c <uartgetc+0x24>

0000000080005d30 <uartintr>:
    80005d30:	100007b7          	lui	a5,0x10000
    80005d34:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005d38:	0017f793          	andi	a5,a5,1
    80005d3c:	0a078463          	beqz	a5,80005de4 <uartintr+0xb4>
    80005d40:	fe010113          	addi	sp,sp,-32
    80005d44:	00813823          	sd	s0,16(sp)
    80005d48:	00913423          	sd	s1,8(sp)
    80005d4c:	00113c23          	sd	ra,24(sp)
    80005d50:	02010413          	addi	s0,sp,32
    80005d54:	100004b7          	lui	s1,0x10000
    80005d58:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80005d5c:	0ff57513          	andi	a0,a0,255
    80005d60:	fffff097          	auipc	ra,0xfffff
    80005d64:	534080e7          	jalr	1332(ra) # 80005294 <consoleintr>
    80005d68:	0054c783          	lbu	a5,5(s1)
    80005d6c:	0017f793          	andi	a5,a5,1
    80005d70:	fe0794e3          	bnez	a5,80005d58 <uartintr+0x28>
    80005d74:	00003617          	auipc	a2,0x3
    80005d78:	eec60613          	addi	a2,a2,-276 # 80008c60 <uart_tx_r>
    80005d7c:	00003517          	auipc	a0,0x3
    80005d80:	eec50513          	addi	a0,a0,-276 # 80008c68 <uart_tx_w>
    80005d84:	00063783          	ld	a5,0(a2)
    80005d88:	00053703          	ld	a4,0(a0)
    80005d8c:	04f70263          	beq	a4,a5,80005dd0 <uartintr+0xa0>
    80005d90:	100005b7          	lui	a1,0x10000
    80005d94:	00004817          	auipc	a6,0x4
    80005d98:	13c80813          	addi	a6,a6,316 # 80009ed0 <uart_tx_buf>
    80005d9c:	01c0006f          	j	80005db8 <uartintr+0x88>
    80005da0:	0006c703          	lbu	a4,0(a3)
    80005da4:	00f63023          	sd	a5,0(a2)
    80005da8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005dac:	00063783          	ld	a5,0(a2)
    80005db0:	00053703          	ld	a4,0(a0)
    80005db4:	00f70e63          	beq	a4,a5,80005dd0 <uartintr+0xa0>
    80005db8:	01f7f713          	andi	a4,a5,31
    80005dbc:	00e806b3          	add	a3,a6,a4
    80005dc0:	0055c703          	lbu	a4,5(a1)
    80005dc4:	00178793          	addi	a5,a5,1
    80005dc8:	02077713          	andi	a4,a4,32
    80005dcc:	fc071ae3          	bnez	a4,80005da0 <uartintr+0x70>
    80005dd0:	01813083          	ld	ra,24(sp)
    80005dd4:	01013403          	ld	s0,16(sp)
    80005dd8:	00813483          	ld	s1,8(sp)
    80005ddc:	02010113          	addi	sp,sp,32
    80005de0:	00008067          	ret
    80005de4:	00003617          	auipc	a2,0x3
    80005de8:	e7c60613          	addi	a2,a2,-388 # 80008c60 <uart_tx_r>
    80005dec:	00003517          	auipc	a0,0x3
    80005df0:	e7c50513          	addi	a0,a0,-388 # 80008c68 <uart_tx_w>
    80005df4:	00063783          	ld	a5,0(a2)
    80005df8:	00053703          	ld	a4,0(a0)
    80005dfc:	04f70263          	beq	a4,a5,80005e40 <uartintr+0x110>
    80005e00:	100005b7          	lui	a1,0x10000
    80005e04:	00004817          	auipc	a6,0x4
    80005e08:	0cc80813          	addi	a6,a6,204 # 80009ed0 <uart_tx_buf>
    80005e0c:	01c0006f          	j	80005e28 <uartintr+0xf8>
    80005e10:	0006c703          	lbu	a4,0(a3)
    80005e14:	00f63023          	sd	a5,0(a2)
    80005e18:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005e1c:	00063783          	ld	a5,0(a2)
    80005e20:	00053703          	ld	a4,0(a0)
    80005e24:	02f70063          	beq	a4,a5,80005e44 <uartintr+0x114>
    80005e28:	01f7f713          	andi	a4,a5,31
    80005e2c:	00e806b3          	add	a3,a6,a4
    80005e30:	0055c703          	lbu	a4,5(a1)
    80005e34:	00178793          	addi	a5,a5,1
    80005e38:	02077713          	andi	a4,a4,32
    80005e3c:	fc071ae3          	bnez	a4,80005e10 <uartintr+0xe0>
    80005e40:	00008067          	ret
    80005e44:	00008067          	ret

0000000080005e48 <kinit>:
    80005e48:	fc010113          	addi	sp,sp,-64
    80005e4c:	02913423          	sd	s1,40(sp)
    80005e50:	fffff7b7          	lui	a5,0xfffff
    80005e54:	00005497          	auipc	s1,0x5
    80005e58:	0ab48493          	addi	s1,s1,171 # 8000aeff <end+0xfff>
    80005e5c:	02813823          	sd	s0,48(sp)
    80005e60:	01313c23          	sd	s3,24(sp)
    80005e64:	00f4f4b3          	and	s1,s1,a5
    80005e68:	02113c23          	sd	ra,56(sp)
    80005e6c:	03213023          	sd	s2,32(sp)
    80005e70:	01413823          	sd	s4,16(sp)
    80005e74:	01513423          	sd	s5,8(sp)
    80005e78:	04010413          	addi	s0,sp,64
    80005e7c:	000017b7          	lui	a5,0x1
    80005e80:	01100993          	li	s3,17
    80005e84:	00f487b3          	add	a5,s1,a5
    80005e88:	01b99993          	slli	s3,s3,0x1b
    80005e8c:	06f9e063          	bltu	s3,a5,80005eec <kinit+0xa4>
    80005e90:	00004a97          	auipc	s5,0x4
    80005e94:	070a8a93          	addi	s5,s5,112 # 80009f00 <end>
    80005e98:	0754ec63          	bltu	s1,s5,80005f10 <kinit+0xc8>
    80005e9c:	0734fa63          	bgeu	s1,s3,80005f10 <kinit+0xc8>
    80005ea0:	00088a37          	lui	s4,0x88
    80005ea4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005ea8:	00003917          	auipc	s2,0x3
    80005eac:	dc890913          	addi	s2,s2,-568 # 80008c70 <kmem>
    80005eb0:	00ca1a13          	slli	s4,s4,0xc
    80005eb4:	0140006f          	j	80005ec8 <kinit+0x80>
    80005eb8:	000017b7          	lui	a5,0x1
    80005ebc:	00f484b3          	add	s1,s1,a5
    80005ec0:	0554e863          	bltu	s1,s5,80005f10 <kinit+0xc8>
    80005ec4:	0534f663          	bgeu	s1,s3,80005f10 <kinit+0xc8>
    80005ec8:	00001637          	lui	a2,0x1
    80005ecc:	00100593          	li	a1,1
    80005ed0:	00048513          	mv	a0,s1
    80005ed4:	00000097          	auipc	ra,0x0
    80005ed8:	5e4080e7          	jalr	1508(ra) # 800064b8 <__memset>
    80005edc:	00093783          	ld	a5,0(s2)
    80005ee0:	00f4b023          	sd	a5,0(s1)
    80005ee4:	00993023          	sd	s1,0(s2)
    80005ee8:	fd4498e3          	bne	s1,s4,80005eb8 <kinit+0x70>
    80005eec:	03813083          	ld	ra,56(sp)
    80005ef0:	03013403          	ld	s0,48(sp)
    80005ef4:	02813483          	ld	s1,40(sp)
    80005ef8:	02013903          	ld	s2,32(sp)
    80005efc:	01813983          	ld	s3,24(sp)
    80005f00:	01013a03          	ld	s4,16(sp)
    80005f04:	00813a83          	ld	s5,8(sp)
    80005f08:	04010113          	addi	sp,sp,64
    80005f0c:	00008067          	ret
    80005f10:	00002517          	auipc	a0,0x2
    80005f14:	98050513          	addi	a0,a0,-1664 # 80007890 <digits+0x18>
    80005f18:	fffff097          	auipc	ra,0xfffff
    80005f1c:	4b4080e7          	jalr	1204(ra) # 800053cc <panic>

0000000080005f20 <freerange>:
    80005f20:	fc010113          	addi	sp,sp,-64
    80005f24:	000017b7          	lui	a5,0x1
    80005f28:	02913423          	sd	s1,40(sp)
    80005f2c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005f30:	009504b3          	add	s1,a0,s1
    80005f34:	fffff537          	lui	a0,0xfffff
    80005f38:	02813823          	sd	s0,48(sp)
    80005f3c:	02113c23          	sd	ra,56(sp)
    80005f40:	03213023          	sd	s2,32(sp)
    80005f44:	01313c23          	sd	s3,24(sp)
    80005f48:	01413823          	sd	s4,16(sp)
    80005f4c:	01513423          	sd	s5,8(sp)
    80005f50:	01613023          	sd	s6,0(sp)
    80005f54:	04010413          	addi	s0,sp,64
    80005f58:	00a4f4b3          	and	s1,s1,a0
    80005f5c:	00f487b3          	add	a5,s1,a5
    80005f60:	06f5e463          	bltu	a1,a5,80005fc8 <freerange+0xa8>
    80005f64:	00004a97          	auipc	s5,0x4
    80005f68:	f9ca8a93          	addi	s5,s5,-100 # 80009f00 <end>
    80005f6c:	0954e263          	bltu	s1,s5,80005ff0 <freerange+0xd0>
    80005f70:	01100993          	li	s3,17
    80005f74:	01b99993          	slli	s3,s3,0x1b
    80005f78:	0734fc63          	bgeu	s1,s3,80005ff0 <freerange+0xd0>
    80005f7c:	00058a13          	mv	s4,a1
    80005f80:	00003917          	auipc	s2,0x3
    80005f84:	cf090913          	addi	s2,s2,-784 # 80008c70 <kmem>
    80005f88:	00002b37          	lui	s6,0x2
    80005f8c:	0140006f          	j	80005fa0 <freerange+0x80>
    80005f90:	000017b7          	lui	a5,0x1
    80005f94:	00f484b3          	add	s1,s1,a5
    80005f98:	0554ec63          	bltu	s1,s5,80005ff0 <freerange+0xd0>
    80005f9c:	0534fa63          	bgeu	s1,s3,80005ff0 <freerange+0xd0>
    80005fa0:	00001637          	lui	a2,0x1
    80005fa4:	00100593          	li	a1,1
    80005fa8:	00048513          	mv	a0,s1
    80005fac:	00000097          	auipc	ra,0x0
    80005fb0:	50c080e7          	jalr	1292(ra) # 800064b8 <__memset>
    80005fb4:	00093703          	ld	a4,0(s2)
    80005fb8:	016487b3          	add	a5,s1,s6
    80005fbc:	00e4b023          	sd	a4,0(s1)
    80005fc0:	00993023          	sd	s1,0(s2)
    80005fc4:	fcfa76e3          	bgeu	s4,a5,80005f90 <freerange+0x70>
    80005fc8:	03813083          	ld	ra,56(sp)
    80005fcc:	03013403          	ld	s0,48(sp)
    80005fd0:	02813483          	ld	s1,40(sp)
    80005fd4:	02013903          	ld	s2,32(sp)
    80005fd8:	01813983          	ld	s3,24(sp)
    80005fdc:	01013a03          	ld	s4,16(sp)
    80005fe0:	00813a83          	ld	s5,8(sp)
    80005fe4:	00013b03          	ld	s6,0(sp)
    80005fe8:	04010113          	addi	sp,sp,64
    80005fec:	00008067          	ret
    80005ff0:	00002517          	auipc	a0,0x2
    80005ff4:	8a050513          	addi	a0,a0,-1888 # 80007890 <digits+0x18>
    80005ff8:	fffff097          	auipc	ra,0xfffff
    80005ffc:	3d4080e7          	jalr	980(ra) # 800053cc <panic>

0000000080006000 <kfree>:
    80006000:	fe010113          	addi	sp,sp,-32
    80006004:	00813823          	sd	s0,16(sp)
    80006008:	00113c23          	sd	ra,24(sp)
    8000600c:	00913423          	sd	s1,8(sp)
    80006010:	02010413          	addi	s0,sp,32
    80006014:	03451793          	slli	a5,a0,0x34
    80006018:	04079c63          	bnez	a5,80006070 <kfree+0x70>
    8000601c:	00004797          	auipc	a5,0x4
    80006020:	ee478793          	addi	a5,a5,-284 # 80009f00 <end>
    80006024:	00050493          	mv	s1,a0
    80006028:	04f56463          	bltu	a0,a5,80006070 <kfree+0x70>
    8000602c:	01100793          	li	a5,17
    80006030:	01b79793          	slli	a5,a5,0x1b
    80006034:	02f57e63          	bgeu	a0,a5,80006070 <kfree+0x70>
    80006038:	00001637          	lui	a2,0x1
    8000603c:	00100593          	li	a1,1
    80006040:	00000097          	auipc	ra,0x0
    80006044:	478080e7          	jalr	1144(ra) # 800064b8 <__memset>
    80006048:	00003797          	auipc	a5,0x3
    8000604c:	c2878793          	addi	a5,a5,-984 # 80008c70 <kmem>
    80006050:	0007b703          	ld	a4,0(a5)
    80006054:	01813083          	ld	ra,24(sp)
    80006058:	01013403          	ld	s0,16(sp)
    8000605c:	00e4b023          	sd	a4,0(s1)
    80006060:	0097b023          	sd	s1,0(a5)
    80006064:	00813483          	ld	s1,8(sp)
    80006068:	02010113          	addi	sp,sp,32
    8000606c:	00008067          	ret
    80006070:	00002517          	auipc	a0,0x2
    80006074:	82050513          	addi	a0,a0,-2016 # 80007890 <digits+0x18>
    80006078:	fffff097          	auipc	ra,0xfffff
    8000607c:	354080e7          	jalr	852(ra) # 800053cc <panic>

0000000080006080 <kalloc>:
    80006080:	fe010113          	addi	sp,sp,-32
    80006084:	00813823          	sd	s0,16(sp)
    80006088:	00913423          	sd	s1,8(sp)
    8000608c:	00113c23          	sd	ra,24(sp)
    80006090:	02010413          	addi	s0,sp,32
    80006094:	00003797          	auipc	a5,0x3
    80006098:	bdc78793          	addi	a5,a5,-1060 # 80008c70 <kmem>
    8000609c:	0007b483          	ld	s1,0(a5)
    800060a0:	02048063          	beqz	s1,800060c0 <kalloc+0x40>
    800060a4:	0004b703          	ld	a4,0(s1)
    800060a8:	00001637          	lui	a2,0x1
    800060ac:	00500593          	li	a1,5
    800060b0:	00048513          	mv	a0,s1
    800060b4:	00e7b023          	sd	a4,0(a5)
    800060b8:	00000097          	auipc	ra,0x0
    800060bc:	400080e7          	jalr	1024(ra) # 800064b8 <__memset>
    800060c0:	01813083          	ld	ra,24(sp)
    800060c4:	01013403          	ld	s0,16(sp)
    800060c8:	00048513          	mv	a0,s1
    800060cc:	00813483          	ld	s1,8(sp)
    800060d0:	02010113          	addi	sp,sp,32
    800060d4:	00008067          	ret

00000000800060d8 <initlock>:
    800060d8:	ff010113          	addi	sp,sp,-16
    800060dc:	00813423          	sd	s0,8(sp)
    800060e0:	01010413          	addi	s0,sp,16
    800060e4:	00813403          	ld	s0,8(sp)
    800060e8:	00b53423          	sd	a1,8(a0)
    800060ec:	00052023          	sw	zero,0(a0)
    800060f0:	00053823          	sd	zero,16(a0)
    800060f4:	01010113          	addi	sp,sp,16
    800060f8:	00008067          	ret

00000000800060fc <acquire>:
    800060fc:	fe010113          	addi	sp,sp,-32
    80006100:	00813823          	sd	s0,16(sp)
    80006104:	00913423          	sd	s1,8(sp)
    80006108:	00113c23          	sd	ra,24(sp)
    8000610c:	01213023          	sd	s2,0(sp)
    80006110:	02010413          	addi	s0,sp,32
    80006114:	00050493          	mv	s1,a0
    80006118:	10002973          	csrr	s2,sstatus
    8000611c:	100027f3          	csrr	a5,sstatus
    80006120:	ffd7f793          	andi	a5,a5,-3
    80006124:	10079073          	csrw	sstatus,a5
    80006128:	fffff097          	auipc	ra,0xfffff
    8000612c:	8e8080e7          	jalr	-1816(ra) # 80004a10 <mycpu>
    80006130:	07852783          	lw	a5,120(a0)
    80006134:	06078e63          	beqz	a5,800061b0 <acquire+0xb4>
    80006138:	fffff097          	auipc	ra,0xfffff
    8000613c:	8d8080e7          	jalr	-1832(ra) # 80004a10 <mycpu>
    80006140:	07852783          	lw	a5,120(a0)
    80006144:	0004a703          	lw	a4,0(s1)
    80006148:	0017879b          	addiw	a5,a5,1
    8000614c:	06f52c23          	sw	a5,120(a0)
    80006150:	04071063          	bnez	a4,80006190 <acquire+0x94>
    80006154:	00100713          	li	a4,1
    80006158:	00070793          	mv	a5,a4
    8000615c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006160:	0007879b          	sext.w	a5,a5
    80006164:	fe079ae3          	bnez	a5,80006158 <acquire+0x5c>
    80006168:	0ff0000f          	fence
    8000616c:	fffff097          	auipc	ra,0xfffff
    80006170:	8a4080e7          	jalr	-1884(ra) # 80004a10 <mycpu>
    80006174:	01813083          	ld	ra,24(sp)
    80006178:	01013403          	ld	s0,16(sp)
    8000617c:	00a4b823          	sd	a0,16(s1)
    80006180:	00013903          	ld	s2,0(sp)
    80006184:	00813483          	ld	s1,8(sp)
    80006188:	02010113          	addi	sp,sp,32
    8000618c:	00008067          	ret
    80006190:	0104b903          	ld	s2,16(s1)
    80006194:	fffff097          	auipc	ra,0xfffff
    80006198:	87c080e7          	jalr	-1924(ra) # 80004a10 <mycpu>
    8000619c:	faa91ce3          	bne	s2,a0,80006154 <acquire+0x58>
    800061a0:	00001517          	auipc	a0,0x1
    800061a4:	6f850513          	addi	a0,a0,1784 # 80007898 <digits+0x20>
    800061a8:	fffff097          	auipc	ra,0xfffff
    800061ac:	224080e7          	jalr	548(ra) # 800053cc <panic>
    800061b0:	00195913          	srli	s2,s2,0x1
    800061b4:	fffff097          	auipc	ra,0xfffff
    800061b8:	85c080e7          	jalr	-1956(ra) # 80004a10 <mycpu>
    800061bc:	00197913          	andi	s2,s2,1
    800061c0:	07252e23          	sw	s2,124(a0)
    800061c4:	f75ff06f          	j	80006138 <acquire+0x3c>

00000000800061c8 <release>:
    800061c8:	fe010113          	addi	sp,sp,-32
    800061cc:	00813823          	sd	s0,16(sp)
    800061d0:	00113c23          	sd	ra,24(sp)
    800061d4:	00913423          	sd	s1,8(sp)
    800061d8:	01213023          	sd	s2,0(sp)
    800061dc:	02010413          	addi	s0,sp,32
    800061e0:	00052783          	lw	a5,0(a0)
    800061e4:	00079a63          	bnez	a5,800061f8 <release+0x30>
    800061e8:	00001517          	auipc	a0,0x1
    800061ec:	6b850513          	addi	a0,a0,1720 # 800078a0 <digits+0x28>
    800061f0:	fffff097          	auipc	ra,0xfffff
    800061f4:	1dc080e7          	jalr	476(ra) # 800053cc <panic>
    800061f8:	01053903          	ld	s2,16(a0)
    800061fc:	00050493          	mv	s1,a0
    80006200:	fffff097          	auipc	ra,0xfffff
    80006204:	810080e7          	jalr	-2032(ra) # 80004a10 <mycpu>
    80006208:	fea910e3          	bne	s2,a0,800061e8 <release+0x20>
    8000620c:	0004b823          	sd	zero,16(s1)
    80006210:	0ff0000f          	fence
    80006214:	0f50000f          	fence	iorw,ow
    80006218:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000621c:	ffffe097          	auipc	ra,0xffffe
    80006220:	7f4080e7          	jalr	2036(ra) # 80004a10 <mycpu>
    80006224:	100027f3          	csrr	a5,sstatus
    80006228:	0027f793          	andi	a5,a5,2
    8000622c:	04079a63          	bnez	a5,80006280 <release+0xb8>
    80006230:	07852783          	lw	a5,120(a0)
    80006234:	02f05e63          	blez	a5,80006270 <release+0xa8>
    80006238:	fff7871b          	addiw	a4,a5,-1
    8000623c:	06e52c23          	sw	a4,120(a0)
    80006240:	00071c63          	bnez	a4,80006258 <release+0x90>
    80006244:	07c52783          	lw	a5,124(a0)
    80006248:	00078863          	beqz	a5,80006258 <release+0x90>
    8000624c:	100027f3          	csrr	a5,sstatus
    80006250:	0027e793          	ori	a5,a5,2
    80006254:	10079073          	csrw	sstatus,a5
    80006258:	01813083          	ld	ra,24(sp)
    8000625c:	01013403          	ld	s0,16(sp)
    80006260:	00813483          	ld	s1,8(sp)
    80006264:	00013903          	ld	s2,0(sp)
    80006268:	02010113          	addi	sp,sp,32
    8000626c:	00008067          	ret
    80006270:	00001517          	auipc	a0,0x1
    80006274:	65050513          	addi	a0,a0,1616 # 800078c0 <digits+0x48>
    80006278:	fffff097          	auipc	ra,0xfffff
    8000627c:	154080e7          	jalr	340(ra) # 800053cc <panic>
    80006280:	00001517          	auipc	a0,0x1
    80006284:	62850513          	addi	a0,a0,1576 # 800078a8 <digits+0x30>
    80006288:	fffff097          	auipc	ra,0xfffff
    8000628c:	144080e7          	jalr	324(ra) # 800053cc <panic>

0000000080006290 <holding>:
    80006290:	00052783          	lw	a5,0(a0)
    80006294:	00079663          	bnez	a5,800062a0 <holding+0x10>
    80006298:	00000513          	li	a0,0
    8000629c:	00008067          	ret
    800062a0:	fe010113          	addi	sp,sp,-32
    800062a4:	00813823          	sd	s0,16(sp)
    800062a8:	00913423          	sd	s1,8(sp)
    800062ac:	00113c23          	sd	ra,24(sp)
    800062b0:	02010413          	addi	s0,sp,32
    800062b4:	01053483          	ld	s1,16(a0)
    800062b8:	ffffe097          	auipc	ra,0xffffe
    800062bc:	758080e7          	jalr	1880(ra) # 80004a10 <mycpu>
    800062c0:	01813083          	ld	ra,24(sp)
    800062c4:	01013403          	ld	s0,16(sp)
    800062c8:	40a48533          	sub	a0,s1,a0
    800062cc:	00153513          	seqz	a0,a0
    800062d0:	00813483          	ld	s1,8(sp)
    800062d4:	02010113          	addi	sp,sp,32
    800062d8:	00008067          	ret

00000000800062dc <push_off>:
    800062dc:	fe010113          	addi	sp,sp,-32
    800062e0:	00813823          	sd	s0,16(sp)
    800062e4:	00113c23          	sd	ra,24(sp)
    800062e8:	00913423          	sd	s1,8(sp)
    800062ec:	02010413          	addi	s0,sp,32
    800062f0:	100024f3          	csrr	s1,sstatus
    800062f4:	100027f3          	csrr	a5,sstatus
    800062f8:	ffd7f793          	andi	a5,a5,-3
    800062fc:	10079073          	csrw	sstatus,a5
    80006300:	ffffe097          	auipc	ra,0xffffe
    80006304:	710080e7          	jalr	1808(ra) # 80004a10 <mycpu>
    80006308:	07852783          	lw	a5,120(a0)
    8000630c:	02078663          	beqz	a5,80006338 <push_off+0x5c>
    80006310:	ffffe097          	auipc	ra,0xffffe
    80006314:	700080e7          	jalr	1792(ra) # 80004a10 <mycpu>
    80006318:	07852783          	lw	a5,120(a0)
    8000631c:	01813083          	ld	ra,24(sp)
    80006320:	01013403          	ld	s0,16(sp)
    80006324:	0017879b          	addiw	a5,a5,1
    80006328:	06f52c23          	sw	a5,120(a0)
    8000632c:	00813483          	ld	s1,8(sp)
    80006330:	02010113          	addi	sp,sp,32
    80006334:	00008067          	ret
    80006338:	0014d493          	srli	s1,s1,0x1
    8000633c:	ffffe097          	auipc	ra,0xffffe
    80006340:	6d4080e7          	jalr	1748(ra) # 80004a10 <mycpu>
    80006344:	0014f493          	andi	s1,s1,1
    80006348:	06952e23          	sw	s1,124(a0)
    8000634c:	fc5ff06f          	j	80006310 <push_off+0x34>

0000000080006350 <pop_off>:
    80006350:	ff010113          	addi	sp,sp,-16
    80006354:	00813023          	sd	s0,0(sp)
    80006358:	00113423          	sd	ra,8(sp)
    8000635c:	01010413          	addi	s0,sp,16
    80006360:	ffffe097          	auipc	ra,0xffffe
    80006364:	6b0080e7          	jalr	1712(ra) # 80004a10 <mycpu>
    80006368:	100027f3          	csrr	a5,sstatus
    8000636c:	0027f793          	andi	a5,a5,2
    80006370:	04079663          	bnez	a5,800063bc <pop_off+0x6c>
    80006374:	07852783          	lw	a5,120(a0)
    80006378:	02f05a63          	blez	a5,800063ac <pop_off+0x5c>
    8000637c:	fff7871b          	addiw	a4,a5,-1
    80006380:	06e52c23          	sw	a4,120(a0)
    80006384:	00071c63          	bnez	a4,8000639c <pop_off+0x4c>
    80006388:	07c52783          	lw	a5,124(a0)
    8000638c:	00078863          	beqz	a5,8000639c <pop_off+0x4c>
    80006390:	100027f3          	csrr	a5,sstatus
    80006394:	0027e793          	ori	a5,a5,2
    80006398:	10079073          	csrw	sstatus,a5
    8000639c:	00813083          	ld	ra,8(sp)
    800063a0:	00013403          	ld	s0,0(sp)
    800063a4:	01010113          	addi	sp,sp,16
    800063a8:	00008067          	ret
    800063ac:	00001517          	auipc	a0,0x1
    800063b0:	51450513          	addi	a0,a0,1300 # 800078c0 <digits+0x48>
    800063b4:	fffff097          	auipc	ra,0xfffff
    800063b8:	018080e7          	jalr	24(ra) # 800053cc <panic>
    800063bc:	00001517          	auipc	a0,0x1
    800063c0:	4ec50513          	addi	a0,a0,1260 # 800078a8 <digits+0x30>
    800063c4:	fffff097          	auipc	ra,0xfffff
    800063c8:	008080e7          	jalr	8(ra) # 800053cc <panic>

00000000800063cc <push_on>:
    800063cc:	fe010113          	addi	sp,sp,-32
    800063d0:	00813823          	sd	s0,16(sp)
    800063d4:	00113c23          	sd	ra,24(sp)
    800063d8:	00913423          	sd	s1,8(sp)
    800063dc:	02010413          	addi	s0,sp,32
    800063e0:	100024f3          	csrr	s1,sstatus
    800063e4:	100027f3          	csrr	a5,sstatus
    800063e8:	0027e793          	ori	a5,a5,2
    800063ec:	10079073          	csrw	sstatus,a5
    800063f0:	ffffe097          	auipc	ra,0xffffe
    800063f4:	620080e7          	jalr	1568(ra) # 80004a10 <mycpu>
    800063f8:	07852783          	lw	a5,120(a0)
    800063fc:	02078663          	beqz	a5,80006428 <push_on+0x5c>
    80006400:	ffffe097          	auipc	ra,0xffffe
    80006404:	610080e7          	jalr	1552(ra) # 80004a10 <mycpu>
    80006408:	07852783          	lw	a5,120(a0)
    8000640c:	01813083          	ld	ra,24(sp)
    80006410:	01013403          	ld	s0,16(sp)
    80006414:	0017879b          	addiw	a5,a5,1
    80006418:	06f52c23          	sw	a5,120(a0)
    8000641c:	00813483          	ld	s1,8(sp)
    80006420:	02010113          	addi	sp,sp,32
    80006424:	00008067          	ret
    80006428:	0014d493          	srli	s1,s1,0x1
    8000642c:	ffffe097          	auipc	ra,0xffffe
    80006430:	5e4080e7          	jalr	1508(ra) # 80004a10 <mycpu>
    80006434:	0014f493          	andi	s1,s1,1
    80006438:	06952e23          	sw	s1,124(a0)
    8000643c:	fc5ff06f          	j	80006400 <push_on+0x34>

0000000080006440 <pop_on>:
    80006440:	ff010113          	addi	sp,sp,-16
    80006444:	00813023          	sd	s0,0(sp)
    80006448:	00113423          	sd	ra,8(sp)
    8000644c:	01010413          	addi	s0,sp,16
    80006450:	ffffe097          	auipc	ra,0xffffe
    80006454:	5c0080e7          	jalr	1472(ra) # 80004a10 <mycpu>
    80006458:	100027f3          	csrr	a5,sstatus
    8000645c:	0027f793          	andi	a5,a5,2
    80006460:	04078463          	beqz	a5,800064a8 <pop_on+0x68>
    80006464:	07852783          	lw	a5,120(a0)
    80006468:	02f05863          	blez	a5,80006498 <pop_on+0x58>
    8000646c:	fff7879b          	addiw	a5,a5,-1
    80006470:	06f52c23          	sw	a5,120(a0)
    80006474:	07853783          	ld	a5,120(a0)
    80006478:	00079863          	bnez	a5,80006488 <pop_on+0x48>
    8000647c:	100027f3          	csrr	a5,sstatus
    80006480:	ffd7f793          	andi	a5,a5,-3
    80006484:	10079073          	csrw	sstatus,a5
    80006488:	00813083          	ld	ra,8(sp)
    8000648c:	00013403          	ld	s0,0(sp)
    80006490:	01010113          	addi	sp,sp,16
    80006494:	00008067          	ret
    80006498:	00001517          	auipc	a0,0x1
    8000649c:	45050513          	addi	a0,a0,1104 # 800078e8 <digits+0x70>
    800064a0:	fffff097          	auipc	ra,0xfffff
    800064a4:	f2c080e7          	jalr	-212(ra) # 800053cc <panic>
    800064a8:	00001517          	auipc	a0,0x1
    800064ac:	42050513          	addi	a0,a0,1056 # 800078c8 <digits+0x50>
    800064b0:	fffff097          	auipc	ra,0xfffff
    800064b4:	f1c080e7          	jalr	-228(ra) # 800053cc <panic>

00000000800064b8 <__memset>:
    800064b8:	ff010113          	addi	sp,sp,-16
    800064bc:	00813423          	sd	s0,8(sp)
    800064c0:	01010413          	addi	s0,sp,16
    800064c4:	1a060e63          	beqz	a2,80006680 <__memset+0x1c8>
    800064c8:	40a007b3          	neg	a5,a0
    800064cc:	0077f793          	andi	a5,a5,7
    800064d0:	00778693          	addi	a3,a5,7
    800064d4:	00b00813          	li	a6,11
    800064d8:	0ff5f593          	andi	a1,a1,255
    800064dc:	fff6071b          	addiw	a4,a2,-1
    800064e0:	1b06e663          	bltu	a3,a6,8000668c <__memset+0x1d4>
    800064e4:	1cd76463          	bltu	a4,a3,800066ac <__memset+0x1f4>
    800064e8:	1a078e63          	beqz	a5,800066a4 <__memset+0x1ec>
    800064ec:	00b50023          	sb	a1,0(a0)
    800064f0:	00100713          	li	a4,1
    800064f4:	1ae78463          	beq	a5,a4,8000669c <__memset+0x1e4>
    800064f8:	00b500a3          	sb	a1,1(a0)
    800064fc:	00200713          	li	a4,2
    80006500:	1ae78a63          	beq	a5,a4,800066b4 <__memset+0x1fc>
    80006504:	00b50123          	sb	a1,2(a0)
    80006508:	00300713          	li	a4,3
    8000650c:	18e78463          	beq	a5,a4,80006694 <__memset+0x1dc>
    80006510:	00b501a3          	sb	a1,3(a0)
    80006514:	00400713          	li	a4,4
    80006518:	1ae78263          	beq	a5,a4,800066bc <__memset+0x204>
    8000651c:	00b50223          	sb	a1,4(a0)
    80006520:	00500713          	li	a4,5
    80006524:	1ae78063          	beq	a5,a4,800066c4 <__memset+0x20c>
    80006528:	00b502a3          	sb	a1,5(a0)
    8000652c:	00700713          	li	a4,7
    80006530:	18e79e63          	bne	a5,a4,800066cc <__memset+0x214>
    80006534:	00b50323          	sb	a1,6(a0)
    80006538:	00700e93          	li	t4,7
    8000653c:	00859713          	slli	a4,a1,0x8
    80006540:	00e5e733          	or	a4,a1,a4
    80006544:	01059e13          	slli	t3,a1,0x10
    80006548:	01c76e33          	or	t3,a4,t3
    8000654c:	01859313          	slli	t1,a1,0x18
    80006550:	006e6333          	or	t1,t3,t1
    80006554:	02059893          	slli	a7,a1,0x20
    80006558:	40f60e3b          	subw	t3,a2,a5
    8000655c:	011368b3          	or	a7,t1,a7
    80006560:	02859813          	slli	a6,a1,0x28
    80006564:	0108e833          	or	a6,a7,a6
    80006568:	03059693          	slli	a3,a1,0x30
    8000656c:	003e589b          	srliw	a7,t3,0x3
    80006570:	00d866b3          	or	a3,a6,a3
    80006574:	03859713          	slli	a4,a1,0x38
    80006578:	00389813          	slli	a6,a7,0x3
    8000657c:	00f507b3          	add	a5,a0,a5
    80006580:	00e6e733          	or	a4,a3,a4
    80006584:	000e089b          	sext.w	a7,t3
    80006588:	00f806b3          	add	a3,a6,a5
    8000658c:	00e7b023          	sd	a4,0(a5)
    80006590:	00878793          	addi	a5,a5,8
    80006594:	fed79ce3          	bne	a5,a3,8000658c <__memset+0xd4>
    80006598:	ff8e7793          	andi	a5,t3,-8
    8000659c:	0007871b          	sext.w	a4,a5
    800065a0:	01d787bb          	addw	a5,a5,t4
    800065a4:	0ce88e63          	beq	a7,a4,80006680 <__memset+0x1c8>
    800065a8:	00f50733          	add	a4,a0,a5
    800065ac:	00b70023          	sb	a1,0(a4)
    800065b0:	0017871b          	addiw	a4,a5,1
    800065b4:	0cc77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    800065b8:	00e50733          	add	a4,a0,a4
    800065bc:	00b70023          	sb	a1,0(a4)
    800065c0:	0027871b          	addiw	a4,a5,2
    800065c4:	0ac77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    800065c8:	00e50733          	add	a4,a0,a4
    800065cc:	00b70023          	sb	a1,0(a4)
    800065d0:	0037871b          	addiw	a4,a5,3
    800065d4:	0ac77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    800065d8:	00e50733          	add	a4,a0,a4
    800065dc:	00b70023          	sb	a1,0(a4)
    800065e0:	0047871b          	addiw	a4,a5,4
    800065e4:	08c77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    800065e8:	00e50733          	add	a4,a0,a4
    800065ec:	00b70023          	sb	a1,0(a4)
    800065f0:	0057871b          	addiw	a4,a5,5
    800065f4:	08c77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    800065f8:	00e50733          	add	a4,a0,a4
    800065fc:	00b70023          	sb	a1,0(a4)
    80006600:	0067871b          	addiw	a4,a5,6
    80006604:	06c77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006608:	00e50733          	add	a4,a0,a4
    8000660c:	00b70023          	sb	a1,0(a4)
    80006610:	0077871b          	addiw	a4,a5,7
    80006614:	06c77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006618:	00e50733          	add	a4,a0,a4
    8000661c:	00b70023          	sb	a1,0(a4)
    80006620:	0087871b          	addiw	a4,a5,8
    80006624:	04c77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006628:	00e50733          	add	a4,a0,a4
    8000662c:	00b70023          	sb	a1,0(a4)
    80006630:	0097871b          	addiw	a4,a5,9
    80006634:	04c77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006638:	00e50733          	add	a4,a0,a4
    8000663c:	00b70023          	sb	a1,0(a4)
    80006640:	00a7871b          	addiw	a4,a5,10
    80006644:	02c77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006648:	00e50733          	add	a4,a0,a4
    8000664c:	00b70023          	sb	a1,0(a4)
    80006650:	00b7871b          	addiw	a4,a5,11
    80006654:	02c77663          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006658:	00e50733          	add	a4,a0,a4
    8000665c:	00b70023          	sb	a1,0(a4)
    80006660:	00c7871b          	addiw	a4,a5,12
    80006664:	00c77e63          	bgeu	a4,a2,80006680 <__memset+0x1c8>
    80006668:	00e50733          	add	a4,a0,a4
    8000666c:	00b70023          	sb	a1,0(a4)
    80006670:	00d7879b          	addiw	a5,a5,13
    80006674:	00c7f663          	bgeu	a5,a2,80006680 <__memset+0x1c8>
    80006678:	00f507b3          	add	a5,a0,a5
    8000667c:	00b78023          	sb	a1,0(a5)
    80006680:	00813403          	ld	s0,8(sp)
    80006684:	01010113          	addi	sp,sp,16
    80006688:	00008067          	ret
    8000668c:	00b00693          	li	a3,11
    80006690:	e55ff06f          	j	800064e4 <__memset+0x2c>
    80006694:	00300e93          	li	t4,3
    80006698:	ea5ff06f          	j	8000653c <__memset+0x84>
    8000669c:	00100e93          	li	t4,1
    800066a0:	e9dff06f          	j	8000653c <__memset+0x84>
    800066a4:	00000e93          	li	t4,0
    800066a8:	e95ff06f          	j	8000653c <__memset+0x84>
    800066ac:	00000793          	li	a5,0
    800066b0:	ef9ff06f          	j	800065a8 <__memset+0xf0>
    800066b4:	00200e93          	li	t4,2
    800066b8:	e85ff06f          	j	8000653c <__memset+0x84>
    800066bc:	00400e93          	li	t4,4
    800066c0:	e7dff06f          	j	8000653c <__memset+0x84>
    800066c4:	00500e93          	li	t4,5
    800066c8:	e75ff06f          	j	8000653c <__memset+0x84>
    800066cc:	00600e93          	li	t4,6
    800066d0:	e6dff06f          	j	8000653c <__memset+0x84>

00000000800066d4 <__memmove>:
    800066d4:	ff010113          	addi	sp,sp,-16
    800066d8:	00813423          	sd	s0,8(sp)
    800066dc:	01010413          	addi	s0,sp,16
    800066e0:	0e060863          	beqz	a2,800067d0 <__memmove+0xfc>
    800066e4:	fff6069b          	addiw	a3,a2,-1
    800066e8:	0006881b          	sext.w	a6,a3
    800066ec:	0ea5e863          	bltu	a1,a0,800067dc <__memmove+0x108>
    800066f0:	00758713          	addi	a4,a1,7
    800066f4:	00a5e7b3          	or	a5,a1,a0
    800066f8:	40a70733          	sub	a4,a4,a0
    800066fc:	0077f793          	andi	a5,a5,7
    80006700:	00f73713          	sltiu	a4,a4,15
    80006704:	00174713          	xori	a4,a4,1
    80006708:	0017b793          	seqz	a5,a5
    8000670c:	00e7f7b3          	and	a5,a5,a4
    80006710:	10078863          	beqz	a5,80006820 <__memmove+0x14c>
    80006714:	00900793          	li	a5,9
    80006718:	1107f463          	bgeu	a5,a6,80006820 <__memmove+0x14c>
    8000671c:	0036581b          	srliw	a6,a2,0x3
    80006720:	fff8081b          	addiw	a6,a6,-1
    80006724:	02081813          	slli	a6,a6,0x20
    80006728:	01d85893          	srli	a7,a6,0x1d
    8000672c:	00858813          	addi	a6,a1,8
    80006730:	00058793          	mv	a5,a1
    80006734:	00050713          	mv	a4,a0
    80006738:	01088833          	add	a6,a7,a6
    8000673c:	0007b883          	ld	a7,0(a5)
    80006740:	00878793          	addi	a5,a5,8
    80006744:	00870713          	addi	a4,a4,8
    80006748:	ff173c23          	sd	a7,-8(a4)
    8000674c:	ff0798e3          	bne	a5,a6,8000673c <__memmove+0x68>
    80006750:	ff867713          	andi	a4,a2,-8
    80006754:	02071793          	slli	a5,a4,0x20
    80006758:	0207d793          	srli	a5,a5,0x20
    8000675c:	00f585b3          	add	a1,a1,a5
    80006760:	40e686bb          	subw	a3,a3,a4
    80006764:	00f507b3          	add	a5,a0,a5
    80006768:	06e60463          	beq	a2,a4,800067d0 <__memmove+0xfc>
    8000676c:	0005c703          	lbu	a4,0(a1)
    80006770:	00e78023          	sb	a4,0(a5)
    80006774:	04068e63          	beqz	a3,800067d0 <__memmove+0xfc>
    80006778:	0015c603          	lbu	a2,1(a1)
    8000677c:	00100713          	li	a4,1
    80006780:	00c780a3          	sb	a2,1(a5)
    80006784:	04e68663          	beq	a3,a4,800067d0 <__memmove+0xfc>
    80006788:	0025c603          	lbu	a2,2(a1)
    8000678c:	00200713          	li	a4,2
    80006790:	00c78123          	sb	a2,2(a5)
    80006794:	02e68e63          	beq	a3,a4,800067d0 <__memmove+0xfc>
    80006798:	0035c603          	lbu	a2,3(a1)
    8000679c:	00300713          	li	a4,3
    800067a0:	00c781a3          	sb	a2,3(a5)
    800067a4:	02e68663          	beq	a3,a4,800067d0 <__memmove+0xfc>
    800067a8:	0045c603          	lbu	a2,4(a1)
    800067ac:	00400713          	li	a4,4
    800067b0:	00c78223          	sb	a2,4(a5)
    800067b4:	00e68e63          	beq	a3,a4,800067d0 <__memmove+0xfc>
    800067b8:	0055c603          	lbu	a2,5(a1)
    800067bc:	00500713          	li	a4,5
    800067c0:	00c782a3          	sb	a2,5(a5)
    800067c4:	00e68663          	beq	a3,a4,800067d0 <__memmove+0xfc>
    800067c8:	0065c703          	lbu	a4,6(a1)
    800067cc:	00e78323          	sb	a4,6(a5)
    800067d0:	00813403          	ld	s0,8(sp)
    800067d4:	01010113          	addi	sp,sp,16
    800067d8:	00008067          	ret
    800067dc:	02061713          	slli	a4,a2,0x20
    800067e0:	02075713          	srli	a4,a4,0x20
    800067e4:	00e587b3          	add	a5,a1,a4
    800067e8:	f0f574e3          	bgeu	a0,a5,800066f0 <__memmove+0x1c>
    800067ec:	02069613          	slli	a2,a3,0x20
    800067f0:	02065613          	srli	a2,a2,0x20
    800067f4:	fff64613          	not	a2,a2
    800067f8:	00e50733          	add	a4,a0,a4
    800067fc:	00c78633          	add	a2,a5,a2
    80006800:	fff7c683          	lbu	a3,-1(a5)
    80006804:	fff78793          	addi	a5,a5,-1
    80006808:	fff70713          	addi	a4,a4,-1
    8000680c:	00d70023          	sb	a3,0(a4)
    80006810:	fec798e3          	bne	a5,a2,80006800 <__memmove+0x12c>
    80006814:	00813403          	ld	s0,8(sp)
    80006818:	01010113          	addi	sp,sp,16
    8000681c:	00008067          	ret
    80006820:	02069713          	slli	a4,a3,0x20
    80006824:	02075713          	srli	a4,a4,0x20
    80006828:	00170713          	addi	a4,a4,1
    8000682c:	00e50733          	add	a4,a0,a4
    80006830:	00050793          	mv	a5,a0
    80006834:	0005c683          	lbu	a3,0(a1)
    80006838:	00178793          	addi	a5,a5,1
    8000683c:	00158593          	addi	a1,a1,1
    80006840:	fed78fa3          	sb	a3,-1(a5)
    80006844:	fee798e3          	bne	a5,a4,80006834 <__memmove+0x160>
    80006848:	f89ff06f          	j	800067d0 <__memmove+0xfc>

000000008000684c <__mem_free>:
    8000684c:	ff010113          	addi	sp,sp,-16
    80006850:	00813423          	sd	s0,8(sp)
    80006854:	01010413          	addi	s0,sp,16
    80006858:	00002597          	auipc	a1,0x2
    8000685c:	42058593          	addi	a1,a1,1056 # 80008c78 <freep>
    80006860:	0005b783          	ld	a5,0(a1)
    80006864:	ff050693          	addi	a3,a0,-16
    80006868:	0007b703          	ld	a4,0(a5)
    8000686c:	00d7fc63          	bgeu	a5,a3,80006884 <__mem_free+0x38>
    80006870:	00e6ee63          	bltu	a3,a4,8000688c <__mem_free+0x40>
    80006874:	00e7fc63          	bgeu	a5,a4,8000688c <__mem_free+0x40>
    80006878:	00070793          	mv	a5,a4
    8000687c:	0007b703          	ld	a4,0(a5)
    80006880:	fed7e8e3          	bltu	a5,a3,80006870 <__mem_free+0x24>
    80006884:	fee7eae3          	bltu	a5,a4,80006878 <__mem_free+0x2c>
    80006888:	fee6f8e3          	bgeu	a3,a4,80006878 <__mem_free+0x2c>
    8000688c:	ff852803          	lw	a6,-8(a0)
    80006890:	02081613          	slli	a2,a6,0x20
    80006894:	01c65613          	srli	a2,a2,0x1c
    80006898:	00c68633          	add	a2,a3,a2
    8000689c:	02c70a63          	beq	a4,a2,800068d0 <__mem_free+0x84>
    800068a0:	fee53823          	sd	a4,-16(a0)
    800068a4:	0087a503          	lw	a0,8(a5)
    800068a8:	02051613          	slli	a2,a0,0x20
    800068ac:	01c65613          	srli	a2,a2,0x1c
    800068b0:	00c78633          	add	a2,a5,a2
    800068b4:	04c68263          	beq	a3,a2,800068f8 <__mem_free+0xac>
    800068b8:	00813403          	ld	s0,8(sp)
    800068bc:	00d7b023          	sd	a3,0(a5)
    800068c0:	00f5b023          	sd	a5,0(a1)
    800068c4:	00000513          	li	a0,0
    800068c8:	01010113          	addi	sp,sp,16
    800068cc:	00008067          	ret
    800068d0:	00872603          	lw	a2,8(a4)
    800068d4:	00073703          	ld	a4,0(a4)
    800068d8:	0106083b          	addw	a6,a2,a6
    800068dc:	ff052c23          	sw	a6,-8(a0)
    800068e0:	fee53823          	sd	a4,-16(a0)
    800068e4:	0087a503          	lw	a0,8(a5)
    800068e8:	02051613          	slli	a2,a0,0x20
    800068ec:	01c65613          	srli	a2,a2,0x1c
    800068f0:	00c78633          	add	a2,a5,a2
    800068f4:	fcc692e3          	bne	a3,a2,800068b8 <__mem_free+0x6c>
    800068f8:	00813403          	ld	s0,8(sp)
    800068fc:	0105053b          	addw	a0,a0,a6
    80006900:	00a7a423          	sw	a0,8(a5)
    80006904:	00e7b023          	sd	a4,0(a5)
    80006908:	00f5b023          	sd	a5,0(a1)
    8000690c:	00000513          	li	a0,0
    80006910:	01010113          	addi	sp,sp,16
    80006914:	00008067          	ret

0000000080006918 <__mem_alloc>:
    80006918:	fc010113          	addi	sp,sp,-64
    8000691c:	02813823          	sd	s0,48(sp)
    80006920:	02913423          	sd	s1,40(sp)
    80006924:	03213023          	sd	s2,32(sp)
    80006928:	01513423          	sd	s5,8(sp)
    8000692c:	02113c23          	sd	ra,56(sp)
    80006930:	01313c23          	sd	s3,24(sp)
    80006934:	01413823          	sd	s4,16(sp)
    80006938:	01613023          	sd	s6,0(sp)
    8000693c:	04010413          	addi	s0,sp,64
    80006940:	00002a97          	auipc	s5,0x2
    80006944:	338a8a93          	addi	s5,s5,824 # 80008c78 <freep>
    80006948:	00f50913          	addi	s2,a0,15
    8000694c:	000ab683          	ld	a3,0(s5)
    80006950:	00495913          	srli	s2,s2,0x4
    80006954:	0019049b          	addiw	s1,s2,1
    80006958:	00048913          	mv	s2,s1
    8000695c:	0c068c63          	beqz	a3,80006a34 <__mem_alloc+0x11c>
    80006960:	0006b503          	ld	a0,0(a3)
    80006964:	00852703          	lw	a4,8(a0)
    80006968:	10977063          	bgeu	a4,s1,80006a68 <__mem_alloc+0x150>
    8000696c:	000017b7          	lui	a5,0x1
    80006970:	0009099b          	sext.w	s3,s2
    80006974:	0af4e863          	bltu	s1,a5,80006a24 <__mem_alloc+0x10c>
    80006978:	02099a13          	slli	s4,s3,0x20
    8000697c:	01ca5a13          	srli	s4,s4,0x1c
    80006980:	fff00b13          	li	s6,-1
    80006984:	0100006f          	j	80006994 <__mem_alloc+0x7c>
    80006988:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    8000698c:	00852703          	lw	a4,8(a0)
    80006990:	04977463          	bgeu	a4,s1,800069d8 <__mem_alloc+0xc0>
    80006994:	00050793          	mv	a5,a0
    80006998:	fea698e3          	bne	a3,a0,80006988 <__mem_alloc+0x70>
    8000699c:	000a0513          	mv	a0,s4
    800069a0:	00000097          	auipc	ra,0x0
    800069a4:	1f0080e7          	jalr	496(ra) # 80006b90 <kvmincrease>
    800069a8:	00050793          	mv	a5,a0
    800069ac:	01050513          	addi	a0,a0,16
    800069b0:	07678e63          	beq	a5,s6,80006a2c <__mem_alloc+0x114>
    800069b4:	0137a423          	sw	s3,8(a5)
    800069b8:	00000097          	auipc	ra,0x0
    800069bc:	e94080e7          	jalr	-364(ra) # 8000684c <__mem_free>
    800069c0:	000ab783          	ld	a5,0(s5)
    800069c4:	06078463          	beqz	a5,80006a2c <__mem_alloc+0x114>
    800069c8:	0007b503          	ld	a0,0(a5)
    800069cc:	00078693          	mv	a3,a5
    800069d0:	00852703          	lw	a4,8(a0)
    800069d4:	fc9760e3          	bltu	a4,s1,80006994 <__mem_alloc+0x7c>
    800069d8:	08e48263          	beq	s1,a4,80006a5c <__mem_alloc+0x144>
    800069dc:	4127073b          	subw	a4,a4,s2
    800069e0:	02071693          	slli	a3,a4,0x20
    800069e4:	01c6d693          	srli	a3,a3,0x1c
    800069e8:	00e52423          	sw	a4,8(a0)
    800069ec:	00d50533          	add	a0,a0,a3
    800069f0:	01252423          	sw	s2,8(a0)
    800069f4:	00fab023          	sd	a5,0(s5)
    800069f8:	01050513          	addi	a0,a0,16
    800069fc:	03813083          	ld	ra,56(sp)
    80006a00:	03013403          	ld	s0,48(sp)
    80006a04:	02813483          	ld	s1,40(sp)
    80006a08:	02013903          	ld	s2,32(sp)
    80006a0c:	01813983          	ld	s3,24(sp)
    80006a10:	01013a03          	ld	s4,16(sp)
    80006a14:	00813a83          	ld	s5,8(sp)
    80006a18:	00013b03          	ld	s6,0(sp)
    80006a1c:	04010113          	addi	sp,sp,64
    80006a20:	00008067          	ret
    80006a24:	000019b7          	lui	s3,0x1
    80006a28:	f51ff06f          	j	80006978 <__mem_alloc+0x60>
    80006a2c:	00000513          	li	a0,0
    80006a30:	fcdff06f          	j	800069fc <__mem_alloc+0xe4>
    80006a34:	00003797          	auipc	a5,0x3
    80006a38:	4bc78793          	addi	a5,a5,1212 # 80009ef0 <base>
    80006a3c:	00078513          	mv	a0,a5
    80006a40:	00fab023          	sd	a5,0(s5)
    80006a44:	00f7b023          	sd	a5,0(a5)
    80006a48:	00000713          	li	a4,0
    80006a4c:	00003797          	auipc	a5,0x3
    80006a50:	4a07a623          	sw	zero,1196(a5) # 80009ef8 <base+0x8>
    80006a54:	00050693          	mv	a3,a0
    80006a58:	f11ff06f          	j	80006968 <__mem_alloc+0x50>
    80006a5c:	00053703          	ld	a4,0(a0)
    80006a60:	00e7b023          	sd	a4,0(a5)
    80006a64:	f91ff06f          	j	800069f4 <__mem_alloc+0xdc>
    80006a68:	00068793          	mv	a5,a3
    80006a6c:	f6dff06f          	j	800069d8 <__mem_alloc+0xc0>

0000000080006a70 <__putc>:
    80006a70:	fe010113          	addi	sp,sp,-32
    80006a74:	00813823          	sd	s0,16(sp)
    80006a78:	00113c23          	sd	ra,24(sp)
    80006a7c:	02010413          	addi	s0,sp,32
    80006a80:	00050793          	mv	a5,a0
    80006a84:	fef40593          	addi	a1,s0,-17
    80006a88:	00100613          	li	a2,1
    80006a8c:	00000513          	li	a0,0
    80006a90:	fef407a3          	sb	a5,-17(s0)
    80006a94:	fffff097          	auipc	ra,0xfffff
    80006a98:	918080e7          	jalr	-1768(ra) # 800053ac <console_write>
    80006a9c:	01813083          	ld	ra,24(sp)
    80006aa0:	01013403          	ld	s0,16(sp)
    80006aa4:	02010113          	addi	sp,sp,32
    80006aa8:	00008067          	ret

0000000080006aac <__getc>:
    80006aac:	fe010113          	addi	sp,sp,-32
    80006ab0:	00813823          	sd	s0,16(sp)
    80006ab4:	00113c23          	sd	ra,24(sp)
    80006ab8:	02010413          	addi	s0,sp,32
    80006abc:	fe840593          	addi	a1,s0,-24
    80006ac0:	00100613          	li	a2,1
    80006ac4:	00000513          	li	a0,0
    80006ac8:	fffff097          	auipc	ra,0xfffff
    80006acc:	8c4080e7          	jalr	-1852(ra) # 8000538c <console_read>
    80006ad0:	fe844503          	lbu	a0,-24(s0)
    80006ad4:	01813083          	ld	ra,24(sp)
    80006ad8:	01013403          	ld	s0,16(sp)
    80006adc:	02010113          	addi	sp,sp,32
    80006ae0:	00008067          	ret

0000000080006ae4 <console_handler>:
    80006ae4:	fe010113          	addi	sp,sp,-32
    80006ae8:	00813823          	sd	s0,16(sp)
    80006aec:	00113c23          	sd	ra,24(sp)
    80006af0:	00913423          	sd	s1,8(sp)
    80006af4:	02010413          	addi	s0,sp,32
    80006af8:	14202773          	csrr	a4,scause
    80006afc:	100027f3          	csrr	a5,sstatus
    80006b00:	0027f793          	andi	a5,a5,2
    80006b04:	06079e63          	bnez	a5,80006b80 <console_handler+0x9c>
    80006b08:	00074c63          	bltz	a4,80006b20 <console_handler+0x3c>
    80006b0c:	01813083          	ld	ra,24(sp)
    80006b10:	01013403          	ld	s0,16(sp)
    80006b14:	00813483          	ld	s1,8(sp)
    80006b18:	02010113          	addi	sp,sp,32
    80006b1c:	00008067          	ret
    80006b20:	0ff77713          	andi	a4,a4,255
    80006b24:	00900793          	li	a5,9
    80006b28:	fef712e3          	bne	a4,a5,80006b0c <console_handler+0x28>
    80006b2c:	ffffe097          	auipc	ra,0xffffe
    80006b30:	4b8080e7          	jalr	1208(ra) # 80004fe4 <plic_claim>
    80006b34:	00a00793          	li	a5,10
    80006b38:	00050493          	mv	s1,a0
    80006b3c:	02f50c63          	beq	a0,a5,80006b74 <console_handler+0x90>
    80006b40:	fc0506e3          	beqz	a0,80006b0c <console_handler+0x28>
    80006b44:	00050593          	mv	a1,a0
    80006b48:	00001517          	auipc	a0,0x1
    80006b4c:	ca850513          	addi	a0,a0,-856 # 800077f0 <_ZTV7WorkerD+0xf8>
    80006b50:	fffff097          	auipc	ra,0xfffff
    80006b54:	8d8080e7          	jalr	-1832(ra) # 80005428 <__printf>
    80006b58:	01013403          	ld	s0,16(sp)
    80006b5c:	01813083          	ld	ra,24(sp)
    80006b60:	00048513          	mv	a0,s1
    80006b64:	00813483          	ld	s1,8(sp)
    80006b68:	02010113          	addi	sp,sp,32
    80006b6c:	ffffe317          	auipc	t1,0xffffe
    80006b70:	4b030067          	jr	1200(t1) # 8000501c <plic_complete>
    80006b74:	fffff097          	auipc	ra,0xfffff
    80006b78:	1bc080e7          	jalr	444(ra) # 80005d30 <uartintr>
    80006b7c:	fddff06f          	j	80006b58 <console_handler+0x74>
    80006b80:	00001517          	auipc	a0,0x1
    80006b84:	d7050513          	addi	a0,a0,-656 # 800078f0 <digits+0x78>
    80006b88:	fffff097          	auipc	ra,0xfffff
    80006b8c:	844080e7          	jalr	-1980(ra) # 800053cc <panic>

0000000080006b90 <kvmincrease>:
    80006b90:	fe010113          	addi	sp,sp,-32
    80006b94:	01213023          	sd	s2,0(sp)
    80006b98:	00001937          	lui	s2,0x1
    80006b9c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80006ba0:	00813823          	sd	s0,16(sp)
    80006ba4:	00113c23          	sd	ra,24(sp)
    80006ba8:	00913423          	sd	s1,8(sp)
    80006bac:	02010413          	addi	s0,sp,32
    80006bb0:	01250933          	add	s2,a0,s2
    80006bb4:	00c95913          	srli	s2,s2,0xc
    80006bb8:	02090863          	beqz	s2,80006be8 <kvmincrease+0x58>
    80006bbc:	00000493          	li	s1,0
    80006bc0:	00148493          	addi	s1,s1,1
    80006bc4:	fffff097          	auipc	ra,0xfffff
    80006bc8:	4bc080e7          	jalr	1212(ra) # 80006080 <kalloc>
    80006bcc:	fe991ae3          	bne	s2,s1,80006bc0 <kvmincrease+0x30>
    80006bd0:	01813083          	ld	ra,24(sp)
    80006bd4:	01013403          	ld	s0,16(sp)
    80006bd8:	00813483          	ld	s1,8(sp)
    80006bdc:	00013903          	ld	s2,0(sp)
    80006be0:	02010113          	addi	sp,sp,32
    80006be4:	00008067          	ret
    80006be8:	01813083          	ld	ra,24(sp)
    80006bec:	01013403          	ld	s0,16(sp)
    80006bf0:	00813483          	ld	s1,8(sp)
    80006bf4:	00013903          	ld	s2,0(sp)
    80006bf8:	00000513          	li	a0,0
    80006bfc:	02010113          	addi	sp,sp,32
    80006c00:	00008067          	ret
	...
