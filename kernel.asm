
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	c1013103          	ld	sp,-1008(sp) # 80005c10 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5b0020ef          	jal	ra,800025cc <start>

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
    80001250:	00003097          	auipc	ra,0x3
    80001254:	508080e7          	jalr	1288(ra) # 80004758 <__mem_alloc>
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
    80001278:	00003097          	auipc	ra,0x3
    8000127c:	4e0080e7          	jalr	1248(ra) # 80004758 <__mem_alloc>
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
    800012a0:	00003097          	auipc	ra,0x3
    800012a4:	3ec080e7          	jalr	1004(ra) # 8000468c <__mem_free>
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
    800012c8:	00003097          	auipc	ra,0x3
    800012cc:	3c4080e7          	jalr	964(ra) # 8000468c <__mem_free>
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
    8000130c:	00005797          	auipc	a5,0x5
    80001310:	9c478793          	addi	a5,a5,-1596 # 80005cd0 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001334:	00005517          	auipc	a0,0x5
    80001338:	99c53503          	ld	a0,-1636(a0) # 80005cd0 <_ZN9Scheduler19readyCoroutineQueueE>
    8000133c:	04050263          	beqz	a0,80001380 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001340:	00853783          	ld	a5,8(a0)
    80001344:	00005717          	auipc	a4,0x5
    80001348:	98f73623          	sd	a5,-1652(a4) # 80005cd0 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001374:	00005797          	auipc	a5,0x5
    80001378:	9607b223          	sd	zero,-1692(a5) # 80005cd8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
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
    800013b4:	00005797          	auipc	a5,0x5
    800013b8:	9247b783          	ld	a5,-1756(a5) # 80005cd8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013bc:	02078263          	beqz	a5,800013e0 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800013c0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800013c4:	00005797          	auipc	a5,0x5
    800013c8:	90a7ba23          	sd	a0,-1772(a5) # 80005cd8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013cc:	01813083          	ld	ra,24(sp)
    800013d0:	01013403          	ld	s0,16(sp)
    800013d4:	00813483          	ld	s1,8(sp)
    800013d8:	02010113          	addi	sp,sp,32
    800013dc:	00008067          	ret
            head = tail = elem;
    800013e0:	00005797          	auipc	a5,0x5
    800013e4:	8f078793          	addi	a5,a5,-1808 # 80005cd0 <_ZN9Scheduler19readyCoroutineQueueE>
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
    uint64 volatile fcode, handle, start_routine, arg;
    asm volatile("mv %0, a0" : "=r" (fcode));
    8000145c:	00050793          	mv	a5,a0
    80001460:	fcf43c23          	sd	a5,-40(s0)
    asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
    80001464:	00058793          	mv	a5,a1
    80001468:	fcf43823          	sd	a5,-48(s0)
    asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
    8000146c:	00060793          	mv	a5,a2
    80001470:	fcf43423          	sd	a5,-56(s0)
    asm volatile("mv %0, a3" : "=r" (arg));
    80001474:	00068793          	mv	a5,a3
    80001478:	fcf43023          	sd	a5,-64(s0)
};

inline uint64 Riscv::r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000147c:	142027f3          	csrr	a5,scause
    80001480:	f8f43c23          	sd	a5,-104(s0)
    return scause;
    80001484:	f9843483          	ld	s1,-104(s0)
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
    80001488:	ff848713          	addi	a4,s1,-8
    8000148c:	00100793          	li	a5,1
    80001490:	0ce7fa63          	bgeu	a5,a4,80001564 <_ZN5Riscv23interruptRoutineHandlerEv+0x11c>
        }

        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
        w_sstatus(sstatus);
    }
    else if (scause == 0x8000000000000001UL){
    80001494:	fff00793          	li	a5,-1
    80001498:	03f79793          	slli	a5,a5,0x3f
    8000149c:	00178793          	addi	a5,a5,1
    800014a0:	18f48063          	beq	s1,a5,80001620 <_ZN5Riscv23interruptRoutineHandlerEv+0x1d8>
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
    800014a4:	fff00793          	li	a5,-1
    800014a8:	03f79793          	slli	a5,a5,0x3f
    800014ac:	00978793          	addi	a5,a5,9
    800014b0:	16f48e63          	beq	s1,a5,8000162c <_ZN5Riscv23interruptRoutineHandlerEv+0x1e4>
        console_handler();
    }
    else{
        printString("\nPc greske: ");
    800014b4:	00004517          	auipc	a0,0x4
    800014b8:	b4c50513          	addi	a0,a0,-1204 # 80005000 <kvmincrease+0x630>
    800014bc:	00001097          	auipc	ra,0x1
    800014c0:	868080e7          	jalr	-1944(ra) # 80001d24 <_Z11printStringPKc>
}

inline uint64 Riscv::r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800014c4:	141027f3          	csrr	a5,sepc
    800014c8:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    800014cc:	fb843503          	ld	a0,-72(s0)
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
    800014d0:	00000613          	li	a2,0
    800014d4:	00a00593          	li	a1,10
    800014d8:	0005051b          	sext.w	a0,a0
    800014dc:	00001097          	auipc	ra,0x1
    800014e0:	9f8080e7          	jalr	-1544(ra) # 80001ed4 <_Z8printIntiii>
        printString("\nStVal greske: ");
    800014e4:	00004517          	auipc	a0,0x4
    800014e8:	b2c50513          	addi	a0,a0,-1236 # 80005010 <kvmincrease+0x640>
    800014ec:	00001097          	auipc	ra,0x1
    800014f0:	838080e7          	jalr	-1992(ra) # 80001d24 <_Z11printStringPKc>
}

inline uint64 Riscv::r_stval()
{
    uint64 volatile stval;
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800014f4:	143027f3          	csrr	a5,stval
    800014f8:	faf43823          	sd	a5,-80(s0)
    return stval;
    800014fc:	fb043503          	ld	a0,-80(s0)
        printInt(r_stval());
    80001500:	00000613          	li	a2,0
    80001504:	00a00593          	li	a1,10
    80001508:	0005051b          	sext.w	a0,a0
    8000150c:	00001097          	auipc	ra,0x1
    80001510:	9c8080e7          	jalr	-1592(ra) # 80001ed4 <_Z8printIntiii>
        printString("\nRazlog greske scause: ");
    80001514:	00004517          	auipc	a0,0x4
    80001518:	b0c50513          	addi	a0,a0,-1268 # 80005020 <kvmincrease+0x650>
    8000151c:	00001097          	auipc	ra,0x1
    80001520:	808080e7          	jalr	-2040(ra) # 80001d24 <_Z11printStringPKc>
        printInt(scause);
    80001524:	00000613          	li	a2,0
    80001528:	00a00593          	li	a1,10
    8000152c:	0004851b          	sext.w	a0,s1
    80001530:	00001097          	auipc	ra,0x1
    80001534:	9a4080e7          	jalr	-1628(ra) # 80001ed4 <_Z8printIntiii>
        switch(scause) {
    80001538:	00500793          	li	a5,5
    8000153c:	10f48863          	beq	s1,a5,8000164c <_ZN5Riscv23interruptRoutineHandlerEv+0x204>
    80001540:	00700793          	li	a5,7
    80001544:	10f48e63          	beq	s1,a5,80001660 <_ZN5Riscv23interruptRoutineHandlerEv+0x218>
    80001548:	00200793          	li	a5,2
    8000154c:	0ef48663          	beq	s1,a5,80001638 <_ZN5Riscv23interruptRoutineHandlerEv+0x1f0>
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
    80001550:	00004517          	auipc	a0,0x4
    80001554:	b4050513          	addi	a0,a0,-1216 # 80005090 <kvmincrease+0x6c0>
    80001558:	00000097          	auipc	ra,0x0
    8000155c:	7cc080e7          	jalr	1996(ra) # 80001d24 <_Z11printStringPKc>
                break;
        }
    }
    80001560:	0a00006f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001564:	141027f3          	csrr	a5,sepc
    80001568:	faf43423          	sd	a5,-88(s0)
    return sepc;
    8000156c:	fa843783          	ld	a5,-88(s0)
        uint64 volatile sepc = r_sepc() + 4;    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    80001570:	00478793          	addi	a5,a5,4
    80001574:	f8f43423          	sd	a5,-120(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001578:	100027f3          	csrr	a5,sstatus
    8000157c:	faf43023          	sd	a5,-96(s0)
    return sstatus;
    80001580:	fa043783          	ld	a5,-96(s0)
        uint64 volatile sstatus = r_sstatus();
    80001584:	f8f43823          	sd	a5,-112(s0)
        switch(fcode){
    80001588:	fd843783          	ld	a5,-40(s0)
    8000158c:	01300713          	li	a4,19
    80001590:	08e78263          	beq	a5,a4,80001614 <_ZN5Riscv23interruptRoutineHandlerEv+0x1cc>
    80001594:	02f76063          	bltu	a4,a5,800015b4 <_ZN5Riscv23interruptRoutineHandlerEv+0x16c>
    80001598:	01100713          	li	a4,17
    8000159c:	02e78663          	beq	a5,a4,800015c8 <_ZN5Riscv23interruptRoutineHandlerEv+0x180>
    800015a0:	01200713          	li	a4,18
    800015a4:	04e79663          	bne	a5,a4,800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                _thread::thread_exit();
    800015a8:	00000097          	auipc	ra,0x0
    800015ac:	2a0080e7          	jalr	672(ra) # 80001848 <_ZN7_thread11thread_exitEv>
                break;
    800015b0:	0400006f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
        switch(fcode){
    800015b4:	02000713          	li	a4,32
    800015b8:	02e79c63          	bne	a5,a4,800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                __getc();
    800015bc:	00003097          	auipc	ra,0x3
    800015c0:	330080e7          	jalr	816(ra) # 800048ec <__getc>
    800015c4:	02c0006f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
    800015c8:	00008537          	lui	a0,0x8
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	c9c080e7          	jalr	-868(ra) # 80001268 <_Znam>
    800015d4:	00050693          	mv	a3,a0
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
    800015d8:	fd043503          	ld	a0,-48(s0)
    800015dc:	fc843583          	ld	a1,-56(s0)
    800015e0:	fc043603          	ld	a2,-64(s0)
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	110080e7          	jalr	272(ra) # 800016f4 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>
                asm volatile("mv a0, %0" : : "r" (retval));
    800015ec:	00050513          	mv	a0,a0
        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
    800015f0:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015f4:	14179073          	csrw	sepc,a5
        w_sstatus(sstatus);
    800015f8:	f9043783          	ld	a5,-112(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015fc:	10079073          	csrw	sstatus,a5
    80001600:	07813083          	ld	ra,120(sp)
    80001604:	07013403          	ld	s0,112(sp)
    80001608:	06813483          	ld	s1,104(sp)
    8000160c:	08010113          	addi	sp,sp,128
    80001610:	00008067          	ret
                _thread::thread_dispatch();
    80001614:	00000097          	auipc	ra,0x0
    80001618:	1cc080e7          	jalr	460(ra) # 800017e0 <_ZN7_thread15thread_dispatchEv>
                break;
    8000161c:	fd5ff06f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001620:	00200793          	li	a5,2
    80001624:	1447b073          	csrc	sip,a5
}
    80001628:	fd9ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
        console_handler();
    8000162c:	00003097          	auipc	ra,0x3
    80001630:	2f8080e7          	jalr	760(ra) # 80004924 <console_handler>
    80001634:	fcdff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nelegelna instrukcija");
    80001638:	00004517          	auipc	a0,0x4
    8000163c:	a0050513          	addi	a0,a0,-1536 # 80005038 <kvmincrease+0x668>
    80001640:	00000097          	auipc	ra,0x0
    80001644:	6e4080e7          	jalr	1764(ra) # 80001d24 <_Z11printStringPKc>
                break;
    80001648:	fb9ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nedozvoljena adresa citanja");
    8000164c:	00004517          	auipc	a0,0x4
    80001650:	a0450513          	addi	a0,a0,-1532 # 80005050 <kvmincrease+0x680>
    80001654:	00000097          	auipc	ra,0x0
    80001658:	6d0080e7          	jalr	1744(ra) # 80001d24 <_Z11printStringPKc>
                break;
    8000165c:	fa5ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nedozvoljena adresa upisa");
    80001660:	00004517          	auipc	a0,0x4
    80001664:	a1050513          	addi	a0,a0,-1520 # 80005070 <kvmincrease+0x6a0>
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	6bc080e7          	jalr	1724(ra) # 80001d24 <_Z11printStringPKc>
                break;
    80001670:	f91ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>

0000000080001674 <_ZN7_thread5yieldEv>:
#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread* _thread::running = nullptr;

void _thread::yield(){
    80001674:	ff010113          	addi	sp,sp,-16
    80001678:	00813423          	sd	s0,8(sp)
    8000167c:	01010413          	addi	s0,sp,16
    uint64 fcode = 0x13;
    asm volatile("mv a0, %0" : : "r" (fcode));  //a0 <- 13
    80001680:	01300793          	li	a5,19
    80001684:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80001688:	00000073          	ecall
}
    8000168c:	00813403          	ld	s0,8(sp)
    80001690:	01010113          	addi	sp,sp,16
    80001694:	00008067          	ret

0000000080001698 <_ZN7_thread13threadWrapperEv>:
    _thread::running->setFinished(true);
    _thread::yield();
    return 0;
}

void _thread::threadWrapper() {
    80001698:	fe010113          	addi	sp,sp,-32
    8000169c:	00113c23          	sd	ra,24(sp)
    800016a0:	00813823          	sd	s0,16(sp)
    800016a4:	00913423          	sd	s1,8(sp)
    800016a8:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	d7c080e7          	jalr	-644(ra) # 80001428 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    800016b4:	00004497          	auipc	s1,0x4
    800016b8:	5bc48493          	addi	s1,s1,1468 # 80005c70 <_ZN7_thread7runningE>
    800016bc:	0004b783          	ld	a5,0(s1)
    800016c0:	0007b703          	ld	a4,0(a5)
    800016c4:	0207b503          	ld	a0,32(a5)
    800016c8:	000700e7          	jalr	a4
    running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    800016cc:	0004b783          	ld	a5,0(s1)

    ~_thread() {delete[] stack;}

    bool isFinished() const { return finished; }

    void setFinished(bool fin) { _thread::finished = fin; }
    800016d0:	00100713          	li	a4,1
    800016d4:	02e78423          	sb	a4,40(a5)
    _thread::yield();
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	f9c080e7          	jalr	-100(ra) # 80001674 <_ZN7_thread5yieldEv>
}
    800016e0:	01813083          	ld	ra,24(sp)
    800016e4:	01013403          	ld	s0,16(sp)
    800016e8:	00813483          	ld	s1,8(sp)
    800016ec:	02010113          	addi	sp,sp,32
    800016f0:	00008067          	ret

00000000800016f4 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>:
int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){
    800016f4:	fc010113          	addi	sp,sp,-64
    800016f8:	02113c23          	sd	ra,56(sp)
    800016fc:	02813823          	sd	s0,48(sp)
    80001700:	02913423          	sd	s1,40(sp)
    80001704:	03213023          	sd	s2,32(sp)
    80001708:	01313c23          	sd	s3,24(sp)
    8000170c:	01413823          	sd	s4,16(sp)
    80001710:	01513423          	sd	s5,8(sp)
    80001714:	04010413          	addi	s0,sp,64
    80001718:	00050a13          	mv	s4,a0
    8000171c:	00058993          	mv	s3,a1
    80001720:	00060a93          	mv	s5,a2
    80001724:	00068913          	mv	s2,a3
    *handle = new _thread(body, arg, stack_space);
    80001728:	03000513          	li	a0,48
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	b14080e7          	jalr	-1260(ra) # 80001240 <_Znwm>
    80001734:	00050493          	mv	s1,a0
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false) {
    80001738:	01353023          	sd	s3,0(a0)
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    8000173c:	04098063          	beqz	s3,8000177c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x88>
        finished(false) {
    80001740:	0124b423          	sd	s2,8(s1)
    80001744:	00000797          	auipc	a5,0x0
    80001748:	f5478793          	addi	a5,a5,-172 # 80001698 <_ZN7_thread13threadWrapperEv>
    8000174c:	00f4b823          	sd	a5,16(s1)
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001750:	02090a63          	beqz	s2,80001784 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x90>
    80001754:	000086b7          	lui	a3,0x8
    80001758:	00d90933          	add	s2,s2,a3
        finished(false) {
    8000175c:	0124bc23          	sd	s2,24(s1)
    80001760:	0354b023          	sd	s5,32(s1)
    80001764:	02048423          	sb	zero,40(s1)
        if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
    80001768:	02098263          	beqz	s3,8000178c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
    8000176c:	00048513          	mv	a0,s1
    80001770:	00000097          	auipc	ra,0x0
    80001774:	c18080e7          	jalr	-1000(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001778:	0140006f          	j	8000178c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    8000177c:	00000913          	li	s2,0
    80001780:	fc1ff06f          	j	80001740 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x4c>
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001784:	00000913          	li	s2,0
    80001788:	fd5ff06f          	j	8000175c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x68>
    8000178c:	009a3023          	sd	s1,0(s4)
    if(*handle != nullptr) return 0;//mozda treba !=nullptr
    80001790:	02048663          	beqz	s1,800017bc <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xc8>
    80001794:	00000513          	li	a0,0
}
    80001798:	03813083          	ld	ra,56(sp)
    8000179c:	03013403          	ld	s0,48(sp)
    800017a0:	02813483          	ld	s1,40(sp)
    800017a4:	02013903          	ld	s2,32(sp)
    800017a8:	01813983          	ld	s3,24(sp)
    800017ac:	01013a03          	ld	s4,16(sp)
    800017b0:	00813a83          	ld	s5,8(sp)
    800017b4:	04010113          	addi	sp,sp,64
    800017b8:	00008067          	ret
    return -1;
    800017bc:	fff00513          	li	a0,-1
    800017c0:	fd9ff06f          	j	80001798 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xa4>
    800017c4:	00050913          	mv	s2,a0
    *handle = new _thread(body, arg, stack_space);
    800017c8:	00048513          	mv	a0,s1
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	ac4080e7          	jalr	-1340(ra) # 80001290 <_ZdlPv>
    800017d4:	00090513          	mv	a0,s2
    800017d8:	00005097          	auipc	ra,0x5
    800017dc:	5d0080e7          	jalr	1488(ra) # 80006da8 <_Unwind_Resume>

00000000800017e0 <_ZN7_thread15thread_dispatchEv>:
void _thread::thread_dispatch(){
    800017e0:	fe010113          	addi	sp,sp,-32
    800017e4:	00113c23          	sd	ra,24(sp)
    800017e8:	00813823          	sd	s0,16(sp)
    800017ec:	00913423          	sd	s1,8(sp)
    800017f0:	02010413          	addi	s0,sp,32
    _thread *old = running;
    800017f4:	00004497          	auipc	s1,0x4
    800017f8:	47c4b483          	ld	s1,1148(s1) # 80005c70 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    800017fc:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001800:	02078c63          	beqz	a5,80001838 <_ZN7_thread15thread_dispatchEv+0x58>
    running = Scheduler::get();
    80001804:	00000097          	auipc	ra,0x0
    80001808:	b1c080e7          	jalr	-1252(ra) # 80001320 <_ZN9Scheduler3getEv>
    8000180c:	00004797          	auipc	a5,0x4
    80001810:	46a7b223          	sd	a0,1124(a5) # 80005c70 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    80001814:	01050593          	addi	a1,a0,16
    80001818:	01048513          	addi	a0,s1,16
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	8fc080e7          	jalr	-1796(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001824:	01813083          	ld	ra,24(sp)
    80001828:	01013403          	ld	s0,16(sp)
    8000182c:	00813483          	ld	s1,8(sp)
    80001830:	02010113          	addi	sp,sp,32
    80001834:	00008067          	ret
    if(!old->isFinished()){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001838:	00048513          	mv	a0,s1
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	b4c080e7          	jalr	-1204(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001844:	fc1ff06f          	j	80001804 <_ZN7_thread15thread_dispatchEv+0x24>

0000000080001848 <_ZN7_thread11thread_exitEv>:
int _thread::thread_exit() {
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00113423          	sd	ra,8(sp)
    80001850:	00813023          	sd	s0,0(sp)
    80001854:	01010413          	addi	s0,sp,16
    void setFinished(bool fin) { _thread::finished = fin; }
    80001858:	00004797          	auipc	a5,0x4
    8000185c:	4187b783          	ld	a5,1048(a5) # 80005c70 <_ZN7_thread7runningE>
    80001860:	00100713          	li	a4,1
    80001864:	02e78423          	sb	a4,40(a5)
    _thread::yield();
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	e0c080e7          	jalr	-500(ra) # 80001674 <_ZN7_thread5yieldEv>
}
    80001870:	00000513          	li	a0,0
    80001874:	00813083          	ld	ra,8(sp)
    80001878:	00013403          	ld	s0,0(sp)
    8000187c:	01010113          	addi	sp,sp,16
    80001880:	00008067          	ret

0000000080001884 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80001884:	fe010113          	addi	sp,sp,-32
    80001888:	00113c23          	sd	ra,24(sp)
    8000188c:	00813823          	sd	s0,16(sp)
    80001890:	00913423          	sd	s1,8(sp)
    80001894:	01213023          	sd	s2,0(sp)
    80001898:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    8000189c:	00003517          	auipc	a0,0x3
    800018a0:	7fc50513          	addi	a0,a0,2044 # 80005098 <kvmincrease+0x6c8>
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	480080e7          	jalr	1152(ra) # 80001d24 <_Z11printStringPKc>
    int test = getc() - '0';
    800018ac:	00000097          	auipc	ra,0x0
    800018b0:	42c080e7          	jalr	1068(ra) # 80001cd8 <_Z4getcv>
    800018b4:	0005091b          	sext.w	s2,a0
    800018b8:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800018bc:	00000097          	auipc	ra,0x0
    800018c0:	41c080e7          	jalr	1052(ra) # 80001cd8 <_Z4getcv>
            printString("Nije navedeno da je zadatak 2 implementiran\n");
            return;
        }
    }

    if (test >= 3 && test <= 4) {
    800018c4:	fcd9071b          	addiw	a4,s2,-51
    800018c8:	00100793          	li	a5,1
    800018cc:	04e7f263          	bgeu	a5,a4,80001910 <_Z8userMainv+0x8c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800018d0:	fcb9091b          	addiw	s2,s2,-53
    800018d4:	00100793          	li	a5,1
    800018d8:	0727f063          	bgeu	a5,s2,80001938 <_Z8userMainv+0xb4>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800018dc:	00600793          	li	a5,6
    800018e0:	0697c663          	blt	a5,s1,8000194c <_Z8userMainv+0xc8>
    800018e4:	00300793          	li	a5,3
    800018e8:	02f4dc63          	bge	s1,a5,80001920 <_Z8userMainv+0x9c>
    800018ec:	00100793          	li	a5,1
    800018f0:	08f48463          	beq	s1,a5,80001978 <_Z8userMainv+0xf4>
    800018f4:	00200793          	li	a5,2
    800018f8:	08f49e63          	bne	s1,a5,80001994 <_Z8userMainv+0x110>
#endif
            break;
        case 2:
#if LEVEL_2_IMPLEMENTED == 1
            //Threads_CPP_API_test();
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    800018fc:	00004517          	auipc	a0,0x4
    80001900:	85c50513          	addi	a0,a0,-1956 # 80005158 <kvmincrease+0x788>
    80001904:	00000097          	auipc	ra,0x0
    80001908:	420080e7          	jalr	1056(ra) # 80001d24 <_Z11printStringPKc>
#endif
            break;
    8000190c:	0140006f          	j	80001920 <_Z8userMainv+0x9c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
    80001910:	00003517          	auipc	a0,0x3
    80001914:	7a850513          	addi	a0,a0,1960 # 800050b8 <kvmincrease+0x6e8>
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	40c080e7          	jalr	1036(ra) # 80001d24 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80001920:	01813083          	ld	ra,24(sp)
    80001924:	01013403          	ld	s0,16(sp)
    80001928:	00813483          	ld	s1,8(sp)
    8000192c:	00013903          	ld	s2,0(sp)
    80001930:	02010113          	addi	sp,sp,32
    80001934:	00008067          	ret
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001938:	00003517          	auipc	a0,0x3
    8000193c:	7b050513          	addi	a0,a0,1968 # 800050e8 <kvmincrease+0x718>
    80001940:	00000097          	auipc	ra,0x0
    80001944:	3e4080e7          	jalr	996(ra) # 80001d24 <_Z11printStringPKc>
            return;
    80001948:	fd9ff06f          	j	80001920 <_Z8userMainv+0x9c>
    switch (test) {
    8000194c:	00700793          	li	a5,7
    80001950:	04f49263          	bne	s1,a5,80001994 <_Z8userMainv+0x110>
            printString("Test se nije uspesno zavrsio\n");
    80001954:	00004517          	auipc	a0,0x4
    80001958:	84450513          	addi	a0,a0,-1980 # 80005198 <kvmincrease+0x7c8>
    8000195c:	00000097          	auipc	ra,0x0
    80001960:	3c8080e7          	jalr	968(ra) # 80001d24 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001964:	00004517          	auipc	a0,0x4
    80001968:	85450513          	addi	a0,a0,-1964 # 800051b8 <kvmincrease+0x7e8>
    8000196c:	00000097          	auipc	ra,0x0
    80001970:	3b8080e7          	jalr	952(ra) # 80001d24 <_Z11printStringPKc>
            break;
    80001974:	fadff06f          	j	80001920 <_Z8userMainv+0x9c>
            Threads_C_API_test();
    80001978:	00001097          	auipc	ra,0x1
    8000197c:	b58080e7          	jalr	-1192(ra) # 800024d0 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001980:	00003517          	auipc	a0,0x3
    80001984:	79850513          	addi	a0,a0,1944 # 80005118 <kvmincrease+0x748>
    80001988:	00000097          	auipc	ra,0x0
    8000198c:	39c080e7          	jalr	924(ra) # 80001d24 <_Z11printStringPKc>
            break;
    80001990:	f91ff06f          	j	80001920 <_Z8userMainv+0x9c>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001994:	00004517          	auipc	a0,0x4
    80001998:	87c50513          	addi	a0,a0,-1924 # 80005210 <kvmincrease+0x840>
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	388080e7          	jalr	904(ra) # 80001d24 <_Z11printStringPKc>
    800019a4:	f7dff06f          	j	80001920 <_Z8userMainv+0x9c>

00000000800019a8 <_Z2faPv>:

void fa(void*){
    800019a8:	fe010113          	addi	sp,sp,-32
    800019ac:	00113c23          	sd	ra,24(sp)
    800019b0:	00813823          	sd	s0,16(sp)
    800019b4:	00913423          	sd	s1,8(sp)
    800019b8:	02010413          	addi	s0,sp,32
    //running je nitA
    //threadJoin(nitB);
    for(int i=0;i<10;i++){
    800019bc:	00000493          	li	s1,0
    800019c0:	00900793          	li	a5,9
    800019c4:	0097ce63          	blt	a5,s1,800019e0 <_Z2faPv+0x38>
        printString("A\n");
    800019c8:	00004517          	auipc	a0,0x4
    800019cc:	87050513          	addi	a0,a0,-1936 # 80005238 <kvmincrease+0x868>
    800019d0:	00000097          	auipc	ra,0x0
    800019d4:	354080e7          	jalr	852(ra) # 80001d24 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    800019d8:	0014849b          	addiw	s1,s1,1
    800019dc:	fe5ff06f          	j	800019c0 <_Z2faPv+0x18>

    }
    printString("\n");
    800019e0:	00004517          	auipc	a0,0x4
    800019e4:	a9850513          	addi	a0,a0,-1384 # 80005478 <kvmincrease+0xaa8>
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	33c080e7          	jalr	828(ra) # 80001d24 <_Z11printStringPKc>
    800019f0:	00004797          	auipc	a5,0x4
    800019f4:	2807b783          	ld	a5,640(a5) # 80005c70 <_ZN7_thread7runningE>
    800019f8:	00100713          	li	a4,1
    800019fc:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	290080e7          	jalr	656(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80001a08:	01813083          	ld	ra,24(sp)
    80001a0c:	01013403          	ld	s0,16(sp)
    80001a10:	00813483          	ld	s1,8(sp)
    80001a14:	02010113          	addi	sp,sp,32
    80001a18:	00008067          	ret

0000000080001a1c <_Z2fbPv>:

void fb(void*){
    80001a1c:	fe010113          	addi	sp,sp,-32
    80001a20:	00113c23          	sd	ra,24(sp)
    80001a24:	00813823          	sd	s0,16(sp)
    80001a28:	00913423          	sd	s1,8(sp)
    80001a2c:	02010413          	addi	s0,sp,32
    //threadJoin(nitC);
    for(int i=0;i<10;i++){
    80001a30:	00000493          	li	s1,0
    80001a34:	00900793          	li	a5,9
    80001a38:	0097ce63          	blt	a5,s1,80001a54 <_Z2fbPv+0x38>
        printString("B\n");
    80001a3c:	00004517          	auipc	a0,0x4
    80001a40:	80450513          	addi	a0,a0,-2044 # 80005240 <kvmincrease+0x870>
    80001a44:	00000097          	auipc	ra,0x0
    80001a48:	2e0080e7          	jalr	736(ra) # 80001d24 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    80001a4c:	0014849b          	addiw	s1,s1,1
    80001a50:	fe5ff06f          	j	80001a34 <_Z2fbPv+0x18>

    }
    printString("\n");
    80001a54:	00004517          	auipc	a0,0x4
    80001a58:	a2450513          	addi	a0,a0,-1500 # 80005478 <kvmincrease+0xaa8>
    80001a5c:	00000097          	auipc	ra,0x0
    80001a60:	2c8080e7          	jalr	712(ra) # 80001d24 <_Z11printStringPKc>
    80001a64:	00004797          	auipc	a5,0x4
    80001a68:	20c7b783          	ld	a5,524(a5) # 80005c70 <_ZN7_thread7runningE>
    80001a6c:	00100713          	li	a4,1
    80001a70:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001a74:	00000097          	auipc	ra,0x0
    80001a78:	21c080e7          	jalr	540(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80001a7c:	01813083          	ld	ra,24(sp)
    80001a80:	01013403          	ld	s0,16(sp)
    80001a84:	00813483          	ld	s1,8(sp)
    80001a88:	02010113          	addi	sp,sp,32
    80001a8c:	00008067          	ret

0000000080001a90 <_Z2fcPv>:

void fc(void*){
    80001a90:	fe010113          	addi	sp,sp,-32
    80001a94:	00113c23          	sd	ra,24(sp)
    80001a98:	00813823          	sd	s0,16(sp)
    80001a9c:	00913423          	sd	s1,8(sp)
    80001aa0:	02010413          	addi	s0,sp,32
    for(int i=0;i<10;i++){
    80001aa4:	00000493          	li	s1,0
    80001aa8:	00900793          	li	a5,9
    80001aac:	0097ce63          	blt	a5,s1,80001ac8 <_Z2fcPv+0x38>
        printString("C\n");
    80001ab0:	00003517          	auipc	a0,0x3
    80001ab4:	79850513          	addi	a0,a0,1944 # 80005248 <kvmincrease+0x878>
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	26c080e7          	jalr	620(ra) # 80001d24 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    80001ac0:	0014849b          	addiw	s1,s1,1
    80001ac4:	fe5ff06f          	j	80001aa8 <_Z2fcPv+0x18>

    }
    printString("\n");
    80001ac8:	00004517          	auipc	a0,0x4
    80001acc:	9b050513          	addi	a0,a0,-1616 # 80005478 <kvmincrease+0xaa8>
    80001ad0:	00000097          	auipc	ra,0x0
    80001ad4:	254080e7          	jalr	596(ra) # 80001d24 <_Z11printStringPKc>
    80001ad8:	00004797          	auipc	a5,0x4
    80001adc:	1987b783          	ld	a5,408(a5) # 80005c70 <_ZN7_thread7runningE>
    80001ae0:	00100713          	li	a4,1
    80001ae4:	02e78423          	sb	a4,40(a5)

    _thread::running->setFinished(true);
    thread_dispatch();
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	1a8080e7          	jalr	424(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80001af0:	01813083          	ld	ra,24(sp)
    80001af4:	01013403          	ld	s0,16(sp)
    80001af8:	00813483          	ld	s1,8(sp)
    80001afc:	02010113          	addi	sp,sp,32
    80001b00:	00008067          	ret

0000000080001b04 <_Z7wrapperPv>:



void wrapper(void* arg){
    80001b04:	ff010113          	addi	sp,sp,-16
    80001b08:	00113423          	sd	ra,8(sp)
    80001b0c:	00813023          	sd	s0,0(sp)
    80001b10:	01010413          	addi	s0,sp,16
    thread_create(&nitA, fa, nullptr);
    80001b14:	00000613          	li	a2,0
    80001b18:	00000597          	auipc	a1,0x0
    80001b1c:	e9058593          	addi	a1,a1,-368 # 800019a8 <_Z2faPv>
    80001b20:	00004517          	auipc	a0,0x4
    80001b24:	16850513          	addi	a0,a0,360 # 80005c88 <nitA>
    80001b28:	00000097          	auipc	ra,0x0
    80001b2c:	134080e7          	jalr	308(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    thread_create(&nitB, fb, nullptr);
    80001b30:	00000613          	li	a2,0
    80001b34:	00000597          	auipc	a1,0x0
    80001b38:	ee858593          	addi	a1,a1,-280 # 80001a1c <_Z2fbPv>
    80001b3c:	00004517          	auipc	a0,0x4
    80001b40:	14450513          	addi	a0,a0,324 # 80005c80 <nitB>
    80001b44:	00000097          	auipc	ra,0x0
    80001b48:	118080e7          	jalr	280(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    thread_create(&nitC, fc, nullptr);
    80001b4c:	00000613          	li	a2,0
    80001b50:	00000597          	auipc	a1,0x0
    80001b54:	f4058593          	addi	a1,a1,-192 # 80001a90 <_Z2fcPv>
    80001b58:	00004517          	auipc	a0,0x4
    80001b5c:	12050513          	addi	a0,a0,288 # 80005c78 <nitC>
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	0fc080e7          	jalr	252(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    80001b68:	00c0006f          	j	80001b74 <_Z7wrapperPv+0x70>

    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
        thread_dispatch();
    80001b6c:	00000097          	auipc	ra,0x0
    80001b70:	124080e7          	jalr	292(ra) # 80001c90 <_Z15thread_dispatchv>
    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
    80001b74:	00004797          	auipc	a5,0x4
    80001b78:	1147b783          	ld	a5,276(a5) # 80005c88 <nitA>
    bool isFinished() const { return finished; }
    80001b7c:	0287c783          	lbu	a5,40(a5)
    80001b80:	fe0786e3          	beqz	a5,80001b6c <_Z7wrapperPv+0x68>
    80001b84:	00004797          	auipc	a5,0x4
    80001b88:	0fc7b783          	ld	a5,252(a5) # 80005c80 <nitB>
    80001b8c:	0287c783          	lbu	a5,40(a5)
    80001b90:	fc078ee3          	beqz	a5,80001b6c <_Z7wrapperPv+0x68>
    80001b94:	00004797          	auipc	a5,0x4
    80001b98:	0e47b783          	ld	a5,228(a5) # 80005c78 <nitC>
    80001b9c:	0287c783          	lbu	a5,40(a5)
    80001ba0:	fc0786e3          	beqz	a5,80001b6c <_Z7wrapperPv+0x68>
    }

    printString("ZAVRSENA JE WRAPPER FJA\n");
    80001ba4:	00003517          	auipc	a0,0x3
    80001ba8:	6ac50513          	addi	a0,a0,1708 # 80005250 <kvmincrease+0x880>
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	178080e7          	jalr	376(ra) # 80001d24 <_Z11printStringPKc>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001bb4:	00004797          	auipc	a5,0x4
    80001bb8:	0bc7b783          	ld	a5,188(a5) # 80005c70 <_ZN7_thread7runningE>
    80001bbc:	00100713          	li	a4,1
    80001bc0:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	0cc080e7          	jalr	204(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80001bcc:	00813083          	ld	ra,8(sp)
    80001bd0:	00013403          	ld	s0,0(sp)
    80001bd4:	01010113          	addi	sp,sp,16
    80001bd8:	00008067          	ret

0000000080001bdc <main>:

int main()
{
    80001bdc:	fe010113          	addi	sp,sp,-32
    80001be0:	00113c23          	sd	ra,24(sp)
    80001be4:	00813823          	sd	s0,16(sp)
    80001be8:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine
    80001bec:	fffff797          	auipc	a5,0xfffff
    80001bf0:	54478793          	addi	a5,a5,1348 # 80001130 <_ZN5Riscv16interruptRoutineEv>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001bf4:	10579073          	csrw	stvec,a5
    //Riscv: :ms_sstatus (Riscv:: SSTATUS_SIE);
    thread_t thread1;
    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    80001bf8:	00000613          	li	a2,0
    80001bfc:	00000593          	li	a1,0
    80001c00:	fe840513          	addi	a0,s0,-24
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	058080e7          	jalr	88(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = thread1;
    80001c0c:	fe843783          	ld	a5,-24(s0)
    80001c10:	00004717          	auipc	a4,0x4
    80001c14:	06f73023          	sd	a5,96(a4) # 80005c70 <_ZN7_thread7runningE>

    thread_t thread2;
    thread_create(&thread2, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80001c18:	00000613          	li	a2,0
    80001c1c:	00000597          	auipc	a1,0x0
    80001c20:	c6858593          	addi	a1,a1,-920 # 80001884 <_Z8userMainv>
    80001c24:	fe040513          	addi	a0,s0,-32
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	034080e7          	jalr	52(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>

    while (!(thread2->isFinished())) {
    80001c30:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001c34:	0287c783          	lbu	a5,40(a5)
    80001c38:	00079863          	bnez	a5,80001c48 <main+0x6c>
        thread_dispatch();
    80001c3c:	00000097          	auipc	ra,0x0
    80001c40:	054080e7          	jalr	84(ra) # 80001c90 <_Z15thread_dispatchv>
    80001c44:	fedff06f          	j	80001c30 <main+0x54>
    }

    return 0;
}
    80001c48:	00000513          	li	a0,0
    80001c4c:	01813083          	ld	ra,24(sp)
    80001c50:	01013403          	ld	s0,16(sp)
    80001c54:	02010113          	addi	sp,sp,32
    80001c58:	00008067          	ret

0000000080001c5c <_Z13thread_createPP7_threadPFvPvES2_>:

#include "../lib/hw.h"
#include "../h/_thread.hpp"
#include "../lib/console.h"

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001c5c:	ff010113          	addi	sp,sp,-16
    80001c60:	00813423          	sd	s0,8(sp)
    80001c64:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x11;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    80001c68:	00060693          	mv	a3,a2
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80001c6c:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001c70:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001c74:	01100793          	li	a5,17
    80001c78:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001c7c:	00000073          	ecall
    return 0;
    //dodati promenljivu za povratnu vrednost
}
    80001c80:	00000513          	li	a0,0
    80001c84:	00813403          	ld	s0,8(sp)
    80001c88:	01010113          	addi	sp,sp,16
    80001c8c:	00008067          	ret

0000000080001c90 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001c90:	ff010113          	addi	sp,sp,-16
    80001c94:	00813423          	sd	s0,8(sp)
    80001c98:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001c9c:	01300793          	li	a5,19
    80001ca0:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001ca4:	00000073          	ecall
}
    80001ca8:	00813403          	ld	s0,8(sp)
    80001cac:	01010113          	addi	sp,sp,16
    80001cb0:	00008067          	ret

0000000080001cb4 <_Z11thread_exitv>:

void thread_exit(){
    80001cb4:	ff010113          	addi	sp,sp,-16
    80001cb8:	00813423          	sd	s0,8(sp)
    80001cbc:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x12;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001cc0:	01200793          	li	a5,18
    80001cc4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001cc8:	00000073          	ecall
}
    80001ccc:	00813403          	ld	s0,8(sp)
    80001cd0:	01010113          	addi	sp,sp,16
    80001cd4:	00008067          	ret

0000000080001cd8 <_Z4getcv>:

void getc(){
    80001cd8:	ff010113          	addi	sp,sp,-16
    80001cdc:	00813423          	sd	s0,8(sp)
    80001ce0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x20;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001ce4:	02000793          	li	a5,32
    80001ce8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001cec:	00000073          	ecall
}
    80001cf0:	00813403          	ld	s0,8(sp)
    80001cf4:	01010113          	addi	sp,sp,16
    80001cf8:	00008067          	ret

0000000080001cfc <_Z4putcc>:

void putc(char c){
    80001cfc:	ff010113          	addi	sp,sp,-16
    80001d00:	00113423          	sd	ra,8(sp)
    80001d04:	00813023          	sd	s0,0(sp)
    80001d08:	01010413          	addi	s0,sp,16
    __putc(c);
    80001d0c:	00003097          	auipc	ra,0x3
    80001d10:	ba4080e7          	jalr	-1116(ra) # 800048b0 <__putc>
    80001d14:	00813083          	ld	ra,8(sp)
    80001d18:	00013403          	ld	s0,0(sp)
    80001d1c:	01010113          	addi	sp,sp,16
    80001d20:	00008067          	ret

0000000080001d24 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001d24:	fe010113          	addi	sp,sp,-32
    80001d28:	00113c23          	sd	ra,24(sp)
    80001d2c:	00813823          	sd	s0,16(sp)
    80001d30:	00913423          	sd	s1,8(sp)
    80001d34:	02010413          	addi	s0,sp,32
    80001d38:	00050493          	mv	s1,a0
    LOCK();
    80001d3c:	00100613          	li	a2,1
    80001d40:	00000593          	li	a1,0
    80001d44:	00004517          	auipc	a0,0x4
    80001d48:	f4c50513          	addi	a0,a0,-180 # 80005c90 <lockPrint>
    80001d4c:	fffff097          	auipc	ra,0xfffff
    80001d50:	2b4080e7          	jalr	692(ra) # 80001000 <copy_and_swap>
    80001d54:	00050863          	beqz	a0,80001d64 <_Z11printStringPKc+0x40>
    80001d58:	00000097          	auipc	ra,0x0
    80001d5c:	f38080e7          	jalr	-200(ra) # 80001c90 <_Z15thread_dispatchv>
    80001d60:	fddff06f          	j	80001d3c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001d64:	0004c503          	lbu	a0,0(s1)
    80001d68:	00050a63          	beqz	a0,80001d7c <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	f90080e7          	jalr	-112(ra) # 80001cfc <_Z4putcc>
        string++;
    80001d74:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001d78:	fedff06f          	j	80001d64 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80001d7c:	00000613          	li	a2,0
    80001d80:	00100593          	li	a1,1
    80001d84:	00004517          	auipc	a0,0x4
    80001d88:	f0c50513          	addi	a0,a0,-244 # 80005c90 <lockPrint>
    80001d8c:	fffff097          	auipc	ra,0xfffff
    80001d90:	274080e7          	jalr	628(ra) # 80001000 <copy_and_swap>
    80001d94:	fe0514e3          	bnez	a0,80001d7c <_Z11printStringPKc+0x58>
}
    80001d98:	01813083          	ld	ra,24(sp)
    80001d9c:	01013403          	ld	s0,16(sp)
    80001da0:	00813483          	ld	s1,8(sp)
    80001da4:	02010113          	addi	sp,sp,32
    80001da8:	00008067          	ret

0000000080001dac <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001dac:	fd010113          	addi	sp,sp,-48
    80001db0:	02113423          	sd	ra,40(sp)
    80001db4:	02813023          	sd	s0,32(sp)
    80001db8:	00913c23          	sd	s1,24(sp)
    80001dbc:	01213823          	sd	s2,16(sp)
    80001dc0:	01313423          	sd	s3,8(sp)
    80001dc4:	01413023          	sd	s4,0(sp)
    80001dc8:	03010413          	addi	s0,sp,48
    80001dcc:	00050993          	mv	s3,a0
    80001dd0:	00058a13          	mv	s4,a1
    LOCK();
    80001dd4:	00100613          	li	a2,1
    80001dd8:	00000593          	li	a1,0
    80001ddc:	00004517          	auipc	a0,0x4
    80001de0:	eb450513          	addi	a0,a0,-332 # 80005c90 <lockPrint>
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	21c080e7          	jalr	540(ra) # 80001000 <copy_and_swap>
    80001dec:	00050863          	beqz	a0,80001dfc <_Z9getStringPci+0x50>
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	ea0080e7          	jalr	-352(ra) # 80001c90 <_Z15thread_dispatchv>
    80001df8:	fddff06f          	j	80001dd4 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001dfc:	00000913          	li	s2,0
    80001e00:	00090493          	mv	s1,s2
    80001e04:	0019091b          	addiw	s2,s2,1
    80001e08:	03495a63          	bge	s2,s4,80001e3c <_Z9getStringPci+0x90>
        cc = getc();
    80001e0c:	00000097          	auipc	ra,0x0
    80001e10:	ecc080e7          	jalr	-308(ra) # 80001cd8 <_Z4getcv>
        if(cc < 1)
    80001e14:	02050463          	beqz	a0,80001e3c <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80001e18:	009984b3          	add	s1,s3,s1
    80001e1c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001e20:	00a00793          	li	a5,10
    80001e24:	00f50a63          	beq	a0,a5,80001e38 <_Z9getStringPci+0x8c>
    80001e28:	00d00793          	li	a5,13
    80001e2c:	fcf51ae3          	bne	a0,a5,80001e00 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80001e30:	00090493          	mv	s1,s2
    80001e34:	0080006f          	j	80001e3c <_Z9getStringPci+0x90>
    80001e38:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001e3c:	009984b3          	add	s1,s3,s1
    80001e40:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001e44:	00000613          	li	a2,0
    80001e48:	00100593          	li	a1,1
    80001e4c:	00004517          	auipc	a0,0x4
    80001e50:	e4450513          	addi	a0,a0,-444 # 80005c90 <lockPrint>
    80001e54:	fffff097          	auipc	ra,0xfffff
    80001e58:	1ac080e7          	jalr	428(ra) # 80001000 <copy_and_swap>
    80001e5c:	fe0514e3          	bnez	a0,80001e44 <_Z9getStringPci+0x98>
    return buf;
}
    80001e60:	00098513          	mv	a0,s3
    80001e64:	02813083          	ld	ra,40(sp)
    80001e68:	02013403          	ld	s0,32(sp)
    80001e6c:	01813483          	ld	s1,24(sp)
    80001e70:	01013903          	ld	s2,16(sp)
    80001e74:	00813983          	ld	s3,8(sp)
    80001e78:	00013a03          	ld	s4,0(sp)
    80001e7c:	03010113          	addi	sp,sp,48
    80001e80:	00008067          	ret

0000000080001e84 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001e84:	ff010113          	addi	sp,sp,-16
    80001e88:	00813423          	sd	s0,8(sp)
    80001e8c:	01010413          	addi	s0,sp,16
    80001e90:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001e94:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001e98:	0006c603          	lbu	a2,0(a3) # 8000 <_entry-0x7fff8000>
    80001e9c:	fd06071b          	addiw	a4,a2,-48
    80001ea0:	0ff77713          	andi	a4,a4,255
    80001ea4:	00900793          	li	a5,9
    80001ea8:	02e7e063          	bltu	a5,a4,80001ec8 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001eac:	0025179b          	slliw	a5,a0,0x2
    80001eb0:	00a787bb          	addw	a5,a5,a0
    80001eb4:	0017979b          	slliw	a5,a5,0x1
    80001eb8:	00168693          	addi	a3,a3,1
    80001ebc:	00c787bb          	addw	a5,a5,a2
    80001ec0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001ec4:	fd5ff06f          	j	80001e98 <_Z11stringToIntPKc+0x14>
    return n;
}
    80001ec8:	00813403          	ld	s0,8(sp)
    80001ecc:	01010113          	addi	sp,sp,16
    80001ed0:	00008067          	ret

0000000080001ed4 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001ed4:	fc010113          	addi	sp,sp,-64
    80001ed8:	02113c23          	sd	ra,56(sp)
    80001edc:	02813823          	sd	s0,48(sp)
    80001ee0:	02913423          	sd	s1,40(sp)
    80001ee4:	03213023          	sd	s2,32(sp)
    80001ee8:	01313c23          	sd	s3,24(sp)
    80001eec:	04010413          	addi	s0,sp,64
    80001ef0:	00050493          	mv	s1,a0
    80001ef4:	00058913          	mv	s2,a1
    80001ef8:	00060993          	mv	s3,a2
    LOCK();
    80001efc:	00100613          	li	a2,1
    80001f00:	00000593          	li	a1,0
    80001f04:	00004517          	auipc	a0,0x4
    80001f08:	d8c50513          	addi	a0,a0,-628 # 80005c90 <lockPrint>
    80001f0c:	fffff097          	auipc	ra,0xfffff
    80001f10:	0f4080e7          	jalr	244(ra) # 80001000 <copy_and_swap>
    80001f14:	00050863          	beqz	a0,80001f24 <_Z8printIntiii+0x50>
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	d78080e7          	jalr	-648(ra) # 80001c90 <_Z15thread_dispatchv>
    80001f20:	fddff06f          	j	80001efc <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001f24:	00098463          	beqz	s3,80001f2c <_Z8printIntiii+0x58>
    80001f28:	0804c463          	bltz	s1,80001fb0 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001f2c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001f30:	00000593          	li	a1,0
    }

    i = 0;
    80001f34:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001f38:	0009079b          	sext.w	a5,s2
    80001f3c:	0325773b          	remuw	a4,a0,s2
    80001f40:	00048613          	mv	a2,s1
    80001f44:	0014849b          	addiw	s1,s1,1
    80001f48:	02071693          	slli	a3,a4,0x20
    80001f4c:	0206d693          	srli	a3,a3,0x20
    80001f50:	00004717          	auipc	a4,0x4
    80001f54:	ca070713          	addi	a4,a4,-864 # 80005bf0 <digits>
    80001f58:	00d70733          	add	a4,a4,a3
    80001f5c:	00074683          	lbu	a3,0(a4)
    80001f60:	fd040713          	addi	a4,s0,-48
    80001f64:	00c70733          	add	a4,a4,a2
    80001f68:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001f6c:	0005071b          	sext.w	a4,a0
    80001f70:	0325553b          	divuw	a0,a0,s2
    80001f74:	fcf772e3          	bgeu	a4,a5,80001f38 <_Z8printIntiii+0x64>
    if(neg)
    80001f78:	00058c63          	beqz	a1,80001f90 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80001f7c:	fd040793          	addi	a5,s0,-48
    80001f80:	009784b3          	add	s1,a5,s1
    80001f84:	02d00793          	li	a5,45
    80001f88:	fef48823          	sb	a5,-16(s1)
    80001f8c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001f90:	fff4849b          	addiw	s1,s1,-1
    80001f94:	0204c463          	bltz	s1,80001fbc <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80001f98:	fd040793          	addi	a5,s0,-48
    80001f9c:	009787b3          	add	a5,a5,s1
    80001fa0:	ff07c503          	lbu	a0,-16(a5)
    80001fa4:	00000097          	auipc	ra,0x0
    80001fa8:	d58080e7          	jalr	-680(ra) # 80001cfc <_Z4putcc>
    80001fac:	fe5ff06f          	j	80001f90 <_Z8printIntiii+0xbc>
        x = -xx;
    80001fb0:	4090053b          	negw	a0,s1
        neg = 1;
    80001fb4:	00100593          	li	a1,1
        x = -xx;
    80001fb8:	f7dff06f          	j	80001f34 <_Z8printIntiii+0x60>

    UNLOCK();
    80001fbc:	00000613          	li	a2,0
    80001fc0:	00100593          	li	a1,1
    80001fc4:	00004517          	auipc	a0,0x4
    80001fc8:	ccc50513          	addi	a0,a0,-820 # 80005c90 <lockPrint>
    80001fcc:	fffff097          	auipc	ra,0xfffff
    80001fd0:	034080e7          	jalr	52(ra) # 80001000 <copy_and_swap>
    80001fd4:	fe0514e3          	bnez	a0,80001fbc <_Z8printIntiii+0xe8>
    80001fd8:	03813083          	ld	ra,56(sp)
    80001fdc:	03013403          	ld	s0,48(sp)
    80001fe0:	02813483          	ld	s1,40(sp)
    80001fe4:	02013903          	ld	s2,32(sp)
    80001fe8:	01813983          	ld	s3,24(sp)
    80001fec:	04010113          	addi	sp,sp,64
    80001ff0:	00008067          	ret

0000000080001ff4 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001ff4:	fe010113          	addi	sp,sp,-32
    80001ff8:	00113c23          	sd	ra,24(sp)
    80001ffc:	00813823          	sd	s0,16(sp)
    80002000:	00913423          	sd	s1,8(sp)
    80002004:	01213023          	sd	s2,0(sp)
    80002008:	02010413          	addi	s0,sp,32
    8000200c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002010:	00100793          	li	a5,1
    80002014:	02a7f863          	bgeu	a5,a0,80002044 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002018:	00a00793          	li	a5,10
    8000201c:	02f577b3          	remu	a5,a0,a5
    80002020:	02078e63          	beqz	a5,8000205c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002024:	fff48513          	addi	a0,s1,-1
    80002028:	00000097          	auipc	ra,0x0
    8000202c:	fcc080e7          	jalr	-52(ra) # 80001ff4 <_ZL9fibonaccim>
    80002030:	00050913          	mv	s2,a0
    80002034:	ffe48513          	addi	a0,s1,-2
    80002038:	00000097          	auipc	ra,0x0
    8000203c:	fbc080e7          	jalr	-68(ra) # 80001ff4 <_ZL9fibonaccim>
    80002040:	00a90533          	add	a0,s2,a0
}
    80002044:	01813083          	ld	ra,24(sp)
    80002048:	01013403          	ld	s0,16(sp)
    8000204c:	00813483          	ld	s1,8(sp)
    80002050:	00013903          	ld	s2,0(sp)
    80002054:	02010113          	addi	sp,sp,32
    80002058:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000205c:	00000097          	auipc	ra,0x0
    80002060:	c34080e7          	jalr	-972(ra) # 80001c90 <_Z15thread_dispatchv>
    80002064:	fc1ff06f          	j	80002024 <_ZL9fibonaccim+0x30>

0000000080002068 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002068:	fe010113          	addi	sp,sp,-32
    8000206c:	00113c23          	sd	ra,24(sp)
    80002070:	00813823          	sd	s0,16(sp)
    80002074:	00913423          	sd	s1,8(sp)
    80002078:	01213023          	sd	s2,0(sp)
    8000207c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002080:	00a00493          	li	s1,10
    80002084:	0400006f          	j	800020c4 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002088:	00003517          	auipc	a0,0x3
    8000208c:	1e850513          	addi	a0,a0,488 # 80005270 <kvmincrease+0x8a0>
    80002090:	00000097          	auipc	ra,0x0
    80002094:	c94080e7          	jalr	-876(ra) # 80001d24 <_Z11printStringPKc>
    80002098:	00000613          	li	a2,0
    8000209c:	00a00593          	li	a1,10
    800020a0:	00048513          	mv	a0,s1
    800020a4:	00000097          	auipc	ra,0x0
    800020a8:	e30080e7          	jalr	-464(ra) # 80001ed4 <_Z8printIntiii>
    800020ac:	00003517          	auipc	a0,0x3
    800020b0:	3cc50513          	addi	a0,a0,972 # 80005478 <kvmincrease+0xaa8>
    800020b4:	00000097          	auipc	ra,0x0
    800020b8:	c70080e7          	jalr	-912(ra) # 80001d24 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800020bc:	0014849b          	addiw	s1,s1,1
    800020c0:	0ff4f493          	andi	s1,s1,255
    800020c4:	00c00793          	li	a5,12
    800020c8:	fc97f0e3          	bgeu	a5,s1,80002088 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800020cc:	00003517          	auipc	a0,0x3
    800020d0:	1ac50513          	addi	a0,a0,428 # 80005278 <kvmincrease+0x8a8>
    800020d4:	00000097          	auipc	ra,0x0
    800020d8:	c50080e7          	jalr	-944(ra) # 80001d24 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800020dc:	00500313          	li	t1,5
    thread_dispatch();
    800020e0:	00000097          	auipc	ra,0x0
    800020e4:	bb0080e7          	jalr	-1104(ra) # 80001c90 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800020e8:	01000513          	li	a0,16
    800020ec:	00000097          	auipc	ra,0x0
    800020f0:	f08080e7          	jalr	-248(ra) # 80001ff4 <_ZL9fibonaccim>
    800020f4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800020f8:	00003517          	auipc	a0,0x3
    800020fc:	19050513          	addi	a0,a0,400 # 80005288 <kvmincrease+0x8b8>
    80002100:	00000097          	auipc	ra,0x0
    80002104:	c24080e7          	jalr	-988(ra) # 80001d24 <_Z11printStringPKc>
    80002108:	00000613          	li	a2,0
    8000210c:	00a00593          	li	a1,10
    80002110:	0009051b          	sext.w	a0,s2
    80002114:	00000097          	auipc	ra,0x0
    80002118:	dc0080e7          	jalr	-576(ra) # 80001ed4 <_Z8printIntiii>
    8000211c:	00003517          	auipc	a0,0x3
    80002120:	35c50513          	addi	a0,a0,860 # 80005478 <kvmincrease+0xaa8>
    80002124:	00000097          	auipc	ra,0x0
    80002128:	c00080e7          	jalr	-1024(ra) # 80001d24 <_Z11printStringPKc>
    8000212c:	0400006f          	j	8000216c <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002130:	00003517          	auipc	a0,0x3
    80002134:	14050513          	addi	a0,a0,320 # 80005270 <kvmincrease+0x8a0>
    80002138:	00000097          	auipc	ra,0x0
    8000213c:	bec080e7          	jalr	-1044(ra) # 80001d24 <_Z11printStringPKc>
    80002140:	00000613          	li	a2,0
    80002144:	00a00593          	li	a1,10
    80002148:	00048513          	mv	a0,s1
    8000214c:	00000097          	auipc	ra,0x0
    80002150:	d88080e7          	jalr	-632(ra) # 80001ed4 <_Z8printIntiii>
    80002154:	00003517          	auipc	a0,0x3
    80002158:	32450513          	addi	a0,a0,804 # 80005478 <kvmincrease+0xaa8>
    8000215c:	00000097          	auipc	ra,0x0
    80002160:	bc8080e7          	jalr	-1080(ra) # 80001d24 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002164:	0014849b          	addiw	s1,s1,1
    80002168:	0ff4f493          	andi	s1,s1,255
    8000216c:	00f00793          	li	a5,15
    80002170:	fc97f0e3          	bgeu	a5,s1,80002130 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002174:	00003517          	auipc	a0,0x3
    80002178:	12450513          	addi	a0,a0,292 # 80005298 <kvmincrease+0x8c8>
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	ba8080e7          	jalr	-1112(ra) # 80001d24 <_Z11printStringPKc>
    finishedD = true;
    80002184:	00100793          	li	a5,1
    80002188:	00004717          	auipc	a4,0x4
    8000218c:	b0f70823          	sb	a5,-1264(a4) # 80005c98 <_ZL9finishedD>
    thread_dispatch();
    80002190:	00000097          	auipc	ra,0x0
    80002194:	b00080e7          	jalr	-1280(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80002198:	01813083          	ld	ra,24(sp)
    8000219c:	01013403          	ld	s0,16(sp)
    800021a0:	00813483          	ld	s1,8(sp)
    800021a4:	00013903          	ld	s2,0(sp)
    800021a8:	02010113          	addi	sp,sp,32
    800021ac:	00008067          	ret

00000000800021b0 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800021b0:	fe010113          	addi	sp,sp,-32
    800021b4:	00113c23          	sd	ra,24(sp)
    800021b8:	00813823          	sd	s0,16(sp)
    800021bc:	00913423          	sd	s1,8(sp)
    800021c0:	01213023          	sd	s2,0(sp)
    800021c4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800021c8:	00000493          	li	s1,0
    800021cc:	0400006f          	j	8000220c <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800021d0:	00003517          	auipc	a0,0x3
    800021d4:	0d850513          	addi	a0,a0,216 # 800052a8 <kvmincrease+0x8d8>
    800021d8:	00000097          	auipc	ra,0x0
    800021dc:	b4c080e7          	jalr	-1204(ra) # 80001d24 <_Z11printStringPKc>
    800021e0:	00000613          	li	a2,0
    800021e4:	00a00593          	li	a1,10
    800021e8:	00048513          	mv	a0,s1
    800021ec:	00000097          	auipc	ra,0x0
    800021f0:	ce8080e7          	jalr	-792(ra) # 80001ed4 <_Z8printIntiii>
    800021f4:	00003517          	auipc	a0,0x3
    800021f8:	28450513          	addi	a0,a0,644 # 80005478 <kvmincrease+0xaa8>
    800021fc:	00000097          	auipc	ra,0x0
    80002200:	b28080e7          	jalr	-1240(ra) # 80001d24 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002204:	0014849b          	addiw	s1,s1,1
    80002208:	0ff4f493          	andi	s1,s1,255
    8000220c:	00200793          	li	a5,2
    80002210:	fc97f0e3          	bgeu	a5,s1,800021d0 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80002214:	00003517          	auipc	a0,0x3
    80002218:	09c50513          	addi	a0,a0,156 # 800052b0 <kvmincrease+0x8e0>
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	b08080e7          	jalr	-1272(ra) # 80001d24 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002224:	00700313          	li	t1,7
    thread_dispatch();
    80002228:	00000097          	auipc	ra,0x0
    8000222c:	a68080e7          	jalr	-1432(ra) # 80001c90 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002230:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002234:	00003517          	auipc	a0,0x3
    80002238:	08c50513          	addi	a0,a0,140 # 800052c0 <kvmincrease+0x8f0>
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	ae8080e7          	jalr	-1304(ra) # 80001d24 <_Z11printStringPKc>
    80002244:	00000613          	li	a2,0
    80002248:	00a00593          	li	a1,10
    8000224c:	0009051b          	sext.w	a0,s2
    80002250:	00000097          	auipc	ra,0x0
    80002254:	c84080e7          	jalr	-892(ra) # 80001ed4 <_Z8printIntiii>
    80002258:	00003517          	auipc	a0,0x3
    8000225c:	22050513          	addi	a0,a0,544 # 80005478 <kvmincrease+0xaa8>
    80002260:	00000097          	auipc	ra,0x0
    80002264:	ac4080e7          	jalr	-1340(ra) # 80001d24 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80002268:	00c00513          	li	a0,12
    8000226c:	00000097          	auipc	ra,0x0
    80002270:	d88080e7          	jalr	-632(ra) # 80001ff4 <_ZL9fibonaccim>
    80002274:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002278:	00003517          	auipc	a0,0x3
    8000227c:	05050513          	addi	a0,a0,80 # 800052c8 <kvmincrease+0x8f8>
    80002280:	00000097          	auipc	ra,0x0
    80002284:	aa4080e7          	jalr	-1372(ra) # 80001d24 <_Z11printStringPKc>
    80002288:	00000613          	li	a2,0
    8000228c:	00a00593          	li	a1,10
    80002290:	0009051b          	sext.w	a0,s2
    80002294:	00000097          	auipc	ra,0x0
    80002298:	c40080e7          	jalr	-960(ra) # 80001ed4 <_Z8printIntiii>
    8000229c:	00003517          	auipc	a0,0x3
    800022a0:	1dc50513          	addi	a0,a0,476 # 80005478 <kvmincrease+0xaa8>
    800022a4:	00000097          	auipc	ra,0x0
    800022a8:	a80080e7          	jalr	-1408(ra) # 80001d24 <_Z11printStringPKc>
    800022ac:	0400006f          	j	800022ec <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800022b0:	00003517          	auipc	a0,0x3
    800022b4:	ff850513          	addi	a0,a0,-8 # 800052a8 <kvmincrease+0x8d8>
    800022b8:	00000097          	auipc	ra,0x0
    800022bc:	a6c080e7          	jalr	-1428(ra) # 80001d24 <_Z11printStringPKc>
    800022c0:	00000613          	li	a2,0
    800022c4:	00a00593          	li	a1,10
    800022c8:	00048513          	mv	a0,s1
    800022cc:	00000097          	auipc	ra,0x0
    800022d0:	c08080e7          	jalr	-1016(ra) # 80001ed4 <_Z8printIntiii>
    800022d4:	00003517          	auipc	a0,0x3
    800022d8:	1a450513          	addi	a0,a0,420 # 80005478 <kvmincrease+0xaa8>
    800022dc:	00000097          	auipc	ra,0x0
    800022e0:	a48080e7          	jalr	-1464(ra) # 80001d24 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800022e4:	0014849b          	addiw	s1,s1,1
    800022e8:	0ff4f493          	andi	s1,s1,255
    800022ec:	00500793          	li	a5,5
    800022f0:	fc97f0e3          	bgeu	a5,s1,800022b0 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800022f4:	00003517          	auipc	a0,0x3
    800022f8:	fe450513          	addi	a0,a0,-28 # 800052d8 <kvmincrease+0x908>
    800022fc:	00000097          	auipc	ra,0x0
    80002300:	a28080e7          	jalr	-1496(ra) # 80001d24 <_Z11printStringPKc>
    finishedC = true;
    80002304:	00100793          	li	a5,1
    80002308:	00004717          	auipc	a4,0x4
    8000230c:	98f708a3          	sb	a5,-1647(a4) # 80005c99 <_ZL9finishedC>
    thread_dispatch();
    80002310:	00000097          	auipc	ra,0x0
    80002314:	980080e7          	jalr	-1664(ra) # 80001c90 <_Z15thread_dispatchv>
}
    80002318:	01813083          	ld	ra,24(sp)
    8000231c:	01013403          	ld	s0,16(sp)
    80002320:	00813483          	ld	s1,8(sp)
    80002324:	00013903          	ld	s2,0(sp)
    80002328:	02010113          	addi	sp,sp,32
    8000232c:	00008067          	ret

0000000080002330 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80002330:	fe010113          	addi	sp,sp,-32
    80002334:	00113c23          	sd	ra,24(sp)
    80002338:	00813823          	sd	s0,16(sp)
    8000233c:	00913423          	sd	s1,8(sp)
    80002340:	01213023          	sd	s2,0(sp)
    80002344:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002348:	00000913          	li	s2,0
    8000234c:	0380006f          	j	80002384 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80002350:	00000097          	auipc	ra,0x0
    80002354:	940080e7          	jalr	-1728(ra) # 80001c90 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002358:	00148493          	addi	s1,s1,1
    8000235c:	000027b7          	lui	a5,0x2
    80002360:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002364:	0097ee63          	bltu	a5,s1,80002380 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002368:	00000713          	li	a4,0
    8000236c:	000077b7          	lui	a5,0x7
    80002370:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002374:	fce7eee3          	bltu	a5,a4,80002350 <_ZL11workerBodyBPv+0x20>
    80002378:	00170713          	addi	a4,a4,1
    8000237c:	ff1ff06f          	j	8000236c <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002380:	00190913          	addi	s2,s2,1
    80002384:	00f00793          	li	a5,15
    80002388:	0527e063          	bltu	a5,s2,800023c8 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000238c:	00003517          	auipc	a0,0x3
    80002390:	f5c50513          	addi	a0,a0,-164 # 800052e8 <kvmincrease+0x918>
    80002394:	00000097          	auipc	ra,0x0
    80002398:	990080e7          	jalr	-1648(ra) # 80001d24 <_Z11printStringPKc>
    8000239c:	00000613          	li	a2,0
    800023a0:	00a00593          	li	a1,10
    800023a4:	0009051b          	sext.w	a0,s2
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	b2c080e7          	jalr	-1236(ra) # 80001ed4 <_Z8printIntiii>
    800023b0:	00003517          	auipc	a0,0x3
    800023b4:	0c850513          	addi	a0,a0,200 # 80005478 <kvmincrease+0xaa8>
    800023b8:	00000097          	auipc	ra,0x0
    800023bc:	96c080e7          	jalr	-1684(ra) # 80001d24 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800023c0:	00000493          	li	s1,0
    800023c4:	f99ff06f          	j	8000235c <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800023c8:	00003517          	auipc	a0,0x3
    800023cc:	f2850513          	addi	a0,a0,-216 # 800052f0 <kvmincrease+0x920>
    800023d0:	00000097          	auipc	ra,0x0
    800023d4:	954080e7          	jalr	-1708(ra) # 80001d24 <_Z11printStringPKc>
    finishedB = true;
    800023d8:	00100793          	li	a5,1
    800023dc:	00004717          	auipc	a4,0x4
    800023e0:	8af70f23          	sb	a5,-1858(a4) # 80005c9a <_ZL9finishedB>
    thread_dispatch();
    800023e4:	00000097          	auipc	ra,0x0
    800023e8:	8ac080e7          	jalr	-1876(ra) # 80001c90 <_Z15thread_dispatchv>
}
    800023ec:	01813083          	ld	ra,24(sp)
    800023f0:	01013403          	ld	s0,16(sp)
    800023f4:	00813483          	ld	s1,8(sp)
    800023f8:	00013903          	ld	s2,0(sp)
    800023fc:	02010113          	addi	sp,sp,32
    80002400:	00008067          	ret

0000000080002404 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80002404:	fe010113          	addi	sp,sp,-32
    80002408:	00113c23          	sd	ra,24(sp)
    8000240c:	00813823          	sd	s0,16(sp)
    80002410:	00913423          	sd	s1,8(sp)
    80002414:	01213023          	sd	s2,0(sp)
    80002418:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000241c:	00000913          	li	s2,0
    80002420:	0380006f          	j	80002458 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80002424:	00000097          	auipc	ra,0x0
    80002428:	86c080e7          	jalr	-1940(ra) # 80001c90 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000242c:	00148493          	addi	s1,s1,1
    80002430:	000027b7          	lui	a5,0x2
    80002434:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002438:	0097ee63          	bltu	a5,s1,80002454 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000243c:	00000713          	li	a4,0
    80002440:	000077b7          	lui	a5,0x7
    80002444:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002448:	fce7eee3          	bltu	a5,a4,80002424 <_ZL11workerBodyAPv+0x20>
    8000244c:	00170713          	addi	a4,a4,1
    80002450:	ff1ff06f          	j	80002440 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002454:	00190913          	addi	s2,s2,1
    80002458:	00900793          	li	a5,9
    8000245c:	0527e063          	bltu	a5,s2,8000249c <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002460:	00003517          	auipc	a0,0x3
    80002464:	ea050513          	addi	a0,a0,-352 # 80005300 <kvmincrease+0x930>
    80002468:	00000097          	auipc	ra,0x0
    8000246c:	8bc080e7          	jalr	-1860(ra) # 80001d24 <_Z11printStringPKc>
    80002470:	00000613          	li	a2,0
    80002474:	00a00593          	li	a1,10
    80002478:	0009051b          	sext.w	a0,s2
    8000247c:	00000097          	auipc	ra,0x0
    80002480:	a58080e7          	jalr	-1448(ra) # 80001ed4 <_Z8printIntiii>
    80002484:	00003517          	auipc	a0,0x3
    80002488:	ff450513          	addi	a0,a0,-12 # 80005478 <kvmincrease+0xaa8>
    8000248c:	00000097          	auipc	ra,0x0
    80002490:	898080e7          	jalr	-1896(ra) # 80001d24 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002494:	00000493          	li	s1,0
    80002498:	f99ff06f          	j	80002430 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    8000249c:	00003517          	auipc	a0,0x3
    800024a0:	e3c50513          	addi	a0,a0,-452 # 800052d8 <kvmincrease+0x908>
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	880080e7          	jalr	-1920(ra) # 80001d24 <_Z11printStringPKc>
    finishedA = true;
    800024ac:	00100793          	li	a5,1
    800024b0:	00003717          	auipc	a4,0x3
    800024b4:	7ef705a3          	sb	a5,2027(a4) # 80005c9b <_ZL9finishedA>
}
    800024b8:	01813083          	ld	ra,24(sp)
    800024bc:	01013403          	ld	s0,16(sp)
    800024c0:	00813483          	ld	s1,8(sp)
    800024c4:	00013903          	ld	s2,0(sp)
    800024c8:	02010113          	addi	sp,sp,32
    800024cc:	00008067          	ret

00000000800024d0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800024d0:	fd010113          	addi	sp,sp,-48
    800024d4:	02113423          	sd	ra,40(sp)
    800024d8:	02813023          	sd	s0,32(sp)
    800024dc:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800024e0:	00000613          	li	a2,0
    800024e4:	00000597          	auipc	a1,0x0
    800024e8:	f2058593          	addi	a1,a1,-224 # 80002404 <_ZL11workerBodyAPv>
    800024ec:	fd040513          	addi	a0,s0,-48
    800024f0:	fffff097          	auipc	ra,0xfffff
    800024f4:	76c080e7          	jalr	1900(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800024f8:	00003517          	auipc	a0,0x3
    800024fc:	e1050513          	addi	a0,a0,-496 # 80005308 <kvmincrease+0x938>
    80002500:	00000097          	auipc	ra,0x0
    80002504:	824080e7          	jalr	-2012(ra) # 80001d24 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002508:	00000613          	li	a2,0
    8000250c:	00000597          	auipc	a1,0x0
    80002510:	e2458593          	addi	a1,a1,-476 # 80002330 <_ZL11workerBodyBPv>
    80002514:	fd840513          	addi	a0,s0,-40
    80002518:	fffff097          	auipc	ra,0xfffff
    8000251c:	744080e7          	jalr	1860(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80002520:	00003517          	auipc	a0,0x3
    80002524:	e0050513          	addi	a0,a0,-512 # 80005320 <kvmincrease+0x950>
    80002528:	fffff097          	auipc	ra,0xfffff
    8000252c:	7fc080e7          	jalr	2044(ra) # 80001d24 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80002530:	00000613          	li	a2,0
    80002534:	00000597          	auipc	a1,0x0
    80002538:	c7c58593          	addi	a1,a1,-900 # 800021b0 <_ZL11workerBodyCPv>
    8000253c:	fe040513          	addi	a0,s0,-32
    80002540:	fffff097          	auipc	ra,0xfffff
    80002544:	71c080e7          	jalr	1820(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80002548:	00003517          	auipc	a0,0x3
    8000254c:	df050513          	addi	a0,a0,-528 # 80005338 <kvmincrease+0x968>
    80002550:	fffff097          	auipc	ra,0xfffff
    80002554:	7d4080e7          	jalr	2004(ra) # 80001d24 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002558:	00000613          	li	a2,0
    8000255c:	00000597          	auipc	a1,0x0
    80002560:	b0c58593          	addi	a1,a1,-1268 # 80002068 <_ZL11workerBodyDPv>
    80002564:	fe840513          	addi	a0,s0,-24
    80002568:	fffff097          	auipc	ra,0xfffff
    8000256c:	6f4080e7          	jalr	1780(ra) # 80001c5c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80002570:	00003517          	auipc	a0,0x3
    80002574:	de050513          	addi	a0,a0,-544 # 80005350 <kvmincrease+0x980>
    80002578:	fffff097          	auipc	ra,0xfffff
    8000257c:	7ac080e7          	jalr	1964(ra) # 80001d24 <_Z11printStringPKc>
    80002580:	00c0006f          	j	8000258c <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80002584:	fffff097          	auipc	ra,0xfffff
    80002588:	70c080e7          	jalr	1804(ra) # 80001c90 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000258c:	00003797          	auipc	a5,0x3
    80002590:	70f7c783          	lbu	a5,1807(a5) # 80005c9b <_ZL9finishedA>
    80002594:	fe0788e3          	beqz	a5,80002584 <_Z18Threads_C_API_testv+0xb4>
    80002598:	00003797          	auipc	a5,0x3
    8000259c:	7027c783          	lbu	a5,1794(a5) # 80005c9a <_ZL9finishedB>
    800025a0:	fe0782e3          	beqz	a5,80002584 <_Z18Threads_C_API_testv+0xb4>
    800025a4:	00003797          	auipc	a5,0x3
    800025a8:	6f57c783          	lbu	a5,1781(a5) # 80005c99 <_ZL9finishedC>
    800025ac:	fc078ce3          	beqz	a5,80002584 <_Z18Threads_C_API_testv+0xb4>
    800025b0:	00003797          	auipc	a5,0x3
    800025b4:	6e87c783          	lbu	a5,1768(a5) # 80005c98 <_ZL9finishedD>
    800025b8:	fc0786e3          	beqz	a5,80002584 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800025bc:	02813083          	ld	ra,40(sp)
    800025c0:	02013403          	ld	s0,32(sp)
    800025c4:	03010113          	addi	sp,sp,48
    800025c8:	00008067          	ret

00000000800025cc <start>:
    800025cc:	ff010113          	addi	sp,sp,-16
    800025d0:	00813423          	sd	s0,8(sp)
    800025d4:	01010413          	addi	s0,sp,16
    800025d8:	300027f3          	csrr	a5,mstatus
    800025dc:	ffffe737          	lui	a4,0xffffe
    800025e0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff78af>
    800025e4:	00e7f7b3          	and	a5,a5,a4
    800025e8:	00001737          	lui	a4,0x1
    800025ec:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800025f0:	00e7e7b3          	or	a5,a5,a4
    800025f4:	30079073          	csrw	mstatus,a5
    800025f8:	00000797          	auipc	a5,0x0
    800025fc:	16078793          	addi	a5,a5,352 # 80002758 <system_main>
    80002600:	34179073          	csrw	mepc,a5
    80002604:	00000793          	li	a5,0
    80002608:	18079073          	csrw	satp,a5
    8000260c:	000107b7          	lui	a5,0x10
    80002610:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002614:	30279073          	csrw	medeleg,a5
    80002618:	30379073          	csrw	mideleg,a5
    8000261c:	104027f3          	csrr	a5,sie
    80002620:	2227e793          	ori	a5,a5,546
    80002624:	10479073          	csrw	sie,a5
    80002628:	fff00793          	li	a5,-1
    8000262c:	00a7d793          	srli	a5,a5,0xa
    80002630:	3b079073          	csrw	pmpaddr0,a5
    80002634:	00f00793          	li	a5,15
    80002638:	3a079073          	csrw	pmpcfg0,a5
    8000263c:	f14027f3          	csrr	a5,mhartid
    80002640:	0200c737          	lui	a4,0x200c
    80002644:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002648:	0007869b          	sext.w	a3,a5
    8000264c:	00269713          	slli	a4,a3,0x2
    80002650:	000f4637          	lui	a2,0xf4
    80002654:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002658:	00d70733          	add	a4,a4,a3
    8000265c:	0037979b          	slliw	a5,a5,0x3
    80002660:	020046b7          	lui	a3,0x2004
    80002664:	00d787b3          	add	a5,a5,a3
    80002668:	00c585b3          	add	a1,a1,a2
    8000266c:	00371693          	slli	a3,a4,0x3
    80002670:	00003717          	auipc	a4,0x3
    80002674:	67070713          	addi	a4,a4,1648 # 80005ce0 <timer_scratch>
    80002678:	00b7b023          	sd	a1,0(a5)
    8000267c:	00d70733          	add	a4,a4,a3
    80002680:	00f73c23          	sd	a5,24(a4)
    80002684:	02c73023          	sd	a2,32(a4)
    80002688:	34071073          	csrw	mscratch,a4
    8000268c:	00000797          	auipc	a5,0x0
    80002690:	6e478793          	addi	a5,a5,1764 # 80002d70 <timervec>
    80002694:	30579073          	csrw	mtvec,a5
    80002698:	300027f3          	csrr	a5,mstatus
    8000269c:	0087e793          	ori	a5,a5,8
    800026a0:	30079073          	csrw	mstatus,a5
    800026a4:	304027f3          	csrr	a5,mie
    800026a8:	0807e793          	ori	a5,a5,128
    800026ac:	30479073          	csrw	mie,a5
    800026b0:	f14027f3          	csrr	a5,mhartid
    800026b4:	0007879b          	sext.w	a5,a5
    800026b8:	00078213          	mv	tp,a5
    800026bc:	30200073          	mret
    800026c0:	00813403          	ld	s0,8(sp)
    800026c4:	01010113          	addi	sp,sp,16
    800026c8:	00008067          	ret

00000000800026cc <timerinit>:
    800026cc:	ff010113          	addi	sp,sp,-16
    800026d0:	00813423          	sd	s0,8(sp)
    800026d4:	01010413          	addi	s0,sp,16
    800026d8:	f14027f3          	csrr	a5,mhartid
    800026dc:	0200c737          	lui	a4,0x200c
    800026e0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800026e4:	0007869b          	sext.w	a3,a5
    800026e8:	00269713          	slli	a4,a3,0x2
    800026ec:	000f4637          	lui	a2,0xf4
    800026f0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800026f4:	00d70733          	add	a4,a4,a3
    800026f8:	0037979b          	slliw	a5,a5,0x3
    800026fc:	020046b7          	lui	a3,0x2004
    80002700:	00d787b3          	add	a5,a5,a3
    80002704:	00c585b3          	add	a1,a1,a2
    80002708:	00371693          	slli	a3,a4,0x3
    8000270c:	00003717          	auipc	a4,0x3
    80002710:	5d470713          	addi	a4,a4,1492 # 80005ce0 <timer_scratch>
    80002714:	00b7b023          	sd	a1,0(a5)
    80002718:	00d70733          	add	a4,a4,a3
    8000271c:	00f73c23          	sd	a5,24(a4)
    80002720:	02c73023          	sd	a2,32(a4)
    80002724:	34071073          	csrw	mscratch,a4
    80002728:	00000797          	auipc	a5,0x0
    8000272c:	64878793          	addi	a5,a5,1608 # 80002d70 <timervec>
    80002730:	30579073          	csrw	mtvec,a5
    80002734:	300027f3          	csrr	a5,mstatus
    80002738:	0087e793          	ori	a5,a5,8
    8000273c:	30079073          	csrw	mstatus,a5
    80002740:	304027f3          	csrr	a5,mie
    80002744:	0807e793          	ori	a5,a5,128
    80002748:	30479073          	csrw	mie,a5
    8000274c:	00813403          	ld	s0,8(sp)
    80002750:	01010113          	addi	sp,sp,16
    80002754:	00008067          	ret

0000000080002758 <system_main>:
    80002758:	fe010113          	addi	sp,sp,-32
    8000275c:	00813823          	sd	s0,16(sp)
    80002760:	00913423          	sd	s1,8(sp)
    80002764:	00113c23          	sd	ra,24(sp)
    80002768:	02010413          	addi	s0,sp,32
    8000276c:	00000097          	auipc	ra,0x0
    80002770:	0c4080e7          	jalr	196(ra) # 80002830 <cpuid>
    80002774:	00003497          	auipc	s1,0x3
    80002778:	52848493          	addi	s1,s1,1320 # 80005c9c <started>
    8000277c:	02050263          	beqz	a0,800027a0 <system_main+0x48>
    80002780:	0004a783          	lw	a5,0(s1)
    80002784:	0007879b          	sext.w	a5,a5
    80002788:	fe078ce3          	beqz	a5,80002780 <system_main+0x28>
    8000278c:	0ff0000f          	fence
    80002790:	00003517          	auipc	a0,0x3
    80002794:	c0850513          	addi	a0,a0,-1016 # 80005398 <kvmincrease+0x9c8>
    80002798:	00001097          	auipc	ra,0x1
    8000279c:	a74080e7          	jalr	-1420(ra) # 8000320c <panic>
    800027a0:	00001097          	auipc	ra,0x1
    800027a4:	9c8080e7          	jalr	-1592(ra) # 80003168 <consoleinit>
    800027a8:	00001097          	auipc	ra,0x1
    800027ac:	154080e7          	jalr	340(ra) # 800038fc <printfinit>
    800027b0:	00003517          	auipc	a0,0x3
    800027b4:	cc850513          	addi	a0,a0,-824 # 80005478 <kvmincrease+0xaa8>
    800027b8:	00001097          	auipc	ra,0x1
    800027bc:	ab0080e7          	jalr	-1360(ra) # 80003268 <__printf>
    800027c0:	00003517          	auipc	a0,0x3
    800027c4:	ba850513          	addi	a0,a0,-1112 # 80005368 <kvmincrease+0x998>
    800027c8:	00001097          	auipc	ra,0x1
    800027cc:	aa0080e7          	jalr	-1376(ra) # 80003268 <__printf>
    800027d0:	00003517          	auipc	a0,0x3
    800027d4:	ca850513          	addi	a0,a0,-856 # 80005478 <kvmincrease+0xaa8>
    800027d8:	00001097          	auipc	ra,0x1
    800027dc:	a90080e7          	jalr	-1392(ra) # 80003268 <__printf>
    800027e0:	00001097          	auipc	ra,0x1
    800027e4:	4a8080e7          	jalr	1192(ra) # 80003c88 <kinit>
    800027e8:	00000097          	auipc	ra,0x0
    800027ec:	148080e7          	jalr	328(ra) # 80002930 <trapinit>
    800027f0:	00000097          	auipc	ra,0x0
    800027f4:	16c080e7          	jalr	364(ra) # 8000295c <trapinithart>
    800027f8:	00000097          	auipc	ra,0x0
    800027fc:	5b8080e7          	jalr	1464(ra) # 80002db0 <plicinit>
    80002800:	00000097          	auipc	ra,0x0
    80002804:	5d8080e7          	jalr	1496(ra) # 80002dd8 <plicinithart>
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	078080e7          	jalr	120(ra) # 80002880 <userinit>
    80002810:	0ff0000f          	fence
    80002814:	00100793          	li	a5,1
    80002818:	00003517          	auipc	a0,0x3
    8000281c:	b6850513          	addi	a0,a0,-1176 # 80005380 <kvmincrease+0x9b0>
    80002820:	00f4a023          	sw	a5,0(s1)
    80002824:	00001097          	auipc	ra,0x1
    80002828:	a44080e7          	jalr	-1468(ra) # 80003268 <__printf>
    8000282c:	0000006f          	j	8000282c <system_main+0xd4>

0000000080002830 <cpuid>:
    80002830:	ff010113          	addi	sp,sp,-16
    80002834:	00813423          	sd	s0,8(sp)
    80002838:	01010413          	addi	s0,sp,16
    8000283c:	00020513          	mv	a0,tp
    80002840:	00813403          	ld	s0,8(sp)
    80002844:	0005051b          	sext.w	a0,a0
    80002848:	01010113          	addi	sp,sp,16
    8000284c:	00008067          	ret

0000000080002850 <mycpu>:
    80002850:	ff010113          	addi	sp,sp,-16
    80002854:	00813423          	sd	s0,8(sp)
    80002858:	01010413          	addi	s0,sp,16
    8000285c:	00020793          	mv	a5,tp
    80002860:	00813403          	ld	s0,8(sp)
    80002864:	0007879b          	sext.w	a5,a5
    80002868:	00779793          	slli	a5,a5,0x7
    8000286c:	00004517          	auipc	a0,0x4
    80002870:	4a450513          	addi	a0,a0,1188 # 80006d10 <cpus>
    80002874:	00f50533          	add	a0,a0,a5
    80002878:	01010113          	addi	sp,sp,16
    8000287c:	00008067          	ret

0000000080002880 <userinit>:
    80002880:	ff010113          	addi	sp,sp,-16
    80002884:	00813423          	sd	s0,8(sp)
    80002888:	01010413          	addi	s0,sp,16
    8000288c:	00813403          	ld	s0,8(sp)
    80002890:	01010113          	addi	sp,sp,16
    80002894:	fffff317          	auipc	t1,0xfffff
    80002898:	34830067          	jr	840(t1) # 80001bdc <main>

000000008000289c <either_copyout>:
    8000289c:	ff010113          	addi	sp,sp,-16
    800028a0:	00813023          	sd	s0,0(sp)
    800028a4:	00113423          	sd	ra,8(sp)
    800028a8:	01010413          	addi	s0,sp,16
    800028ac:	02051663          	bnez	a0,800028d8 <either_copyout+0x3c>
    800028b0:	00058513          	mv	a0,a1
    800028b4:	00060593          	mv	a1,a2
    800028b8:	0006861b          	sext.w	a2,a3
    800028bc:	00002097          	auipc	ra,0x2
    800028c0:	c58080e7          	jalr	-936(ra) # 80004514 <__memmove>
    800028c4:	00813083          	ld	ra,8(sp)
    800028c8:	00013403          	ld	s0,0(sp)
    800028cc:	00000513          	li	a0,0
    800028d0:	01010113          	addi	sp,sp,16
    800028d4:	00008067          	ret
    800028d8:	00003517          	auipc	a0,0x3
    800028dc:	ae850513          	addi	a0,a0,-1304 # 800053c0 <kvmincrease+0x9f0>
    800028e0:	00001097          	auipc	ra,0x1
    800028e4:	92c080e7          	jalr	-1748(ra) # 8000320c <panic>

00000000800028e8 <either_copyin>:
    800028e8:	ff010113          	addi	sp,sp,-16
    800028ec:	00813023          	sd	s0,0(sp)
    800028f0:	00113423          	sd	ra,8(sp)
    800028f4:	01010413          	addi	s0,sp,16
    800028f8:	02059463          	bnez	a1,80002920 <either_copyin+0x38>
    800028fc:	00060593          	mv	a1,a2
    80002900:	0006861b          	sext.w	a2,a3
    80002904:	00002097          	auipc	ra,0x2
    80002908:	c10080e7          	jalr	-1008(ra) # 80004514 <__memmove>
    8000290c:	00813083          	ld	ra,8(sp)
    80002910:	00013403          	ld	s0,0(sp)
    80002914:	00000513          	li	a0,0
    80002918:	01010113          	addi	sp,sp,16
    8000291c:	00008067          	ret
    80002920:	00003517          	auipc	a0,0x3
    80002924:	ac850513          	addi	a0,a0,-1336 # 800053e8 <kvmincrease+0xa18>
    80002928:	00001097          	auipc	ra,0x1
    8000292c:	8e4080e7          	jalr	-1820(ra) # 8000320c <panic>

0000000080002930 <trapinit>:
    80002930:	ff010113          	addi	sp,sp,-16
    80002934:	00813423          	sd	s0,8(sp)
    80002938:	01010413          	addi	s0,sp,16
    8000293c:	00813403          	ld	s0,8(sp)
    80002940:	00003597          	auipc	a1,0x3
    80002944:	ad058593          	addi	a1,a1,-1328 # 80005410 <kvmincrease+0xa40>
    80002948:	00004517          	auipc	a0,0x4
    8000294c:	44850513          	addi	a0,a0,1096 # 80006d90 <tickslock>
    80002950:	01010113          	addi	sp,sp,16
    80002954:	00001317          	auipc	t1,0x1
    80002958:	5c430067          	jr	1476(t1) # 80003f18 <initlock>

000000008000295c <trapinithart>:
    8000295c:	ff010113          	addi	sp,sp,-16
    80002960:	00813423          	sd	s0,8(sp)
    80002964:	01010413          	addi	s0,sp,16
    80002968:	00000797          	auipc	a5,0x0
    8000296c:	2f878793          	addi	a5,a5,760 # 80002c60 <kernelvec>
    80002970:	10579073          	csrw	stvec,a5
    80002974:	00813403          	ld	s0,8(sp)
    80002978:	01010113          	addi	sp,sp,16
    8000297c:	00008067          	ret

0000000080002980 <usertrap>:
    80002980:	ff010113          	addi	sp,sp,-16
    80002984:	00813423          	sd	s0,8(sp)
    80002988:	01010413          	addi	s0,sp,16
    8000298c:	00813403          	ld	s0,8(sp)
    80002990:	01010113          	addi	sp,sp,16
    80002994:	00008067          	ret

0000000080002998 <usertrapret>:
    80002998:	ff010113          	addi	sp,sp,-16
    8000299c:	00813423          	sd	s0,8(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	00813403          	ld	s0,8(sp)
    800029a8:	01010113          	addi	sp,sp,16
    800029ac:	00008067          	ret

00000000800029b0 <kerneltrap>:
    800029b0:	fe010113          	addi	sp,sp,-32
    800029b4:	00813823          	sd	s0,16(sp)
    800029b8:	00113c23          	sd	ra,24(sp)
    800029bc:	00913423          	sd	s1,8(sp)
    800029c0:	02010413          	addi	s0,sp,32
    800029c4:	142025f3          	csrr	a1,scause
    800029c8:	100027f3          	csrr	a5,sstatus
    800029cc:	0027f793          	andi	a5,a5,2
    800029d0:	10079c63          	bnez	a5,80002ae8 <kerneltrap+0x138>
    800029d4:	142027f3          	csrr	a5,scause
    800029d8:	0207ce63          	bltz	a5,80002a14 <kerneltrap+0x64>
    800029dc:	00003517          	auipc	a0,0x3
    800029e0:	a7c50513          	addi	a0,a0,-1412 # 80005458 <kvmincrease+0xa88>
    800029e4:	00001097          	auipc	ra,0x1
    800029e8:	884080e7          	jalr	-1916(ra) # 80003268 <__printf>
    800029ec:	141025f3          	csrr	a1,sepc
    800029f0:	14302673          	csrr	a2,stval
    800029f4:	00003517          	auipc	a0,0x3
    800029f8:	a7450513          	addi	a0,a0,-1420 # 80005468 <kvmincrease+0xa98>
    800029fc:	00001097          	auipc	ra,0x1
    80002a00:	86c080e7          	jalr	-1940(ra) # 80003268 <__printf>
    80002a04:	00003517          	auipc	a0,0x3
    80002a08:	a7c50513          	addi	a0,a0,-1412 # 80005480 <kvmincrease+0xab0>
    80002a0c:	00001097          	auipc	ra,0x1
    80002a10:	800080e7          	jalr	-2048(ra) # 8000320c <panic>
    80002a14:	0ff7f713          	andi	a4,a5,255
    80002a18:	00900693          	li	a3,9
    80002a1c:	04d70063          	beq	a4,a3,80002a5c <kerneltrap+0xac>
    80002a20:	fff00713          	li	a4,-1
    80002a24:	03f71713          	slli	a4,a4,0x3f
    80002a28:	00170713          	addi	a4,a4,1
    80002a2c:	fae798e3          	bne	a5,a4,800029dc <kerneltrap+0x2c>
    80002a30:	00000097          	auipc	ra,0x0
    80002a34:	e00080e7          	jalr	-512(ra) # 80002830 <cpuid>
    80002a38:	06050663          	beqz	a0,80002aa4 <kerneltrap+0xf4>
    80002a3c:	144027f3          	csrr	a5,sip
    80002a40:	ffd7f793          	andi	a5,a5,-3
    80002a44:	14479073          	csrw	sip,a5
    80002a48:	01813083          	ld	ra,24(sp)
    80002a4c:	01013403          	ld	s0,16(sp)
    80002a50:	00813483          	ld	s1,8(sp)
    80002a54:	02010113          	addi	sp,sp,32
    80002a58:	00008067          	ret
    80002a5c:	00000097          	auipc	ra,0x0
    80002a60:	3c8080e7          	jalr	968(ra) # 80002e24 <plic_claim>
    80002a64:	00a00793          	li	a5,10
    80002a68:	00050493          	mv	s1,a0
    80002a6c:	06f50863          	beq	a0,a5,80002adc <kerneltrap+0x12c>
    80002a70:	fc050ce3          	beqz	a0,80002a48 <kerneltrap+0x98>
    80002a74:	00050593          	mv	a1,a0
    80002a78:	00003517          	auipc	a0,0x3
    80002a7c:	9c050513          	addi	a0,a0,-1600 # 80005438 <kvmincrease+0xa68>
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	7e8080e7          	jalr	2024(ra) # 80003268 <__printf>
    80002a88:	01013403          	ld	s0,16(sp)
    80002a8c:	01813083          	ld	ra,24(sp)
    80002a90:	00048513          	mv	a0,s1
    80002a94:	00813483          	ld	s1,8(sp)
    80002a98:	02010113          	addi	sp,sp,32
    80002a9c:	00000317          	auipc	t1,0x0
    80002aa0:	3c030067          	jr	960(t1) # 80002e5c <plic_complete>
    80002aa4:	00004517          	auipc	a0,0x4
    80002aa8:	2ec50513          	addi	a0,a0,748 # 80006d90 <tickslock>
    80002aac:	00001097          	auipc	ra,0x1
    80002ab0:	490080e7          	jalr	1168(ra) # 80003f3c <acquire>
    80002ab4:	00003717          	auipc	a4,0x3
    80002ab8:	1ec70713          	addi	a4,a4,492 # 80005ca0 <ticks>
    80002abc:	00072783          	lw	a5,0(a4)
    80002ac0:	00004517          	auipc	a0,0x4
    80002ac4:	2d050513          	addi	a0,a0,720 # 80006d90 <tickslock>
    80002ac8:	0017879b          	addiw	a5,a5,1
    80002acc:	00f72023          	sw	a5,0(a4)
    80002ad0:	00001097          	auipc	ra,0x1
    80002ad4:	538080e7          	jalr	1336(ra) # 80004008 <release>
    80002ad8:	f65ff06f          	j	80002a3c <kerneltrap+0x8c>
    80002adc:	00001097          	auipc	ra,0x1
    80002ae0:	094080e7          	jalr	148(ra) # 80003b70 <uartintr>
    80002ae4:	fa5ff06f          	j	80002a88 <kerneltrap+0xd8>
    80002ae8:	00003517          	auipc	a0,0x3
    80002aec:	93050513          	addi	a0,a0,-1744 # 80005418 <kvmincrease+0xa48>
    80002af0:	00000097          	auipc	ra,0x0
    80002af4:	71c080e7          	jalr	1820(ra) # 8000320c <panic>

0000000080002af8 <clockintr>:
    80002af8:	fe010113          	addi	sp,sp,-32
    80002afc:	00813823          	sd	s0,16(sp)
    80002b00:	00913423          	sd	s1,8(sp)
    80002b04:	00113c23          	sd	ra,24(sp)
    80002b08:	02010413          	addi	s0,sp,32
    80002b0c:	00004497          	auipc	s1,0x4
    80002b10:	28448493          	addi	s1,s1,644 # 80006d90 <tickslock>
    80002b14:	00048513          	mv	a0,s1
    80002b18:	00001097          	auipc	ra,0x1
    80002b1c:	424080e7          	jalr	1060(ra) # 80003f3c <acquire>
    80002b20:	00003717          	auipc	a4,0x3
    80002b24:	18070713          	addi	a4,a4,384 # 80005ca0 <ticks>
    80002b28:	00072783          	lw	a5,0(a4)
    80002b2c:	01013403          	ld	s0,16(sp)
    80002b30:	01813083          	ld	ra,24(sp)
    80002b34:	00048513          	mv	a0,s1
    80002b38:	0017879b          	addiw	a5,a5,1
    80002b3c:	00813483          	ld	s1,8(sp)
    80002b40:	00f72023          	sw	a5,0(a4)
    80002b44:	02010113          	addi	sp,sp,32
    80002b48:	00001317          	auipc	t1,0x1
    80002b4c:	4c030067          	jr	1216(t1) # 80004008 <release>

0000000080002b50 <devintr>:
    80002b50:	142027f3          	csrr	a5,scause
    80002b54:	00000513          	li	a0,0
    80002b58:	0007c463          	bltz	a5,80002b60 <devintr+0x10>
    80002b5c:	00008067          	ret
    80002b60:	fe010113          	addi	sp,sp,-32
    80002b64:	00813823          	sd	s0,16(sp)
    80002b68:	00113c23          	sd	ra,24(sp)
    80002b6c:	00913423          	sd	s1,8(sp)
    80002b70:	02010413          	addi	s0,sp,32
    80002b74:	0ff7f713          	andi	a4,a5,255
    80002b78:	00900693          	li	a3,9
    80002b7c:	04d70c63          	beq	a4,a3,80002bd4 <devintr+0x84>
    80002b80:	fff00713          	li	a4,-1
    80002b84:	03f71713          	slli	a4,a4,0x3f
    80002b88:	00170713          	addi	a4,a4,1
    80002b8c:	00e78c63          	beq	a5,a4,80002ba4 <devintr+0x54>
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	00813483          	ld	s1,8(sp)
    80002b9c:	02010113          	addi	sp,sp,32
    80002ba0:	00008067          	ret
    80002ba4:	00000097          	auipc	ra,0x0
    80002ba8:	c8c080e7          	jalr	-884(ra) # 80002830 <cpuid>
    80002bac:	06050663          	beqz	a0,80002c18 <devintr+0xc8>
    80002bb0:	144027f3          	csrr	a5,sip
    80002bb4:	ffd7f793          	andi	a5,a5,-3
    80002bb8:	14479073          	csrw	sip,a5
    80002bbc:	01813083          	ld	ra,24(sp)
    80002bc0:	01013403          	ld	s0,16(sp)
    80002bc4:	00813483          	ld	s1,8(sp)
    80002bc8:	00200513          	li	a0,2
    80002bcc:	02010113          	addi	sp,sp,32
    80002bd0:	00008067          	ret
    80002bd4:	00000097          	auipc	ra,0x0
    80002bd8:	250080e7          	jalr	592(ra) # 80002e24 <plic_claim>
    80002bdc:	00a00793          	li	a5,10
    80002be0:	00050493          	mv	s1,a0
    80002be4:	06f50663          	beq	a0,a5,80002c50 <devintr+0x100>
    80002be8:	00100513          	li	a0,1
    80002bec:	fa0482e3          	beqz	s1,80002b90 <devintr+0x40>
    80002bf0:	00048593          	mv	a1,s1
    80002bf4:	00003517          	auipc	a0,0x3
    80002bf8:	84450513          	addi	a0,a0,-1980 # 80005438 <kvmincrease+0xa68>
    80002bfc:	00000097          	auipc	ra,0x0
    80002c00:	66c080e7          	jalr	1644(ra) # 80003268 <__printf>
    80002c04:	00048513          	mv	a0,s1
    80002c08:	00000097          	auipc	ra,0x0
    80002c0c:	254080e7          	jalr	596(ra) # 80002e5c <plic_complete>
    80002c10:	00100513          	li	a0,1
    80002c14:	f7dff06f          	j	80002b90 <devintr+0x40>
    80002c18:	00004517          	auipc	a0,0x4
    80002c1c:	17850513          	addi	a0,a0,376 # 80006d90 <tickslock>
    80002c20:	00001097          	auipc	ra,0x1
    80002c24:	31c080e7          	jalr	796(ra) # 80003f3c <acquire>
    80002c28:	00003717          	auipc	a4,0x3
    80002c2c:	07870713          	addi	a4,a4,120 # 80005ca0 <ticks>
    80002c30:	00072783          	lw	a5,0(a4)
    80002c34:	00004517          	auipc	a0,0x4
    80002c38:	15c50513          	addi	a0,a0,348 # 80006d90 <tickslock>
    80002c3c:	0017879b          	addiw	a5,a5,1
    80002c40:	00f72023          	sw	a5,0(a4)
    80002c44:	00001097          	auipc	ra,0x1
    80002c48:	3c4080e7          	jalr	964(ra) # 80004008 <release>
    80002c4c:	f65ff06f          	j	80002bb0 <devintr+0x60>
    80002c50:	00001097          	auipc	ra,0x1
    80002c54:	f20080e7          	jalr	-224(ra) # 80003b70 <uartintr>
    80002c58:	fadff06f          	j	80002c04 <devintr+0xb4>
    80002c5c:	0000                	unimp
	...

0000000080002c60 <kernelvec>:
    80002c60:	f0010113          	addi	sp,sp,-256
    80002c64:	00113023          	sd	ra,0(sp)
    80002c68:	00213423          	sd	sp,8(sp)
    80002c6c:	00313823          	sd	gp,16(sp)
    80002c70:	00413c23          	sd	tp,24(sp)
    80002c74:	02513023          	sd	t0,32(sp)
    80002c78:	02613423          	sd	t1,40(sp)
    80002c7c:	02713823          	sd	t2,48(sp)
    80002c80:	02813c23          	sd	s0,56(sp)
    80002c84:	04913023          	sd	s1,64(sp)
    80002c88:	04a13423          	sd	a0,72(sp)
    80002c8c:	04b13823          	sd	a1,80(sp)
    80002c90:	04c13c23          	sd	a2,88(sp)
    80002c94:	06d13023          	sd	a3,96(sp)
    80002c98:	06e13423          	sd	a4,104(sp)
    80002c9c:	06f13823          	sd	a5,112(sp)
    80002ca0:	07013c23          	sd	a6,120(sp)
    80002ca4:	09113023          	sd	a7,128(sp)
    80002ca8:	09213423          	sd	s2,136(sp)
    80002cac:	09313823          	sd	s3,144(sp)
    80002cb0:	09413c23          	sd	s4,152(sp)
    80002cb4:	0b513023          	sd	s5,160(sp)
    80002cb8:	0b613423          	sd	s6,168(sp)
    80002cbc:	0b713823          	sd	s7,176(sp)
    80002cc0:	0b813c23          	sd	s8,184(sp)
    80002cc4:	0d913023          	sd	s9,192(sp)
    80002cc8:	0da13423          	sd	s10,200(sp)
    80002ccc:	0db13823          	sd	s11,208(sp)
    80002cd0:	0dc13c23          	sd	t3,216(sp)
    80002cd4:	0fd13023          	sd	t4,224(sp)
    80002cd8:	0fe13423          	sd	t5,232(sp)
    80002cdc:	0ff13823          	sd	t6,240(sp)
    80002ce0:	cd1ff0ef          	jal	ra,800029b0 <kerneltrap>
    80002ce4:	00013083          	ld	ra,0(sp)
    80002ce8:	00813103          	ld	sp,8(sp)
    80002cec:	01013183          	ld	gp,16(sp)
    80002cf0:	02013283          	ld	t0,32(sp)
    80002cf4:	02813303          	ld	t1,40(sp)
    80002cf8:	03013383          	ld	t2,48(sp)
    80002cfc:	03813403          	ld	s0,56(sp)
    80002d00:	04013483          	ld	s1,64(sp)
    80002d04:	04813503          	ld	a0,72(sp)
    80002d08:	05013583          	ld	a1,80(sp)
    80002d0c:	05813603          	ld	a2,88(sp)
    80002d10:	06013683          	ld	a3,96(sp)
    80002d14:	06813703          	ld	a4,104(sp)
    80002d18:	07013783          	ld	a5,112(sp)
    80002d1c:	07813803          	ld	a6,120(sp)
    80002d20:	08013883          	ld	a7,128(sp)
    80002d24:	08813903          	ld	s2,136(sp)
    80002d28:	09013983          	ld	s3,144(sp)
    80002d2c:	09813a03          	ld	s4,152(sp)
    80002d30:	0a013a83          	ld	s5,160(sp)
    80002d34:	0a813b03          	ld	s6,168(sp)
    80002d38:	0b013b83          	ld	s7,176(sp)
    80002d3c:	0b813c03          	ld	s8,184(sp)
    80002d40:	0c013c83          	ld	s9,192(sp)
    80002d44:	0c813d03          	ld	s10,200(sp)
    80002d48:	0d013d83          	ld	s11,208(sp)
    80002d4c:	0d813e03          	ld	t3,216(sp)
    80002d50:	0e013e83          	ld	t4,224(sp)
    80002d54:	0e813f03          	ld	t5,232(sp)
    80002d58:	0f013f83          	ld	t6,240(sp)
    80002d5c:	10010113          	addi	sp,sp,256
    80002d60:	10200073          	sret
    80002d64:	00000013          	nop
    80002d68:	00000013          	nop
    80002d6c:	00000013          	nop

0000000080002d70 <timervec>:
    80002d70:	34051573          	csrrw	a0,mscratch,a0
    80002d74:	00b53023          	sd	a1,0(a0)
    80002d78:	00c53423          	sd	a2,8(a0)
    80002d7c:	00d53823          	sd	a3,16(a0)
    80002d80:	01853583          	ld	a1,24(a0)
    80002d84:	02053603          	ld	a2,32(a0)
    80002d88:	0005b683          	ld	a3,0(a1)
    80002d8c:	00c686b3          	add	a3,a3,a2
    80002d90:	00d5b023          	sd	a3,0(a1)
    80002d94:	00200593          	li	a1,2
    80002d98:	14459073          	csrw	sip,a1
    80002d9c:	01053683          	ld	a3,16(a0)
    80002da0:	00853603          	ld	a2,8(a0)
    80002da4:	00053583          	ld	a1,0(a0)
    80002da8:	34051573          	csrrw	a0,mscratch,a0
    80002dac:	30200073          	mret

0000000080002db0 <plicinit>:
    80002db0:	ff010113          	addi	sp,sp,-16
    80002db4:	00813423          	sd	s0,8(sp)
    80002db8:	01010413          	addi	s0,sp,16
    80002dbc:	00813403          	ld	s0,8(sp)
    80002dc0:	0c0007b7          	lui	a5,0xc000
    80002dc4:	00100713          	li	a4,1
    80002dc8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002dcc:	00e7a223          	sw	a4,4(a5)
    80002dd0:	01010113          	addi	sp,sp,16
    80002dd4:	00008067          	ret

0000000080002dd8 <plicinithart>:
    80002dd8:	ff010113          	addi	sp,sp,-16
    80002ddc:	00813023          	sd	s0,0(sp)
    80002de0:	00113423          	sd	ra,8(sp)
    80002de4:	01010413          	addi	s0,sp,16
    80002de8:	00000097          	auipc	ra,0x0
    80002dec:	a48080e7          	jalr	-1464(ra) # 80002830 <cpuid>
    80002df0:	0085171b          	slliw	a4,a0,0x8
    80002df4:	0c0027b7          	lui	a5,0xc002
    80002df8:	00e787b3          	add	a5,a5,a4
    80002dfc:	40200713          	li	a4,1026
    80002e00:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002e04:	00813083          	ld	ra,8(sp)
    80002e08:	00013403          	ld	s0,0(sp)
    80002e0c:	00d5151b          	slliw	a0,a0,0xd
    80002e10:	0c2017b7          	lui	a5,0xc201
    80002e14:	00a78533          	add	a0,a5,a0
    80002e18:	00052023          	sw	zero,0(a0)
    80002e1c:	01010113          	addi	sp,sp,16
    80002e20:	00008067          	ret

0000000080002e24 <plic_claim>:
    80002e24:	ff010113          	addi	sp,sp,-16
    80002e28:	00813023          	sd	s0,0(sp)
    80002e2c:	00113423          	sd	ra,8(sp)
    80002e30:	01010413          	addi	s0,sp,16
    80002e34:	00000097          	auipc	ra,0x0
    80002e38:	9fc080e7          	jalr	-1540(ra) # 80002830 <cpuid>
    80002e3c:	00813083          	ld	ra,8(sp)
    80002e40:	00013403          	ld	s0,0(sp)
    80002e44:	00d5151b          	slliw	a0,a0,0xd
    80002e48:	0c2017b7          	lui	a5,0xc201
    80002e4c:	00a78533          	add	a0,a5,a0
    80002e50:	00452503          	lw	a0,4(a0)
    80002e54:	01010113          	addi	sp,sp,16
    80002e58:	00008067          	ret

0000000080002e5c <plic_complete>:
    80002e5c:	fe010113          	addi	sp,sp,-32
    80002e60:	00813823          	sd	s0,16(sp)
    80002e64:	00913423          	sd	s1,8(sp)
    80002e68:	00113c23          	sd	ra,24(sp)
    80002e6c:	02010413          	addi	s0,sp,32
    80002e70:	00050493          	mv	s1,a0
    80002e74:	00000097          	auipc	ra,0x0
    80002e78:	9bc080e7          	jalr	-1604(ra) # 80002830 <cpuid>
    80002e7c:	01813083          	ld	ra,24(sp)
    80002e80:	01013403          	ld	s0,16(sp)
    80002e84:	00d5179b          	slliw	a5,a0,0xd
    80002e88:	0c201737          	lui	a4,0xc201
    80002e8c:	00f707b3          	add	a5,a4,a5
    80002e90:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002e94:	00813483          	ld	s1,8(sp)
    80002e98:	02010113          	addi	sp,sp,32
    80002e9c:	00008067          	ret

0000000080002ea0 <consolewrite>:
    80002ea0:	fb010113          	addi	sp,sp,-80
    80002ea4:	04813023          	sd	s0,64(sp)
    80002ea8:	04113423          	sd	ra,72(sp)
    80002eac:	02913c23          	sd	s1,56(sp)
    80002eb0:	03213823          	sd	s2,48(sp)
    80002eb4:	03313423          	sd	s3,40(sp)
    80002eb8:	03413023          	sd	s4,32(sp)
    80002ebc:	01513c23          	sd	s5,24(sp)
    80002ec0:	05010413          	addi	s0,sp,80
    80002ec4:	06c05c63          	blez	a2,80002f3c <consolewrite+0x9c>
    80002ec8:	00060993          	mv	s3,a2
    80002ecc:	00050a13          	mv	s4,a0
    80002ed0:	00058493          	mv	s1,a1
    80002ed4:	00000913          	li	s2,0
    80002ed8:	fff00a93          	li	s5,-1
    80002edc:	01c0006f          	j	80002ef8 <consolewrite+0x58>
    80002ee0:	fbf44503          	lbu	a0,-65(s0)
    80002ee4:	0019091b          	addiw	s2,s2,1
    80002ee8:	00148493          	addi	s1,s1,1
    80002eec:	00001097          	auipc	ra,0x1
    80002ef0:	a9c080e7          	jalr	-1380(ra) # 80003988 <uartputc>
    80002ef4:	03298063          	beq	s3,s2,80002f14 <consolewrite+0x74>
    80002ef8:	00048613          	mv	a2,s1
    80002efc:	00100693          	li	a3,1
    80002f00:	000a0593          	mv	a1,s4
    80002f04:	fbf40513          	addi	a0,s0,-65
    80002f08:	00000097          	auipc	ra,0x0
    80002f0c:	9e0080e7          	jalr	-1568(ra) # 800028e8 <either_copyin>
    80002f10:	fd5518e3          	bne	a0,s5,80002ee0 <consolewrite+0x40>
    80002f14:	04813083          	ld	ra,72(sp)
    80002f18:	04013403          	ld	s0,64(sp)
    80002f1c:	03813483          	ld	s1,56(sp)
    80002f20:	02813983          	ld	s3,40(sp)
    80002f24:	02013a03          	ld	s4,32(sp)
    80002f28:	01813a83          	ld	s5,24(sp)
    80002f2c:	00090513          	mv	a0,s2
    80002f30:	03013903          	ld	s2,48(sp)
    80002f34:	05010113          	addi	sp,sp,80
    80002f38:	00008067          	ret
    80002f3c:	00000913          	li	s2,0
    80002f40:	fd5ff06f          	j	80002f14 <consolewrite+0x74>

0000000080002f44 <consoleread>:
    80002f44:	f9010113          	addi	sp,sp,-112
    80002f48:	06813023          	sd	s0,96(sp)
    80002f4c:	04913c23          	sd	s1,88(sp)
    80002f50:	05213823          	sd	s2,80(sp)
    80002f54:	05313423          	sd	s3,72(sp)
    80002f58:	05413023          	sd	s4,64(sp)
    80002f5c:	03513c23          	sd	s5,56(sp)
    80002f60:	03613823          	sd	s6,48(sp)
    80002f64:	03713423          	sd	s7,40(sp)
    80002f68:	03813023          	sd	s8,32(sp)
    80002f6c:	06113423          	sd	ra,104(sp)
    80002f70:	01913c23          	sd	s9,24(sp)
    80002f74:	07010413          	addi	s0,sp,112
    80002f78:	00060b93          	mv	s7,a2
    80002f7c:	00050913          	mv	s2,a0
    80002f80:	00058c13          	mv	s8,a1
    80002f84:	00060b1b          	sext.w	s6,a2
    80002f88:	00004497          	auipc	s1,0x4
    80002f8c:	e3048493          	addi	s1,s1,-464 # 80006db8 <cons>
    80002f90:	00400993          	li	s3,4
    80002f94:	fff00a13          	li	s4,-1
    80002f98:	00a00a93          	li	s5,10
    80002f9c:	05705e63          	blez	s7,80002ff8 <consoleread+0xb4>
    80002fa0:	09c4a703          	lw	a4,156(s1)
    80002fa4:	0984a783          	lw	a5,152(s1)
    80002fa8:	0007071b          	sext.w	a4,a4
    80002fac:	08e78463          	beq	a5,a4,80003034 <consoleread+0xf0>
    80002fb0:	07f7f713          	andi	a4,a5,127
    80002fb4:	00e48733          	add	a4,s1,a4
    80002fb8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002fbc:	0017869b          	addiw	a3,a5,1
    80002fc0:	08d4ac23          	sw	a3,152(s1)
    80002fc4:	00070c9b          	sext.w	s9,a4
    80002fc8:	0b370663          	beq	a4,s3,80003074 <consoleread+0x130>
    80002fcc:	00100693          	li	a3,1
    80002fd0:	f9f40613          	addi	a2,s0,-97
    80002fd4:	000c0593          	mv	a1,s8
    80002fd8:	00090513          	mv	a0,s2
    80002fdc:	f8e40fa3          	sb	a4,-97(s0)
    80002fe0:	00000097          	auipc	ra,0x0
    80002fe4:	8bc080e7          	jalr	-1860(ra) # 8000289c <either_copyout>
    80002fe8:	01450863          	beq	a0,s4,80002ff8 <consoleread+0xb4>
    80002fec:	001c0c13          	addi	s8,s8,1
    80002ff0:	fffb8b9b          	addiw	s7,s7,-1
    80002ff4:	fb5c94e3          	bne	s9,s5,80002f9c <consoleread+0x58>
    80002ff8:	000b851b          	sext.w	a0,s7
    80002ffc:	06813083          	ld	ra,104(sp)
    80003000:	06013403          	ld	s0,96(sp)
    80003004:	05813483          	ld	s1,88(sp)
    80003008:	05013903          	ld	s2,80(sp)
    8000300c:	04813983          	ld	s3,72(sp)
    80003010:	04013a03          	ld	s4,64(sp)
    80003014:	03813a83          	ld	s5,56(sp)
    80003018:	02813b83          	ld	s7,40(sp)
    8000301c:	02013c03          	ld	s8,32(sp)
    80003020:	01813c83          	ld	s9,24(sp)
    80003024:	40ab053b          	subw	a0,s6,a0
    80003028:	03013b03          	ld	s6,48(sp)
    8000302c:	07010113          	addi	sp,sp,112
    80003030:	00008067          	ret
    80003034:	00001097          	auipc	ra,0x1
    80003038:	1d8080e7          	jalr	472(ra) # 8000420c <push_on>
    8000303c:	0984a703          	lw	a4,152(s1)
    80003040:	09c4a783          	lw	a5,156(s1)
    80003044:	0007879b          	sext.w	a5,a5
    80003048:	fef70ce3          	beq	a4,a5,80003040 <consoleread+0xfc>
    8000304c:	00001097          	auipc	ra,0x1
    80003050:	234080e7          	jalr	564(ra) # 80004280 <pop_on>
    80003054:	0984a783          	lw	a5,152(s1)
    80003058:	07f7f713          	andi	a4,a5,127
    8000305c:	00e48733          	add	a4,s1,a4
    80003060:	01874703          	lbu	a4,24(a4)
    80003064:	0017869b          	addiw	a3,a5,1
    80003068:	08d4ac23          	sw	a3,152(s1)
    8000306c:	00070c9b          	sext.w	s9,a4
    80003070:	f5371ee3          	bne	a4,s3,80002fcc <consoleread+0x88>
    80003074:	000b851b          	sext.w	a0,s7
    80003078:	f96bf2e3          	bgeu	s7,s6,80002ffc <consoleread+0xb8>
    8000307c:	08f4ac23          	sw	a5,152(s1)
    80003080:	f7dff06f          	j	80002ffc <consoleread+0xb8>

0000000080003084 <consputc>:
    80003084:	10000793          	li	a5,256
    80003088:	00f50663          	beq	a0,a5,80003094 <consputc+0x10>
    8000308c:	00001317          	auipc	t1,0x1
    80003090:	9f430067          	jr	-1548(t1) # 80003a80 <uartputc_sync>
    80003094:	ff010113          	addi	sp,sp,-16
    80003098:	00113423          	sd	ra,8(sp)
    8000309c:	00813023          	sd	s0,0(sp)
    800030a0:	01010413          	addi	s0,sp,16
    800030a4:	00800513          	li	a0,8
    800030a8:	00001097          	auipc	ra,0x1
    800030ac:	9d8080e7          	jalr	-1576(ra) # 80003a80 <uartputc_sync>
    800030b0:	02000513          	li	a0,32
    800030b4:	00001097          	auipc	ra,0x1
    800030b8:	9cc080e7          	jalr	-1588(ra) # 80003a80 <uartputc_sync>
    800030bc:	00013403          	ld	s0,0(sp)
    800030c0:	00813083          	ld	ra,8(sp)
    800030c4:	00800513          	li	a0,8
    800030c8:	01010113          	addi	sp,sp,16
    800030cc:	00001317          	auipc	t1,0x1
    800030d0:	9b430067          	jr	-1612(t1) # 80003a80 <uartputc_sync>

00000000800030d4 <consoleintr>:
    800030d4:	fe010113          	addi	sp,sp,-32
    800030d8:	00813823          	sd	s0,16(sp)
    800030dc:	00913423          	sd	s1,8(sp)
    800030e0:	01213023          	sd	s2,0(sp)
    800030e4:	00113c23          	sd	ra,24(sp)
    800030e8:	02010413          	addi	s0,sp,32
    800030ec:	00004917          	auipc	s2,0x4
    800030f0:	ccc90913          	addi	s2,s2,-820 # 80006db8 <cons>
    800030f4:	00050493          	mv	s1,a0
    800030f8:	00090513          	mv	a0,s2
    800030fc:	00001097          	auipc	ra,0x1
    80003100:	e40080e7          	jalr	-448(ra) # 80003f3c <acquire>
    80003104:	02048c63          	beqz	s1,8000313c <consoleintr+0x68>
    80003108:	0a092783          	lw	a5,160(s2)
    8000310c:	09892703          	lw	a4,152(s2)
    80003110:	07f00693          	li	a3,127
    80003114:	40e7873b          	subw	a4,a5,a4
    80003118:	02e6e263          	bltu	a3,a4,8000313c <consoleintr+0x68>
    8000311c:	00d00713          	li	a4,13
    80003120:	04e48063          	beq	s1,a4,80003160 <consoleintr+0x8c>
    80003124:	07f7f713          	andi	a4,a5,127
    80003128:	00e90733          	add	a4,s2,a4
    8000312c:	0017879b          	addiw	a5,a5,1
    80003130:	0af92023          	sw	a5,160(s2)
    80003134:	00970c23          	sb	s1,24(a4)
    80003138:	08f92e23          	sw	a5,156(s2)
    8000313c:	01013403          	ld	s0,16(sp)
    80003140:	01813083          	ld	ra,24(sp)
    80003144:	00813483          	ld	s1,8(sp)
    80003148:	00013903          	ld	s2,0(sp)
    8000314c:	00004517          	auipc	a0,0x4
    80003150:	c6c50513          	addi	a0,a0,-916 # 80006db8 <cons>
    80003154:	02010113          	addi	sp,sp,32
    80003158:	00001317          	auipc	t1,0x1
    8000315c:	eb030067          	jr	-336(t1) # 80004008 <release>
    80003160:	00a00493          	li	s1,10
    80003164:	fc1ff06f          	j	80003124 <consoleintr+0x50>

0000000080003168 <consoleinit>:
    80003168:	fe010113          	addi	sp,sp,-32
    8000316c:	00113c23          	sd	ra,24(sp)
    80003170:	00813823          	sd	s0,16(sp)
    80003174:	00913423          	sd	s1,8(sp)
    80003178:	02010413          	addi	s0,sp,32
    8000317c:	00004497          	auipc	s1,0x4
    80003180:	c3c48493          	addi	s1,s1,-964 # 80006db8 <cons>
    80003184:	00048513          	mv	a0,s1
    80003188:	00002597          	auipc	a1,0x2
    8000318c:	30858593          	addi	a1,a1,776 # 80005490 <kvmincrease+0xac0>
    80003190:	00001097          	auipc	ra,0x1
    80003194:	d88080e7          	jalr	-632(ra) # 80003f18 <initlock>
    80003198:	00000097          	auipc	ra,0x0
    8000319c:	7ac080e7          	jalr	1964(ra) # 80003944 <uartinit>
    800031a0:	01813083          	ld	ra,24(sp)
    800031a4:	01013403          	ld	s0,16(sp)
    800031a8:	00000797          	auipc	a5,0x0
    800031ac:	d9c78793          	addi	a5,a5,-612 # 80002f44 <consoleread>
    800031b0:	0af4bc23          	sd	a5,184(s1)
    800031b4:	00000797          	auipc	a5,0x0
    800031b8:	cec78793          	addi	a5,a5,-788 # 80002ea0 <consolewrite>
    800031bc:	0cf4b023          	sd	a5,192(s1)
    800031c0:	00813483          	ld	s1,8(sp)
    800031c4:	02010113          	addi	sp,sp,32
    800031c8:	00008067          	ret

00000000800031cc <console_read>:
    800031cc:	ff010113          	addi	sp,sp,-16
    800031d0:	00813423          	sd	s0,8(sp)
    800031d4:	01010413          	addi	s0,sp,16
    800031d8:	00813403          	ld	s0,8(sp)
    800031dc:	00004317          	auipc	t1,0x4
    800031e0:	c9433303          	ld	t1,-876(t1) # 80006e70 <devsw+0x10>
    800031e4:	01010113          	addi	sp,sp,16
    800031e8:	00030067          	jr	t1

00000000800031ec <console_write>:
    800031ec:	ff010113          	addi	sp,sp,-16
    800031f0:	00813423          	sd	s0,8(sp)
    800031f4:	01010413          	addi	s0,sp,16
    800031f8:	00813403          	ld	s0,8(sp)
    800031fc:	00004317          	auipc	t1,0x4
    80003200:	c7c33303          	ld	t1,-900(t1) # 80006e78 <devsw+0x18>
    80003204:	01010113          	addi	sp,sp,16
    80003208:	00030067          	jr	t1

000000008000320c <panic>:
    8000320c:	fe010113          	addi	sp,sp,-32
    80003210:	00113c23          	sd	ra,24(sp)
    80003214:	00813823          	sd	s0,16(sp)
    80003218:	00913423          	sd	s1,8(sp)
    8000321c:	02010413          	addi	s0,sp,32
    80003220:	00050493          	mv	s1,a0
    80003224:	00002517          	auipc	a0,0x2
    80003228:	27450513          	addi	a0,a0,628 # 80005498 <kvmincrease+0xac8>
    8000322c:	00004797          	auipc	a5,0x4
    80003230:	ce07a623          	sw	zero,-788(a5) # 80006f18 <pr+0x18>
    80003234:	00000097          	auipc	ra,0x0
    80003238:	034080e7          	jalr	52(ra) # 80003268 <__printf>
    8000323c:	00048513          	mv	a0,s1
    80003240:	00000097          	auipc	ra,0x0
    80003244:	028080e7          	jalr	40(ra) # 80003268 <__printf>
    80003248:	00002517          	auipc	a0,0x2
    8000324c:	23050513          	addi	a0,a0,560 # 80005478 <kvmincrease+0xaa8>
    80003250:	00000097          	auipc	ra,0x0
    80003254:	018080e7          	jalr	24(ra) # 80003268 <__printf>
    80003258:	00100793          	li	a5,1
    8000325c:	00003717          	auipc	a4,0x3
    80003260:	a4f72423          	sw	a5,-1464(a4) # 80005ca4 <panicked>
    80003264:	0000006f          	j	80003264 <panic+0x58>

0000000080003268 <__printf>:
    80003268:	f3010113          	addi	sp,sp,-208
    8000326c:	08813023          	sd	s0,128(sp)
    80003270:	07313423          	sd	s3,104(sp)
    80003274:	09010413          	addi	s0,sp,144
    80003278:	05813023          	sd	s8,64(sp)
    8000327c:	08113423          	sd	ra,136(sp)
    80003280:	06913c23          	sd	s1,120(sp)
    80003284:	07213823          	sd	s2,112(sp)
    80003288:	07413023          	sd	s4,96(sp)
    8000328c:	05513c23          	sd	s5,88(sp)
    80003290:	05613823          	sd	s6,80(sp)
    80003294:	05713423          	sd	s7,72(sp)
    80003298:	03913c23          	sd	s9,56(sp)
    8000329c:	03a13823          	sd	s10,48(sp)
    800032a0:	03b13423          	sd	s11,40(sp)
    800032a4:	00004317          	auipc	t1,0x4
    800032a8:	c5c30313          	addi	t1,t1,-932 # 80006f00 <pr>
    800032ac:	01832c03          	lw	s8,24(t1)
    800032b0:	00b43423          	sd	a1,8(s0)
    800032b4:	00c43823          	sd	a2,16(s0)
    800032b8:	00d43c23          	sd	a3,24(s0)
    800032bc:	02e43023          	sd	a4,32(s0)
    800032c0:	02f43423          	sd	a5,40(s0)
    800032c4:	03043823          	sd	a6,48(s0)
    800032c8:	03143c23          	sd	a7,56(s0)
    800032cc:	00050993          	mv	s3,a0
    800032d0:	4a0c1663          	bnez	s8,8000377c <__printf+0x514>
    800032d4:	60098c63          	beqz	s3,800038ec <__printf+0x684>
    800032d8:	0009c503          	lbu	a0,0(s3)
    800032dc:	00840793          	addi	a5,s0,8
    800032e0:	f6f43c23          	sd	a5,-136(s0)
    800032e4:	00000493          	li	s1,0
    800032e8:	22050063          	beqz	a0,80003508 <__printf+0x2a0>
    800032ec:	00002a37          	lui	s4,0x2
    800032f0:	00018ab7          	lui	s5,0x18
    800032f4:	000f4b37          	lui	s6,0xf4
    800032f8:	00989bb7          	lui	s7,0x989
    800032fc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003300:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003304:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003308:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000330c:	00148c9b          	addiw	s9,s1,1
    80003310:	02500793          	li	a5,37
    80003314:	01998933          	add	s2,s3,s9
    80003318:	38f51263          	bne	a0,a5,8000369c <__printf+0x434>
    8000331c:	00094783          	lbu	a5,0(s2)
    80003320:	00078c9b          	sext.w	s9,a5
    80003324:	1e078263          	beqz	a5,80003508 <__printf+0x2a0>
    80003328:	0024849b          	addiw	s1,s1,2
    8000332c:	07000713          	li	a4,112
    80003330:	00998933          	add	s2,s3,s1
    80003334:	38e78a63          	beq	a5,a4,800036c8 <__printf+0x460>
    80003338:	20f76863          	bltu	a4,a5,80003548 <__printf+0x2e0>
    8000333c:	42a78863          	beq	a5,a0,8000376c <__printf+0x504>
    80003340:	06400713          	li	a4,100
    80003344:	40e79663          	bne	a5,a4,80003750 <__printf+0x4e8>
    80003348:	f7843783          	ld	a5,-136(s0)
    8000334c:	0007a603          	lw	a2,0(a5)
    80003350:	00878793          	addi	a5,a5,8
    80003354:	f6f43c23          	sd	a5,-136(s0)
    80003358:	42064a63          	bltz	a2,8000378c <__printf+0x524>
    8000335c:	00a00713          	li	a4,10
    80003360:	02e677bb          	remuw	a5,a2,a4
    80003364:	00002d97          	auipc	s11,0x2
    80003368:	15cd8d93          	addi	s11,s11,348 # 800054c0 <digits>
    8000336c:	00900593          	li	a1,9
    80003370:	0006051b          	sext.w	a0,a2
    80003374:	00000c93          	li	s9,0
    80003378:	02079793          	slli	a5,a5,0x20
    8000337c:	0207d793          	srli	a5,a5,0x20
    80003380:	00fd87b3          	add	a5,s11,a5
    80003384:	0007c783          	lbu	a5,0(a5)
    80003388:	02e656bb          	divuw	a3,a2,a4
    8000338c:	f8f40023          	sb	a5,-128(s0)
    80003390:	14c5d863          	bge	a1,a2,800034e0 <__printf+0x278>
    80003394:	06300593          	li	a1,99
    80003398:	00100c93          	li	s9,1
    8000339c:	02e6f7bb          	remuw	a5,a3,a4
    800033a0:	02079793          	slli	a5,a5,0x20
    800033a4:	0207d793          	srli	a5,a5,0x20
    800033a8:	00fd87b3          	add	a5,s11,a5
    800033ac:	0007c783          	lbu	a5,0(a5)
    800033b0:	02e6d73b          	divuw	a4,a3,a4
    800033b4:	f8f400a3          	sb	a5,-127(s0)
    800033b8:	12a5f463          	bgeu	a1,a0,800034e0 <__printf+0x278>
    800033bc:	00a00693          	li	a3,10
    800033c0:	00900593          	li	a1,9
    800033c4:	02d777bb          	remuw	a5,a4,a3
    800033c8:	02079793          	slli	a5,a5,0x20
    800033cc:	0207d793          	srli	a5,a5,0x20
    800033d0:	00fd87b3          	add	a5,s11,a5
    800033d4:	0007c503          	lbu	a0,0(a5)
    800033d8:	02d757bb          	divuw	a5,a4,a3
    800033dc:	f8a40123          	sb	a0,-126(s0)
    800033e0:	48e5f263          	bgeu	a1,a4,80003864 <__printf+0x5fc>
    800033e4:	06300513          	li	a0,99
    800033e8:	02d7f5bb          	remuw	a1,a5,a3
    800033ec:	02059593          	slli	a1,a1,0x20
    800033f0:	0205d593          	srli	a1,a1,0x20
    800033f4:	00bd85b3          	add	a1,s11,a1
    800033f8:	0005c583          	lbu	a1,0(a1)
    800033fc:	02d7d7bb          	divuw	a5,a5,a3
    80003400:	f8b401a3          	sb	a1,-125(s0)
    80003404:	48e57263          	bgeu	a0,a4,80003888 <__printf+0x620>
    80003408:	3e700513          	li	a0,999
    8000340c:	02d7f5bb          	remuw	a1,a5,a3
    80003410:	02059593          	slli	a1,a1,0x20
    80003414:	0205d593          	srli	a1,a1,0x20
    80003418:	00bd85b3          	add	a1,s11,a1
    8000341c:	0005c583          	lbu	a1,0(a1)
    80003420:	02d7d7bb          	divuw	a5,a5,a3
    80003424:	f8b40223          	sb	a1,-124(s0)
    80003428:	46e57663          	bgeu	a0,a4,80003894 <__printf+0x62c>
    8000342c:	02d7f5bb          	remuw	a1,a5,a3
    80003430:	02059593          	slli	a1,a1,0x20
    80003434:	0205d593          	srli	a1,a1,0x20
    80003438:	00bd85b3          	add	a1,s11,a1
    8000343c:	0005c583          	lbu	a1,0(a1)
    80003440:	02d7d7bb          	divuw	a5,a5,a3
    80003444:	f8b402a3          	sb	a1,-123(s0)
    80003448:	46ea7863          	bgeu	s4,a4,800038b8 <__printf+0x650>
    8000344c:	02d7f5bb          	remuw	a1,a5,a3
    80003450:	02059593          	slli	a1,a1,0x20
    80003454:	0205d593          	srli	a1,a1,0x20
    80003458:	00bd85b3          	add	a1,s11,a1
    8000345c:	0005c583          	lbu	a1,0(a1)
    80003460:	02d7d7bb          	divuw	a5,a5,a3
    80003464:	f8b40323          	sb	a1,-122(s0)
    80003468:	3eeaf863          	bgeu	s5,a4,80003858 <__printf+0x5f0>
    8000346c:	02d7f5bb          	remuw	a1,a5,a3
    80003470:	02059593          	slli	a1,a1,0x20
    80003474:	0205d593          	srli	a1,a1,0x20
    80003478:	00bd85b3          	add	a1,s11,a1
    8000347c:	0005c583          	lbu	a1,0(a1)
    80003480:	02d7d7bb          	divuw	a5,a5,a3
    80003484:	f8b403a3          	sb	a1,-121(s0)
    80003488:	42eb7e63          	bgeu	s6,a4,800038c4 <__printf+0x65c>
    8000348c:	02d7f5bb          	remuw	a1,a5,a3
    80003490:	02059593          	slli	a1,a1,0x20
    80003494:	0205d593          	srli	a1,a1,0x20
    80003498:	00bd85b3          	add	a1,s11,a1
    8000349c:	0005c583          	lbu	a1,0(a1)
    800034a0:	02d7d7bb          	divuw	a5,a5,a3
    800034a4:	f8b40423          	sb	a1,-120(s0)
    800034a8:	42ebfc63          	bgeu	s7,a4,800038e0 <__printf+0x678>
    800034ac:	02079793          	slli	a5,a5,0x20
    800034b0:	0207d793          	srli	a5,a5,0x20
    800034b4:	00fd8db3          	add	s11,s11,a5
    800034b8:	000dc703          	lbu	a4,0(s11)
    800034bc:	00a00793          	li	a5,10
    800034c0:	00900c93          	li	s9,9
    800034c4:	f8e404a3          	sb	a4,-119(s0)
    800034c8:	00065c63          	bgez	a2,800034e0 <__printf+0x278>
    800034cc:	f9040713          	addi	a4,s0,-112
    800034d0:	00f70733          	add	a4,a4,a5
    800034d4:	02d00693          	li	a3,45
    800034d8:	fed70823          	sb	a3,-16(a4)
    800034dc:	00078c93          	mv	s9,a5
    800034e0:	f8040793          	addi	a5,s0,-128
    800034e4:	01978cb3          	add	s9,a5,s9
    800034e8:	f7f40d13          	addi	s10,s0,-129
    800034ec:	000cc503          	lbu	a0,0(s9)
    800034f0:	fffc8c93          	addi	s9,s9,-1
    800034f4:	00000097          	auipc	ra,0x0
    800034f8:	b90080e7          	jalr	-1136(ra) # 80003084 <consputc>
    800034fc:	ffac98e3          	bne	s9,s10,800034ec <__printf+0x284>
    80003500:	00094503          	lbu	a0,0(s2)
    80003504:	e00514e3          	bnez	a0,8000330c <__printf+0xa4>
    80003508:	1a0c1663          	bnez	s8,800036b4 <__printf+0x44c>
    8000350c:	08813083          	ld	ra,136(sp)
    80003510:	08013403          	ld	s0,128(sp)
    80003514:	07813483          	ld	s1,120(sp)
    80003518:	07013903          	ld	s2,112(sp)
    8000351c:	06813983          	ld	s3,104(sp)
    80003520:	06013a03          	ld	s4,96(sp)
    80003524:	05813a83          	ld	s5,88(sp)
    80003528:	05013b03          	ld	s6,80(sp)
    8000352c:	04813b83          	ld	s7,72(sp)
    80003530:	04013c03          	ld	s8,64(sp)
    80003534:	03813c83          	ld	s9,56(sp)
    80003538:	03013d03          	ld	s10,48(sp)
    8000353c:	02813d83          	ld	s11,40(sp)
    80003540:	0d010113          	addi	sp,sp,208
    80003544:	00008067          	ret
    80003548:	07300713          	li	a4,115
    8000354c:	1ce78a63          	beq	a5,a4,80003720 <__printf+0x4b8>
    80003550:	07800713          	li	a4,120
    80003554:	1ee79e63          	bne	a5,a4,80003750 <__printf+0x4e8>
    80003558:	f7843783          	ld	a5,-136(s0)
    8000355c:	0007a703          	lw	a4,0(a5)
    80003560:	00878793          	addi	a5,a5,8
    80003564:	f6f43c23          	sd	a5,-136(s0)
    80003568:	28074263          	bltz	a4,800037ec <__printf+0x584>
    8000356c:	00002d97          	auipc	s11,0x2
    80003570:	f54d8d93          	addi	s11,s11,-172 # 800054c0 <digits>
    80003574:	00f77793          	andi	a5,a4,15
    80003578:	00fd87b3          	add	a5,s11,a5
    8000357c:	0007c683          	lbu	a3,0(a5)
    80003580:	00f00613          	li	a2,15
    80003584:	0007079b          	sext.w	a5,a4
    80003588:	f8d40023          	sb	a3,-128(s0)
    8000358c:	0047559b          	srliw	a1,a4,0x4
    80003590:	0047569b          	srliw	a3,a4,0x4
    80003594:	00000c93          	li	s9,0
    80003598:	0ee65063          	bge	a2,a4,80003678 <__printf+0x410>
    8000359c:	00f6f693          	andi	a3,a3,15
    800035a0:	00dd86b3          	add	a3,s11,a3
    800035a4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800035a8:	0087d79b          	srliw	a5,a5,0x8
    800035ac:	00100c93          	li	s9,1
    800035b0:	f8d400a3          	sb	a3,-127(s0)
    800035b4:	0cb67263          	bgeu	a2,a1,80003678 <__printf+0x410>
    800035b8:	00f7f693          	andi	a3,a5,15
    800035bc:	00dd86b3          	add	a3,s11,a3
    800035c0:	0006c583          	lbu	a1,0(a3)
    800035c4:	00f00613          	li	a2,15
    800035c8:	0047d69b          	srliw	a3,a5,0x4
    800035cc:	f8b40123          	sb	a1,-126(s0)
    800035d0:	0047d593          	srli	a1,a5,0x4
    800035d4:	28f67e63          	bgeu	a2,a5,80003870 <__printf+0x608>
    800035d8:	00f6f693          	andi	a3,a3,15
    800035dc:	00dd86b3          	add	a3,s11,a3
    800035e0:	0006c503          	lbu	a0,0(a3)
    800035e4:	0087d813          	srli	a6,a5,0x8
    800035e8:	0087d69b          	srliw	a3,a5,0x8
    800035ec:	f8a401a3          	sb	a0,-125(s0)
    800035f0:	28b67663          	bgeu	a2,a1,8000387c <__printf+0x614>
    800035f4:	00f6f693          	andi	a3,a3,15
    800035f8:	00dd86b3          	add	a3,s11,a3
    800035fc:	0006c583          	lbu	a1,0(a3)
    80003600:	00c7d513          	srli	a0,a5,0xc
    80003604:	00c7d69b          	srliw	a3,a5,0xc
    80003608:	f8b40223          	sb	a1,-124(s0)
    8000360c:	29067a63          	bgeu	a2,a6,800038a0 <__printf+0x638>
    80003610:	00f6f693          	andi	a3,a3,15
    80003614:	00dd86b3          	add	a3,s11,a3
    80003618:	0006c583          	lbu	a1,0(a3)
    8000361c:	0107d813          	srli	a6,a5,0x10
    80003620:	0107d69b          	srliw	a3,a5,0x10
    80003624:	f8b402a3          	sb	a1,-123(s0)
    80003628:	28a67263          	bgeu	a2,a0,800038ac <__printf+0x644>
    8000362c:	00f6f693          	andi	a3,a3,15
    80003630:	00dd86b3          	add	a3,s11,a3
    80003634:	0006c683          	lbu	a3,0(a3)
    80003638:	0147d79b          	srliw	a5,a5,0x14
    8000363c:	f8d40323          	sb	a3,-122(s0)
    80003640:	21067663          	bgeu	a2,a6,8000384c <__printf+0x5e4>
    80003644:	02079793          	slli	a5,a5,0x20
    80003648:	0207d793          	srli	a5,a5,0x20
    8000364c:	00fd8db3          	add	s11,s11,a5
    80003650:	000dc683          	lbu	a3,0(s11)
    80003654:	00800793          	li	a5,8
    80003658:	00700c93          	li	s9,7
    8000365c:	f8d403a3          	sb	a3,-121(s0)
    80003660:	00075c63          	bgez	a4,80003678 <__printf+0x410>
    80003664:	f9040713          	addi	a4,s0,-112
    80003668:	00f70733          	add	a4,a4,a5
    8000366c:	02d00693          	li	a3,45
    80003670:	fed70823          	sb	a3,-16(a4)
    80003674:	00078c93          	mv	s9,a5
    80003678:	f8040793          	addi	a5,s0,-128
    8000367c:	01978cb3          	add	s9,a5,s9
    80003680:	f7f40d13          	addi	s10,s0,-129
    80003684:	000cc503          	lbu	a0,0(s9)
    80003688:	fffc8c93          	addi	s9,s9,-1
    8000368c:	00000097          	auipc	ra,0x0
    80003690:	9f8080e7          	jalr	-1544(ra) # 80003084 <consputc>
    80003694:	ff9d18e3          	bne	s10,s9,80003684 <__printf+0x41c>
    80003698:	0100006f          	j	800036a8 <__printf+0x440>
    8000369c:	00000097          	auipc	ra,0x0
    800036a0:	9e8080e7          	jalr	-1560(ra) # 80003084 <consputc>
    800036a4:	000c8493          	mv	s1,s9
    800036a8:	00094503          	lbu	a0,0(s2)
    800036ac:	c60510e3          	bnez	a0,8000330c <__printf+0xa4>
    800036b0:	e40c0ee3          	beqz	s8,8000350c <__printf+0x2a4>
    800036b4:	00004517          	auipc	a0,0x4
    800036b8:	84c50513          	addi	a0,a0,-1972 # 80006f00 <pr>
    800036bc:	00001097          	auipc	ra,0x1
    800036c0:	94c080e7          	jalr	-1716(ra) # 80004008 <release>
    800036c4:	e49ff06f          	j	8000350c <__printf+0x2a4>
    800036c8:	f7843783          	ld	a5,-136(s0)
    800036cc:	03000513          	li	a0,48
    800036d0:	01000d13          	li	s10,16
    800036d4:	00878713          	addi	a4,a5,8
    800036d8:	0007bc83          	ld	s9,0(a5)
    800036dc:	f6e43c23          	sd	a4,-136(s0)
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	9a4080e7          	jalr	-1628(ra) # 80003084 <consputc>
    800036e8:	07800513          	li	a0,120
    800036ec:	00000097          	auipc	ra,0x0
    800036f0:	998080e7          	jalr	-1640(ra) # 80003084 <consputc>
    800036f4:	00002d97          	auipc	s11,0x2
    800036f8:	dccd8d93          	addi	s11,s11,-564 # 800054c0 <digits>
    800036fc:	03ccd793          	srli	a5,s9,0x3c
    80003700:	00fd87b3          	add	a5,s11,a5
    80003704:	0007c503          	lbu	a0,0(a5)
    80003708:	fffd0d1b          	addiw	s10,s10,-1
    8000370c:	004c9c93          	slli	s9,s9,0x4
    80003710:	00000097          	auipc	ra,0x0
    80003714:	974080e7          	jalr	-1676(ra) # 80003084 <consputc>
    80003718:	fe0d12e3          	bnez	s10,800036fc <__printf+0x494>
    8000371c:	f8dff06f          	j	800036a8 <__printf+0x440>
    80003720:	f7843783          	ld	a5,-136(s0)
    80003724:	0007bc83          	ld	s9,0(a5)
    80003728:	00878793          	addi	a5,a5,8
    8000372c:	f6f43c23          	sd	a5,-136(s0)
    80003730:	000c9a63          	bnez	s9,80003744 <__printf+0x4dc>
    80003734:	1080006f          	j	8000383c <__printf+0x5d4>
    80003738:	001c8c93          	addi	s9,s9,1
    8000373c:	00000097          	auipc	ra,0x0
    80003740:	948080e7          	jalr	-1720(ra) # 80003084 <consputc>
    80003744:	000cc503          	lbu	a0,0(s9)
    80003748:	fe0518e3          	bnez	a0,80003738 <__printf+0x4d0>
    8000374c:	f5dff06f          	j	800036a8 <__printf+0x440>
    80003750:	02500513          	li	a0,37
    80003754:	00000097          	auipc	ra,0x0
    80003758:	930080e7          	jalr	-1744(ra) # 80003084 <consputc>
    8000375c:	000c8513          	mv	a0,s9
    80003760:	00000097          	auipc	ra,0x0
    80003764:	924080e7          	jalr	-1756(ra) # 80003084 <consputc>
    80003768:	f41ff06f          	j	800036a8 <__printf+0x440>
    8000376c:	02500513          	li	a0,37
    80003770:	00000097          	auipc	ra,0x0
    80003774:	914080e7          	jalr	-1772(ra) # 80003084 <consputc>
    80003778:	f31ff06f          	j	800036a8 <__printf+0x440>
    8000377c:	00030513          	mv	a0,t1
    80003780:	00000097          	auipc	ra,0x0
    80003784:	7bc080e7          	jalr	1980(ra) # 80003f3c <acquire>
    80003788:	b4dff06f          	j	800032d4 <__printf+0x6c>
    8000378c:	40c0053b          	negw	a0,a2
    80003790:	00a00713          	li	a4,10
    80003794:	02e576bb          	remuw	a3,a0,a4
    80003798:	00002d97          	auipc	s11,0x2
    8000379c:	d28d8d93          	addi	s11,s11,-728 # 800054c0 <digits>
    800037a0:	ff700593          	li	a1,-9
    800037a4:	02069693          	slli	a3,a3,0x20
    800037a8:	0206d693          	srli	a3,a3,0x20
    800037ac:	00dd86b3          	add	a3,s11,a3
    800037b0:	0006c683          	lbu	a3,0(a3)
    800037b4:	02e557bb          	divuw	a5,a0,a4
    800037b8:	f8d40023          	sb	a3,-128(s0)
    800037bc:	10b65e63          	bge	a2,a1,800038d8 <__printf+0x670>
    800037c0:	06300593          	li	a1,99
    800037c4:	02e7f6bb          	remuw	a3,a5,a4
    800037c8:	02069693          	slli	a3,a3,0x20
    800037cc:	0206d693          	srli	a3,a3,0x20
    800037d0:	00dd86b3          	add	a3,s11,a3
    800037d4:	0006c683          	lbu	a3,0(a3)
    800037d8:	02e7d73b          	divuw	a4,a5,a4
    800037dc:	00200793          	li	a5,2
    800037e0:	f8d400a3          	sb	a3,-127(s0)
    800037e4:	bca5ece3          	bltu	a1,a0,800033bc <__printf+0x154>
    800037e8:	ce5ff06f          	j	800034cc <__printf+0x264>
    800037ec:	40e007bb          	negw	a5,a4
    800037f0:	00002d97          	auipc	s11,0x2
    800037f4:	cd0d8d93          	addi	s11,s11,-816 # 800054c0 <digits>
    800037f8:	00f7f693          	andi	a3,a5,15
    800037fc:	00dd86b3          	add	a3,s11,a3
    80003800:	0006c583          	lbu	a1,0(a3)
    80003804:	ff100613          	li	a2,-15
    80003808:	0047d69b          	srliw	a3,a5,0x4
    8000380c:	f8b40023          	sb	a1,-128(s0)
    80003810:	0047d59b          	srliw	a1,a5,0x4
    80003814:	0ac75e63          	bge	a4,a2,800038d0 <__printf+0x668>
    80003818:	00f6f693          	andi	a3,a3,15
    8000381c:	00dd86b3          	add	a3,s11,a3
    80003820:	0006c603          	lbu	a2,0(a3)
    80003824:	00f00693          	li	a3,15
    80003828:	0087d79b          	srliw	a5,a5,0x8
    8000382c:	f8c400a3          	sb	a2,-127(s0)
    80003830:	d8b6e4e3          	bltu	a3,a1,800035b8 <__printf+0x350>
    80003834:	00200793          	li	a5,2
    80003838:	e2dff06f          	j	80003664 <__printf+0x3fc>
    8000383c:	00002c97          	auipc	s9,0x2
    80003840:	c64c8c93          	addi	s9,s9,-924 # 800054a0 <kvmincrease+0xad0>
    80003844:	02800513          	li	a0,40
    80003848:	ef1ff06f          	j	80003738 <__printf+0x4d0>
    8000384c:	00700793          	li	a5,7
    80003850:	00600c93          	li	s9,6
    80003854:	e0dff06f          	j	80003660 <__printf+0x3f8>
    80003858:	00700793          	li	a5,7
    8000385c:	00600c93          	li	s9,6
    80003860:	c69ff06f          	j	800034c8 <__printf+0x260>
    80003864:	00300793          	li	a5,3
    80003868:	00200c93          	li	s9,2
    8000386c:	c5dff06f          	j	800034c8 <__printf+0x260>
    80003870:	00300793          	li	a5,3
    80003874:	00200c93          	li	s9,2
    80003878:	de9ff06f          	j	80003660 <__printf+0x3f8>
    8000387c:	00400793          	li	a5,4
    80003880:	00300c93          	li	s9,3
    80003884:	dddff06f          	j	80003660 <__printf+0x3f8>
    80003888:	00400793          	li	a5,4
    8000388c:	00300c93          	li	s9,3
    80003890:	c39ff06f          	j	800034c8 <__printf+0x260>
    80003894:	00500793          	li	a5,5
    80003898:	00400c93          	li	s9,4
    8000389c:	c2dff06f          	j	800034c8 <__printf+0x260>
    800038a0:	00500793          	li	a5,5
    800038a4:	00400c93          	li	s9,4
    800038a8:	db9ff06f          	j	80003660 <__printf+0x3f8>
    800038ac:	00600793          	li	a5,6
    800038b0:	00500c93          	li	s9,5
    800038b4:	dadff06f          	j	80003660 <__printf+0x3f8>
    800038b8:	00600793          	li	a5,6
    800038bc:	00500c93          	li	s9,5
    800038c0:	c09ff06f          	j	800034c8 <__printf+0x260>
    800038c4:	00800793          	li	a5,8
    800038c8:	00700c93          	li	s9,7
    800038cc:	bfdff06f          	j	800034c8 <__printf+0x260>
    800038d0:	00100793          	li	a5,1
    800038d4:	d91ff06f          	j	80003664 <__printf+0x3fc>
    800038d8:	00100793          	li	a5,1
    800038dc:	bf1ff06f          	j	800034cc <__printf+0x264>
    800038e0:	00900793          	li	a5,9
    800038e4:	00800c93          	li	s9,8
    800038e8:	be1ff06f          	j	800034c8 <__printf+0x260>
    800038ec:	00002517          	auipc	a0,0x2
    800038f0:	bbc50513          	addi	a0,a0,-1092 # 800054a8 <kvmincrease+0xad8>
    800038f4:	00000097          	auipc	ra,0x0
    800038f8:	918080e7          	jalr	-1768(ra) # 8000320c <panic>

00000000800038fc <printfinit>:
    800038fc:	fe010113          	addi	sp,sp,-32
    80003900:	00813823          	sd	s0,16(sp)
    80003904:	00913423          	sd	s1,8(sp)
    80003908:	00113c23          	sd	ra,24(sp)
    8000390c:	02010413          	addi	s0,sp,32
    80003910:	00003497          	auipc	s1,0x3
    80003914:	5f048493          	addi	s1,s1,1520 # 80006f00 <pr>
    80003918:	00048513          	mv	a0,s1
    8000391c:	00002597          	auipc	a1,0x2
    80003920:	b9c58593          	addi	a1,a1,-1124 # 800054b8 <kvmincrease+0xae8>
    80003924:	00000097          	auipc	ra,0x0
    80003928:	5f4080e7          	jalr	1524(ra) # 80003f18 <initlock>
    8000392c:	01813083          	ld	ra,24(sp)
    80003930:	01013403          	ld	s0,16(sp)
    80003934:	0004ac23          	sw	zero,24(s1)
    80003938:	00813483          	ld	s1,8(sp)
    8000393c:	02010113          	addi	sp,sp,32
    80003940:	00008067          	ret

0000000080003944 <uartinit>:
    80003944:	ff010113          	addi	sp,sp,-16
    80003948:	00813423          	sd	s0,8(sp)
    8000394c:	01010413          	addi	s0,sp,16
    80003950:	100007b7          	lui	a5,0x10000
    80003954:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003958:	f8000713          	li	a4,-128
    8000395c:	00e781a3          	sb	a4,3(a5)
    80003960:	00300713          	li	a4,3
    80003964:	00e78023          	sb	a4,0(a5)
    80003968:	000780a3          	sb	zero,1(a5)
    8000396c:	00e781a3          	sb	a4,3(a5)
    80003970:	00700693          	li	a3,7
    80003974:	00d78123          	sb	a3,2(a5)
    80003978:	00e780a3          	sb	a4,1(a5)
    8000397c:	00813403          	ld	s0,8(sp)
    80003980:	01010113          	addi	sp,sp,16
    80003984:	00008067          	ret

0000000080003988 <uartputc>:
    80003988:	00002797          	auipc	a5,0x2
    8000398c:	31c7a783          	lw	a5,796(a5) # 80005ca4 <panicked>
    80003990:	00078463          	beqz	a5,80003998 <uartputc+0x10>
    80003994:	0000006f          	j	80003994 <uartputc+0xc>
    80003998:	fd010113          	addi	sp,sp,-48
    8000399c:	02813023          	sd	s0,32(sp)
    800039a0:	00913c23          	sd	s1,24(sp)
    800039a4:	01213823          	sd	s2,16(sp)
    800039a8:	01313423          	sd	s3,8(sp)
    800039ac:	02113423          	sd	ra,40(sp)
    800039b0:	03010413          	addi	s0,sp,48
    800039b4:	00002917          	auipc	s2,0x2
    800039b8:	2f490913          	addi	s2,s2,756 # 80005ca8 <uart_tx_r>
    800039bc:	00093783          	ld	a5,0(s2)
    800039c0:	00002497          	auipc	s1,0x2
    800039c4:	2f048493          	addi	s1,s1,752 # 80005cb0 <uart_tx_w>
    800039c8:	0004b703          	ld	a4,0(s1)
    800039cc:	02078693          	addi	a3,a5,32
    800039d0:	00050993          	mv	s3,a0
    800039d4:	02e69c63          	bne	a3,a4,80003a0c <uartputc+0x84>
    800039d8:	00001097          	auipc	ra,0x1
    800039dc:	834080e7          	jalr	-1996(ra) # 8000420c <push_on>
    800039e0:	00093783          	ld	a5,0(s2)
    800039e4:	0004b703          	ld	a4,0(s1)
    800039e8:	02078793          	addi	a5,a5,32
    800039ec:	00e79463          	bne	a5,a4,800039f4 <uartputc+0x6c>
    800039f0:	0000006f          	j	800039f0 <uartputc+0x68>
    800039f4:	00001097          	auipc	ra,0x1
    800039f8:	88c080e7          	jalr	-1908(ra) # 80004280 <pop_on>
    800039fc:	00093783          	ld	a5,0(s2)
    80003a00:	0004b703          	ld	a4,0(s1)
    80003a04:	02078693          	addi	a3,a5,32
    80003a08:	fce688e3          	beq	a3,a4,800039d8 <uartputc+0x50>
    80003a0c:	01f77693          	andi	a3,a4,31
    80003a10:	00003597          	auipc	a1,0x3
    80003a14:	51058593          	addi	a1,a1,1296 # 80006f20 <uart_tx_buf>
    80003a18:	00d586b3          	add	a3,a1,a3
    80003a1c:	00170713          	addi	a4,a4,1
    80003a20:	01368023          	sb	s3,0(a3)
    80003a24:	00e4b023          	sd	a4,0(s1)
    80003a28:	10000637          	lui	a2,0x10000
    80003a2c:	02f71063          	bne	a4,a5,80003a4c <uartputc+0xc4>
    80003a30:	0340006f          	j	80003a64 <uartputc+0xdc>
    80003a34:	00074703          	lbu	a4,0(a4)
    80003a38:	00f93023          	sd	a5,0(s2)
    80003a3c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003a40:	00093783          	ld	a5,0(s2)
    80003a44:	0004b703          	ld	a4,0(s1)
    80003a48:	00f70e63          	beq	a4,a5,80003a64 <uartputc+0xdc>
    80003a4c:	00564683          	lbu	a3,5(a2)
    80003a50:	01f7f713          	andi	a4,a5,31
    80003a54:	00e58733          	add	a4,a1,a4
    80003a58:	0206f693          	andi	a3,a3,32
    80003a5c:	00178793          	addi	a5,a5,1
    80003a60:	fc069ae3          	bnez	a3,80003a34 <uartputc+0xac>
    80003a64:	02813083          	ld	ra,40(sp)
    80003a68:	02013403          	ld	s0,32(sp)
    80003a6c:	01813483          	ld	s1,24(sp)
    80003a70:	01013903          	ld	s2,16(sp)
    80003a74:	00813983          	ld	s3,8(sp)
    80003a78:	03010113          	addi	sp,sp,48
    80003a7c:	00008067          	ret

0000000080003a80 <uartputc_sync>:
    80003a80:	ff010113          	addi	sp,sp,-16
    80003a84:	00813423          	sd	s0,8(sp)
    80003a88:	01010413          	addi	s0,sp,16
    80003a8c:	00002717          	auipc	a4,0x2
    80003a90:	21872703          	lw	a4,536(a4) # 80005ca4 <panicked>
    80003a94:	02071663          	bnez	a4,80003ac0 <uartputc_sync+0x40>
    80003a98:	00050793          	mv	a5,a0
    80003a9c:	100006b7          	lui	a3,0x10000
    80003aa0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003aa4:	02077713          	andi	a4,a4,32
    80003aa8:	fe070ce3          	beqz	a4,80003aa0 <uartputc_sync+0x20>
    80003aac:	0ff7f793          	andi	a5,a5,255
    80003ab0:	00f68023          	sb	a5,0(a3)
    80003ab4:	00813403          	ld	s0,8(sp)
    80003ab8:	01010113          	addi	sp,sp,16
    80003abc:	00008067          	ret
    80003ac0:	0000006f          	j	80003ac0 <uartputc_sync+0x40>

0000000080003ac4 <uartstart>:
    80003ac4:	ff010113          	addi	sp,sp,-16
    80003ac8:	00813423          	sd	s0,8(sp)
    80003acc:	01010413          	addi	s0,sp,16
    80003ad0:	00002617          	auipc	a2,0x2
    80003ad4:	1d860613          	addi	a2,a2,472 # 80005ca8 <uart_tx_r>
    80003ad8:	00002517          	auipc	a0,0x2
    80003adc:	1d850513          	addi	a0,a0,472 # 80005cb0 <uart_tx_w>
    80003ae0:	00063783          	ld	a5,0(a2)
    80003ae4:	00053703          	ld	a4,0(a0)
    80003ae8:	04f70263          	beq	a4,a5,80003b2c <uartstart+0x68>
    80003aec:	100005b7          	lui	a1,0x10000
    80003af0:	00003817          	auipc	a6,0x3
    80003af4:	43080813          	addi	a6,a6,1072 # 80006f20 <uart_tx_buf>
    80003af8:	01c0006f          	j	80003b14 <uartstart+0x50>
    80003afc:	0006c703          	lbu	a4,0(a3)
    80003b00:	00f63023          	sd	a5,0(a2)
    80003b04:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003b08:	00063783          	ld	a5,0(a2)
    80003b0c:	00053703          	ld	a4,0(a0)
    80003b10:	00f70e63          	beq	a4,a5,80003b2c <uartstart+0x68>
    80003b14:	01f7f713          	andi	a4,a5,31
    80003b18:	00e806b3          	add	a3,a6,a4
    80003b1c:	0055c703          	lbu	a4,5(a1)
    80003b20:	00178793          	addi	a5,a5,1
    80003b24:	02077713          	andi	a4,a4,32
    80003b28:	fc071ae3          	bnez	a4,80003afc <uartstart+0x38>
    80003b2c:	00813403          	ld	s0,8(sp)
    80003b30:	01010113          	addi	sp,sp,16
    80003b34:	00008067          	ret

0000000080003b38 <uartgetc>:
    80003b38:	ff010113          	addi	sp,sp,-16
    80003b3c:	00813423          	sd	s0,8(sp)
    80003b40:	01010413          	addi	s0,sp,16
    80003b44:	10000737          	lui	a4,0x10000
    80003b48:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80003b4c:	0017f793          	andi	a5,a5,1
    80003b50:	00078c63          	beqz	a5,80003b68 <uartgetc+0x30>
    80003b54:	00074503          	lbu	a0,0(a4)
    80003b58:	0ff57513          	andi	a0,a0,255
    80003b5c:	00813403          	ld	s0,8(sp)
    80003b60:	01010113          	addi	sp,sp,16
    80003b64:	00008067          	ret
    80003b68:	fff00513          	li	a0,-1
    80003b6c:	ff1ff06f          	j	80003b5c <uartgetc+0x24>

0000000080003b70 <uartintr>:
    80003b70:	100007b7          	lui	a5,0x10000
    80003b74:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003b78:	0017f793          	andi	a5,a5,1
    80003b7c:	0a078463          	beqz	a5,80003c24 <uartintr+0xb4>
    80003b80:	fe010113          	addi	sp,sp,-32
    80003b84:	00813823          	sd	s0,16(sp)
    80003b88:	00913423          	sd	s1,8(sp)
    80003b8c:	00113c23          	sd	ra,24(sp)
    80003b90:	02010413          	addi	s0,sp,32
    80003b94:	100004b7          	lui	s1,0x10000
    80003b98:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80003b9c:	0ff57513          	andi	a0,a0,255
    80003ba0:	fffff097          	auipc	ra,0xfffff
    80003ba4:	534080e7          	jalr	1332(ra) # 800030d4 <consoleintr>
    80003ba8:	0054c783          	lbu	a5,5(s1)
    80003bac:	0017f793          	andi	a5,a5,1
    80003bb0:	fe0794e3          	bnez	a5,80003b98 <uartintr+0x28>
    80003bb4:	00002617          	auipc	a2,0x2
    80003bb8:	0f460613          	addi	a2,a2,244 # 80005ca8 <uart_tx_r>
    80003bbc:	00002517          	auipc	a0,0x2
    80003bc0:	0f450513          	addi	a0,a0,244 # 80005cb0 <uart_tx_w>
    80003bc4:	00063783          	ld	a5,0(a2)
    80003bc8:	00053703          	ld	a4,0(a0)
    80003bcc:	04f70263          	beq	a4,a5,80003c10 <uartintr+0xa0>
    80003bd0:	100005b7          	lui	a1,0x10000
    80003bd4:	00003817          	auipc	a6,0x3
    80003bd8:	34c80813          	addi	a6,a6,844 # 80006f20 <uart_tx_buf>
    80003bdc:	01c0006f          	j	80003bf8 <uartintr+0x88>
    80003be0:	0006c703          	lbu	a4,0(a3)
    80003be4:	00f63023          	sd	a5,0(a2)
    80003be8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003bec:	00063783          	ld	a5,0(a2)
    80003bf0:	00053703          	ld	a4,0(a0)
    80003bf4:	00f70e63          	beq	a4,a5,80003c10 <uartintr+0xa0>
    80003bf8:	01f7f713          	andi	a4,a5,31
    80003bfc:	00e806b3          	add	a3,a6,a4
    80003c00:	0055c703          	lbu	a4,5(a1)
    80003c04:	00178793          	addi	a5,a5,1
    80003c08:	02077713          	andi	a4,a4,32
    80003c0c:	fc071ae3          	bnez	a4,80003be0 <uartintr+0x70>
    80003c10:	01813083          	ld	ra,24(sp)
    80003c14:	01013403          	ld	s0,16(sp)
    80003c18:	00813483          	ld	s1,8(sp)
    80003c1c:	02010113          	addi	sp,sp,32
    80003c20:	00008067          	ret
    80003c24:	00002617          	auipc	a2,0x2
    80003c28:	08460613          	addi	a2,a2,132 # 80005ca8 <uart_tx_r>
    80003c2c:	00002517          	auipc	a0,0x2
    80003c30:	08450513          	addi	a0,a0,132 # 80005cb0 <uart_tx_w>
    80003c34:	00063783          	ld	a5,0(a2)
    80003c38:	00053703          	ld	a4,0(a0)
    80003c3c:	04f70263          	beq	a4,a5,80003c80 <uartintr+0x110>
    80003c40:	100005b7          	lui	a1,0x10000
    80003c44:	00003817          	auipc	a6,0x3
    80003c48:	2dc80813          	addi	a6,a6,732 # 80006f20 <uart_tx_buf>
    80003c4c:	01c0006f          	j	80003c68 <uartintr+0xf8>
    80003c50:	0006c703          	lbu	a4,0(a3)
    80003c54:	00f63023          	sd	a5,0(a2)
    80003c58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003c5c:	00063783          	ld	a5,0(a2)
    80003c60:	00053703          	ld	a4,0(a0)
    80003c64:	02f70063          	beq	a4,a5,80003c84 <uartintr+0x114>
    80003c68:	01f7f713          	andi	a4,a5,31
    80003c6c:	00e806b3          	add	a3,a6,a4
    80003c70:	0055c703          	lbu	a4,5(a1)
    80003c74:	00178793          	addi	a5,a5,1
    80003c78:	02077713          	andi	a4,a4,32
    80003c7c:	fc071ae3          	bnez	a4,80003c50 <uartintr+0xe0>
    80003c80:	00008067          	ret
    80003c84:	00008067          	ret

0000000080003c88 <kinit>:
    80003c88:	fc010113          	addi	sp,sp,-64
    80003c8c:	02913423          	sd	s1,40(sp)
    80003c90:	fffff7b7          	lui	a5,0xfffff
    80003c94:	00004497          	auipc	s1,0x4
    80003c98:	2bb48493          	addi	s1,s1,699 # 80007f4f <end+0xfff>
    80003c9c:	02813823          	sd	s0,48(sp)
    80003ca0:	01313c23          	sd	s3,24(sp)
    80003ca4:	00f4f4b3          	and	s1,s1,a5
    80003ca8:	02113c23          	sd	ra,56(sp)
    80003cac:	03213023          	sd	s2,32(sp)
    80003cb0:	01413823          	sd	s4,16(sp)
    80003cb4:	01513423          	sd	s5,8(sp)
    80003cb8:	04010413          	addi	s0,sp,64
    80003cbc:	000017b7          	lui	a5,0x1
    80003cc0:	01100993          	li	s3,17
    80003cc4:	00f487b3          	add	a5,s1,a5
    80003cc8:	01b99993          	slli	s3,s3,0x1b
    80003ccc:	06f9e063          	bltu	s3,a5,80003d2c <kinit+0xa4>
    80003cd0:	00003a97          	auipc	s5,0x3
    80003cd4:	280a8a93          	addi	s5,s5,640 # 80006f50 <end>
    80003cd8:	0754ec63          	bltu	s1,s5,80003d50 <kinit+0xc8>
    80003cdc:	0734fa63          	bgeu	s1,s3,80003d50 <kinit+0xc8>
    80003ce0:	00088a37          	lui	s4,0x88
    80003ce4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003ce8:	00002917          	auipc	s2,0x2
    80003cec:	fd090913          	addi	s2,s2,-48 # 80005cb8 <kmem>
    80003cf0:	00ca1a13          	slli	s4,s4,0xc
    80003cf4:	0140006f          	j	80003d08 <kinit+0x80>
    80003cf8:	000017b7          	lui	a5,0x1
    80003cfc:	00f484b3          	add	s1,s1,a5
    80003d00:	0554e863          	bltu	s1,s5,80003d50 <kinit+0xc8>
    80003d04:	0534f663          	bgeu	s1,s3,80003d50 <kinit+0xc8>
    80003d08:	00001637          	lui	a2,0x1
    80003d0c:	00100593          	li	a1,1
    80003d10:	00048513          	mv	a0,s1
    80003d14:	00000097          	auipc	ra,0x0
    80003d18:	5e4080e7          	jalr	1508(ra) # 800042f8 <__memset>
    80003d1c:	00093783          	ld	a5,0(s2)
    80003d20:	00f4b023          	sd	a5,0(s1)
    80003d24:	00993023          	sd	s1,0(s2)
    80003d28:	fd4498e3          	bne	s1,s4,80003cf8 <kinit+0x70>
    80003d2c:	03813083          	ld	ra,56(sp)
    80003d30:	03013403          	ld	s0,48(sp)
    80003d34:	02813483          	ld	s1,40(sp)
    80003d38:	02013903          	ld	s2,32(sp)
    80003d3c:	01813983          	ld	s3,24(sp)
    80003d40:	01013a03          	ld	s4,16(sp)
    80003d44:	00813a83          	ld	s5,8(sp)
    80003d48:	04010113          	addi	sp,sp,64
    80003d4c:	00008067          	ret
    80003d50:	00001517          	auipc	a0,0x1
    80003d54:	78850513          	addi	a0,a0,1928 # 800054d8 <digits+0x18>
    80003d58:	fffff097          	auipc	ra,0xfffff
    80003d5c:	4b4080e7          	jalr	1204(ra) # 8000320c <panic>

0000000080003d60 <freerange>:
    80003d60:	fc010113          	addi	sp,sp,-64
    80003d64:	000017b7          	lui	a5,0x1
    80003d68:	02913423          	sd	s1,40(sp)
    80003d6c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003d70:	009504b3          	add	s1,a0,s1
    80003d74:	fffff537          	lui	a0,0xfffff
    80003d78:	02813823          	sd	s0,48(sp)
    80003d7c:	02113c23          	sd	ra,56(sp)
    80003d80:	03213023          	sd	s2,32(sp)
    80003d84:	01313c23          	sd	s3,24(sp)
    80003d88:	01413823          	sd	s4,16(sp)
    80003d8c:	01513423          	sd	s5,8(sp)
    80003d90:	01613023          	sd	s6,0(sp)
    80003d94:	04010413          	addi	s0,sp,64
    80003d98:	00a4f4b3          	and	s1,s1,a0
    80003d9c:	00f487b3          	add	a5,s1,a5
    80003da0:	06f5e463          	bltu	a1,a5,80003e08 <freerange+0xa8>
    80003da4:	00003a97          	auipc	s5,0x3
    80003da8:	1aca8a93          	addi	s5,s5,428 # 80006f50 <end>
    80003dac:	0954e263          	bltu	s1,s5,80003e30 <freerange+0xd0>
    80003db0:	01100993          	li	s3,17
    80003db4:	01b99993          	slli	s3,s3,0x1b
    80003db8:	0734fc63          	bgeu	s1,s3,80003e30 <freerange+0xd0>
    80003dbc:	00058a13          	mv	s4,a1
    80003dc0:	00002917          	auipc	s2,0x2
    80003dc4:	ef890913          	addi	s2,s2,-264 # 80005cb8 <kmem>
    80003dc8:	00002b37          	lui	s6,0x2
    80003dcc:	0140006f          	j	80003de0 <freerange+0x80>
    80003dd0:	000017b7          	lui	a5,0x1
    80003dd4:	00f484b3          	add	s1,s1,a5
    80003dd8:	0554ec63          	bltu	s1,s5,80003e30 <freerange+0xd0>
    80003ddc:	0534fa63          	bgeu	s1,s3,80003e30 <freerange+0xd0>
    80003de0:	00001637          	lui	a2,0x1
    80003de4:	00100593          	li	a1,1
    80003de8:	00048513          	mv	a0,s1
    80003dec:	00000097          	auipc	ra,0x0
    80003df0:	50c080e7          	jalr	1292(ra) # 800042f8 <__memset>
    80003df4:	00093703          	ld	a4,0(s2)
    80003df8:	016487b3          	add	a5,s1,s6
    80003dfc:	00e4b023          	sd	a4,0(s1)
    80003e00:	00993023          	sd	s1,0(s2)
    80003e04:	fcfa76e3          	bgeu	s4,a5,80003dd0 <freerange+0x70>
    80003e08:	03813083          	ld	ra,56(sp)
    80003e0c:	03013403          	ld	s0,48(sp)
    80003e10:	02813483          	ld	s1,40(sp)
    80003e14:	02013903          	ld	s2,32(sp)
    80003e18:	01813983          	ld	s3,24(sp)
    80003e1c:	01013a03          	ld	s4,16(sp)
    80003e20:	00813a83          	ld	s5,8(sp)
    80003e24:	00013b03          	ld	s6,0(sp)
    80003e28:	04010113          	addi	sp,sp,64
    80003e2c:	00008067          	ret
    80003e30:	00001517          	auipc	a0,0x1
    80003e34:	6a850513          	addi	a0,a0,1704 # 800054d8 <digits+0x18>
    80003e38:	fffff097          	auipc	ra,0xfffff
    80003e3c:	3d4080e7          	jalr	980(ra) # 8000320c <panic>

0000000080003e40 <kfree>:
    80003e40:	fe010113          	addi	sp,sp,-32
    80003e44:	00813823          	sd	s0,16(sp)
    80003e48:	00113c23          	sd	ra,24(sp)
    80003e4c:	00913423          	sd	s1,8(sp)
    80003e50:	02010413          	addi	s0,sp,32
    80003e54:	03451793          	slli	a5,a0,0x34
    80003e58:	04079c63          	bnez	a5,80003eb0 <kfree+0x70>
    80003e5c:	00003797          	auipc	a5,0x3
    80003e60:	0f478793          	addi	a5,a5,244 # 80006f50 <end>
    80003e64:	00050493          	mv	s1,a0
    80003e68:	04f56463          	bltu	a0,a5,80003eb0 <kfree+0x70>
    80003e6c:	01100793          	li	a5,17
    80003e70:	01b79793          	slli	a5,a5,0x1b
    80003e74:	02f57e63          	bgeu	a0,a5,80003eb0 <kfree+0x70>
    80003e78:	00001637          	lui	a2,0x1
    80003e7c:	00100593          	li	a1,1
    80003e80:	00000097          	auipc	ra,0x0
    80003e84:	478080e7          	jalr	1144(ra) # 800042f8 <__memset>
    80003e88:	00002797          	auipc	a5,0x2
    80003e8c:	e3078793          	addi	a5,a5,-464 # 80005cb8 <kmem>
    80003e90:	0007b703          	ld	a4,0(a5)
    80003e94:	01813083          	ld	ra,24(sp)
    80003e98:	01013403          	ld	s0,16(sp)
    80003e9c:	00e4b023          	sd	a4,0(s1)
    80003ea0:	0097b023          	sd	s1,0(a5)
    80003ea4:	00813483          	ld	s1,8(sp)
    80003ea8:	02010113          	addi	sp,sp,32
    80003eac:	00008067          	ret
    80003eb0:	00001517          	auipc	a0,0x1
    80003eb4:	62850513          	addi	a0,a0,1576 # 800054d8 <digits+0x18>
    80003eb8:	fffff097          	auipc	ra,0xfffff
    80003ebc:	354080e7          	jalr	852(ra) # 8000320c <panic>

0000000080003ec0 <kalloc>:
    80003ec0:	fe010113          	addi	sp,sp,-32
    80003ec4:	00813823          	sd	s0,16(sp)
    80003ec8:	00913423          	sd	s1,8(sp)
    80003ecc:	00113c23          	sd	ra,24(sp)
    80003ed0:	02010413          	addi	s0,sp,32
    80003ed4:	00002797          	auipc	a5,0x2
    80003ed8:	de478793          	addi	a5,a5,-540 # 80005cb8 <kmem>
    80003edc:	0007b483          	ld	s1,0(a5)
    80003ee0:	02048063          	beqz	s1,80003f00 <kalloc+0x40>
    80003ee4:	0004b703          	ld	a4,0(s1)
    80003ee8:	00001637          	lui	a2,0x1
    80003eec:	00500593          	li	a1,5
    80003ef0:	00048513          	mv	a0,s1
    80003ef4:	00e7b023          	sd	a4,0(a5)
    80003ef8:	00000097          	auipc	ra,0x0
    80003efc:	400080e7          	jalr	1024(ra) # 800042f8 <__memset>
    80003f00:	01813083          	ld	ra,24(sp)
    80003f04:	01013403          	ld	s0,16(sp)
    80003f08:	00048513          	mv	a0,s1
    80003f0c:	00813483          	ld	s1,8(sp)
    80003f10:	02010113          	addi	sp,sp,32
    80003f14:	00008067          	ret

0000000080003f18 <initlock>:
    80003f18:	ff010113          	addi	sp,sp,-16
    80003f1c:	00813423          	sd	s0,8(sp)
    80003f20:	01010413          	addi	s0,sp,16
    80003f24:	00813403          	ld	s0,8(sp)
    80003f28:	00b53423          	sd	a1,8(a0)
    80003f2c:	00052023          	sw	zero,0(a0)
    80003f30:	00053823          	sd	zero,16(a0)
    80003f34:	01010113          	addi	sp,sp,16
    80003f38:	00008067          	ret

0000000080003f3c <acquire>:
    80003f3c:	fe010113          	addi	sp,sp,-32
    80003f40:	00813823          	sd	s0,16(sp)
    80003f44:	00913423          	sd	s1,8(sp)
    80003f48:	00113c23          	sd	ra,24(sp)
    80003f4c:	01213023          	sd	s2,0(sp)
    80003f50:	02010413          	addi	s0,sp,32
    80003f54:	00050493          	mv	s1,a0
    80003f58:	10002973          	csrr	s2,sstatus
    80003f5c:	100027f3          	csrr	a5,sstatus
    80003f60:	ffd7f793          	andi	a5,a5,-3
    80003f64:	10079073          	csrw	sstatus,a5
    80003f68:	fffff097          	auipc	ra,0xfffff
    80003f6c:	8e8080e7          	jalr	-1816(ra) # 80002850 <mycpu>
    80003f70:	07852783          	lw	a5,120(a0)
    80003f74:	06078e63          	beqz	a5,80003ff0 <acquire+0xb4>
    80003f78:	fffff097          	auipc	ra,0xfffff
    80003f7c:	8d8080e7          	jalr	-1832(ra) # 80002850 <mycpu>
    80003f80:	07852783          	lw	a5,120(a0)
    80003f84:	0004a703          	lw	a4,0(s1)
    80003f88:	0017879b          	addiw	a5,a5,1
    80003f8c:	06f52c23          	sw	a5,120(a0)
    80003f90:	04071063          	bnez	a4,80003fd0 <acquire+0x94>
    80003f94:	00100713          	li	a4,1
    80003f98:	00070793          	mv	a5,a4
    80003f9c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003fa0:	0007879b          	sext.w	a5,a5
    80003fa4:	fe079ae3          	bnez	a5,80003f98 <acquire+0x5c>
    80003fa8:	0ff0000f          	fence
    80003fac:	fffff097          	auipc	ra,0xfffff
    80003fb0:	8a4080e7          	jalr	-1884(ra) # 80002850 <mycpu>
    80003fb4:	01813083          	ld	ra,24(sp)
    80003fb8:	01013403          	ld	s0,16(sp)
    80003fbc:	00a4b823          	sd	a0,16(s1)
    80003fc0:	00013903          	ld	s2,0(sp)
    80003fc4:	00813483          	ld	s1,8(sp)
    80003fc8:	02010113          	addi	sp,sp,32
    80003fcc:	00008067          	ret
    80003fd0:	0104b903          	ld	s2,16(s1)
    80003fd4:	fffff097          	auipc	ra,0xfffff
    80003fd8:	87c080e7          	jalr	-1924(ra) # 80002850 <mycpu>
    80003fdc:	faa91ce3          	bne	s2,a0,80003f94 <acquire+0x58>
    80003fe0:	00001517          	auipc	a0,0x1
    80003fe4:	50050513          	addi	a0,a0,1280 # 800054e0 <digits+0x20>
    80003fe8:	fffff097          	auipc	ra,0xfffff
    80003fec:	224080e7          	jalr	548(ra) # 8000320c <panic>
    80003ff0:	00195913          	srli	s2,s2,0x1
    80003ff4:	fffff097          	auipc	ra,0xfffff
    80003ff8:	85c080e7          	jalr	-1956(ra) # 80002850 <mycpu>
    80003ffc:	00197913          	andi	s2,s2,1
    80004000:	07252e23          	sw	s2,124(a0)
    80004004:	f75ff06f          	j	80003f78 <acquire+0x3c>

0000000080004008 <release>:
    80004008:	fe010113          	addi	sp,sp,-32
    8000400c:	00813823          	sd	s0,16(sp)
    80004010:	00113c23          	sd	ra,24(sp)
    80004014:	00913423          	sd	s1,8(sp)
    80004018:	01213023          	sd	s2,0(sp)
    8000401c:	02010413          	addi	s0,sp,32
    80004020:	00052783          	lw	a5,0(a0)
    80004024:	00079a63          	bnez	a5,80004038 <release+0x30>
    80004028:	00001517          	auipc	a0,0x1
    8000402c:	4c050513          	addi	a0,a0,1216 # 800054e8 <digits+0x28>
    80004030:	fffff097          	auipc	ra,0xfffff
    80004034:	1dc080e7          	jalr	476(ra) # 8000320c <panic>
    80004038:	01053903          	ld	s2,16(a0)
    8000403c:	00050493          	mv	s1,a0
    80004040:	fffff097          	auipc	ra,0xfffff
    80004044:	810080e7          	jalr	-2032(ra) # 80002850 <mycpu>
    80004048:	fea910e3          	bne	s2,a0,80004028 <release+0x20>
    8000404c:	0004b823          	sd	zero,16(s1)
    80004050:	0ff0000f          	fence
    80004054:	0f50000f          	fence	iorw,ow
    80004058:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000405c:	ffffe097          	auipc	ra,0xffffe
    80004060:	7f4080e7          	jalr	2036(ra) # 80002850 <mycpu>
    80004064:	100027f3          	csrr	a5,sstatus
    80004068:	0027f793          	andi	a5,a5,2
    8000406c:	04079a63          	bnez	a5,800040c0 <release+0xb8>
    80004070:	07852783          	lw	a5,120(a0)
    80004074:	02f05e63          	blez	a5,800040b0 <release+0xa8>
    80004078:	fff7871b          	addiw	a4,a5,-1
    8000407c:	06e52c23          	sw	a4,120(a0)
    80004080:	00071c63          	bnez	a4,80004098 <release+0x90>
    80004084:	07c52783          	lw	a5,124(a0)
    80004088:	00078863          	beqz	a5,80004098 <release+0x90>
    8000408c:	100027f3          	csrr	a5,sstatus
    80004090:	0027e793          	ori	a5,a5,2
    80004094:	10079073          	csrw	sstatus,a5
    80004098:	01813083          	ld	ra,24(sp)
    8000409c:	01013403          	ld	s0,16(sp)
    800040a0:	00813483          	ld	s1,8(sp)
    800040a4:	00013903          	ld	s2,0(sp)
    800040a8:	02010113          	addi	sp,sp,32
    800040ac:	00008067          	ret
    800040b0:	00001517          	auipc	a0,0x1
    800040b4:	45850513          	addi	a0,a0,1112 # 80005508 <digits+0x48>
    800040b8:	fffff097          	auipc	ra,0xfffff
    800040bc:	154080e7          	jalr	340(ra) # 8000320c <panic>
    800040c0:	00001517          	auipc	a0,0x1
    800040c4:	43050513          	addi	a0,a0,1072 # 800054f0 <digits+0x30>
    800040c8:	fffff097          	auipc	ra,0xfffff
    800040cc:	144080e7          	jalr	324(ra) # 8000320c <panic>

00000000800040d0 <holding>:
    800040d0:	00052783          	lw	a5,0(a0)
    800040d4:	00079663          	bnez	a5,800040e0 <holding+0x10>
    800040d8:	00000513          	li	a0,0
    800040dc:	00008067          	ret
    800040e0:	fe010113          	addi	sp,sp,-32
    800040e4:	00813823          	sd	s0,16(sp)
    800040e8:	00913423          	sd	s1,8(sp)
    800040ec:	00113c23          	sd	ra,24(sp)
    800040f0:	02010413          	addi	s0,sp,32
    800040f4:	01053483          	ld	s1,16(a0)
    800040f8:	ffffe097          	auipc	ra,0xffffe
    800040fc:	758080e7          	jalr	1880(ra) # 80002850 <mycpu>
    80004100:	01813083          	ld	ra,24(sp)
    80004104:	01013403          	ld	s0,16(sp)
    80004108:	40a48533          	sub	a0,s1,a0
    8000410c:	00153513          	seqz	a0,a0
    80004110:	00813483          	ld	s1,8(sp)
    80004114:	02010113          	addi	sp,sp,32
    80004118:	00008067          	ret

000000008000411c <push_off>:
    8000411c:	fe010113          	addi	sp,sp,-32
    80004120:	00813823          	sd	s0,16(sp)
    80004124:	00113c23          	sd	ra,24(sp)
    80004128:	00913423          	sd	s1,8(sp)
    8000412c:	02010413          	addi	s0,sp,32
    80004130:	100024f3          	csrr	s1,sstatus
    80004134:	100027f3          	csrr	a5,sstatus
    80004138:	ffd7f793          	andi	a5,a5,-3
    8000413c:	10079073          	csrw	sstatus,a5
    80004140:	ffffe097          	auipc	ra,0xffffe
    80004144:	710080e7          	jalr	1808(ra) # 80002850 <mycpu>
    80004148:	07852783          	lw	a5,120(a0)
    8000414c:	02078663          	beqz	a5,80004178 <push_off+0x5c>
    80004150:	ffffe097          	auipc	ra,0xffffe
    80004154:	700080e7          	jalr	1792(ra) # 80002850 <mycpu>
    80004158:	07852783          	lw	a5,120(a0)
    8000415c:	01813083          	ld	ra,24(sp)
    80004160:	01013403          	ld	s0,16(sp)
    80004164:	0017879b          	addiw	a5,a5,1
    80004168:	06f52c23          	sw	a5,120(a0)
    8000416c:	00813483          	ld	s1,8(sp)
    80004170:	02010113          	addi	sp,sp,32
    80004174:	00008067          	ret
    80004178:	0014d493          	srli	s1,s1,0x1
    8000417c:	ffffe097          	auipc	ra,0xffffe
    80004180:	6d4080e7          	jalr	1748(ra) # 80002850 <mycpu>
    80004184:	0014f493          	andi	s1,s1,1
    80004188:	06952e23          	sw	s1,124(a0)
    8000418c:	fc5ff06f          	j	80004150 <push_off+0x34>

0000000080004190 <pop_off>:
    80004190:	ff010113          	addi	sp,sp,-16
    80004194:	00813023          	sd	s0,0(sp)
    80004198:	00113423          	sd	ra,8(sp)
    8000419c:	01010413          	addi	s0,sp,16
    800041a0:	ffffe097          	auipc	ra,0xffffe
    800041a4:	6b0080e7          	jalr	1712(ra) # 80002850 <mycpu>
    800041a8:	100027f3          	csrr	a5,sstatus
    800041ac:	0027f793          	andi	a5,a5,2
    800041b0:	04079663          	bnez	a5,800041fc <pop_off+0x6c>
    800041b4:	07852783          	lw	a5,120(a0)
    800041b8:	02f05a63          	blez	a5,800041ec <pop_off+0x5c>
    800041bc:	fff7871b          	addiw	a4,a5,-1
    800041c0:	06e52c23          	sw	a4,120(a0)
    800041c4:	00071c63          	bnez	a4,800041dc <pop_off+0x4c>
    800041c8:	07c52783          	lw	a5,124(a0)
    800041cc:	00078863          	beqz	a5,800041dc <pop_off+0x4c>
    800041d0:	100027f3          	csrr	a5,sstatus
    800041d4:	0027e793          	ori	a5,a5,2
    800041d8:	10079073          	csrw	sstatus,a5
    800041dc:	00813083          	ld	ra,8(sp)
    800041e0:	00013403          	ld	s0,0(sp)
    800041e4:	01010113          	addi	sp,sp,16
    800041e8:	00008067          	ret
    800041ec:	00001517          	auipc	a0,0x1
    800041f0:	31c50513          	addi	a0,a0,796 # 80005508 <digits+0x48>
    800041f4:	fffff097          	auipc	ra,0xfffff
    800041f8:	018080e7          	jalr	24(ra) # 8000320c <panic>
    800041fc:	00001517          	auipc	a0,0x1
    80004200:	2f450513          	addi	a0,a0,756 # 800054f0 <digits+0x30>
    80004204:	fffff097          	auipc	ra,0xfffff
    80004208:	008080e7          	jalr	8(ra) # 8000320c <panic>

000000008000420c <push_on>:
    8000420c:	fe010113          	addi	sp,sp,-32
    80004210:	00813823          	sd	s0,16(sp)
    80004214:	00113c23          	sd	ra,24(sp)
    80004218:	00913423          	sd	s1,8(sp)
    8000421c:	02010413          	addi	s0,sp,32
    80004220:	100024f3          	csrr	s1,sstatus
    80004224:	100027f3          	csrr	a5,sstatus
    80004228:	0027e793          	ori	a5,a5,2
    8000422c:	10079073          	csrw	sstatus,a5
    80004230:	ffffe097          	auipc	ra,0xffffe
    80004234:	620080e7          	jalr	1568(ra) # 80002850 <mycpu>
    80004238:	07852783          	lw	a5,120(a0)
    8000423c:	02078663          	beqz	a5,80004268 <push_on+0x5c>
    80004240:	ffffe097          	auipc	ra,0xffffe
    80004244:	610080e7          	jalr	1552(ra) # 80002850 <mycpu>
    80004248:	07852783          	lw	a5,120(a0)
    8000424c:	01813083          	ld	ra,24(sp)
    80004250:	01013403          	ld	s0,16(sp)
    80004254:	0017879b          	addiw	a5,a5,1
    80004258:	06f52c23          	sw	a5,120(a0)
    8000425c:	00813483          	ld	s1,8(sp)
    80004260:	02010113          	addi	sp,sp,32
    80004264:	00008067          	ret
    80004268:	0014d493          	srli	s1,s1,0x1
    8000426c:	ffffe097          	auipc	ra,0xffffe
    80004270:	5e4080e7          	jalr	1508(ra) # 80002850 <mycpu>
    80004274:	0014f493          	andi	s1,s1,1
    80004278:	06952e23          	sw	s1,124(a0)
    8000427c:	fc5ff06f          	j	80004240 <push_on+0x34>

0000000080004280 <pop_on>:
    80004280:	ff010113          	addi	sp,sp,-16
    80004284:	00813023          	sd	s0,0(sp)
    80004288:	00113423          	sd	ra,8(sp)
    8000428c:	01010413          	addi	s0,sp,16
    80004290:	ffffe097          	auipc	ra,0xffffe
    80004294:	5c0080e7          	jalr	1472(ra) # 80002850 <mycpu>
    80004298:	100027f3          	csrr	a5,sstatus
    8000429c:	0027f793          	andi	a5,a5,2
    800042a0:	04078463          	beqz	a5,800042e8 <pop_on+0x68>
    800042a4:	07852783          	lw	a5,120(a0)
    800042a8:	02f05863          	blez	a5,800042d8 <pop_on+0x58>
    800042ac:	fff7879b          	addiw	a5,a5,-1
    800042b0:	06f52c23          	sw	a5,120(a0)
    800042b4:	07853783          	ld	a5,120(a0)
    800042b8:	00079863          	bnez	a5,800042c8 <pop_on+0x48>
    800042bc:	100027f3          	csrr	a5,sstatus
    800042c0:	ffd7f793          	andi	a5,a5,-3
    800042c4:	10079073          	csrw	sstatus,a5
    800042c8:	00813083          	ld	ra,8(sp)
    800042cc:	00013403          	ld	s0,0(sp)
    800042d0:	01010113          	addi	sp,sp,16
    800042d4:	00008067          	ret
    800042d8:	00001517          	auipc	a0,0x1
    800042dc:	25850513          	addi	a0,a0,600 # 80005530 <digits+0x70>
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	f2c080e7          	jalr	-212(ra) # 8000320c <panic>
    800042e8:	00001517          	auipc	a0,0x1
    800042ec:	22850513          	addi	a0,a0,552 # 80005510 <digits+0x50>
    800042f0:	fffff097          	auipc	ra,0xfffff
    800042f4:	f1c080e7          	jalr	-228(ra) # 8000320c <panic>

00000000800042f8 <__memset>:
    800042f8:	ff010113          	addi	sp,sp,-16
    800042fc:	00813423          	sd	s0,8(sp)
    80004300:	01010413          	addi	s0,sp,16
    80004304:	1a060e63          	beqz	a2,800044c0 <__memset+0x1c8>
    80004308:	40a007b3          	neg	a5,a0
    8000430c:	0077f793          	andi	a5,a5,7
    80004310:	00778693          	addi	a3,a5,7
    80004314:	00b00813          	li	a6,11
    80004318:	0ff5f593          	andi	a1,a1,255
    8000431c:	fff6071b          	addiw	a4,a2,-1
    80004320:	1b06e663          	bltu	a3,a6,800044cc <__memset+0x1d4>
    80004324:	1cd76463          	bltu	a4,a3,800044ec <__memset+0x1f4>
    80004328:	1a078e63          	beqz	a5,800044e4 <__memset+0x1ec>
    8000432c:	00b50023          	sb	a1,0(a0)
    80004330:	00100713          	li	a4,1
    80004334:	1ae78463          	beq	a5,a4,800044dc <__memset+0x1e4>
    80004338:	00b500a3          	sb	a1,1(a0)
    8000433c:	00200713          	li	a4,2
    80004340:	1ae78a63          	beq	a5,a4,800044f4 <__memset+0x1fc>
    80004344:	00b50123          	sb	a1,2(a0)
    80004348:	00300713          	li	a4,3
    8000434c:	18e78463          	beq	a5,a4,800044d4 <__memset+0x1dc>
    80004350:	00b501a3          	sb	a1,3(a0)
    80004354:	00400713          	li	a4,4
    80004358:	1ae78263          	beq	a5,a4,800044fc <__memset+0x204>
    8000435c:	00b50223          	sb	a1,4(a0)
    80004360:	00500713          	li	a4,5
    80004364:	1ae78063          	beq	a5,a4,80004504 <__memset+0x20c>
    80004368:	00b502a3          	sb	a1,5(a0)
    8000436c:	00700713          	li	a4,7
    80004370:	18e79e63          	bne	a5,a4,8000450c <__memset+0x214>
    80004374:	00b50323          	sb	a1,6(a0)
    80004378:	00700e93          	li	t4,7
    8000437c:	00859713          	slli	a4,a1,0x8
    80004380:	00e5e733          	or	a4,a1,a4
    80004384:	01059e13          	slli	t3,a1,0x10
    80004388:	01c76e33          	or	t3,a4,t3
    8000438c:	01859313          	slli	t1,a1,0x18
    80004390:	006e6333          	or	t1,t3,t1
    80004394:	02059893          	slli	a7,a1,0x20
    80004398:	40f60e3b          	subw	t3,a2,a5
    8000439c:	011368b3          	or	a7,t1,a7
    800043a0:	02859813          	slli	a6,a1,0x28
    800043a4:	0108e833          	or	a6,a7,a6
    800043a8:	03059693          	slli	a3,a1,0x30
    800043ac:	003e589b          	srliw	a7,t3,0x3
    800043b0:	00d866b3          	or	a3,a6,a3
    800043b4:	03859713          	slli	a4,a1,0x38
    800043b8:	00389813          	slli	a6,a7,0x3
    800043bc:	00f507b3          	add	a5,a0,a5
    800043c0:	00e6e733          	or	a4,a3,a4
    800043c4:	000e089b          	sext.w	a7,t3
    800043c8:	00f806b3          	add	a3,a6,a5
    800043cc:	00e7b023          	sd	a4,0(a5)
    800043d0:	00878793          	addi	a5,a5,8
    800043d4:	fed79ce3          	bne	a5,a3,800043cc <__memset+0xd4>
    800043d8:	ff8e7793          	andi	a5,t3,-8
    800043dc:	0007871b          	sext.w	a4,a5
    800043e0:	01d787bb          	addw	a5,a5,t4
    800043e4:	0ce88e63          	beq	a7,a4,800044c0 <__memset+0x1c8>
    800043e8:	00f50733          	add	a4,a0,a5
    800043ec:	00b70023          	sb	a1,0(a4)
    800043f0:	0017871b          	addiw	a4,a5,1
    800043f4:	0cc77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    800043f8:	00e50733          	add	a4,a0,a4
    800043fc:	00b70023          	sb	a1,0(a4)
    80004400:	0027871b          	addiw	a4,a5,2
    80004404:	0ac77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004408:	00e50733          	add	a4,a0,a4
    8000440c:	00b70023          	sb	a1,0(a4)
    80004410:	0037871b          	addiw	a4,a5,3
    80004414:	0ac77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004418:	00e50733          	add	a4,a0,a4
    8000441c:	00b70023          	sb	a1,0(a4)
    80004420:	0047871b          	addiw	a4,a5,4
    80004424:	08c77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004428:	00e50733          	add	a4,a0,a4
    8000442c:	00b70023          	sb	a1,0(a4)
    80004430:	0057871b          	addiw	a4,a5,5
    80004434:	08c77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004438:	00e50733          	add	a4,a0,a4
    8000443c:	00b70023          	sb	a1,0(a4)
    80004440:	0067871b          	addiw	a4,a5,6
    80004444:	06c77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004448:	00e50733          	add	a4,a0,a4
    8000444c:	00b70023          	sb	a1,0(a4)
    80004450:	0077871b          	addiw	a4,a5,7
    80004454:	06c77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004458:	00e50733          	add	a4,a0,a4
    8000445c:	00b70023          	sb	a1,0(a4)
    80004460:	0087871b          	addiw	a4,a5,8
    80004464:	04c77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004468:	00e50733          	add	a4,a0,a4
    8000446c:	00b70023          	sb	a1,0(a4)
    80004470:	0097871b          	addiw	a4,a5,9
    80004474:	04c77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004478:	00e50733          	add	a4,a0,a4
    8000447c:	00b70023          	sb	a1,0(a4)
    80004480:	00a7871b          	addiw	a4,a5,10
    80004484:	02c77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004488:	00e50733          	add	a4,a0,a4
    8000448c:	00b70023          	sb	a1,0(a4)
    80004490:	00b7871b          	addiw	a4,a5,11
    80004494:	02c77663          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    80004498:	00e50733          	add	a4,a0,a4
    8000449c:	00b70023          	sb	a1,0(a4)
    800044a0:	00c7871b          	addiw	a4,a5,12
    800044a4:	00c77e63          	bgeu	a4,a2,800044c0 <__memset+0x1c8>
    800044a8:	00e50733          	add	a4,a0,a4
    800044ac:	00b70023          	sb	a1,0(a4)
    800044b0:	00d7879b          	addiw	a5,a5,13
    800044b4:	00c7f663          	bgeu	a5,a2,800044c0 <__memset+0x1c8>
    800044b8:	00f507b3          	add	a5,a0,a5
    800044bc:	00b78023          	sb	a1,0(a5)
    800044c0:	00813403          	ld	s0,8(sp)
    800044c4:	01010113          	addi	sp,sp,16
    800044c8:	00008067          	ret
    800044cc:	00b00693          	li	a3,11
    800044d0:	e55ff06f          	j	80004324 <__memset+0x2c>
    800044d4:	00300e93          	li	t4,3
    800044d8:	ea5ff06f          	j	8000437c <__memset+0x84>
    800044dc:	00100e93          	li	t4,1
    800044e0:	e9dff06f          	j	8000437c <__memset+0x84>
    800044e4:	00000e93          	li	t4,0
    800044e8:	e95ff06f          	j	8000437c <__memset+0x84>
    800044ec:	00000793          	li	a5,0
    800044f0:	ef9ff06f          	j	800043e8 <__memset+0xf0>
    800044f4:	00200e93          	li	t4,2
    800044f8:	e85ff06f          	j	8000437c <__memset+0x84>
    800044fc:	00400e93          	li	t4,4
    80004500:	e7dff06f          	j	8000437c <__memset+0x84>
    80004504:	00500e93          	li	t4,5
    80004508:	e75ff06f          	j	8000437c <__memset+0x84>
    8000450c:	00600e93          	li	t4,6
    80004510:	e6dff06f          	j	8000437c <__memset+0x84>

0000000080004514 <__memmove>:
    80004514:	ff010113          	addi	sp,sp,-16
    80004518:	00813423          	sd	s0,8(sp)
    8000451c:	01010413          	addi	s0,sp,16
    80004520:	0e060863          	beqz	a2,80004610 <__memmove+0xfc>
    80004524:	fff6069b          	addiw	a3,a2,-1
    80004528:	0006881b          	sext.w	a6,a3
    8000452c:	0ea5e863          	bltu	a1,a0,8000461c <__memmove+0x108>
    80004530:	00758713          	addi	a4,a1,7
    80004534:	00a5e7b3          	or	a5,a1,a0
    80004538:	40a70733          	sub	a4,a4,a0
    8000453c:	0077f793          	andi	a5,a5,7
    80004540:	00f73713          	sltiu	a4,a4,15
    80004544:	00174713          	xori	a4,a4,1
    80004548:	0017b793          	seqz	a5,a5
    8000454c:	00e7f7b3          	and	a5,a5,a4
    80004550:	10078863          	beqz	a5,80004660 <__memmove+0x14c>
    80004554:	00900793          	li	a5,9
    80004558:	1107f463          	bgeu	a5,a6,80004660 <__memmove+0x14c>
    8000455c:	0036581b          	srliw	a6,a2,0x3
    80004560:	fff8081b          	addiw	a6,a6,-1
    80004564:	02081813          	slli	a6,a6,0x20
    80004568:	01d85893          	srli	a7,a6,0x1d
    8000456c:	00858813          	addi	a6,a1,8
    80004570:	00058793          	mv	a5,a1
    80004574:	00050713          	mv	a4,a0
    80004578:	01088833          	add	a6,a7,a6
    8000457c:	0007b883          	ld	a7,0(a5)
    80004580:	00878793          	addi	a5,a5,8
    80004584:	00870713          	addi	a4,a4,8
    80004588:	ff173c23          	sd	a7,-8(a4)
    8000458c:	ff0798e3          	bne	a5,a6,8000457c <__memmove+0x68>
    80004590:	ff867713          	andi	a4,a2,-8
    80004594:	02071793          	slli	a5,a4,0x20
    80004598:	0207d793          	srli	a5,a5,0x20
    8000459c:	00f585b3          	add	a1,a1,a5
    800045a0:	40e686bb          	subw	a3,a3,a4
    800045a4:	00f507b3          	add	a5,a0,a5
    800045a8:	06e60463          	beq	a2,a4,80004610 <__memmove+0xfc>
    800045ac:	0005c703          	lbu	a4,0(a1)
    800045b0:	00e78023          	sb	a4,0(a5)
    800045b4:	04068e63          	beqz	a3,80004610 <__memmove+0xfc>
    800045b8:	0015c603          	lbu	a2,1(a1)
    800045bc:	00100713          	li	a4,1
    800045c0:	00c780a3          	sb	a2,1(a5)
    800045c4:	04e68663          	beq	a3,a4,80004610 <__memmove+0xfc>
    800045c8:	0025c603          	lbu	a2,2(a1)
    800045cc:	00200713          	li	a4,2
    800045d0:	00c78123          	sb	a2,2(a5)
    800045d4:	02e68e63          	beq	a3,a4,80004610 <__memmove+0xfc>
    800045d8:	0035c603          	lbu	a2,3(a1)
    800045dc:	00300713          	li	a4,3
    800045e0:	00c781a3          	sb	a2,3(a5)
    800045e4:	02e68663          	beq	a3,a4,80004610 <__memmove+0xfc>
    800045e8:	0045c603          	lbu	a2,4(a1)
    800045ec:	00400713          	li	a4,4
    800045f0:	00c78223          	sb	a2,4(a5)
    800045f4:	00e68e63          	beq	a3,a4,80004610 <__memmove+0xfc>
    800045f8:	0055c603          	lbu	a2,5(a1)
    800045fc:	00500713          	li	a4,5
    80004600:	00c782a3          	sb	a2,5(a5)
    80004604:	00e68663          	beq	a3,a4,80004610 <__memmove+0xfc>
    80004608:	0065c703          	lbu	a4,6(a1)
    8000460c:	00e78323          	sb	a4,6(a5)
    80004610:	00813403          	ld	s0,8(sp)
    80004614:	01010113          	addi	sp,sp,16
    80004618:	00008067          	ret
    8000461c:	02061713          	slli	a4,a2,0x20
    80004620:	02075713          	srli	a4,a4,0x20
    80004624:	00e587b3          	add	a5,a1,a4
    80004628:	f0f574e3          	bgeu	a0,a5,80004530 <__memmove+0x1c>
    8000462c:	02069613          	slli	a2,a3,0x20
    80004630:	02065613          	srli	a2,a2,0x20
    80004634:	fff64613          	not	a2,a2
    80004638:	00e50733          	add	a4,a0,a4
    8000463c:	00c78633          	add	a2,a5,a2
    80004640:	fff7c683          	lbu	a3,-1(a5)
    80004644:	fff78793          	addi	a5,a5,-1
    80004648:	fff70713          	addi	a4,a4,-1
    8000464c:	00d70023          	sb	a3,0(a4)
    80004650:	fec798e3          	bne	a5,a2,80004640 <__memmove+0x12c>
    80004654:	00813403          	ld	s0,8(sp)
    80004658:	01010113          	addi	sp,sp,16
    8000465c:	00008067          	ret
    80004660:	02069713          	slli	a4,a3,0x20
    80004664:	02075713          	srli	a4,a4,0x20
    80004668:	00170713          	addi	a4,a4,1
    8000466c:	00e50733          	add	a4,a0,a4
    80004670:	00050793          	mv	a5,a0
    80004674:	0005c683          	lbu	a3,0(a1)
    80004678:	00178793          	addi	a5,a5,1
    8000467c:	00158593          	addi	a1,a1,1
    80004680:	fed78fa3          	sb	a3,-1(a5)
    80004684:	fee798e3          	bne	a5,a4,80004674 <__memmove+0x160>
    80004688:	f89ff06f          	j	80004610 <__memmove+0xfc>

000000008000468c <__mem_free>:
    8000468c:	ff010113          	addi	sp,sp,-16
    80004690:	00813423          	sd	s0,8(sp)
    80004694:	01010413          	addi	s0,sp,16
    80004698:	00001597          	auipc	a1,0x1
    8000469c:	62858593          	addi	a1,a1,1576 # 80005cc0 <freep>
    800046a0:	0005b783          	ld	a5,0(a1)
    800046a4:	ff050693          	addi	a3,a0,-16
    800046a8:	0007b703          	ld	a4,0(a5)
    800046ac:	00d7fc63          	bgeu	a5,a3,800046c4 <__mem_free+0x38>
    800046b0:	00e6ee63          	bltu	a3,a4,800046cc <__mem_free+0x40>
    800046b4:	00e7fc63          	bgeu	a5,a4,800046cc <__mem_free+0x40>
    800046b8:	00070793          	mv	a5,a4
    800046bc:	0007b703          	ld	a4,0(a5)
    800046c0:	fed7e8e3          	bltu	a5,a3,800046b0 <__mem_free+0x24>
    800046c4:	fee7eae3          	bltu	a5,a4,800046b8 <__mem_free+0x2c>
    800046c8:	fee6f8e3          	bgeu	a3,a4,800046b8 <__mem_free+0x2c>
    800046cc:	ff852803          	lw	a6,-8(a0)
    800046d0:	02081613          	slli	a2,a6,0x20
    800046d4:	01c65613          	srli	a2,a2,0x1c
    800046d8:	00c68633          	add	a2,a3,a2
    800046dc:	02c70a63          	beq	a4,a2,80004710 <__mem_free+0x84>
    800046e0:	fee53823          	sd	a4,-16(a0)
    800046e4:	0087a503          	lw	a0,8(a5)
    800046e8:	02051613          	slli	a2,a0,0x20
    800046ec:	01c65613          	srli	a2,a2,0x1c
    800046f0:	00c78633          	add	a2,a5,a2
    800046f4:	04c68263          	beq	a3,a2,80004738 <__mem_free+0xac>
    800046f8:	00813403          	ld	s0,8(sp)
    800046fc:	00d7b023          	sd	a3,0(a5)
    80004700:	00f5b023          	sd	a5,0(a1)
    80004704:	00000513          	li	a0,0
    80004708:	01010113          	addi	sp,sp,16
    8000470c:	00008067          	ret
    80004710:	00872603          	lw	a2,8(a4)
    80004714:	00073703          	ld	a4,0(a4)
    80004718:	0106083b          	addw	a6,a2,a6
    8000471c:	ff052c23          	sw	a6,-8(a0)
    80004720:	fee53823          	sd	a4,-16(a0)
    80004724:	0087a503          	lw	a0,8(a5)
    80004728:	02051613          	slli	a2,a0,0x20
    8000472c:	01c65613          	srli	a2,a2,0x1c
    80004730:	00c78633          	add	a2,a5,a2
    80004734:	fcc692e3          	bne	a3,a2,800046f8 <__mem_free+0x6c>
    80004738:	00813403          	ld	s0,8(sp)
    8000473c:	0105053b          	addw	a0,a0,a6
    80004740:	00a7a423          	sw	a0,8(a5)
    80004744:	00e7b023          	sd	a4,0(a5)
    80004748:	00f5b023          	sd	a5,0(a1)
    8000474c:	00000513          	li	a0,0
    80004750:	01010113          	addi	sp,sp,16
    80004754:	00008067          	ret

0000000080004758 <__mem_alloc>:
    80004758:	fc010113          	addi	sp,sp,-64
    8000475c:	02813823          	sd	s0,48(sp)
    80004760:	02913423          	sd	s1,40(sp)
    80004764:	03213023          	sd	s2,32(sp)
    80004768:	01513423          	sd	s5,8(sp)
    8000476c:	02113c23          	sd	ra,56(sp)
    80004770:	01313c23          	sd	s3,24(sp)
    80004774:	01413823          	sd	s4,16(sp)
    80004778:	01613023          	sd	s6,0(sp)
    8000477c:	04010413          	addi	s0,sp,64
    80004780:	00001a97          	auipc	s5,0x1
    80004784:	540a8a93          	addi	s5,s5,1344 # 80005cc0 <freep>
    80004788:	00f50913          	addi	s2,a0,15
    8000478c:	000ab683          	ld	a3,0(s5)
    80004790:	00495913          	srli	s2,s2,0x4
    80004794:	0019049b          	addiw	s1,s2,1
    80004798:	00048913          	mv	s2,s1
    8000479c:	0c068c63          	beqz	a3,80004874 <__mem_alloc+0x11c>
    800047a0:	0006b503          	ld	a0,0(a3)
    800047a4:	00852703          	lw	a4,8(a0)
    800047a8:	10977063          	bgeu	a4,s1,800048a8 <__mem_alloc+0x150>
    800047ac:	000017b7          	lui	a5,0x1
    800047b0:	0009099b          	sext.w	s3,s2
    800047b4:	0af4e863          	bltu	s1,a5,80004864 <__mem_alloc+0x10c>
    800047b8:	02099a13          	slli	s4,s3,0x20
    800047bc:	01ca5a13          	srli	s4,s4,0x1c
    800047c0:	fff00b13          	li	s6,-1
    800047c4:	0100006f          	j	800047d4 <__mem_alloc+0x7c>
    800047c8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    800047cc:	00852703          	lw	a4,8(a0)
    800047d0:	04977463          	bgeu	a4,s1,80004818 <__mem_alloc+0xc0>
    800047d4:	00050793          	mv	a5,a0
    800047d8:	fea698e3          	bne	a3,a0,800047c8 <__mem_alloc+0x70>
    800047dc:	000a0513          	mv	a0,s4
    800047e0:	00000097          	auipc	ra,0x0
    800047e4:	1f0080e7          	jalr	496(ra) # 800049d0 <kvmincrease>
    800047e8:	00050793          	mv	a5,a0
    800047ec:	01050513          	addi	a0,a0,16
    800047f0:	07678e63          	beq	a5,s6,8000486c <__mem_alloc+0x114>
    800047f4:	0137a423          	sw	s3,8(a5)
    800047f8:	00000097          	auipc	ra,0x0
    800047fc:	e94080e7          	jalr	-364(ra) # 8000468c <__mem_free>
    80004800:	000ab783          	ld	a5,0(s5)
    80004804:	06078463          	beqz	a5,8000486c <__mem_alloc+0x114>
    80004808:	0007b503          	ld	a0,0(a5)
    8000480c:	00078693          	mv	a3,a5
    80004810:	00852703          	lw	a4,8(a0)
    80004814:	fc9760e3          	bltu	a4,s1,800047d4 <__mem_alloc+0x7c>
    80004818:	08e48263          	beq	s1,a4,8000489c <__mem_alloc+0x144>
    8000481c:	4127073b          	subw	a4,a4,s2
    80004820:	02071693          	slli	a3,a4,0x20
    80004824:	01c6d693          	srli	a3,a3,0x1c
    80004828:	00e52423          	sw	a4,8(a0)
    8000482c:	00d50533          	add	a0,a0,a3
    80004830:	01252423          	sw	s2,8(a0)
    80004834:	00fab023          	sd	a5,0(s5)
    80004838:	01050513          	addi	a0,a0,16
    8000483c:	03813083          	ld	ra,56(sp)
    80004840:	03013403          	ld	s0,48(sp)
    80004844:	02813483          	ld	s1,40(sp)
    80004848:	02013903          	ld	s2,32(sp)
    8000484c:	01813983          	ld	s3,24(sp)
    80004850:	01013a03          	ld	s4,16(sp)
    80004854:	00813a83          	ld	s5,8(sp)
    80004858:	00013b03          	ld	s6,0(sp)
    8000485c:	04010113          	addi	sp,sp,64
    80004860:	00008067          	ret
    80004864:	000019b7          	lui	s3,0x1
    80004868:	f51ff06f          	j	800047b8 <__mem_alloc+0x60>
    8000486c:	00000513          	li	a0,0
    80004870:	fcdff06f          	j	8000483c <__mem_alloc+0xe4>
    80004874:	00002797          	auipc	a5,0x2
    80004878:	6cc78793          	addi	a5,a5,1740 # 80006f40 <base>
    8000487c:	00078513          	mv	a0,a5
    80004880:	00fab023          	sd	a5,0(s5)
    80004884:	00f7b023          	sd	a5,0(a5)
    80004888:	00000713          	li	a4,0
    8000488c:	00002797          	auipc	a5,0x2
    80004890:	6a07ae23          	sw	zero,1724(a5) # 80006f48 <base+0x8>
    80004894:	00050693          	mv	a3,a0
    80004898:	f11ff06f          	j	800047a8 <__mem_alloc+0x50>
    8000489c:	00053703          	ld	a4,0(a0)
    800048a0:	00e7b023          	sd	a4,0(a5)
    800048a4:	f91ff06f          	j	80004834 <__mem_alloc+0xdc>
    800048a8:	00068793          	mv	a5,a3
    800048ac:	f6dff06f          	j	80004818 <__mem_alloc+0xc0>

00000000800048b0 <__putc>:
    800048b0:	fe010113          	addi	sp,sp,-32
    800048b4:	00813823          	sd	s0,16(sp)
    800048b8:	00113c23          	sd	ra,24(sp)
    800048bc:	02010413          	addi	s0,sp,32
    800048c0:	00050793          	mv	a5,a0
    800048c4:	fef40593          	addi	a1,s0,-17
    800048c8:	00100613          	li	a2,1
    800048cc:	00000513          	li	a0,0
    800048d0:	fef407a3          	sb	a5,-17(s0)
    800048d4:	fffff097          	auipc	ra,0xfffff
    800048d8:	918080e7          	jalr	-1768(ra) # 800031ec <console_write>
    800048dc:	01813083          	ld	ra,24(sp)
    800048e0:	01013403          	ld	s0,16(sp)
    800048e4:	02010113          	addi	sp,sp,32
    800048e8:	00008067          	ret

00000000800048ec <__getc>:
    800048ec:	fe010113          	addi	sp,sp,-32
    800048f0:	00813823          	sd	s0,16(sp)
    800048f4:	00113c23          	sd	ra,24(sp)
    800048f8:	02010413          	addi	s0,sp,32
    800048fc:	fe840593          	addi	a1,s0,-24
    80004900:	00100613          	li	a2,1
    80004904:	00000513          	li	a0,0
    80004908:	fffff097          	auipc	ra,0xfffff
    8000490c:	8c4080e7          	jalr	-1852(ra) # 800031cc <console_read>
    80004910:	fe844503          	lbu	a0,-24(s0)
    80004914:	01813083          	ld	ra,24(sp)
    80004918:	01013403          	ld	s0,16(sp)
    8000491c:	02010113          	addi	sp,sp,32
    80004920:	00008067          	ret

0000000080004924 <console_handler>:
    80004924:	fe010113          	addi	sp,sp,-32
    80004928:	00813823          	sd	s0,16(sp)
    8000492c:	00113c23          	sd	ra,24(sp)
    80004930:	00913423          	sd	s1,8(sp)
    80004934:	02010413          	addi	s0,sp,32
    80004938:	14202773          	csrr	a4,scause
    8000493c:	100027f3          	csrr	a5,sstatus
    80004940:	0027f793          	andi	a5,a5,2
    80004944:	06079e63          	bnez	a5,800049c0 <console_handler+0x9c>
    80004948:	00074c63          	bltz	a4,80004960 <console_handler+0x3c>
    8000494c:	01813083          	ld	ra,24(sp)
    80004950:	01013403          	ld	s0,16(sp)
    80004954:	00813483          	ld	s1,8(sp)
    80004958:	02010113          	addi	sp,sp,32
    8000495c:	00008067          	ret
    80004960:	0ff77713          	andi	a4,a4,255
    80004964:	00900793          	li	a5,9
    80004968:	fef712e3          	bne	a4,a5,8000494c <console_handler+0x28>
    8000496c:	ffffe097          	auipc	ra,0xffffe
    80004970:	4b8080e7          	jalr	1208(ra) # 80002e24 <plic_claim>
    80004974:	00a00793          	li	a5,10
    80004978:	00050493          	mv	s1,a0
    8000497c:	02f50c63          	beq	a0,a5,800049b4 <console_handler+0x90>
    80004980:	fc0506e3          	beqz	a0,8000494c <console_handler+0x28>
    80004984:	00050593          	mv	a1,a0
    80004988:	00001517          	auipc	a0,0x1
    8000498c:	ab050513          	addi	a0,a0,-1360 # 80005438 <kvmincrease+0xa68>
    80004990:	fffff097          	auipc	ra,0xfffff
    80004994:	8d8080e7          	jalr	-1832(ra) # 80003268 <__printf>
    80004998:	01013403          	ld	s0,16(sp)
    8000499c:	01813083          	ld	ra,24(sp)
    800049a0:	00048513          	mv	a0,s1
    800049a4:	00813483          	ld	s1,8(sp)
    800049a8:	02010113          	addi	sp,sp,32
    800049ac:	ffffe317          	auipc	t1,0xffffe
    800049b0:	4b030067          	jr	1200(t1) # 80002e5c <plic_complete>
    800049b4:	fffff097          	auipc	ra,0xfffff
    800049b8:	1bc080e7          	jalr	444(ra) # 80003b70 <uartintr>
    800049bc:	fddff06f          	j	80004998 <console_handler+0x74>
    800049c0:	00001517          	auipc	a0,0x1
    800049c4:	b7850513          	addi	a0,a0,-1160 # 80005538 <digits+0x78>
    800049c8:	fffff097          	auipc	ra,0xfffff
    800049cc:	844080e7          	jalr	-1980(ra) # 8000320c <panic>

00000000800049d0 <kvmincrease>:
    800049d0:	fe010113          	addi	sp,sp,-32
    800049d4:	01213023          	sd	s2,0(sp)
    800049d8:	00001937          	lui	s2,0x1
    800049dc:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    800049e0:	00813823          	sd	s0,16(sp)
    800049e4:	00113c23          	sd	ra,24(sp)
    800049e8:	00913423          	sd	s1,8(sp)
    800049ec:	02010413          	addi	s0,sp,32
    800049f0:	01250933          	add	s2,a0,s2
    800049f4:	00c95913          	srli	s2,s2,0xc
    800049f8:	02090863          	beqz	s2,80004a28 <kvmincrease+0x58>
    800049fc:	00000493          	li	s1,0
    80004a00:	00148493          	addi	s1,s1,1
    80004a04:	fffff097          	auipc	ra,0xfffff
    80004a08:	4bc080e7          	jalr	1212(ra) # 80003ec0 <kalloc>
    80004a0c:	fe991ae3          	bne	s2,s1,80004a00 <kvmincrease+0x30>
    80004a10:	01813083          	ld	ra,24(sp)
    80004a14:	01013403          	ld	s0,16(sp)
    80004a18:	00813483          	ld	s1,8(sp)
    80004a1c:	00013903          	ld	s2,0(sp)
    80004a20:	02010113          	addi	sp,sp,32
    80004a24:	00008067          	ret
    80004a28:	01813083          	ld	ra,24(sp)
    80004a2c:	01013403          	ld	s0,16(sp)
    80004a30:	00813483          	ld	s1,8(sp)
    80004a34:	00013903          	ld	s2,0(sp)
    80004a38:	00000513          	li	a0,0
    80004a3c:	02010113          	addi	sp,sp,32
    80004a40:	00008067          	ret
	...
