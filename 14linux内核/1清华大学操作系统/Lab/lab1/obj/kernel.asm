
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 00 fe 10 00       	mov    $0x10fe00,%edx
  10000b:	b8 56 ea 10 00       	mov    $0x10ea56,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	83 ec 04             	sub    $0x4,%esp
  100017:	50                   	push   %eax
  100018:	6a 00                	push   $0x0
  10001a:	68 56 ea 10 00       	push   $0x10ea56
  10001f:	e8 f7 29 00 00       	call   102a1b <memset>
  100024:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100027:	e8 3c 14 00 00       	call   101468 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002c:	c7 45 f4 c0 31 10 00 	movl   $0x1031c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100033:	83 ec 08             	sub    $0x8,%esp
  100036:	ff 75 f4             	pushl  -0xc(%ebp)
  100039:	68 dc 31 10 00       	push   $0x1031dc
  10003e:	e8 f1 01 00 00       	call   100234 <cprintf>
  100043:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100046:	e8 6f 08 00 00       	call   1008ba <print_kerninfo>

    grade_backtrace();
  10004b:	e8 71 00 00 00       	call   1000c1 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100050:	e8 8b 26 00 00       	call   1026e0 <pmm_init>

    pic_init();                 // init interrupt controller
  100055:	e8 4d 15 00 00       	call   1015a7 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005a:	e8 aa 16 00 00       	call   101709 <idt_init>

    clock_init();               // init clock interrupt
  10005f:	e8 fa 0b 00 00       	call   100c5e <clock_init>
    intr_enable();              // enable irq interrupt
  100064:	e8 7a 16 00 00       	call   1016e3 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100069:	eb fe                	jmp    100069 <kern_init+0x69>

0010006b <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  10006b:	55                   	push   %ebp
  10006c:	89 e5                	mov    %esp,%ebp
  10006e:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  100071:	83 ec 04             	sub    $0x4,%esp
  100074:	6a 00                	push   $0x0
  100076:	6a 00                	push   $0x0
  100078:	6a 00                	push   $0x0
  10007a:	e8 cd 0b 00 00       	call   100c4c <mon_backtrace>
  10007f:	83 c4 10             	add    $0x10,%esp
}
  100082:	c9                   	leave  
  100083:	c3                   	ret    

00100084 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100084:	55                   	push   %ebp
  100085:	89 e5                	mov    %esp,%ebp
  100087:	53                   	push   %ebx
  100088:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10008b:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  10008e:	8b 55 0c             	mov    0xc(%ebp),%edx
  100091:	8d 5d 08             	lea    0x8(%ebp),%ebx
  100094:	8b 45 08             	mov    0x8(%ebp),%eax
  100097:	51                   	push   %ecx
  100098:	52                   	push   %edx
  100099:	53                   	push   %ebx
  10009a:	50                   	push   %eax
  10009b:	e8 cb ff ff ff       	call   10006b <grade_backtrace2>
  1000a0:	83 c4 10             	add    $0x10,%esp
}
  1000a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000a6:	c9                   	leave  
  1000a7:	c3                   	ret    

001000a8 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000a8:	55                   	push   %ebp
  1000a9:	89 e5                	mov    %esp,%ebp
  1000ab:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000ae:	83 ec 08             	sub    $0x8,%esp
  1000b1:	ff 75 10             	pushl  0x10(%ebp)
  1000b4:	ff 75 08             	pushl  0x8(%ebp)
  1000b7:	e8 c8 ff ff ff       	call   100084 <grade_backtrace1>
  1000bc:	83 c4 10             	add    $0x10,%esp
}
  1000bf:	c9                   	leave  
  1000c0:	c3                   	ret    

001000c1 <grade_backtrace>:

void
grade_backtrace(void) {
  1000c1:	55                   	push   %ebp
  1000c2:	89 e5                	mov    %esp,%ebp
  1000c4:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000c7:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000cc:	83 ec 04             	sub    $0x4,%esp
  1000cf:	68 00 00 ff ff       	push   $0xffff0000
  1000d4:	50                   	push   %eax
  1000d5:	6a 00                	push   $0x0
  1000d7:	e8 cc ff ff ff       	call   1000a8 <grade_backtrace0>
  1000dc:	83 c4 10             	add    $0x10,%esp
}
  1000df:	c9                   	leave  
  1000e0:	c3                   	ret    

001000e1 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  1000e1:	55                   	push   %ebp
  1000e2:	89 e5                	mov    %esp,%ebp
  1000e4:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  1000e7:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  1000ea:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  1000ed:	8c 45 f2             	mov    %es,-0xe(%ebp)
  1000f0:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  1000f3:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1000f7:	0f b7 c0             	movzwl %ax,%eax
  1000fa:	83 e0 03             	and    $0x3,%eax
  1000fd:	89 c2                	mov    %eax,%edx
  1000ff:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  100104:	83 ec 04             	sub    $0x4,%esp
  100107:	52                   	push   %edx
  100108:	50                   	push   %eax
  100109:	68 e1 31 10 00       	push   $0x1031e1
  10010e:	e8 21 01 00 00       	call   100234 <cprintf>
  100113:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100116:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011a:	0f b7 d0             	movzwl %ax,%edx
  10011d:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  100122:	83 ec 04             	sub    $0x4,%esp
  100125:	52                   	push   %edx
  100126:	50                   	push   %eax
  100127:	68 ef 31 10 00       	push   $0x1031ef
  10012c:	e8 03 01 00 00       	call   100234 <cprintf>
  100131:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100134:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100138:	0f b7 d0             	movzwl %ax,%edx
  10013b:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  100140:	83 ec 04             	sub    $0x4,%esp
  100143:	52                   	push   %edx
  100144:	50                   	push   %eax
  100145:	68 fd 31 10 00       	push   $0x1031fd
  10014a:	e8 e5 00 00 00       	call   100234 <cprintf>
  10014f:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  100152:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100156:	0f b7 d0             	movzwl %ax,%edx
  100159:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  10015e:	83 ec 04             	sub    $0x4,%esp
  100161:	52                   	push   %edx
  100162:	50                   	push   %eax
  100163:	68 0b 32 10 00       	push   $0x10320b
  100168:	e8 c7 00 00 00       	call   100234 <cprintf>
  10016d:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  100170:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  100174:	0f b7 d0             	movzwl %ax,%edx
  100177:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  10017c:	83 ec 04             	sub    $0x4,%esp
  10017f:	52                   	push   %edx
  100180:	50                   	push   %eax
  100181:	68 19 32 10 00       	push   $0x103219
  100186:	e8 a9 00 00 00       	call   100234 <cprintf>
  10018b:	83 c4 10             	add    $0x10,%esp
    round ++;
  10018e:	a1 80 ea 10 00       	mov    0x10ea80,%eax
  100193:	83 c0 01             	add    $0x1,%eax
  100196:	a3 80 ea 10 00       	mov    %eax,0x10ea80
}
  10019b:	c9                   	leave  
  10019c:	c3                   	ret    

0010019d <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  10019d:	55                   	push   %ebp
  10019e:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001a0:	5d                   	pop    %ebp
  1001a1:	c3                   	ret    

001001a2 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001a2:	55                   	push   %ebp
  1001a3:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001a5:	5d                   	pop    %ebp
  1001a6:	c3                   	ret    

001001a7 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001a7:	55                   	push   %ebp
  1001a8:	89 e5                	mov    %esp,%ebp
  1001aa:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001ad:	e8 2f ff ff ff       	call   1000e1 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001b2:	83 ec 0c             	sub    $0xc,%esp
  1001b5:	68 28 32 10 00       	push   $0x103228
  1001ba:	e8 75 00 00 00       	call   100234 <cprintf>
  1001bf:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  1001c2:	e8 d6 ff ff ff       	call   10019d <lab1_switch_to_user>
    lab1_print_cur_status();
  1001c7:	e8 15 ff ff ff       	call   1000e1 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001cc:	83 ec 0c             	sub    $0xc,%esp
  1001cf:	68 48 32 10 00       	push   $0x103248
  1001d4:	e8 5b 00 00 00       	call   100234 <cprintf>
  1001d9:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  1001dc:	e8 c1 ff ff ff       	call   1001a2 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  1001e1:	e8 fb fe ff ff       	call   1000e1 <lab1_print_cur_status>
}
  1001e6:	c9                   	leave  
  1001e7:	c3                   	ret    

001001e8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1001e8:	55                   	push   %ebp
  1001e9:	89 e5                	mov    %esp,%ebp
  1001eb:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  1001ee:	83 ec 0c             	sub    $0xc,%esp
  1001f1:	ff 75 08             	pushl  0x8(%ebp)
  1001f4:	e8 9f 12 00 00       	call   101498 <cons_putc>
  1001f9:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  1001fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1001ff:	8b 00                	mov    (%eax),%eax
  100201:	8d 50 01             	lea    0x1(%eax),%edx
  100204:	8b 45 0c             	mov    0xc(%ebp),%eax
  100207:	89 10                	mov    %edx,(%eax)
}
  100209:	c9                   	leave  
  10020a:	c3                   	ret    

0010020b <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10020b:	55                   	push   %ebp
  10020c:	89 e5                	mov    %esp,%ebp
  10020e:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  100211:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100218:	ff 75 0c             	pushl  0xc(%ebp)
  10021b:	ff 75 08             	pushl  0x8(%ebp)
  10021e:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100221:	50                   	push   %eax
  100222:	68 e8 01 10 00       	push   $0x1001e8
  100227:	e8 23 2b 00 00       	call   102d4f <vprintfmt>
  10022c:	83 c4 10             	add    $0x10,%esp
    return cnt;
  10022f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100232:	c9                   	leave  
  100233:	c3                   	ret    

00100234 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100234:	55                   	push   %ebp
  100235:	89 e5                	mov    %esp,%ebp
  100237:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10023a:	8d 45 0c             	lea    0xc(%ebp),%eax
  10023d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100240:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100243:	83 ec 08             	sub    $0x8,%esp
  100246:	50                   	push   %eax
  100247:	ff 75 08             	pushl  0x8(%ebp)
  10024a:	e8 bc ff ff ff       	call   10020b <vcprintf>
  10024f:	83 c4 10             	add    $0x10,%esp
  100252:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100255:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100258:	c9                   	leave  
  100259:	c3                   	ret    

0010025a <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  10025a:	55                   	push   %ebp
  10025b:	89 e5                	mov    %esp,%ebp
  10025d:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100260:	83 ec 0c             	sub    $0xc,%esp
  100263:	ff 75 08             	pushl  0x8(%ebp)
  100266:	e8 2d 12 00 00       	call   101498 <cons_putc>
  10026b:	83 c4 10             	add    $0x10,%esp
}
  10026e:	c9                   	leave  
  10026f:	c3                   	ret    

00100270 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  100270:	55                   	push   %ebp
  100271:	89 e5                	mov    %esp,%ebp
  100273:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  100276:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  10027d:	eb 14                	jmp    100293 <cputs+0x23>
        cputch(c, &cnt);
  10027f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100283:	83 ec 08             	sub    $0x8,%esp
  100286:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100289:	52                   	push   %edx
  10028a:	50                   	push   %eax
  10028b:	e8 58 ff ff ff       	call   1001e8 <cputch>
  100290:	83 c4 10             	add    $0x10,%esp
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  100293:	8b 45 08             	mov    0x8(%ebp),%eax
  100296:	8d 50 01             	lea    0x1(%eax),%edx
  100299:	89 55 08             	mov    %edx,0x8(%ebp)
  10029c:	0f b6 00             	movzbl (%eax),%eax
  10029f:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002a2:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002a6:	75 d7                	jne    10027f <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  1002a8:	83 ec 08             	sub    $0x8,%esp
  1002ab:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002ae:	50                   	push   %eax
  1002af:	6a 0a                	push   $0xa
  1002b1:	e8 32 ff ff ff       	call   1001e8 <cputch>
  1002b6:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1002bc:	c9                   	leave  
  1002bd:	c3                   	ret    

001002be <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1002be:	55                   	push   %ebp
  1002bf:	89 e5                	mov    %esp,%ebp
  1002c1:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1002c4:	e8 fe 11 00 00       	call   1014c7 <cons_getc>
  1002c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1002cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1002d0:	74 f2                	je     1002c4 <getchar+0x6>
        /* do nothing */;
    return c;
  1002d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002d5:	c9                   	leave  
  1002d6:	c3                   	ret    

001002d7 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1002d7:	55                   	push   %ebp
  1002d8:	89 e5                	mov    %esp,%ebp
  1002da:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  1002dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1002e1:	74 13                	je     1002f6 <readline+0x1f>
        cprintf("%s", prompt);
  1002e3:	83 ec 08             	sub    $0x8,%esp
  1002e6:	ff 75 08             	pushl  0x8(%ebp)
  1002e9:	68 67 32 10 00       	push   $0x103267
  1002ee:	e8 41 ff ff ff       	call   100234 <cprintf>
  1002f3:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  1002f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  1002fd:	e8 bc ff ff ff       	call   1002be <getchar>
  100302:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100305:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100309:	79 0a                	jns    100315 <readline+0x3e>
            return NULL;
  10030b:	b8 00 00 00 00       	mov    $0x0,%eax
  100310:	e9 82 00 00 00       	jmp    100397 <readline+0xc0>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100315:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100319:	7e 2b                	jle    100346 <readline+0x6f>
  10031b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100322:	7f 22                	jg     100346 <readline+0x6f>
            cputchar(c);
  100324:	83 ec 0c             	sub    $0xc,%esp
  100327:	ff 75 f0             	pushl  -0x10(%ebp)
  10032a:	e8 2b ff ff ff       	call   10025a <cputchar>
  10032f:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100332:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100335:	8d 50 01             	lea    0x1(%eax),%edx
  100338:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10033b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10033e:	88 90 c0 ea 10 00    	mov    %dl,0x10eac0(%eax)
  100344:	eb 4c                	jmp    100392 <readline+0xbb>
        }
        else if (c == '\b' && i > 0) {
  100346:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10034a:	75 1a                	jne    100366 <readline+0x8f>
  10034c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100350:	7e 14                	jle    100366 <readline+0x8f>
            cputchar(c);
  100352:	83 ec 0c             	sub    $0xc,%esp
  100355:	ff 75 f0             	pushl  -0x10(%ebp)
  100358:	e8 fd fe ff ff       	call   10025a <cputchar>
  10035d:	83 c4 10             	add    $0x10,%esp
            i --;
  100360:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  100364:	eb 2c                	jmp    100392 <readline+0xbb>
        }
        else if (c == '\n' || c == '\r') {
  100366:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  10036a:	74 06                	je     100372 <readline+0x9b>
  10036c:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100370:	75 20                	jne    100392 <readline+0xbb>
            cputchar(c);
  100372:	83 ec 0c             	sub    $0xc,%esp
  100375:	ff 75 f0             	pushl  -0x10(%ebp)
  100378:	e8 dd fe ff ff       	call   10025a <cputchar>
  10037d:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  100380:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100383:	05 c0 ea 10 00       	add    $0x10eac0,%eax
  100388:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  10038b:	b8 c0 ea 10 00       	mov    $0x10eac0,%eax
  100390:	eb 05                	jmp    100397 <readline+0xc0>
        }
    }
  100392:	e9 66 ff ff ff       	jmp    1002fd <readline+0x26>
}
  100397:	c9                   	leave  
  100398:	c3                   	ret    

00100399 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100399:	55                   	push   %ebp
  10039a:	89 e5                	mov    %esp,%ebp
  10039c:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  10039f:	a1 c0 ee 10 00       	mov    0x10eec0,%eax
  1003a4:	85 c0                	test   %eax,%eax
  1003a6:	74 02                	je     1003aa <__panic+0x11>
        goto panic_dead;
  1003a8:	eb 48                	jmp    1003f2 <__panic+0x59>
    }
    is_panic = 1;
  1003aa:	c7 05 c0 ee 10 00 01 	movl   $0x1,0x10eec0
  1003b1:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1003b4:	8d 45 14             	lea    0x14(%ebp),%eax
  1003b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1003ba:	83 ec 04             	sub    $0x4,%esp
  1003bd:	ff 75 0c             	pushl  0xc(%ebp)
  1003c0:	ff 75 08             	pushl  0x8(%ebp)
  1003c3:	68 6a 32 10 00       	push   $0x10326a
  1003c8:	e8 67 fe ff ff       	call   100234 <cprintf>
  1003cd:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1003d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003d3:	83 ec 08             	sub    $0x8,%esp
  1003d6:	50                   	push   %eax
  1003d7:	ff 75 10             	pushl  0x10(%ebp)
  1003da:	e8 2c fe ff ff       	call   10020b <vcprintf>
  1003df:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1003e2:	83 ec 0c             	sub    $0xc,%esp
  1003e5:	68 86 32 10 00       	push   $0x103286
  1003ea:	e8 45 fe ff ff       	call   100234 <cprintf>
  1003ef:	83 c4 10             	add    $0x10,%esp
    va_end(ap);

panic_dead:
    intr_disable();
  1003f2:	e8 f2 12 00 00       	call   1016e9 <intr_disable>
    while (1) {
        kmonitor(NULL);
  1003f7:	83 ec 0c             	sub    $0xc,%esp
  1003fa:	6a 00                	push   $0x0
  1003fc:	e8 70 07 00 00       	call   100b71 <kmonitor>
  100401:	83 c4 10             	add    $0x10,%esp
    }
  100404:	eb f1                	jmp    1003f7 <__panic+0x5e>

00100406 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100406:	55                   	push   %ebp
  100407:	89 e5                	mov    %esp,%ebp
  100409:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  10040c:	8d 45 14             	lea    0x14(%ebp),%eax
  10040f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100412:	83 ec 04             	sub    $0x4,%esp
  100415:	ff 75 0c             	pushl  0xc(%ebp)
  100418:	ff 75 08             	pushl  0x8(%ebp)
  10041b:	68 88 32 10 00       	push   $0x103288
  100420:	e8 0f fe ff ff       	call   100234 <cprintf>
  100425:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100428:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10042b:	83 ec 08             	sub    $0x8,%esp
  10042e:	50                   	push   %eax
  10042f:	ff 75 10             	pushl  0x10(%ebp)
  100432:	e8 d4 fd ff ff       	call   10020b <vcprintf>
  100437:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10043a:	83 ec 0c             	sub    $0xc,%esp
  10043d:	68 86 32 10 00       	push   $0x103286
  100442:	e8 ed fd ff ff       	call   100234 <cprintf>
  100447:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10044a:	c9                   	leave  
  10044b:	c3                   	ret    

0010044c <is_kernel_panic>:

bool
is_kernel_panic(void) {
  10044c:	55                   	push   %ebp
  10044d:	89 e5                	mov    %esp,%ebp
    return is_panic;
  10044f:	a1 c0 ee 10 00       	mov    0x10eec0,%eax
}
  100454:	5d                   	pop    %ebp
  100455:	c3                   	ret    

00100456 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100456:	55                   	push   %ebp
  100457:	89 e5                	mov    %esp,%ebp
  100459:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  10045c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10045f:	8b 00                	mov    (%eax),%eax
  100461:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100464:	8b 45 10             	mov    0x10(%ebp),%eax
  100467:	8b 00                	mov    (%eax),%eax
  100469:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10046c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  100473:	e9 d2 00 00 00       	jmp    10054a <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  100478:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10047b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10047e:	01 d0                	add    %edx,%eax
  100480:	89 c2                	mov    %eax,%edx
  100482:	c1 ea 1f             	shr    $0x1f,%edx
  100485:	01 d0                	add    %edx,%eax
  100487:	d1 f8                	sar    %eax
  100489:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10048c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10048f:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100492:	eb 04                	jmp    100498 <stab_binsearch+0x42>
            m --;
  100494:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100498:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10049b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10049e:	7c 1f                	jl     1004bf <stab_binsearch+0x69>
  1004a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004a3:	89 d0                	mov    %edx,%eax
  1004a5:	01 c0                	add    %eax,%eax
  1004a7:	01 d0                	add    %edx,%eax
  1004a9:	c1 e0 02             	shl    $0x2,%eax
  1004ac:	89 c2                	mov    %eax,%edx
  1004ae:	8b 45 08             	mov    0x8(%ebp),%eax
  1004b1:	01 d0                	add    %edx,%eax
  1004b3:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004b7:	0f b6 c0             	movzbl %al,%eax
  1004ba:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004bd:	75 d5                	jne    100494 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  1004bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004c5:	7d 0b                	jge    1004d2 <stab_binsearch+0x7c>
            l = true_m + 1;
  1004c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004ca:	83 c0 01             	add    $0x1,%eax
  1004cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  1004d0:	eb 78                	jmp    10054a <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  1004d2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  1004d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004dc:	89 d0                	mov    %edx,%eax
  1004de:	01 c0                	add    %eax,%eax
  1004e0:	01 d0                	add    %edx,%eax
  1004e2:	c1 e0 02             	shl    $0x2,%eax
  1004e5:	89 c2                	mov    %eax,%edx
  1004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1004ea:	01 d0                	add    %edx,%eax
  1004ec:	8b 40 08             	mov    0x8(%eax),%eax
  1004ef:	3b 45 18             	cmp    0x18(%ebp),%eax
  1004f2:	73 13                	jae    100507 <stab_binsearch+0xb1>
            *region_left = m;
  1004f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004fa:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  1004fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004ff:	83 c0 01             	add    $0x1,%eax
  100502:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100505:	eb 43                	jmp    10054a <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100507:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10050a:	89 d0                	mov    %edx,%eax
  10050c:	01 c0                	add    %eax,%eax
  10050e:	01 d0                	add    %edx,%eax
  100510:	c1 e0 02             	shl    $0x2,%eax
  100513:	89 c2                	mov    %eax,%edx
  100515:	8b 45 08             	mov    0x8(%ebp),%eax
  100518:	01 d0                	add    %edx,%eax
  10051a:	8b 40 08             	mov    0x8(%eax),%eax
  10051d:	3b 45 18             	cmp    0x18(%ebp),%eax
  100520:	76 16                	jbe    100538 <stab_binsearch+0xe2>
            *region_right = m - 1;
  100522:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100525:	8d 50 ff             	lea    -0x1(%eax),%edx
  100528:	8b 45 10             	mov    0x10(%ebp),%eax
  10052b:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10052d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100530:	83 e8 01             	sub    $0x1,%eax
  100533:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100536:	eb 12                	jmp    10054a <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100538:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10053e:	89 10                	mov    %edx,(%eax)
            l = m;
  100540:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100543:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  100546:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  10054a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10054d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100550:	0f 8e 22 ff ff ff    	jle    100478 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  100556:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10055a:	75 0f                	jne    10056b <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  10055c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10055f:	8b 00                	mov    (%eax),%eax
  100561:	8d 50 ff             	lea    -0x1(%eax),%edx
  100564:	8b 45 10             	mov    0x10(%ebp),%eax
  100567:	89 10                	mov    %edx,(%eax)
  100569:	eb 3f                	jmp    1005aa <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  10056b:	8b 45 10             	mov    0x10(%ebp),%eax
  10056e:	8b 00                	mov    (%eax),%eax
  100570:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100573:	eb 04                	jmp    100579 <stab_binsearch+0x123>
  100575:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100579:	8b 45 0c             	mov    0xc(%ebp),%eax
  10057c:	8b 00                	mov    (%eax),%eax
  10057e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100581:	7d 1f                	jge    1005a2 <stab_binsearch+0x14c>
  100583:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100586:	89 d0                	mov    %edx,%eax
  100588:	01 c0                	add    %eax,%eax
  10058a:	01 d0                	add    %edx,%eax
  10058c:	c1 e0 02             	shl    $0x2,%eax
  10058f:	89 c2                	mov    %eax,%edx
  100591:	8b 45 08             	mov    0x8(%ebp),%eax
  100594:	01 d0                	add    %edx,%eax
  100596:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10059a:	0f b6 c0             	movzbl %al,%eax
  10059d:	3b 45 14             	cmp    0x14(%ebp),%eax
  1005a0:	75 d3                	jne    100575 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  1005a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005a8:	89 10                	mov    %edx,(%eax)
    }
}
  1005aa:	c9                   	leave  
  1005ab:	c3                   	ret    

001005ac <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1005ac:	55                   	push   %ebp
  1005ad:	89 e5                	mov    %esp,%ebp
  1005af:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1005b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b5:	c7 00 a8 32 10 00    	movl   $0x1032a8,(%eax)
    info->eip_line = 0;
  1005bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005be:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1005c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c8:	c7 40 08 a8 32 10 00 	movl   $0x1032a8,0x8(%eax)
    info->eip_fn_namelen = 9;
  1005cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d2:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  1005d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005dc:	8b 55 08             	mov    0x8(%ebp),%edx
  1005df:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  1005e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  1005ec:	c7 45 f4 cc 3a 10 00 	movl   $0x103acc,-0xc(%ebp)
    stab_end = __STAB_END__;
  1005f3:	c7 45 f0 50 b0 10 00 	movl   $0x10b050,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  1005fa:	c7 45 ec 51 b0 10 00 	movl   $0x10b051,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100601:	c7 45 e8 1f d0 10 00 	movl   $0x10d01f,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100608:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10060b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10060e:	76 0d                	jbe    10061d <debuginfo_eip+0x71>
  100610:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100613:	83 e8 01             	sub    $0x1,%eax
  100616:	0f b6 00             	movzbl (%eax),%eax
  100619:	84 c0                	test   %al,%al
  10061b:	74 0a                	je     100627 <debuginfo_eip+0x7b>
        return -1;
  10061d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100622:	e9 91 02 00 00       	jmp    1008b8 <debuginfo_eip+0x30c>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100627:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10062e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100631:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100634:	29 c2                	sub    %eax,%edx
  100636:	89 d0                	mov    %edx,%eax
  100638:	c1 f8 02             	sar    $0x2,%eax
  10063b:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  100641:	83 e8 01             	sub    $0x1,%eax
  100644:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100647:	ff 75 08             	pushl  0x8(%ebp)
  10064a:	6a 64                	push   $0x64
  10064c:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10064f:	50                   	push   %eax
  100650:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100653:	50                   	push   %eax
  100654:	ff 75 f4             	pushl  -0xc(%ebp)
  100657:	e8 fa fd ff ff       	call   100456 <stab_binsearch>
  10065c:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  10065f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100662:	85 c0                	test   %eax,%eax
  100664:	75 0a                	jne    100670 <debuginfo_eip+0xc4>
        return -1;
  100666:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10066b:	e9 48 02 00 00       	jmp    1008b8 <debuginfo_eip+0x30c>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  100670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100673:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100676:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100679:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  10067c:	ff 75 08             	pushl  0x8(%ebp)
  10067f:	6a 24                	push   $0x24
  100681:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100684:	50                   	push   %eax
  100685:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100688:	50                   	push   %eax
  100689:	ff 75 f4             	pushl  -0xc(%ebp)
  10068c:	e8 c5 fd ff ff       	call   100456 <stab_binsearch>
  100691:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100694:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100697:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10069a:	39 c2                	cmp    %eax,%edx
  10069c:	7f 7c                	jg     10071a <debuginfo_eip+0x16e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10069e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006a1:	89 c2                	mov    %eax,%edx
  1006a3:	89 d0                	mov    %edx,%eax
  1006a5:	01 c0                	add    %eax,%eax
  1006a7:	01 d0                	add    %edx,%eax
  1006a9:	c1 e0 02             	shl    $0x2,%eax
  1006ac:	89 c2                	mov    %eax,%edx
  1006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006b1:	01 d0                	add    %edx,%eax
  1006b3:	8b 00                	mov    (%eax),%eax
  1006b5:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1006b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1006bb:	29 d1                	sub    %edx,%ecx
  1006bd:	89 ca                	mov    %ecx,%edx
  1006bf:	39 d0                	cmp    %edx,%eax
  1006c1:	73 22                	jae    1006e5 <debuginfo_eip+0x139>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  1006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006c6:	89 c2                	mov    %eax,%edx
  1006c8:	89 d0                	mov    %edx,%eax
  1006ca:	01 c0                	add    %eax,%eax
  1006cc:	01 d0                	add    %edx,%eax
  1006ce:	c1 e0 02             	shl    $0x2,%eax
  1006d1:	89 c2                	mov    %eax,%edx
  1006d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006d6:	01 d0                	add    %edx,%eax
  1006d8:	8b 10                	mov    (%eax),%edx
  1006da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1006dd:	01 c2                	add    %eax,%edx
  1006df:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006e2:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  1006e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006e8:	89 c2                	mov    %eax,%edx
  1006ea:	89 d0                	mov    %edx,%eax
  1006ec:	01 c0                	add    %eax,%eax
  1006ee:	01 d0                	add    %edx,%eax
  1006f0:	c1 e0 02             	shl    $0x2,%eax
  1006f3:	89 c2                	mov    %eax,%edx
  1006f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006f8:	01 d0                	add    %edx,%eax
  1006fa:	8b 50 08             	mov    0x8(%eax),%edx
  1006fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100700:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100703:	8b 45 0c             	mov    0xc(%ebp),%eax
  100706:	8b 40 10             	mov    0x10(%eax),%eax
  100709:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10070c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10070f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100712:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100715:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100718:	eb 15                	jmp    10072f <debuginfo_eip+0x183>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10071a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10071d:	8b 55 08             	mov    0x8(%ebp),%edx
  100720:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100723:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100726:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  100729:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10072c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  10072f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100732:	8b 40 08             	mov    0x8(%eax),%eax
  100735:	83 ec 08             	sub    $0x8,%esp
  100738:	6a 3a                	push   $0x3a
  10073a:	50                   	push   %eax
  10073b:	e8 4f 21 00 00       	call   10288f <strfind>
  100740:	83 c4 10             	add    $0x10,%esp
  100743:	89 c2                	mov    %eax,%edx
  100745:	8b 45 0c             	mov    0xc(%ebp),%eax
  100748:	8b 40 08             	mov    0x8(%eax),%eax
  10074b:	29 c2                	sub    %eax,%edx
  10074d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100750:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100753:	83 ec 0c             	sub    $0xc,%esp
  100756:	ff 75 08             	pushl  0x8(%ebp)
  100759:	6a 44                	push   $0x44
  10075b:	8d 45 d0             	lea    -0x30(%ebp),%eax
  10075e:	50                   	push   %eax
  10075f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100762:	50                   	push   %eax
  100763:	ff 75 f4             	pushl  -0xc(%ebp)
  100766:	e8 eb fc ff ff       	call   100456 <stab_binsearch>
  10076b:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  10076e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100771:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100774:	39 c2                	cmp    %eax,%edx
  100776:	7f 24                	jg     10079c <debuginfo_eip+0x1f0>
        info->eip_line = stabs[rline].n_desc;
  100778:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10077b:	89 c2                	mov    %eax,%edx
  10077d:	89 d0                	mov    %edx,%eax
  10077f:	01 c0                	add    %eax,%eax
  100781:	01 d0                	add    %edx,%eax
  100783:	c1 e0 02             	shl    $0x2,%eax
  100786:	89 c2                	mov    %eax,%edx
  100788:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10078b:	01 d0                	add    %edx,%eax
  10078d:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100791:	0f b7 d0             	movzwl %ax,%edx
  100794:	8b 45 0c             	mov    0xc(%ebp),%eax
  100797:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10079a:	eb 13                	jmp    1007af <debuginfo_eip+0x203>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  10079c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007a1:	e9 12 01 00 00       	jmp    1008b8 <debuginfo_eip+0x30c>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  1007a6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007a9:	83 e8 01             	sub    $0x1,%eax
  1007ac:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1007af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b5:	39 c2                	cmp    %eax,%edx
  1007b7:	7c 56                	jl     10080f <debuginfo_eip+0x263>
           && stabs[lline].n_type != N_SOL
  1007b9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007bc:	89 c2                	mov    %eax,%edx
  1007be:	89 d0                	mov    %edx,%eax
  1007c0:	01 c0                	add    %eax,%eax
  1007c2:	01 d0                	add    %edx,%eax
  1007c4:	c1 e0 02             	shl    $0x2,%eax
  1007c7:	89 c2                	mov    %eax,%edx
  1007c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007cc:	01 d0                	add    %edx,%eax
  1007ce:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1007d2:	3c 84                	cmp    $0x84,%al
  1007d4:	74 39                	je     10080f <debuginfo_eip+0x263>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  1007d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007d9:	89 c2                	mov    %eax,%edx
  1007db:	89 d0                	mov    %edx,%eax
  1007dd:	01 c0                	add    %eax,%eax
  1007df:	01 d0                	add    %edx,%eax
  1007e1:	c1 e0 02             	shl    $0x2,%eax
  1007e4:	89 c2                	mov    %eax,%edx
  1007e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007e9:	01 d0                	add    %edx,%eax
  1007eb:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1007ef:	3c 64                	cmp    $0x64,%al
  1007f1:	75 b3                	jne    1007a6 <debuginfo_eip+0x1fa>
  1007f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007f6:	89 c2                	mov    %eax,%edx
  1007f8:	89 d0                	mov    %edx,%eax
  1007fa:	01 c0                	add    %eax,%eax
  1007fc:	01 d0                	add    %edx,%eax
  1007fe:	c1 e0 02             	shl    $0x2,%eax
  100801:	89 c2                	mov    %eax,%edx
  100803:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100806:	01 d0                	add    %edx,%eax
  100808:	8b 40 08             	mov    0x8(%eax),%eax
  10080b:	85 c0                	test   %eax,%eax
  10080d:	74 97                	je     1007a6 <debuginfo_eip+0x1fa>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10080f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100812:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100815:	39 c2                	cmp    %eax,%edx
  100817:	7c 46                	jl     10085f <debuginfo_eip+0x2b3>
  100819:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10081c:	89 c2                	mov    %eax,%edx
  10081e:	89 d0                	mov    %edx,%eax
  100820:	01 c0                	add    %eax,%eax
  100822:	01 d0                	add    %edx,%eax
  100824:	c1 e0 02             	shl    $0x2,%eax
  100827:	89 c2                	mov    %eax,%edx
  100829:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10082c:	01 d0                	add    %edx,%eax
  10082e:	8b 00                	mov    (%eax),%eax
  100830:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100833:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100836:	29 d1                	sub    %edx,%ecx
  100838:	89 ca                	mov    %ecx,%edx
  10083a:	39 d0                	cmp    %edx,%eax
  10083c:	73 21                	jae    10085f <debuginfo_eip+0x2b3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  10083e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100841:	89 c2                	mov    %eax,%edx
  100843:	89 d0                	mov    %edx,%eax
  100845:	01 c0                	add    %eax,%eax
  100847:	01 d0                	add    %edx,%eax
  100849:	c1 e0 02             	shl    $0x2,%eax
  10084c:	89 c2                	mov    %eax,%edx
  10084e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100851:	01 d0                	add    %edx,%eax
  100853:	8b 10                	mov    (%eax),%edx
  100855:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100858:	01 c2                	add    %eax,%edx
  10085a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10085d:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  10085f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100862:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100865:	39 c2                	cmp    %eax,%edx
  100867:	7d 4a                	jge    1008b3 <debuginfo_eip+0x307>
        for (lline = lfun + 1;
  100869:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10086c:	83 c0 01             	add    $0x1,%eax
  10086f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100872:	eb 18                	jmp    10088c <debuginfo_eip+0x2e0>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100874:	8b 45 0c             	mov    0xc(%ebp),%eax
  100877:	8b 40 14             	mov    0x14(%eax),%eax
  10087a:	8d 50 01             	lea    0x1(%eax),%edx
  10087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100880:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  100883:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100886:	83 c0 01             	add    $0x1,%eax
  100889:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10088c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10088f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  100892:	39 c2                	cmp    %eax,%edx
  100894:	7d 1d                	jge    1008b3 <debuginfo_eip+0x307>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100896:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100899:	89 c2                	mov    %eax,%edx
  10089b:	89 d0                	mov    %edx,%eax
  10089d:	01 c0                	add    %eax,%eax
  10089f:	01 d0                	add    %edx,%eax
  1008a1:	c1 e0 02             	shl    $0x2,%eax
  1008a4:	89 c2                	mov    %eax,%edx
  1008a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a9:	01 d0                	add    %edx,%eax
  1008ab:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008af:	3c a0                	cmp    $0xa0,%al
  1008b1:	74 c1                	je     100874 <debuginfo_eip+0x2c8>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  1008b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1008b8:	c9                   	leave  
  1008b9:	c3                   	ret    

001008ba <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  1008ba:	55                   	push   %ebp
  1008bb:	89 e5                	mov    %esp,%ebp
  1008bd:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  1008c0:	83 ec 0c             	sub    $0xc,%esp
  1008c3:	68 b2 32 10 00       	push   $0x1032b2
  1008c8:	e8 67 f9 ff ff       	call   100234 <cprintf>
  1008cd:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  1008d0:	83 ec 08             	sub    $0x8,%esp
  1008d3:	68 00 00 10 00       	push   $0x100000
  1008d8:	68 cb 32 10 00       	push   $0x1032cb
  1008dd:	e8 52 f9 ff ff       	call   100234 <cprintf>
  1008e2:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  1008e5:	83 ec 08             	sub    $0x8,%esp
  1008e8:	68 ac 31 10 00       	push   $0x1031ac
  1008ed:	68 e3 32 10 00       	push   $0x1032e3
  1008f2:	e8 3d f9 ff ff       	call   100234 <cprintf>
  1008f7:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  1008fa:	83 ec 08             	sub    $0x8,%esp
  1008fd:	68 56 ea 10 00       	push   $0x10ea56
  100902:	68 fb 32 10 00       	push   $0x1032fb
  100907:	e8 28 f9 ff ff       	call   100234 <cprintf>
  10090c:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  10090f:	83 ec 08             	sub    $0x8,%esp
  100912:	68 00 fe 10 00       	push   $0x10fe00
  100917:	68 13 33 10 00       	push   $0x103313
  10091c:	e8 13 f9 ff ff       	call   100234 <cprintf>
  100921:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100924:	b8 00 fe 10 00       	mov    $0x10fe00,%eax
  100929:	05 ff 03 00 00       	add    $0x3ff,%eax
  10092e:	ba 00 00 10 00       	mov    $0x100000,%edx
  100933:	29 d0                	sub    %edx,%eax
  100935:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10093b:	85 c0                	test   %eax,%eax
  10093d:	0f 48 c2             	cmovs  %edx,%eax
  100940:	c1 f8 0a             	sar    $0xa,%eax
  100943:	83 ec 08             	sub    $0x8,%esp
  100946:	50                   	push   %eax
  100947:	68 2c 33 10 00       	push   $0x10332c
  10094c:	e8 e3 f8 ff ff       	call   100234 <cprintf>
  100951:	83 c4 10             	add    $0x10,%esp
}
  100954:	c9                   	leave  
  100955:	c3                   	ret    

00100956 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100956:	55                   	push   %ebp
  100957:	89 e5                	mov    %esp,%ebp
  100959:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  10095f:	83 ec 08             	sub    $0x8,%esp
  100962:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100965:	50                   	push   %eax
  100966:	ff 75 08             	pushl  0x8(%ebp)
  100969:	e8 3e fc ff ff       	call   1005ac <debuginfo_eip>
  10096e:	83 c4 10             	add    $0x10,%esp
  100971:	85 c0                	test   %eax,%eax
  100973:	74 15                	je     10098a <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100975:	83 ec 08             	sub    $0x8,%esp
  100978:	ff 75 08             	pushl  0x8(%ebp)
  10097b:	68 56 33 10 00       	push   $0x103356
  100980:	e8 af f8 ff ff       	call   100234 <cprintf>
  100985:	83 c4 10             	add    $0x10,%esp
  100988:	eb 65                	jmp    1009ef <print_debuginfo+0x99>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  10098a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100991:	eb 1c                	jmp    1009af <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100993:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100996:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100999:	01 d0                	add    %edx,%eax
  10099b:	0f b6 00             	movzbl (%eax),%eax
  10099e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  1009a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1009a7:	01 ca                	add    %ecx,%edx
  1009a9:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1009af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1009b5:	7f dc                	jg     100993 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  1009b7:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  1009bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009c0:	01 d0                	add    %edx,%eax
  1009c2:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  1009c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  1009c8:	8b 55 08             	mov    0x8(%ebp),%edx
  1009cb:	89 d1                	mov    %edx,%ecx
  1009cd:	29 c1                	sub    %eax,%ecx
  1009cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1009d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1009d5:	83 ec 0c             	sub    $0xc,%esp
  1009d8:	51                   	push   %ecx
  1009d9:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  1009df:	51                   	push   %ecx
  1009e0:	52                   	push   %edx
  1009e1:	50                   	push   %eax
  1009e2:	68 72 33 10 00       	push   $0x103372
  1009e7:	e8 48 f8 ff ff       	call   100234 <cprintf>
  1009ec:	83 c4 20             	add    $0x20,%esp
                fnname, eip - info.eip_fn_addr);
    }
}
  1009ef:	c9                   	leave  
  1009f0:	c3                   	ret    

001009f1 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  1009f1:	55                   	push   %ebp
  1009f2:	89 e5                	mov    %esp,%ebp
  1009f4:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  1009f7:	8b 45 04             	mov    0x4(%ebp),%eax
  1009fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  1009fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a00:	c9                   	leave  
  100a01:	c3                   	ret    

00100a02 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a02:	55                   	push   %ebp
  100a03:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100a05:	5d                   	pop    %ebp
  100a06:	c3                   	ret    

00100a07 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a07:	55                   	push   %ebp
  100a08:	89 e5                	mov    %esp,%ebp
  100a0a:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a14:	eb 0c                	jmp    100a22 <parse+0x1b>
            *buf ++ = '\0';
  100a16:	8b 45 08             	mov    0x8(%ebp),%eax
  100a19:	8d 50 01             	lea    0x1(%eax),%edx
  100a1c:	89 55 08             	mov    %edx,0x8(%ebp)
  100a1f:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a22:	8b 45 08             	mov    0x8(%ebp),%eax
  100a25:	0f b6 00             	movzbl (%eax),%eax
  100a28:	84 c0                	test   %al,%al
  100a2a:	74 1e                	je     100a4a <parse+0x43>
  100a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  100a2f:	0f b6 00             	movzbl (%eax),%eax
  100a32:	0f be c0             	movsbl %al,%eax
  100a35:	83 ec 08             	sub    $0x8,%esp
  100a38:	50                   	push   %eax
  100a39:	68 04 34 10 00       	push   $0x103404
  100a3e:	e8 19 1e 00 00       	call   10285c <strchr>
  100a43:	83 c4 10             	add    $0x10,%esp
  100a46:	85 c0                	test   %eax,%eax
  100a48:	75 cc                	jne    100a16 <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  100a4d:	0f b6 00             	movzbl (%eax),%eax
  100a50:	84 c0                	test   %al,%al
  100a52:	75 02                	jne    100a56 <parse+0x4f>
            break;
  100a54:	eb 65                	jmp    100abb <parse+0xb4>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100a56:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100a5a:	75 12                	jne    100a6e <parse+0x67>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100a5c:	83 ec 08             	sub    $0x8,%esp
  100a5f:	6a 10                	push   $0x10
  100a61:	68 09 34 10 00       	push   $0x103409
  100a66:	e8 c9 f7 ff ff       	call   100234 <cprintf>
  100a6b:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a71:	8d 50 01             	lea    0x1(%eax),%edx
  100a74:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100a77:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a81:	01 c2                	add    %eax,%edx
  100a83:	8b 45 08             	mov    0x8(%ebp),%eax
  100a86:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100a88:	eb 04                	jmp    100a8e <parse+0x87>
            buf ++;
  100a8a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  100a91:	0f b6 00             	movzbl (%eax),%eax
  100a94:	84 c0                	test   %al,%al
  100a96:	74 1e                	je     100ab6 <parse+0xaf>
  100a98:	8b 45 08             	mov    0x8(%ebp),%eax
  100a9b:	0f b6 00             	movzbl (%eax),%eax
  100a9e:	0f be c0             	movsbl %al,%eax
  100aa1:	83 ec 08             	sub    $0x8,%esp
  100aa4:	50                   	push   %eax
  100aa5:	68 04 34 10 00       	push   $0x103404
  100aaa:	e8 ad 1d 00 00       	call   10285c <strchr>
  100aaf:	83 c4 10             	add    $0x10,%esp
  100ab2:	85 c0                	test   %eax,%eax
  100ab4:	74 d4                	je     100a8a <parse+0x83>
            buf ++;
        }
    }
  100ab6:	e9 59 ff ff ff       	jmp    100a14 <parse+0xd>
    return argc;
  100abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100abe:	c9                   	leave  
  100abf:	c3                   	ret    

00100ac0 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100ac0:	55                   	push   %ebp
  100ac1:	89 e5                	mov    %esp,%ebp
  100ac3:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100ac6:	83 ec 08             	sub    $0x8,%esp
  100ac9:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100acc:	50                   	push   %eax
  100acd:	ff 75 08             	pushl  0x8(%ebp)
  100ad0:	e8 32 ff ff ff       	call   100a07 <parse>
  100ad5:	83 c4 10             	add    $0x10,%esp
  100ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100adb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100adf:	75 0a                	jne    100aeb <runcmd+0x2b>
        return 0;
  100ae1:	b8 00 00 00 00       	mov    $0x0,%eax
  100ae6:	e9 84 00 00 00       	jmp    100b6f <runcmd+0xaf>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100aeb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100af2:	eb 5a                	jmp    100b4e <runcmd+0x8e>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100af4:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100af7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100afa:	89 d0                	mov    %edx,%eax
  100afc:	01 c0                	add    %eax,%eax
  100afe:	01 d0                	add    %edx,%eax
  100b00:	c1 e0 02             	shl    $0x2,%eax
  100b03:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b08:	8b 00                	mov    (%eax),%eax
  100b0a:	83 ec 08             	sub    $0x8,%esp
  100b0d:	51                   	push   %ecx
  100b0e:	50                   	push   %eax
  100b0f:	e8 a8 1c 00 00       	call   1027bc <strcmp>
  100b14:	83 c4 10             	add    $0x10,%esp
  100b17:	85 c0                	test   %eax,%eax
  100b19:	75 2f                	jne    100b4a <runcmd+0x8a>
            return commands[i].func(argc - 1, argv + 1, tf);
  100b1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b1e:	89 d0                	mov    %edx,%eax
  100b20:	01 c0                	add    %eax,%eax
  100b22:	01 d0                	add    %edx,%eax
  100b24:	c1 e0 02             	shl    $0x2,%eax
  100b27:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b2c:	8b 40 08             	mov    0x8(%eax),%eax
  100b2f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100b32:	83 ea 01             	sub    $0x1,%edx
  100b35:	83 ec 04             	sub    $0x4,%esp
  100b38:	ff 75 0c             	pushl  0xc(%ebp)
  100b3b:	8d 4d b0             	lea    -0x50(%ebp),%ecx
  100b3e:	83 c1 04             	add    $0x4,%ecx
  100b41:	51                   	push   %ecx
  100b42:	52                   	push   %edx
  100b43:	ff d0                	call   *%eax
  100b45:	83 c4 10             	add    $0x10,%esp
  100b48:	eb 25                	jmp    100b6f <runcmd+0xaf>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b4a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b51:	83 f8 02             	cmp    $0x2,%eax
  100b54:	76 9e                	jbe    100af4 <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100b56:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100b59:	83 ec 08             	sub    $0x8,%esp
  100b5c:	50                   	push   %eax
  100b5d:	68 27 34 10 00       	push   $0x103427
  100b62:	e8 cd f6 ff ff       	call   100234 <cprintf>
  100b67:	83 c4 10             	add    $0x10,%esp
    return 0;
  100b6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100b6f:	c9                   	leave  
  100b70:	c3                   	ret    

00100b71 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100b71:	55                   	push   %ebp
  100b72:	89 e5                	mov    %esp,%ebp
  100b74:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100b77:	83 ec 0c             	sub    $0xc,%esp
  100b7a:	68 40 34 10 00       	push   $0x103440
  100b7f:	e8 b0 f6 ff ff       	call   100234 <cprintf>
  100b84:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100b87:	83 ec 0c             	sub    $0xc,%esp
  100b8a:	68 68 34 10 00       	push   $0x103468
  100b8f:	e8 a0 f6 ff ff       	call   100234 <cprintf>
  100b94:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100b97:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100b9b:	74 0e                	je     100bab <kmonitor+0x3a>
        print_trapframe(tf);
  100b9d:	83 ec 0c             	sub    $0xc,%esp
  100ba0:	ff 75 08             	pushl  0x8(%ebp)
  100ba3:	e8 ad 0b 00 00       	call   101755 <print_trapframe>
  100ba8:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100bab:	83 ec 0c             	sub    $0xc,%esp
  100bae:	68 8d 34 10 00       	push   $0x10348d
  100bb3:	e8 1f f7 ff ff       	call   1002d7 <readline>
  100bb8:	83 c4 10             	add    $0x10,%esp
  100bbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100bbe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100bc2:	74 17                	je     100bdb <kmonitor+0x6a>
            if (runcmd(buf, tf) < 0) {
  100bc4:	83 ec 08             	sub    $0x8,%esp
  100bc7:	ff 75 08             	pushl  0x8(%ebp)
  100bca:	ff 75 f4             	pushl  -0xc(%ebp)
  100bcd:	e8 ee fe ff ff       	call   100ac0 <runcmd>
  100bd2:	83 c4 10             	add    $0x10,%esp
  100bd5:	85 c0                	test   %eax,%eax
  100bd7:	79 02                	jns    100bdb <kmonitor+0x6a>
                break;
  100bd9:	eb 02                	jmp    100bdd <kmonitor+0x6c>
            }
        }
    }
  100bdb:	eb ce                	jmp    100bab <kmonitor+0x3a>
}
  100bdd:	c9                   	leave  
  100bde:	c3                   	ret    

00100bdf <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100bdf:	55                   	push   %ebp
  100be0:	89 e5                	mov    %esp,%ebp
  100be2:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100be5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100bec:	eb 3d                	jmp    100c2b <mon_help+0x4c>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100bee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bf1:	89 d0                	mov    %edx,%eax
  100bf3:	01 c0                	add    %eax,%eax
  100bf5:	01 d0                	add    %edx,%eax
  100bf7:	c1 e0 02             	shl    $0x2,%eax
  100bfa:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bff:	8b 48 04             	mov    0x4(%eax),%ecx
  100c02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c05:	89 d0                	mov    %edx,%eax
  100c07:	01 c0                	add    %eax,%eax
  100c09:	01 d0                	add    %edx,%eax
  100c0b:	c1 e0 02             	shl    $0x2,%eax
  100c0e:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c13:	8b 00                	mov    (%eax),%eax
  100c15:	83 ec 04             	sub    $0x4,%esp
  100c18:	51                   	push   %ecx
  100c19:	50                   	push   %eax
  100c1a:	68 91 34 10 00       	push   $0x103491
  100c1f:	e8 10 f6 ff ff       	call   100234 <cprintf>
  100c24:	83 c4 10             	add    $0x10,%esp

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c27:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c2e:	83 f8 02             	cmp    $0x2,%eax
  100c31:	76 bb                	jbe    100bee <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100c33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c38:	c9                   	leave  
  100c39:	c3                   	ret    

00100c3a <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100c3a:	55                   	push   %ebp
  100c3b:	89 e5                	mov    %esp,%ebp
  100c3d:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100c40:	e8 75 fc ff ff       	call   1008ba <print_kerninfo>
    return 0;
  100c45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c4a:	c9                   	leave  
  100c4b:	c3                   	ret    

00100c4c <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100c4c:	55                   	push   %ebp
  100c4d:	89 e5                	mov    %esp,%ebp
  100c4f:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100c52:	e8 ab fd ff ff       	call   100a02 <print_stackframe>
    return 0;
  100c57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c5c:	c9                   	leave  
  100c5d:	c3                   	ret    

00100c5e <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100c5e:	55                   	push   %ebp
  100c5f:	89 e5                	mov    %esp,%ebp
  100c61:	83 ec 18             	sub    $0x18,%esp
  100c64:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100c6a:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100c6e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100c72:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100c76:	ee                   	out    %al,(%dx)
  100c77:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100c7d:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100c81:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100c85:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100c89:	ee                   	out    %al,(%dx)
  100c8a:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100c90:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100c94:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100c98:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100c9c:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100c9d:	c7 05 e8 f9 10 00 00 	movl   $0x0,0x10f9e8
  100ca4:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100ca7:	83 ec 0c             	sub    $0xc,%esp
  100caa:	68 9a 34 10 00       	push   $0x10349a
  100caf:	e8 80 f5 ff ff       	call   100234 <cprintf>
  100cb4:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100cb7:	83 ec 0c             	sub    $0xc,%esp
  100cba:	6a 00                	push   $0x0
  100cbc:	e8 ba 08 00 00       	call   10157b <pic_enable>
  100cc1:	83 c4 10             	add    $0x10,%esp
}
  100cc4:	c9                   	leave  
  100cc5:	c3                   	ret    

00100cc6 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100cc6:	55                   	push   %ebp
  100cc7:	89 e5                	mov    %esp,%ebp
  100cc9:	83 ec 10             	sub    $0x10,%esp
  100ccc:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100cd2:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100cd6:	89 c2                	mov    %eax,%edx
  100cd8:	ec                   	in     (%dx),%al
  100cd9:	88 45 fd             	mov    %al,-0x3(%ebp)
  100cdc:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100ce2:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100ce6:	89 c2                	mov    %eax,%edx
  100ce8:	ec                   	in     (%dx),%al
  100ce9:	88 45 f9             	mov    %al,-0x7(%ebp)
  100cec:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100cf2:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100cf6:	89 c2                	mov    %eax,%edx
  100cf8:	ec                   	in     (%dx),%al
  100cf9:	88 45 f5             	mov    %al,-0xb(%ebp)
  100cfc:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100d02:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100d06:	89 c2                	mov    %eax,%edx
  100d08:	ec                   	in     (%dx),%al
  100d09:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100d0c:	c9                   	leave  
  100d0d:	c3                   	ret    

00100d0e <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100d0e:	55                   	push   %ebp
  100d0f:	89 e5                	mov    %esp,%ebp
  100d11:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100d14:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100d1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d1e:	0f b7 00             	movzwl (%eax),%eax
  100d21:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100d25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d28:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100d2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d30:	0f b7 00             	movzwl (%eax),%eax
  100d33:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100d37:	74 12                	je     100d4b <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100d39:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100d40:	66 c7 05 06 ef 10 00 	movw   $0x3b4,0x10ef06
  100d47:	b4 03 
  100d49:	eb 13                	jmp    100d5e <cga_init+0x50>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100d4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d4e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100d52:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100d55:	66 c7 05 06 ef 10 00 	movw   $0x3d4,0x10ef06
  100d5c:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100d5e:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  100d65:	0f b7 c0             	movzwl %ax,%eax
  100d68:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100d6c:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d70:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100d74:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d78:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100d79:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  100d80:	83 c0 01             	add    $0x1,%eax
  100d83:	0f b7 c0             	movzwl %ax,%eax
  100d86:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d8a:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100d8e:	89 c2                	mov    %eax,%edx
  100d90:	ec                   	in     (%dx),%al
  100d91:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100d94:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100d98:	0f b6 c0             	movzbl %al,%eax
  100d9b:	c1 e0 08             	shl    $0x8,%eax
  100d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100da1:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  100da8:	0f b7 c0             	movzwl %ax,%eax
  100dab:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100daf:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100db3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100db7:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100dbb:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100dbc:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  100dc3:	83 c0 01             	add    $0x1,%eax
  100dc6:	0f b7 c0             	movzwl %ax,%eax
  100dc9:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100dcd:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100dd1:	89 c2                	mov    %eax,%edx
  100dd3:	ec                   	in     (%dx),%al
  100dd4:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100dd7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ddb:	0f b6 c0             	movzbl %al,%eax
  100dde:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100de1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100de4:	a3 00 ef 10 00       	mov    %eax,0x10ef00
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dec:	66 a3 04 ef 10 00    	mov    %ax,0x10ef04
}
  100df2:	c9                   	leave  
  100df3:	c3                   	ret    

00100df4 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100df4:	55                   	push   %ebp
  100df5:	89 e5                	mov    %esp,%ebp
  100df7:	83 ec 38             	sub    $0x38,%esp
  100dfa:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100e00:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e04:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e08:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e0c:	ee                   	out    %al,(%dx)
  100e0d:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100e13:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100e17:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e1b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e1f:	ee                   	out    %al,(%dx)
  100e20:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100e26:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100e2a:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e2e:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e32:	ee                   	out    %al,(%dx)
  100e33:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100e39:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100e3d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100e41:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100e45:	ee                   	out    %al,(%dx)
  100e46:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100e4c:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100e50:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e54:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100e58:	ee                   	out    %al,(%dx)
  100e59:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100e5f:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100e63:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100e67:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100e6b:	ee                   	out    %al,(%dx)
  100e6c:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100e72:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100e76:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100e7a:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100e7e:	ee                   	out    %al,(%dx)
  100e7f:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e85:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100e89:	89 c2                	mov    %eax,%edx
  100e8b:	ec                   	in     (%dx),%al
  100e8c:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100e8f:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100e93:	3c ff                	cmp    $0xff,%al
  100e95:	0f 95 c0             	setne  %al
  100e98:	0f b6 c0             	movzbl %al,%eax
  100e9b:	a3 08 ef 10 00       	mov    %eax,0x10ef08
  100ea0:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ea6:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100eaa:	89 c2                	mov    %eax,%edx
  100eac:	ec                   	in     (%dx),%al
  100ead:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100eb0:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100eb6:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100eba:	89 c2                	mov    %eax,%edx
  100ebc:	ec                   	in     (%dx),%al
  100ebd:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100ec0:	a1 08 ef 10 00       	mov    0x10ef08,%eax
  100ec5:	85 c0                	test   %eax,%eax
  100ec7:	74 0d                	je     100ed6 <serial_init+0xe2>
        pic_enable(IRQ_COM1);
  100ec9:	83 ec 0c             	sub    $0xc,%esp
  100ecc:	6a 04                	push   $0x4
  100ece:	e8 a8 06 00 00       	call   10157b <pic_enable>
  100ed3:	83 c4 10             	add    $0x10,%esp
    }
}
  100ed6:	c9                   	leave  
  100ed7:	c3                   	ret    

00100ed8 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100ed8:	55                   	push   %ebp
  100ed9:	89 e5                	mov    %esp,%ebp
  100edb:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100ede:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100ee5:	eb 09                	jmp    100ef0 <lpt_putc_sub+0x18>
        delay();
  100ee7:	e8 da fd ff ff       	call   100cc6 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100eec:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100ef0:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  100ef6:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100efa:	89 c2                	mov    %eax,%edx
  100efc:	ec                   	in     (%dx),%al
  100efd:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  100f00:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  100f04:	84 c0                	test   %al,%al
  100f06:	78 09                	js     100f11 <lpt_putc_sub+0x39>
  100f08:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  100f0f:	7e d6                	jle    100ee7 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  100f11:	8b 45 08             	mov    0x8(%ebp),%eax
  100f14:	0f b6 c0             	movzbl %al,%eax
  100f17:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  100f1d:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f20:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f24:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f28:	ee                   	out    %al,(%dx)
  100f29:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  100f2f:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  100f33:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f37:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f3b:	ee                   	out    %al,(%dx)
  100f3c:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  100f42:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  100f46:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f4a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f4e:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  100f4f:	c9                   	leave  
  100f50:	c3                   	ret    

00100f51 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  100f51:	55                   	push   %ebp
  100f52:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  100f54:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  100f58:	74 0d                	je     100f67 <lpt_putc+0x16>
        lpt_putc_sub(c);
  100f5a:	ff 75 08             	pushl  0x8(%ebp)
  100f5d:	e8 76 ff ff ff       	call   100ed8 <lpt_putc_sub>
  100f62:	83 c4 04             	add    $0x4,%esp
  100f65:	eb 1e                	jmp    100f85 <lpt_putc+0x34>
    }
    else {
        lpt_putc_sub('\b');
  100f67:	6a 08                	push   $0x8
  100f69:	e8 6a ff ff ff       	call   100ed8 <lpt_putc_sub>
  100f6e:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  100f71:	6a 20                	push   $0x20
  100f73:	e8 60 ff ff ff       	call   100ed8 <lpt_putc_sub>
  100f78:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  100f7b:	6a 08                	push   $0x8
  100f7d:	e8 56 ff ff ff       	call   100ed8 <lpt_putc_sub>
  100f82:	83 c4 04             	add    $0x4,%esp
    }
}
  100f85:	c9                   	leave  
  100f86:	c3                   	ret    

00100f87 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  100f87:	55                   	push   %ebp
  100f88:	89 e5                	mov    %esp,%ebp
  100f8a:	53                   	push   %ebx
  100f8b:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  100f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  100f91:	b0 00                	mov    $0x0,%al
  100f93:	85 c0                	test   %eax,%eax
  100f95:	75 07                	jne    100f9e <cga_putc+0x17>
        c |= 0x0700;
  100f97:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  100f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  100fa1:	0f b6 c0             	movzbl %al,%eax
  100fa4:	83 f8 0a             	cmp    $0xa,%eax
  100fa7:	74 4c                	je     100ff5 <cga_putc+0x6e>
  100fa9:	83 f8 0d             	cmp    $0xd,%eax
  100fac:	74 57                	je     101005 <cga_putc+0x7e>
  100fae:	83 f8 08             	cmp    $0x8,%eax
  100fb1:	0f 85 88 00 00 00    	jne    10103f <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  100fb7:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  100fbe:	66 85 c0             	test   %ax,%ax
  100fc1:	74 30                	je     100ff3 <cga_putc+0x6c>
            crt_pos --;
  100fc3:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  100fca:	83 e8 01             	sub    $0x1,%eax
  100fcd:	66 a3 04 ef 10 00    	mov    %ax,0x10ef04
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  100fd3:	a1 00 ef 10 00       	mov    0x10ef00,%eax
  100fd8:	0f b7 15 04 ef 10 00 	movzwl 0x10ef04,%edx
  100fdf:	0f b7 d2             	movzwl %dx,%edx
  100fe2:	01 d2                	add    %edx,%edx
  100fe4:	01 d0                	add    %edx,%eax
  100fe6:	8b 55 08             	mov    0x8(%ebp),%edx
  100fe9:	b2 00                	mov    $0x0,%dl
  100feb:	83 ca 20             	or     $0x20,%edx
  100fee:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  100ff1:	eb 71                	jmp    101064 <cga_putc+0xdd>
  100ff3:	eb 6f                	jmp    101064 <cga_putc+0xdd>
    case '\n':
        crt_pos += CRT_COLS;
  100ff5:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  100ffc:	83 c0 50             	add    $0x50,%eax
  100fff:	66 a3 04 ef 10 00    	mov    %ax,0x10ef04
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101005:	0f b7 1d 04 ef 10 00 	movzwl 0x10ef04,%ebx
  10100c:	0f b7 0d 04 ef 10 00 	movzwl 0x10ef04,%ecx
  101013:	0f b7 c1             	movzwl %cx,%eax
  101016:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10101c:	c1 e8 10             	shr    $0x10,%eax
  10101f:	89 c2                	mov    %eax,%edx
  101021:	66 c1 ea 06          	shr    $0x6,%dx
  101025:	89 d0                	mov    %edx,%eax
  101027:	c1 e0 02             	shl    $0x2,%eax
  10102a:	01 d0                	add    %edx,%eax
  10102c:	c1 e0 04             	shl    $0x4,%eax
  10102f:	29 c1                	sub    %eax,%ecx
  101031:	89 ca                	mov    %ecx,%edx
  101033:	89 d8                	mov    %ebx,%eax
  101035:	29 d0                	sub    %edx,%eax
  101037:	66 a3 04 ef 10 00    	mov    %ax,0x10ef04
        break;
  10103d:	eb 25                	jmp    101064 <cga_putc+0xdd>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10103f:	8b 0d 00 ef 10 00    	mov    0x10ef00,%ecx
  101045:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  10104c:	8d 50 01             	lea    0x1(%eax),%edx
  10104f:	66 89 15 04 ef 10 00 	mov    %dx,0x10ef04
  101056:	0f b7 c0             	movzwl %ax,%eax
  101059:	01 c0                	add    %eax,%eax
  10105b:	01 c8                	add    %ecx,%eax
  10105d:	8b 55 08             	mov    0x8(%ebp),%edx
  101060:	66 89 10             	mov    %dx,(%eax)
        break;
  101063:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101064:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  10106b:	66 3d cf 07          	cmp    $0x7cf,%ax
  10106f:	76 59                	jbe    1010ca <cga_putc+0x143>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101071:	a1 00 ef 10 00       	mov    0x10ef00,%eax
  101076:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10107c:	a1 00 ef 10 00       	mov    0x10ef00,%eax
  101081:	83 ec 04             	sub    $0x4,%esp
  101084:	68 00 0f 00 00       	push   $0xf00
  101089:	52                   	push   %edx
  10108a:	50                   	push   %eax
  10108b:	e8 cb 19 00 00       	call   102a5b <memmove>
  101090:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101093:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10109a:	eb 15                	jmp    1010b1 <cga_putc+0x12a>
            crt_buf[i] = 0x0700 | ' ';
  10109c:	a1 00 ef 10 00       	mov    0x10ef00,%eax
  1010a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1010a4:	01 d2                	add    %edx,%edx
  1010a6:	01 d0                	add    %edx,%eax
  1010a8:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1010ad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1010b1:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1010b8:	7e e2                	jle    10109c <cga_putc+0x115>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  1010ba:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  1010c1:	83 e8 50             	sub    $0x50,%eax
  1010c4:	66 a3 04 ef 10 00    	mov    %ax,0x10ef04
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1010ca:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  1010d1:	0f b7 c0             	movzwl %ax,%eax
  1010d4:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  1010d8:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  1010dc:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010e0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010e4:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  1010e5:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  1010ec:	66 c1 e8 08          	shr    $0x8,%ax
  1010f0:	0f b6 c0             	movzbl %al,%eax
  1010f3:	0f b7 15 06 ef 10 00 	movzwl 0x10ef06,%edx
  1010fa:	83 c2 01             	add    $0x1,%edx
  1010fd:	0f b7 d2             	movzwl %dx,%edx
  101100:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101104:	88 45 ed             	mov    %al,-0x13(%ebp)
  101107:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10110b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10110f:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101110:	0f b7 05 06 ef 10 00 	movzwl 0x10ef06,%eax
  101117:	0f b7 c0             	movzwl %ax,%eax
  10111a:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  10111e:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101122:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101126:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10112a:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10112b:	0f b7 05 04 ef 10 00 	movzwl 0x10ef04,%eax
  101132:	0f b6 c0             	movzbl %al,%eax
  101135:	0f b7 15 06 ef 10 00 	movzwl 0x10ef06,%edx
  10113c:	83 c2 01             	add    $0x1,%edx
  10113f:	0f b7 d2             	movzwl %dx,%edx
  101142:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  101146:	88 45 e5             	mov    %al,-0x1b(%ebp)
  101149:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10114d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101151:	ee                   	out    %al,(%dx)
}
  101152:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101155:	c9                   	leave  
  101156:	c3                   	ret    

00101157 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101157:	55                   	push   %ebp
  101158:	89 e5                	mov    %esp,%ebp
  10115a:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10115d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101164:	eb 09                	jmp    10116f <serial_putc_sub+0x18>
        delay();
  101166:	e8 5b fb ff ff       	call   100cc6 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10116b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10116f:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101175:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101179:	89 c2                	mov    %eax,%edx
  10117b:	ec                   	in     (%dx),%al
  10117c:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10117f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101183:	0f b6 c0             	movzbl %al,%eax
  101186:	83 e0 20             	and    $0x20,%eax
  101189:	85 c0                	test   %eax,%eax
  10118b:	75 09                	jne    101196 <serial_putc_sub+0x3f>
  10118d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101194:	7e d0                	jle    101166 <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  101196:	8b 45 08             	mov    0x8(%ebp),%eax
  101199:	0f b6 c0             	movzbl %al,%eax
  10119c:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011a2:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1011a5:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1011a9:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1011ad:	ee                   	out    %al,(%dx)
}
  1011ae:	c9                   	leave  
  1011af:	c3                   	ret    

001011b0 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1011b0:	55                   	push   %ebp
  1011b1:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  1011b3:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1011b7:	74 0d                	je     1011c6 <serial_putc+0x16>
        serial_putc_sub(c);
  1011b9:	ff 75 08             	pushl  0x8(%ebp)
  1011bc:	e8 96 ff ff ff       	call   101157 <serial_putc_sub>
  1011c1:	83 c4 04             	add    $0x4,%esp
  1011c4:	eb 1e                	jmp    1011e4 <serial_putc+0x34>
    }
    else {
        serial_putc_sub('\b');
  1011c6:	6a 08                	push   $0x8
  1011c8:	e8 8a ff ff ff       	call   101157 <serial_putc_sub>
  1011cd:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  1011d0:	6a 20                	push   $0x20
  1011d2:	e8 80 ff ff ff       	call   101157 <serial_putc_sub>
  1011d7:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  1011da:	6a 08                	push   $0x8
  1011dc:	e8 76 ff ff ff       	call   101157 <serial_putc_sub>
  1011e1:	83 c4 04             	add    $0x4,%esp
    }
}
  1011e4:	c9                   	leave  
  1011e5:	c3                   	ret    

001011e6 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1011e6:	55                   	push   %ebp
  1011e7:	89 e5                	mov    %esp,%ebp
  1011e9:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1011ec:	eb 33                	jmp    101221 <cons_intr+0x3b>
        if (c != 0) {
  1011ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1011f2:	74 2d                	je     101221 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  1011f4:	a1 44 f1 10 00       	mov    0x10f144,%eax
  1011f9:	8d 50 01             	lea    0x1(%eax),%edx
  1011fc:	89 15 44 f1 10 00    	mov    %edx,0x10f144
  101202:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101205:	88 90 40 ef 10 00    	mov    %dl,0x10ef40(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  10120b:	a1 44 f1 10 00       	mov    0x10f144,%eax
  101210:	3d 00 02 00 00       	cmp    $0x200,%eax
  101215:	75 0a                	jne    101221 <cons_intr+0x3b>
                cons.wpos = 0;
  101217:	c7 05 44 f1 10 00 00 	movl   $0x0,0x10f144
  10121e:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  101221:	8b 45 08             	mov    0x8(%ebp),%eax
  101224:	ff d0                	call   *%eax
  101226:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101229:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  10122d:	75 bf                	jne    1011ee <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  10122f:	c9                   	leave  
  101230:	c3                   	ret    

00101231 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101231:	55                   	push   %ebp
  101232:	89 e5                	mov    %esp,%ebp
  101234:	83 ec 10             	sub    $0x10,%esp
  101237:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10123d:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101241:	89 c2                	mov    %eax,%edx
  101243:	ec                   	in     (%dx),%al
  101244:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101247:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10124b:	0f b6 c0             	movzbl %al,%eax
  10124e:	83 e0 01             	and    $0x1,%eax
  101251:	85 c0                	test   %eax,%eax
  101253:	75 07                	jne    10125c <serial_proc_data+0x2b>
        return -1;
  101255:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10125a:	eb 2a                	jmp    101286 <serial_proc_data+0x55>
  10125c:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101262:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101266:	89 c2                	mov    %eax,%edx
  101268:	ec                   	in     (%dx),%al
  101269:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10126c:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101270:	0f b6 c0             	movzbl %al,%eax
  101273:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101276:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10127a:	75 07                	jne    101283 <serial_proc_data+0x52>
        c = '\b';
  10127c:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101283:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101286:	c9                   	leave  
  101287:	c3                   	ret    

00101288 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101288:	55                   	push   %ebp
  101289:	89 e5                	mov    %esp,%ebp
  10128b:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  10128e:	a1 08 ef 10 00       	mov    0x10ef08,%eax
  101293:	85 c0                	test   %eax,%eax
  101295:	74 10                	je     1012a7 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101297:	83 ec 0c             	sub    $0xc,%esp
  10129a:	68 31 12 10 00       	push   $0x101231
  10129f:	e8 42 ff ff ff       	call   1011e6 <cons_intr>
  1012a4:	83 c4 10             	add    $0x10,%esp
    }
}
  1012a7:	c9                   	leave  
  1012a8:	c3                   	ret    

001012a9 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1012a9:	55                   	push   %ebp
  1012aa:	89 e5                	mov    %esp,%ebp
  1012ac:	83 ec 28             	sub    $0x28,%esp
  1012af:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012b5:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1012b9:	89 c2                	mov    %eax,%edx
  1012bb:	ec                   	in     (%dx),%al
  1012bc:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1012bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1012c3:	0f b6 c0             	movzbl %al,%eax
  1012c6:	83 e0 01             	and    $0x1,%eax
  1012c9:	85 c0                	test   %eax,%eax
  1012cb:	75 0a                	jne    1012d7 <kbd_proc_data+0x2e>
        return -1;
  1012cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1012d2:	e9 5d 01 00 00       	jmp    101434 <kbd_proc_data+0x18b>
  1012d7:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012dd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1012e1:	89 c2                	mov    %eax,%edx
  1012e3:	ec                   	in     (%dx),%al
  1012e4:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1012e7:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1012eb:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1012ee:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1012f2:	75 17                	jne    10130b <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  1012f4:	a1 48 f1 10 00       	mov    0x10f148,%eax
  1012f9:	83 c8 40             	or     $0x40,%eax
  1012fc:	a3 48 f1 10 00       	mov    %eax,0x10f148
        return 0;
  101301:	b8 00 00 00 00       	mov    $0x0,%eax
  101306:	e9 29 01 00 00       	jmp    101434 <kbd_proc_data+0x18b>
    } else if (data & 0x80) {
  10130b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10130f:	84 c0                	test   %al,%al
  101311:	79 47                	jns    10135a <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101313:	a1 48 f1 10 00       	mov    0x10f148,%eax
  101318:	83 e0 40             	and    $0x40,%eax
  10131b:	85 c0                	test   %eax,%eax
  10131d:	75 09                	jne    101328 <kbd_proc_data+0x7f>
  10131f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101323:	83 e0 7f             	and    $0x7f,%eax
  101326:	eb 04                	jmp    10132c <kbd_proc_data+0x83>
  101328:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10132c:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  10132f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101333:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10133a:	83 c8 40             	or     $0x40,%eax
  10133d:	0f b6 c0             	movzbl %al,%eax
  101340:	f7 d0                	not    %eax
  101342:	89 c2                	mov    %eax,%edx
  101344:	a1 48 f1 10 00       	mov    0x10f148,%eax
  101349:	21 d0                	and    %edx,%eax
  10134b:	a3 48 f1 10 00       	mov    %eax,0x10f148
        return 0;
  101350:	b8 00 00 00 00       	mov    $0x0,%eax
  101355:	e9 da 00 00 00       	jmp    101434 <kbd_proc_data+0x18b>
    } else if (shift & E0ESC) {
  10135a:	a1 48 f1 10 00       	mov    0x10f148,%eax
  10135f:	83 e0 40             	and    $0x40,%eax
  101362:	85 c0                	test   %eax,%eax
  101364:	74 11                	je     101377 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101366:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10136a:	a1 48 f1 10 00       	mov    0x10f148,%eax
  10136f:	83 e0 bf             	and    $0xffffffbf,%eax
  101372:	a3 48 f1 10 00       	mov    %eax,0x10f148
    }

    shift |= shiftcode[data];
  101377:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10137b:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101382:	0f b6 d0             	movzbl %al,%edx
  101385:	a1 48 f1 10 00       	mov    0x10f148,%eax
  10138a:	09 d0                	or     %edx,%eax
  10138c:	a3 48 f1 10 00       	mov    %eax,0x10f148
    shift ^= togglecode[data];
  101391:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101395:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  10139c:	0f b6 d0             	movzbl %al,%edx
  10139f:	a1 48 f1 10 00       	mov    0x10f148,%eax
  1013a4:	31 d0                	xor    %edx,%eax
  1013a6:	a3 48 f1 10 00       	mov    %eax,0x10f148

    c = charcode[shift & (CTL | SHIFT)][data];
  1013ab:	a1 48 f1 10 00       	mov    0x10f148,%eax
  1013b0:	83 e0 03             	and    $0x3,%eax
  1013b3:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1013ba:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013be:	01 d0                	add    %edx,%eax
  1013c0:	0f b6 00             	movzbl (%eax),%eax
  1013c3:	0f b6 c0             	movzbl %al,%eax
  1013c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1013c9:	a1 48 f1 10 00       	mov    0x10f148,%eax
  1013ce:	83 e0 08             	and    $0x8,%eax
  1013d1:	85 c0                	test   %eax,%eax
  1013d3:	74 22                	je     1013f7 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1013d5:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1013d9:	7e 0c                	jle    1013e7 <kbd_proc_data+0x13e>
  1013db:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1013df:	7f 06                	jg     1013e7 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1013e1:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1013e5:	eb 10                	jmp    1013f7 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1013e7:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1013eb:	7e 0a                	jle    1013f7 <kbd_proc_data+0x14e>
  1013ed:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1013f1:	7f 04                	jg     1013f7 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1013f3:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1013f7:	a1 48 f1 10 00       	mov    0x10f148,%eax
  1013fc:	f7 d0                	not    %eax
  1013fe:	83 e0 06             	and    $0x6,%eax
  101401:	85 c0                	test   %eax,%eax
  101403:	75 2c                	jne    101431 <kbd_proc_data+0x188>
  101405:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  10140c:	75 23                	jne    101431 <kbd_proc_data+0x188>
        cprintf("Rebooting!\n");
  10140e:	83 ec 0c             	sub    $0xc,%esp
  101411:	68 b5 34 10 00       	push   $0x1034b5
  101416:	e8 19 ee ff ff       	call   100234 <cprintf>
  10141b:	83 c4 10             	add    $0x10,%esp
  10141e:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101424:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101428:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10142c:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101430:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101431:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101434:	c9                   	leave  
  101435:	c3                   	ret    

00101436 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101436:	55                   	push   %ebp
  101437:	89 e5                	mov    %esp,%ebp
  101439:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  10143c:	83 ec 0c             	sub    $0xc,%esp
  10143f:	68 a9 12 10 00       	push   $0x1012a9
  101444:	e8 9d fd ff ff       	call   1011e6 <cons_intr>
  101449:	83 c4 10             	add    $0x10,%esp
}
  10144c:	c9                   	leave  
  10144d:	c3                   	ret    

0010144e <kbd_init>:

static void
kbd_init(void) {
  10144e:	55                   	push   %ebp
  10144f:	89 e5                	mov    %esp,%ebp
  101451:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  101454:	e8 dd ff ff ff       	call   101436 <kbd_intr>
    pic_enable(IRQ_KBD);
  101459:	83 ec 0c             	sub    $0xc,%esp
  10145c:	6a 01                	push   $0x1
  10145e:	e8 18 01 00 00       	call   10157b <pic_enable>
  101463:	83 c4 10             	add    $0x10,%esp
}
  101466:	c9                   	leave  
  101467:	c3                   	ret    

00101468 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101468:	55                   	push   %ebp
  101469:	89 e5                	mov    %esp,%ebp
  10146b:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  10146e:	e8 9b f8 ff ff       	call   100d0e <cga_init>
    serial_init();
  101473:	e8 7c f9 ff ff       	call   100df4 <serial_init>
    kbd_init();
  101478:	e8 d1 ff ff ff       	call   10144e <kbd_init>
    if (!serial_exists) {
  10147d:	a1 08 ef 10 00       	mov    0x10ef08,%eax
  101482:	85 c0                	test   %eax,%eax
  101484:	75 10                	jne    101496 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  101486:	83 ec 0c             	sub    $0xc,%esp
  101489:	68 c1 34 10 00       	push   $0x1034c1
  10148e:	e8 a1 ed ff ff       	call   100234 <cprintf>
  101493:	83 c4 10             	add    $0x10,%esp
    }
}
  101496:	c9                   	leave  
  101497:	c3                   	ret    

00101498 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101498:	55                   	push   %ebp
  101499:	89 e5                	mov    %esp,%ebp
  10149b:	83 ec 08             	sub    $0x8,%esp
    lpt_putc(c);
  10149e:	ff 75 08             	pushl  0x8(%ebp)
  1014a1:	e8 ab fa ff ff       	call   100f51 <lpt_putc>
  1014a6:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  1014a9:	83 ec 0c             	sub    $0xc,%esp
  1014ac:	ff 75 08             	pushl  0x8(%ebp)
  1014af:	e8 d3 fa ff ff       	call   100f87 <cga_putc>
  1014b4:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1014b7:	83 ec 0c             	sub    $0xc,%esp
  1014ba:	ff 75 08             	pushl  0x8(%ebp)
  1014bd:	e8 ee fc ff ff       	call   1011b0 <serial_putc>
  1014c2:	83 c4 10             	add    $0x10,%esp
}
  1014c5:	c9                   	leave  
  1014c6:	c3                   	ret    

001014c7 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1014c7:	55                   	push   %ebp
  1014c8:	89 e5                	mov    %esp,%ebp
  1014ca:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1014cd:	e8 b6 fd ff ff       	call   101288 <serial_intr>
    kbd_intr();
  1014d2:	e8 5f ff ff ff       	call   101436 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1014d7:	8b 15 40 f1 10 00    	mov    0x10f140,%edx
  1014dd:	a1 44 f1 10 00       	mov    0x10f144,%eax
  1014e2:	39 c2                	cmp    %eax,%edx
  1014e4:	74 36                	je     10151c <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  1014e6:	a1 40 f1 10 00       	mov    0x10f140,%eax
  1014eb:	8d 50 01             	lea    0x1(%eax),%edx
  1014ee:	89 15 40 f1 10 00    	mov    %edx,0x10f140
  1014f4:	0f b6 80 40 ef 10 00 	movzbl 0x10ef40(%eax),%eax
  1014fb:	0f b6 c0             	movzbl %al,%eax
  1014fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101501:	a1 40 f1 10 00       	mov    0x10f140,%eax
  101506:	3d 00 02 00 00       	cmp    $0x200,%eax
  10150b:	75 0a                	jne    101517 <cons_getc+0x50>
            cons.rpos = 0;
  10150d:	c7 05 40 f1 10 00 00 	movl   $0x0,0x10f140
  101514:	00 00 00 
        }
        return c;
  101517:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10151a:	eb 05                	jmp    101521 <cons_getc+0x5a>
    }
    return 0;
  10151c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101521:	c9                   	leave  
  101522:	c3                   	ret    

00101523 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101523:	55                   	push   %ebp
  101524:	89 e5                	mov    %esp,%ebp
  101526:	83 ec 14             	sub    $0x14,%esp
  101529:	8b 45 08             	mov    0x8(%ebp),%eax
  10152c:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101530:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101534:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  10153a:	a1 4c f1 10 00       	mov    0x10f14c,%eax
  10153f:	85 c0                	test   %eax,%eax
  101541:	74 36                	je     101579 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101543:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101547:	0f b6 c0             	movzbl %al,%eax
  10154a:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101550:	88 45 fd             	mov    %al,-0x3(%ebp)
  101553:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101557:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10155b:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  10155c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101560:	66 c1 e8 08          	shr    $0x8,%ax
  101564:	0f b6 c0             	movzbl %al,%eax
  101567:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  10156d:	88 45 f9             	mov    %al,-0x7(%ebp)
  101570:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101574:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101578:	ee                   	out    %al,(%dx)
    }
}
  101579:	c9                   	leave  
  10157a:	c3                   	ret    

0010157b <pic_enable>:

void
pic_enable(unsigned int irq) {
  10157b:	55                   	push   %ebp
  10157c:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  10157e:	8b 45 08             	mov    0x8(%ebp),%eax
  101581:	ba 01 00 00 00       	mov    $0x1,%edx
  101586:	89 c1                	mov    %eax,%ecx
  101588:	d3 e2                	shl    %cl,%edx
  10158a:	89 d0                	mov    %edx,%eax
  10158c:	f7 d0                	not    %eax
  10158e:	89 c2                	mov    %eax,%edx
  101590:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101597:	21 d0                	and    %edx,%eax
  101599:	0f b7 c0             	movzwl %ax,%eax
  10159c:	50                   	push   %eax
  10159d:	e8 81 ff ff ff       	call   101523 <pic_setmask>
  1015a2:	83 c4 04             	add    $0x4,%esp
}
  1015a5:	c9                   	leave  
  1015a6:	c3                   	ret    

001015a7 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1015a7:	55                   	push   %ebp
  1015a8:	89 e5                	mov    %esp,%ebp
  1015aa:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
  1015ad:	c7 05 4c f1 10 00 01 	movl   $0x1,0x10f14c
  1015b4:	00 00 00 
  1015b7:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  1015bd:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  1015c1:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1015c5:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1015c9:	ee                   	out    %al,(%dx)
  1015ca:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1015d0:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  1015d4:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1015d8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1015dc:	ee                   	out    %al,(%dx)
  1015dd:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  1015e3:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  1015e7:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1015eb:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1015ef:	ee                   	out    %al,(%dx)
  1015f0:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  1015f6:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  1015fa:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1015fe:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101602:	ee                   	out    %al,(%dx)
  101603:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  101609:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  10160d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101611:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101615:	ee                   	out    %al,(%dx)
  101616:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  10161c:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  101620:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101624:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101628:	ee                   	out    %al,(%dx)
  101629:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  10162f:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  101633:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101637:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10163b:	ee                   	out    %al,(%dx)
  10163c:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101642:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  101646:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10164a:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10164e:	ee                   	out    %al,(%dx)
  10164f:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  101655:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  101659:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10165d:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101661:	ee                   	out    %al,(%dx)
  101662:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  101668:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  10166c:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101670:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101674:	ee                   	out    %al,(%dx)
  101675:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  10167b:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  10167f:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101683:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101687:	ee                   	out    %al,(%dx)
  101688:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  10168e:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  101692:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101696:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  10169a:	ee                   	out    %al,(%dx)
  10169b:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1016a1:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1016a5:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1016a9:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1016ad:	ee                   	out    %al,(%dx)
  1016ae:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  1016b4:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  1016b8:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1016bc:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1016c0:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1016c1:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016c8:	66 83 f8 ff          	cmp    $0xffff,%ax
  1016cc:	74 13                	je     1016e1 <pic_init+0x13a>
        pic_setmask(irq_mask);
  1016ce:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016d5:	0f b7 c0             	movzwl %ax,%eax
  1016d8:	50                   	push   %eax
  1016d9:	e8 45 fe ff ff       	call   101523 <pic_setmask>
  1016de:	83 c4 04             	add    $0x4,%esp
    }
}
  1016e1:	c9                   	leave  
  1016e2:	c3                   	ret    

001016e3 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1016e3:	55                   	push   %ebp
  1016e4:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1016e6:	fb                   	sti    
    sti();
}
  1016e7:	5d                   	pop    %ebp
  1016e8:	c3                   	ret    

001016e9 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1016e9:	55                   	push   %ebp
  1016ea:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  1016ec:	fa                   	cli    
    cli();
}
  1016ed:	5d                   	pop    %ebp
  1016ee:	c3                   	ret    

001016ef <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1016ef:	55                   	push   %ebp
  1016f0:	89 e5                	mov    %esp,%ebp
  1016f2:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1016f5:	83 ec 08             	sub    $0x8,%esp
  1016f8:	6a 64                	push   $0x64
  1016fa:	68 00 35 10 00       	push   $0x103500
  1016ff:	e8 30 eb ff ff       	call   100234 <cprintf>
  101704:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101707:	c9                   	leave  
  101708:	c3                   	ret    

00101709 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101709:	55                   	push   %ebp
  10170a:	89 e5                	mov    %esp,%ebp
      *     Can you see idt[256] in this file? Yes, it's IDT! you can use SETGATE macro to setup each item of IDT
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
}
  10170c:	5d                   	pop    %ebp
  10170d:	c3                   	ret    

0010170e <trapname>:

static const char *
trapname(int trapno) {
  10170e:	55                   	push   %ebp
  10170f:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101711:	8b 45 08             	mov    0x8(%ebp),%eax
  101714:	83 f8 13             	cmp    $0x13,%eax
  101717:	77 0c                	ja     101725 <trapname+0x17>
        return excnames[trapno];
  101719:	8b 45 08             	mov    0x8(%ebp),%eax
  10171c:	8b 04 85 80 38 10 00 	mov    0x103880(,%eax,4),%eax
  101723:	eb 18                	jmp    10173d <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101725:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101729:	7e 0d                	jle    101738 <trapname+0x2a>
  10172b:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  10172f:	7f 07                	jg     101738 <trapname+0x2a>
        return "Hardware Interrupt";
  101731:	b8 0a 35 10 00       	mov    $0x10350a,%eax
  101736:	eb 05                	jmp    10173d <trapname+0x2f>
    }
    return "(unknown trap)";
  101738:	b8 1d 35 10 00       	mov    $0x10351d,%eax
}
  10173d:	5d                   	pop    %ebp
  10173e:	c3                   	ret    

0010173f <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  10173f:	55                   	push   %ebp
  101740:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101742:	8b 45 08             	mov    0x8(%ebp),%eax
  101745:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101749:	66 83 f8 08          	cmp    $0x8,%ax
  10174d:	0f 94 c0             	sete   %al
  101750:	0f b6 c0             	movzbl %al,%eax
}
  101753:	5d                   	pop    %ebp
  101754:	c3                   	ret    

00101755 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101755:	55                   	push   %ebp
  101756:	89 e5                	mov    %esp,%ebp
  101758:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  10175b:	83 ec 08             	sub    $0x8,%esp
  10175e:	ff 75 08             	pushl  0x8(%ebp)
  101761:	68 5e 35 10 00       	push   $0x10355e
  101766:	e8 c9 ea ff ff       	call   100234 <cprintf>
  10176b:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  10176e:	8b 45 08             	mov    0x8(%ebp),%eax
  101771:	83 ec 0c             	sub    $0xc,%esp
  101774:	50                   	push   %eax
  101775:	e8 b7 01 00 00       	call   101931 <print_regs>
  10177a:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  10177d:	8b 45 08             	mov    0x8(%ebp),%eax
  101780:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101784:	0f b7 c0             	movzwl %ax,%eax
  101787:	83 ec 08             	sub    $0x8,%esp
  10178a:	50                   	push   %eax
  10178b:	68 6f 35 10 00       	push   $0x10356f
  101790:	e8 9f ea ff ff       	call   100234 <cprintf>
  101795:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101798:	8b 45 08             	mov    0x8(%ebp),%eax
  10179b:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  10179f:	0f b7 c0             	movzwl %ax,%eax
  1017a2:	83 ec 08             	sub    $0x8,%esp
  1017a5:	50                   	push   %eax
  1017a6:	68 82 35 10 00       	push   $0x103582
  1017ab:	e8 84 ea ff ff       	call   100234 <cprintf>
  1017b0:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  1017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1017b6:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  1017ba:	0f b7 c0             	movzwl %ax,%eax
  1017bd:	83 ec 08             	sub    $0x8,%esp
  1017c0:	50                   	push   %eax
  1017c1:	68 95 35 10 00       	push   $0x103595
  1017c6:	e8 69 ea ff ff       	call   100234 <cprintf>
  1017cb:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  1017ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1017d1:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  1017d5:	0f b7 c0             	movzwl %ax,%eax
  1017d8:	83 ec 08             	sub    $0x8,%esp
  1017db:	50                   	push   %eax
  1017dc:	68 a8 35 10 00       	push   $0x1035a8
  1017e1:	e8 4e ea ff ff       	call   100234 <cprintf>
  1017e6:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  1017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1017ec:	8b 40 30             	mov    0x30(%eax),%eax
  1017ef:	83 ec 0c             	sub    $0xc,%esp
  1017f2:	50                   	push   %eax
  1017f3:	e8 16 ff ff ff       	call   10170e <trapname>
  1017f8:	83 c4 10             	add    $0x10,%esp
  1017fb:	89 c2                	mov    %eax,%edx
  1017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  101800:	8b 40 30             	mov    0x30(%eax),%eax
  101803:	83 ec 04             	sub    $0x4,%esp
  101806:	52                   	push   %edx
  101807:	50                   	push   %eax
  101808:	68 bb 35 10 00       	push   $0x1035bb
  10180d:	e8 22 ea ff ff       	call   100234 <cprintf>
  101812:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101815:	8b 45 08             	mov    0x8(%ebp),%eax
  101818:	8b 40 34             	mov    0x34(%eax),%eax
  10181b:	83 ec 08             	sub    $0x8,%esp
  10181e:	50                   	push   %eax
  10181f:	68 cd 35 10 00       	push   $0x1035cd
  101824:	e8 0b ea ff ff       	call   100234 <cprintf>
  101829:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  10182c:	8b 45 08             	mov    0x8(%ebp),%eax
  10182f:	8b 40 38             	mov    0x38(%eax),%eax
  101832:	83 ec 08             	sub    $0x8,%esp
  101835:	50                   	push   %eax
  101836:	68 dc 35 10 00       	push   $0x1035dc
  10183b:	e8 f4 e9 ff ff       	call   100234 <cprintf>
  101840:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101843:	8b 45 08             	mov    0x8(%ebp),%eax
  101846:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10184a:	0f b7 c0             	movzwl %ax,%eax
  10184d:	83 ec 08             	sub    $0x8,%esp
  101850:	50                   	push   %eax
  101851:	68 eb 35 10 00       	push   $0x1035eb
  101856:	e8 d9 e9 ff ff       	call   100234 <cprintf>
  10185b:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  10185e:	8b 45 08             	mov    0x8(%ebp),%eax
  101861:	8b 40 40             	mov    0x40(%eax),%eax
  101864:	83 ec 08             	sub    $0x8,%esp
  101867:	50                   	push   %eax
  101868:	68 fe 35 10 00       	push   $0x1035fe
  10186d:	e8 c2 e9 ff ff       	call   100234 <cprintf>
  101872:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101875:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10187c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101883:	eb 3f                	jmp    1018c4 <print_trapframe+0x16f>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101885:	8b 45 08             	mov    0x8(%ebp),%eax
  101888:	8b 50 40             	mov    0x40(%eax),%edx
  10188b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10188e:	21 d0                	and    %edx,%eax
  101890:	85 c0                	test   %eax,%eax
  101892:	74 29                	je     1018bd <print_trapframe+0x168>
  101894:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101897:	8b 04 85 c0 e5 10 00 	mov    0x10e5c0(,%eax,4),%eax
  10189e:	85 c0                	test   %eax,%eax
  1018a0:	74 1b                	je     1018bd <print_trapframe+0x168>
            cprintf("%s,", IA32flags[i]);
  1018a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1018a5:	8b 04 85 c0 e5 10 00 	mov    0x10e5c0(,%eax,4),%eax
  1018ac:	83 ec 08             	sub    $0x8,%esp
  1018af:	50                   	push   %eax
  1018b0:	68 0d 36 10 00       	push   $0x10360d
  1018b5:	e8 7a e9 ff ff       	call   100234 <cprintf>
  1018ba:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  1018bd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1018c1:	d1 65 f0             	shll   -0x10(%ebp)
  1018c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1018c7:	83 f8 17             	cmp    $0x17,%eax
  1018ca:	76 b9                	jbe    101885 <print_trapframe+0x130>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  1018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1018cf:	8b 40 40             	mov    0x40(%eax),%eax
  1018d2:	25 00 30 00 00       	and    $0x3000,%eax
  1018d7:	c1 e8 0c             	shr    $0xc,%eax
  1018da:	83 ec 08             	sub    $0x8,%esp
  1018dd:	50                   	push   %eax
  1018de:	68 11 36 10 00       	push   $0x103611
  1018e3:	e8 4c e9 ff ff       	call   100234 <cprintf>
  1018e8:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  1018eb:	83 ec 0c             	sub    $0xc,%esp
  1018ee:	ff 75 08             	pushl  0x8(%ebp)
  1018f1:	e8 49 fe ff ff       	call   10173f <trap_in_kernel>
  1018f6:	83 c4 10             	add    $0x10,%esp
  1018f9:	85 c0                	test   %eax,%eax
  1018fb:	75 32                	jne    10192f <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  1018fd:	8b 45 08             	mov    0x8(%ebp),%eax
  101900:	8b 40 44             	mov    0x44(%eax),%eax
  101903:	83 ec 08             	sub    $0x8,%esp
  101906:	50                   	push   %eax
  101907:	68 1a 36 10 00       	push   $0x10361a
  10190c:	e8 23 e9 ff ff       	call   100234 <cprintf>
  101911:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101914:	8b 45 08             	mov    0x8(%ebp),%eax
  101917:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  10191b:	0f b7 c0             	movzwl %ax,%eax
  10191e:	83 ec 08             	sub    $0x8,%esp
  101921:	50                   	push   %eax
  101922:	68 29 36 10 00       	push   $0x103629
  101927:	e8 08 e9 ff ff       	call   100234 <cprintf>
  10192c:	83 c4 10             	add    $0x10,%esp
    }
}
  10192f:	c9                   	leave  
  101930:	c3                   	ret    

00101931 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101931:	55                   	push   %ebp
  101932:	89 e5                	mov    %esp,%ebp
  101934:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101937:	8b 45 08             	mov    0x8(%ebp),%eax
  10193a:	8b 00                	mov    (%eax),%eax
  10193c:	83 ec 08             	sub    $0x8,%esp
  10193f:	50                   	push   %eax
  101940:	68 3c 36 10 00       	push   $0x10363c
  101945:	e8 ea e8 ff ff       	call   100234 <cprintf>
  10194a:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  10194d:	8b 45 08             	mov    0x8(%ebp),%eax
  101950:	8b 40 04             	mov    0x4(%eax),%eax
  101953:	83 ec 08             	sub    $0x8,%esp
  101956:	50                   	push   %eax
  101957:	68 4b 36 10 00       	push   $0x10364b
  10195c:	e8 d3 e8 ff ff       	call   100234 <cprintf>
  101961:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101964:	8b 45 08             	mov    0x8(%ebp),%eax
  101967:	8b 40 08             	mov    0x8(%eax),%eax
  10196a:	83 ec 08             	sub    $0x8,%esp
  10196d:	50                   	push   %eax
  10196e:	68 5a 36 10 00       	push   $0x10365a
  101973:	e8 bc e8 ff ff       	call   100234 <cprintf>
  101978:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  10197b:	8b 45 08             	mov    0x8(%ebp),%eax
  10197e:	8b 40 0c             	mov    0xc(%eax),%eax
  101981:	83 ec 08             	sub    $0x8,%esp
  101984:	50                   	push   %eax
  101985:	68 69 36 10 00       	push   $0x103669
  10198a:	e8 a5 e8 ff ff       	call   100234 <cprintf>
  10198f:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101992:	8b 45 08             	mov    0x8(%ebp),%eax
  101995:	8b 40 10             	mov    0x10(%eax),%eax
  101998:	83 ec 08             	sub    $0x8,%esp
  10199b:	50                   	push   %eax
  10199c:	68 78 36 10 00       	push   $0x103678
  1019a1:	e8 8e e8 ff ff       	call   100234 <cprintf>
  1019a6:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  1019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ac:	8b 40 14             	mov    0x14(%eax),%eax
  1019af:	83 ec 08             	sub    $0x8,%esp
  1019b2:	50                   	push   %eax
  1019b3:	68 87 36 10 00       	push   $0x103687
  1019b8:	e8 77 e8 ff ff       	call   100234 <cprintf>
  1019bd:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  1019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1019c3:	8b 40 18             	mov    0x18(%eax),%eax
  1019c6:	83 ec 08             	sub    $0x8,%esp
  1019c9:	50                   	push   %eax
  1019ca:	68 96 36 10 00       	push   $0x103696
  1019cf:	e8 60 e8 ff ff       	call   100234 <cprintf>
  1019d4:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  1019d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1019da:	8b 40 1c             	mov    0x1c(%eax),%eax
  1019dd:	83 ec 08             	sub    $0x8,%esp
  1019e0:	50                   	push   %eax
  1019e1:	68 a5 36 10 00       	push   $0x1036a5
  1019e6:	e8 49 e8 ff ff       	call   100234 <cprintf>
  1019eb:	83 c4 10             	add    $0x10,%esp
}
  1019ee:	c9                   	leave  
  1019ef:	c3                   	ret    

001019f0 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  1019f0:	55                   	push   %ebp
  1019f1:	89 e5                	mov    %esp,%ebp
  1019f3:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {            //查找相应的中断号
  1019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1019f9:	8b 40 30             	mov    0x30(%eax),%eax
  1019fc:	83 f8 2f             	cmp    $0x2f,%eax
  1019ff:	77 1d                	ja     101a1e <trap_dispatch+0x2e>
  101a01:	83 f8 2e             	cmp    $0x2e,%eax
  101a04:	0f 83 f5 00 00 00    	jae    101aff <trap_dispatch+0x10f>
  101a0a:	83 f8 21             	cmp    $0x21,%eax
  101a0d:	74 7f                	je     101a8e <trap_dispatch+0x9e>
  101a0f:	83 f8 24             	cmp    $0x24,%eax
  101a12:	74 56                	je     101a6a <trap_dispatch+0x7a>
  101a14:	83 f8 20             	cmp    $0x20,%eax
  101a17:	74 16                	je     101a2f <trap_dispatch+0x3f>
  101a19:	e9 ab 00 00 00       	jmp    101ac9 <trap_dispatch+0xd9>
  101a1e:	83 e8 78             	sub    $0x78,%eax
  101a21:	83 f8 01             	cmp    $0x1,%eax
  101a24:	0f 87 9f 00 00 00    	ja     101ac9 <trap_dispatch+0xd9>
  101a2a:	e9 83 00 00 00       	jmp    101ab2 <trap_dispatch+0xc2>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
            ticks ++;
  101a2f:	a1 e8 f9 10 00       	mov    0x10f9e8,%eax
  101a34:	83 c0 01             	add    $0x1,%eax
  101a37:	a3 e8 f9 10 00       	mov    %eax,0x10f9e8
            if (ticks % TICK_NUM == 0){
  101a3c:	8b 0d e8 f9 10 00    	mov    0x10f9e8,%ecx
  101a42:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101a47:	89 c8                	mov    %ecx,%eax
  101a49:	f7 e2                	mul    %edx
  101a4b:	89 d0                	mov    %edx,%eax
  101a4d:	c1 e8 05             	shr    $0x5,%eax
  101a50:	6b c0 64             	imul   $0x64,%eax,%eax
  101a53:	29 c1                	sub    %eax,%ecx
  101a55:	89 c8                	mov    %ecx,%eax
  101a57:	85 c0                	test   %eax,%eax
  101a59:	75 0a                	jne    101a65 <trap_dispatch+0x75>
                print_ticks();
  101a5b:	e8 8f fc ff ff       	call   1016ef <print_ticks>
            }
        break;
  101a60:	e9 9b 00 00 00       	jmp    101b00 <trap_dispatch+0x110>
  101a65:	e9 96 00 00 00       	jmp    101b00 <trap_dispatch+0x110>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101a6a:	e8 58 fa ff ff       	call   1014c7 <cons_getc>
  101a6f:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101a72:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101a76:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101a7a:	83 ec 04             	sub    $0x4,%esp
  101a7d:	52                   	push   %edx
  101a7e:	50                   	push   %eax
  101a7f:	68 b4 36 10 00       	push   $0x1036b4
  101a84:	e8 ab e7 ff ff       	call   100234 <cprintf>
  101a89:	83 c4 10             	add    $0x10,%esp
        break;
  101a8c:	eb 72                	jmp    101b00 <trap_dispatch+0x110>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101a8e:	e8 34 fa ff ff       	call   1014c7 <cons_getc>
  101a93:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101a96:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101a9a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101a9e:	83 ec 04             	sub    $0x4,%esp
  101aa1:	52                   	push   %edx
  101aa2:	50                   	push   %eax
  101aa3:	68 c6 36 10 00       	push   $0x1036c6
  101aa8:	e8 87 e7 ff ff       	call   100234 <cprintf>
  101aad:	83 c4 10             	add    $0x10,%esp
        break;
  101ab0:	eb 4e                	jmp    101b00 <trap_dispatch+0x110>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101ab2:	83 ec 04             	sub    $0x4,%esp
  101ab5:	68 d5 36 10 00       	push   $0x1036d5
  101aba:	68 a6 00 00 00       	push   $0xa6
  101abf:	68 e5 36 10 00       	push   $0x1036e5
  101ac4:	e8 d0 e8 ff ff       	call   100399 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  101acc:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ad0:	0f b7 c0             	movzwl %ax,%eax
  101ad3:	83 e0 03             	and    $0x3,%eax
  101ad6:	85 c0                	test   %eax,%eax
  101ad8:	75 26                	jne    101b00 <trap_dispatch+0x110>
            print_trapframe(tf);
  101ada:	83 ec 0c             	sub    $0xc,%esp
  101add:	ff 75 08             	pushl  0x8(%ebp)
  101ae0:	e8 70 fc ff ff       	call   101755 <print_trapframe>
  101ae5:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101ae8:	83 ec 04             	sub    $0x4,%esp
  101aeb:	68 f6 36 10 00       	push   $0x1036f6
  101af0:	68 b0 00 00 00       	push   $0xb0
  101af5:	68 e5 36 10 00       	push   $0x1036e5
  101afa:	e8 9a e8 ff ff       	call   100399 <__panic>
        panic("T_SWITCH_** ??\n");
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101aff:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101b00:	c9                   	leave  
  101b01:	c3                   	ret    

00101b02 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101b02:	55                   	push   %ebp
  101b03:	89 e5                	mov    %esp,%ebp
  101b05:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101b08:	83 ec 0c             	sub    $0xc,%esp
  101b0b:	ff 75 08             	pushl  0x8(%ebp)
  101b0e:	e8 dd fe ff ff       	call   1019f0 <trap_dispatch>
  101b13:	83 c4 10             	add    $0x10,%esp
}
  101b16:	c9                   	leave  
  101b17:	c3                   	ret    

00101b18 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101b18:	6a 00                	push   $0x0
  pushl $0
  101b1a:	6a 00                	push   $0x0
  jmp __alltraps
  101b1c:	e9 67 0a 00 00       	jmp    102588 <__alltraps>

00101b21 <vector1>:
.globl vector1
vector1:
  pushl $0
  101b21:	6a 00                	push   $0x0
  pushl $1
  101b23:	6a 01                	push   $0x1
  jmp __alltraps
  101b25:	e9 5e 0a 00 00       	jmp    102588 <__alltraps>

00101b2a <vector2>:
.globl vector2
vector2:
  pushl $0
  101b2a:	6a 00                	push   $0x0
  pushl $2
  101b2c:	6a 02                	push   $0x2
  jmp __alltraps
  101b2e:	e9 55 0a 00 00       	jmp    102588 <__alltraps>

00101b33 <vector3>:
.globl vector3
vector3:
  pushl $0
  101b33:	6a 00                	push   $0x0
  pushl $3
  101b35:	6a 03                	push   $0x3
  jmp __alltraps
  101b37:	e9 4c 0a 00 00       	jmp    102588 <__alltraps>

00101b3c <vector4>:
.globl vector4
vector4:
  pushl $0
  101b3c:	6a 00                	push   $0x0
  pushl $4
  101b3e:	6a 04                	push   $0x4
  jmp __alltraps
  101b40:	e9 43 0a 00 00       	jmp    102588 <__alltraps>

00101b45 <vector5>:
.globl vector5
vector5:
  pushl $0
  101b45:	6a 00                	push   $0x0
  pushl $5
  101b47:	6a 05                	push   $0x5
  jmp __alltraps
  101b49:	e9 3a 0a 00 00       	jmp    102588 <__alltraps>

00101b4e <vector6>:
.globl vector6
vector6:
  pushl $0
  101b4e:	6a 00                	push   $0x0
  pushl $6
  101b50:	6a 06                	push   $0x6
  jmp __alltraps
  101b52:	e9 31 0a 00 00       	jmp    102588 <__alltraps>

00101b57 <vector7>:
.globl vector7
vector7:
  pushl $0
  101b57:	6a 00                	push   $0x0
  pushl $7
  101b59:	6a 07                	push   $0x7
  jmp __alltraps
  101b5b:	e9 28 0a 00 00       	jmp    102588 <__alltraps>

00101b60 <vector8>:
.globl vector8
vector8:
  pushl $8
  101b60:	6a 08                	push   $0x8
  jmp __alltraps
  101b62:	e9 21 0a 00 00       	jmp    102588 <__alltraps>

00101b67 <vector9>:
.globl vector9
vector9:
  pushl $9
  101b67:	6a 09                	push   $0x9
  jmp __alltraps
  101b69:	e9 1a 0a 00 00       	jmp    102588 <__alltraps>

00101b6e <vector10>:
.globl vector10
vector10:
  pushl $10
  101b6e:	6a 0a                	push   $0xa
  jmp __alltraps
  101b70:	e9 13 0a 00 00       	jmp    102588 <__alltraps>

00101b75 <vector11>:
.globl vector11
vector11:
  pushl $11
  101b75:	6a 0b                	push   $0xb
  jmp __alltraps
  101b77:	e9 0c 0a 00 00       	jmp    102588 <__alltraps>

00101b7c <vector12>:
.globl vector12
vector12:
  pushl $12
  101b7c:	6a 0c                	push   $0xc
  jmp __alltraps
  101b7e:	e9 05 0a 00 00       	jmp    102588 <__alltraps>

00101b83 <vector13>:
.globl vector13
vector13:
  pushl $13
  101b83:	6a 0d                	push   $0xd
  jmp __alltraps
  101b85:	e9 fe 09 00 00       	jmp    102588 <__alltraps>

00101b8a <vector14>:
.globl vector14
vector14:
  pushl $14
  101b8a:	6a 0e                	push   $0xe
  jmp __alltraps
  101b8c:	e9 f7 09 00 00       	jmp    102588 <__alltraps>

00101b91 <vector15>:
.globl vector15
vector15:
  pushl $0
  101b91:	6a 00                	push   $0x0
  pushl $15
  101b93:	6a 0f                	push   $0xf
  jmp __alltraps
  101b95:	e9 ee 09 00 00       	jmp    102588 <__alltraps>

00101b9a <vector16>:
.globl vector16
vector16:
  pushl $0
  101b9a:	6a 00                	push   $0x0
  pushl $16
  101b9c:	6a 10                	push   $0x10
  jmp __alltraps
  101b9e:	e9 e5 09 00 00       	jmp    102588 <__alltraps>

00101ba3 <vector17>:
.globl vector17
vector17:
  pushl $17
  101ba3:	6a 11                	push   $0x11
  jmp __alltraps
  101ba5:	e9 de 09 00 00       	jmp    102588 <__alltraps>

00101baa <vector18>:
.globl vector18
vector18:
  pushl $0
  101baa:	6a 00                	push   $0x0
  pushl $18
  101bac:	6a 12                	push   $0x12
  jmp __alltraps
  101bae:	e9 d5 09 00 00       	jmp    102588 <__alltraps>

00101bb3 <vector19>:
.globl vector19
vector19:
  pushl $0
  101bb3:	6a 00                	push   $0x0
  pushl $19
  101bb5:	6a 13                	push   $0x13
  jmp __alltraps
  101bb7:	e9 cc 09 00 00       	jmp    102588 <__alltraps>

00101bbc <vector20>:
.globl vector20
vector20:
  pushl $0
  101bbc:	6a 00                	push   $0x0
  pushl $20
  101bbe:	6a 14                	push   $0x14
  jmp __alltraps
  101bc0:	e9 c3 09 00 00       	jmp    102588 <__alltraps>

00101bc5 <vector21>:
.globl vector21
vector21:
  pushl $0
  101bc5:	6a 00                	push   $0x0
  pushl $21
  101bc7:	6a 15                	push   $0x15
  jmp __alltraps
  101bc9:	e9 ba 09 00 00       	jmp    102588 <__alltraps>

00101bce <vector22>:
.globl vector22
vector22:
  pushl $0
  101bce:	6a 00                	push   $0x0
  pushl $22
  101bd0:	6a 16                	push   $0x16
  jmp __alltraps
  101bd2:	e9 b1 09 00 00       	jmp    102588 <__alltraps>

00101bd7 <vector23>:
.globl vector23
vector23:
  pushl $0
  101bd7:	6a 00                	push   $0x0
  pushl $23
  101bd9:	6a 17                	push   $0x17
  jmp __alltraps
  101bdb:	e9 a8 09 00 00       	jmp    102588 <__alltraps>

00101be0 <vector24>:
.globl vector24
vector24:
  pushl $0
  101be0:	6a 00                	push   $0x0
  pushl $24
  101be2:	6a 18                	push   $0x18
  jmp __alltraps
  101be4:	e9 9f 09 00 00       	jmp    102588 <__alltraps>

00101be9 <vector25>:
.globl vector25
vector25:
  pushl $0
  101be9:	6a 00                	push   $0x0
  pushl $25
  101beb:	6a 19                	push   $0x19
  jmp __alltraps
  101bed:	e9 96 09 00 00       	jmp    102588 <__alltraps>

00101bf2 <vector26>:
.globl vector26
vector26:
  pushl $0
  101bf2:	6a 00                	push   $0x0
  pushl $26
  101bf4:	6a 1a                	push   $0x1a
  jmp __alltraps
  101bf6:	e9 8d 09 00 00       	jmp    102588 <__alltraps>

00101bfb <vector27>:
.globl vector27
vector27:
  pushl $0
  101bfb:	6a 00                	push   $0x0
  pushl $27
  101bfd:	6a 1b                	push   $0x1b
  jmp __alltraps
  101bff:	e9 84 09 00 00       	jmp    102588 <__alltraps>

00101c04 <vector28>:
.globl vector28
vector28:
  pushl $0
  101c04:	6a 00                	push   $0x0
  pushl $28
  101c06:	6a 1c                	push   $0x1c
  jmp __alltraps
  101c08:	e9 7b 09 00 00       	jmp    102588 <__alltraps>

00101c0d <vector29>:
.globl vector29
vector29:
  pushl $0
  101c0d:	6a 00                	push   $0x0
  pushl $29
  101c0f:	6a 1d                	push   $0x1d
  jmp __alltraps
  101c11:	e9 72 09 00 00       	jmp    102588 <__alltraps>

00101c16 <vector30>:
.globl vector30
vector30:
  pushl $0
  101c16:	6a 00                	push   $0x0
  pushl $30
  101c18:	6a 1e                	push   $0x1e
  jmp __alltraps
  101c1a:	e9 69 09 00 00       	jmp    102588 <__alltraps>

00101c1f <vector31>:
.globl vector31
vector31:
  pushl $0
  101c1f:	6a 00                	push   $0x0
  pushl $31
  101c21:	6a 1f                	push   $0x1f
  jmp __alltraps
  101c23:	e9 60 09 00 00       	jmp    102588 <__alltraps>

00101c28 <vector32>:
.globl vector32
vector32:
  pushl $0
  101c28:	6a 00                	push   $0x0
  pushl $32
  101c2a:	6a 20                	push   $0x20
  jmp __alltraps
  101c2c:	e9 57 09 00 00       	jmp    102588 <__alltraps>

00101c31 <vector33>:
.globl vector33
vector33:
  pushl $0
  101c31:	6a 00                	push   $0x0
  pushl $33
  101c33:	6a 21                	push   $0x21
  jmp __alltraps
  101c35:	e9 4e 09 00 00       	jmp    102588 <__alltraps>

00101c3a <vector34>:
.globl vector34
vector34:
  pushl $0
  101c3a:	6a 00                	push   $0x0
  pushl $34
  101c3c:	6a 22                	push   $0x22
  jmp __alltraps
  101c3e:	e9 45 09 00 00       	jmp    102588 <__alltraps>

00101c43 <vector35>:
.globl vector35
vector35:
  pushl $0
  101c43:	6a 00                	push   $0x0
  pushl $35
  101c45:	6a 23                	push   $0x23
  jmp __alltraps
  101c47:	e9 3c 09 00 00       	jmp    102588 <__alltraps>

00101c4c <vector36>:
.globl vector36
vector36:
  pushl $0
  101c4c:	6a 00                	push   $0x0
  pushl $36
  101c4e:	6a 24                	push   $0x24
  jmp __alltraps
  101c50:	e9 33 09 00 00       	jmp    102588 <__alltraps>

00101c55 <vector37>:
.globl vector37
vector37:
  pushl $0
  101c55:	6a 00                	push   $0x0
  pushl $37
  101c57:	6a 25                	push   $0x25
  jmp __alltraps
  101c59:	e9 2a 09 00 00       	jmp    102588 <__alltraps>

00101c5e <vector38>:
.globl vector38
vector38:
  pushl $0
  101c5e:	6a 00                	push   $0x0
  pushl $38
  101c60:	6a 26                	push   $0x26
  jmp __alltraps
  101c62:	e9 21 09 00 00       	jmp    102588 <__alltraps>

00101c67 <vector39>:
.globl vector39
vector39:
  pushl $0
  101c67:	6a 00                	push   $0x0
  pushl $39
  101c69:	6a 27                	push   $0x27
  jmp __alltraps
  101c6b:	e9 18 09 00 00       	jmp    102588 <__alltraps>

00101c70 <vector40>:
.globl vector40
vector40:
  pushl $0
  101c70:	6a 00                	push   $0x0
  pushl $40
  101c72:	6a 28                	push   $0x28
  jmp __alltraps
  101c74:	e9 0f 09 00 00       	jmp    102588 <__alltraps>

00101c79 <vector41>:
.globl vector41
vector41:
  pushl $0
  101c79:	6a 00                	push   $0x0
  pushl $41
  101c7b:	6a 29                	push   $0x29
  jmp __alltraps
  101c7d:	e9 06 09 00 00       	jmp    102588 <__alltraps>

00101c82 <vector42>:
.globl vector42
vector42:
  pushl $0
  101c82:	6a 00                	push   $0x0
  pushl $42
  101c84:	6a 2a                	push   $0x2a
  jmp __alltraps
  101c86:	e9 fd 08 00 00       	jmp    102588 <__alltraps>

00101c8b <vector43>:
.globl vector43
vector43:
  pushl $0
  101c8b:	6a 00                	push   $0x0
  pushl $43
  101c8d:	6a 2b                	push   $0x2b
  jmp __alltraps
  101c8f:	e9 f4 08 00 00       	jmp    102588 <__alltraps>

00101c94 <vector44>:
.globl vector44
vector44:
  pushl $0
  101c94:	6a 00                	push   $0x0
  pushl $44
  101c96:	6a 2c                	push   $0x2c
  jmp __alltraps
  101c98:	e9 eb 08 00 00       	jmp    102588 <__alltraps>

00101c9d <vector45>:
.globl vector45
vector45:
  pushl $0
  101c9d:	6a 00                	push   $0x0
  pushl $45
  101c9f:	6a 2d                	push   $0x2d
  jmp __alltraps
  101ca1:	e9 e2 08 00 00       	jmp    102588 <__alltraps>

00101ca6 <vector46>:
.globl vector46
vector46:
  pushl $0
  101ca6:	6a 00                	push   $0x0
  pushl $46
  101ca8:	6a 2e                	push   $0x2e
  jmp __alltraps
  101caa:	e9 d9 08 00 00       	jmp    102588 <__alltraps>

00101caf <vector47>:
.globl vector47
vector47:
  pushl $0
  101caf:	6a 00                	push   $0x0
  pushl $47
  101cb1:	6a 2f                	push   $0x2f
  jmp __alltraps
  101cb3:	e9 d0 08 00 00       	jmp    102588 <__alltraps>

00101cb8 <vector48>:
.globl vector48
vector48:
  pushl $0
  101cb8:	6a 00                	push   $0x0
  pushl $48
  101cba:	6a 30                	push   $0x30
  jmp __alltraps
  101cbc:	e9 c7 08 00 00       	jmp    102588 <__alltraps>

00101cc1 <vector49>:
.globl vector49
vector49:
  pushl $0
  101cc1:	6a 00                	push   $0x0
  pushl $49
  101cc3:	6a 31                	push   $0x31
  jmp __alltraps
  101cc5:	e9 be 08 00 00       	jmp    102588 <__alltraps>

00101cca <vector50>:
.globl vector50
vector50:
  pushl $0
  101cca:	6a 00                	push   $0x0
  pushl $50
  101ccc:	6a 32                	push   $0x32
  jmp __alltraps
  101cce:	e9 b5 08 00 00       	jmp    102588 <__alltraps>

00101cd3 <vector51>:
.globl vector51
vector51:
  pushl $0
  101cd3:	6a 00                	push   $0x0
  pushl $51
  101cd5:	6a 33                	push   $0x33
  jmp __alltraps
  101cd7:	e9 ac 08 00 00       	jmp    102588 <__alltraps>

00101cdc <vector52>:
.globl vector52
vector52:
  pushl $0
  101cdc:	6a 00                	push   $0x0
  pushl $52
  101cde:	6a 34                	push   $0x34
  jmp __alltraps
  101ce0:	e9 a3 08 00 00       	jmp    102588 <__alltraps>

00101ce5 <vector53>:
.globl vector53
vector53:
  pushl $0
  101ce5:	6a 00                	push   $0x0
  pushl $53
  101ce7:	6a 35                	push   $0x35
  jmp __alltraps
  101ce9:	e9 9a 08 00 00       	jmp    102588 <__alltraps>

00101cee <vector54>:
.globl vector54
vector54:
  pushl $0
  101cee:	6a 00                	push   $0x0
  pushl $54
  101cf0:	6a 36                	push   $0x36
  jmp __alltraps
  101cf2:	e9 91 08 00 00       	jmp    102588 <__alltraps>

00101cf7 <vector55>:
.globl vector55
vector55:
  pushl $0
  101cf7:	6a 00                	push   $0x0
  pushl $55
  101cf9:	6a 37                	push   $0x37
  jmp __alltraps
  101cfb:	e9 88 08 00 00       	jmp    102588 <__alltraps>

00101d00 <vector56>:
.globl vector56
vector56:
  pushl $0
  101d00:	6a 00                	push   $0x0
  pushl $56
  101d02:	6a 38                	push   $0x38
  jmp __alltraps
  101d04:	e9 7f 08 00 00       	jmp    102588 <__alltraps>

00101d09 <vector57>:
.globl vector57
vector57:
  pushl $0
  101d09:	6a 00                	push   $0x0
  pushl $57
  101d0b:	6a 39                	push   $0x39
  jmp __alltraps
  101d0d:	e9 76 08 00 00       	jmp    102588 <__alltraps>

00101d12 <vector58>:
.globl vector58
vector58:
  pushl $0
  101d12:	6a 00                	push   $0x0
  pushl $58
  101d14:	6a 3a                	push   $0x3a
  jmp __alltraps
  101d16:	e9 6d 08 00 00       	jmp    102588 <__alltraps>

00101d1b <vector59>:
.globl vector59
vector59:
  pushl $0
  101d1b:	6a 00                	push   $0x0
  pushl $59
  101d1d:	6a 3b                	push   $0x3b
  jmp __alltraps
  101d1f:	e9 64 08 00 00       	jmp    102588 <__alltraps>

00101d24 <vector60>:
.globl vector60
vector60:
  pushl $0
  101d24:	6a 00                	push   $0x0
  pushl $60
  101d26:	6a 3c                	push   $0x3c
  jmp __alltraps
  101d28:	e9 5b 08 00 00       	jmp    102588 <__alltraps>

00101d2d <vector61>:
.globl vector61
vector61:
  pushl $0
  101d2d:	6a 00                	push   $0x0
  pushl $61
  101d2f:	6a 3d                	push   $0x3d
  jmp __alltraps
  101d31:	e9 52 08 00 00       	jmp    102588 <__alltraps>

00101d36 <vector62>:
.globl vector62
vector62:
  pushl $0
  101d36:	6a 00                	push   $0x0
  pushl $62
  101d38:	6a 3e                	push   $0x3e
  jmp __alltraps
  101d3a:	e9 49 08 00 00       	jmp    102588 <__alltraps>

00101d3f <vector63>:
.globl vector63
vector63:
  pushl $0
  101d3f:	6a 00                	push   $0x0
  pushl $63
  101d41:	6a 3f                	push   $0x3f
  jmp __alltraps
  101d43:	e9 40 08 00 00       	jmp    102588 <__alltraps>

00101d48 <vector64>:
.globl vector64
vector64:
  pushl $0
  101d48:	6a 00                	push   $0x0
  pushl $64
  101d4a:	6a 40                	push   $0x40
  jmp __alltraps
  101d4c:	e9 37 08 00 00       	jmp    102588 <__alltraps>

00101d51 <vector65>:
.globl vector65
vector65:
  pushl $0
  101d51:	6a 00                	push   $0x0
  pushl $65
  101d53:	6a 41                	push   $0x41
  jmp __alltraps
  101d55:	e9 2e 08 00 00       	jmp    102588 <__alltraps>

00101d5a <vector66>:
.globl vector66
vector66:
  pushl $0
  101d5a:	6a 00                	push   $0x0
  pushl $66
  101d5c:	6a 42                	push   $0x42
  jmp __alltraps
  101d5e:	e9 25 08 00 00       	jmp    102588 <__alltraps>

00101d63 <vector67>:
.globl vector67
vector67:
  pushl $0
  101d63:	6a 00                	push   $0x0
  pushl $67
  101d65:	6a 43                	push   $0x43
  jmp __alltraps
  101d67:	e9 1c 08 00 00       	jmp    102588 <__alltraps>

00101d6c <vector68>:
.globl vector68
vector68:
  pushl $0
  101d6c:	6a 00                	push   $0x0
  pushl $68
  101d6e:	6a 44                	push   $0x44
  jmp __alltraps
  101d70:	e9 13 08 00 00       	jmp    102588 <__alltraps>

00101d75 <vector69>:
.globl vector69
vector69:
  pushl $0
  101d75:	6a 00                	push   $0x0
  pushl $69
  101d77:	6a 45                	push   $0x45
  jmp __alltraps
  101d79:	e9 0a 08 00 00       	jmp    102588 <__alltraps>

00101d7e <vector70>:
.globl vector70
vector70:
  pushl $0
  101d7e:	6a 00                	push   $0x0
  pushl $70
  101d80:	6a 46                	push   $0x46
  jmp __alltraps
  101d82:	e9 01 08 00 00       	jmp    102588 <__alltraps>

00101d87 <vector71>:
.globl vector71
vector71:
  pushl $0
  101d87:	6a 00                	push   $0x0
  pushl $71
  101d89:	6a 47                	push   $0x47
  jmp __alltraps
  101d8b:	e9 f8 07 00 00       	jmp    102588 <__alltraps>

00101d90 <vector72>:
.globl vector72
vector72:
  pushl $0
  101d90:	6a 00                	push   $0x0
  pushl $72
  101d92:	6a 48                	push   $0x48
  jmp __alltraps
  101d94:	e9 ef 07 00 00       	jmp    102588 <__alltraps>

00101d99 <vector73>:
.globl vector73
vector73:
  pushl $0
  101d99:	6a 00                	push   $0x0
  pushl $73
  101d9b:	6a 49                	push   $0x49
  jmp __alltraps
  101d9d:	e9 e6 07 00 00       	jmp    102588 <__alltraps>

00101da2 <vector74>:
.globl vector74
vector74:
  pushl $0
  101da2:	6a 00                	push   $0x0
  pushl $74
  101da4:	6a 4a                	push   $0x4a
  jmp __alltraps
  101da6:	e9 dd 07 00 00       	jmp    102588 <__alltraps>

00101dab <vector75>:
.globl vector75
vector75:
  pushl $0
  101dab:	6a 00                	push   $0x0
  pushl $75
  101dad:	6a 4b                	push   $0x4b
  jmp __alltraps
  101daf:	e9 d4 07 00 00       	jmp    102588 <__alltraps>

00101db4 <vector76>:
.globl vector76
vector76:
  pushl $0
  101db4:	6a 00                	push   $0x0
  pushl $76
  101db6:	6a 4c                	push   $0x4c
  jmp __alltraps
  101db8:	e9 cb 07 00 00       	jmp    102588 <__alltraps>

00101dbd <vector77>:
.globl vector77
vector77:
  pushl $0
  101dbd:	6a 00                	push   $0x0
  pushl $77
  101dbf:	6a 4d                	push   $0x4d
  jmp __alltraps
  101dc1:	e9 c2 07 00 00       	jmp    102588 <__alltraps>

00101dc6 <vector78>:
.globl vector78
vector78:
  pushl $0
  101dc6:	6a 00                	push   $0x0
  pushl $78
  101dc8:	6a 4e                	push   $0x4e
  jmp __alltraps
  101dca:	e9 b9 07 00 00       	jmp    102588 <__alltraps>

00101dcf <vector79>:
.globl vector79
vector79:
  pushl $0
  101dcf:	6a 00                	push   $0x0
  pushl $79
  101dd1:	6a 4f                	push   $0x4f
  jmp __alltraps
  101dd3:	e9 b0 07 00 00       	jmp    102588 <__alltraps>

00101dd8 <vector80>:
.globl vector80
vector80:
  pushl $0
  101dd8:	6a 00                	push   $0x0
  pushl $80
  101dda:	6a 50                	push   $0x50
  jmp __alltraps
  101ddc:	e9 a7 07 00 00       	jmp    102588 <__alltraps>

00101de1 <vector81>:
.globl vector81
vector81:
  pushl $0
  101de1:	6a 00                	push   $0x0
  pushl $81
  101de3:	6a 51                	push   $0x51
  jmp __alltraps
  101de5:	e9 9e 07 00 00       	jmp    102588 <__alltraps>

00101dea <vector82>:
.globl vector82
vector82:
  pushl $0
  101dea:	6a 00                	push   $0x0
  pushl $82
  101dec:	6a 52                	push   $0x52
  jmp __alltraps
  101dee:	e9 95 07 00 00       	jmp    102588 <__alltraps>

00101df3 <vector83>:
.globl vector83
vector83:
  pushl $0
  101df3:	6a 00                	push   $0x0
  pushl $83
  101df5:	6a 53                	push   $0x53
  jmp __alltraps
  101df7:	e9 8c 07 00 00       	jmp    102588 <__alltraps>

00101dfc <vector84>:
.globl vector84
vector84:
  pushl $0
  101dfc:	6a 00                	push   $0x0
  pushl $84
  101dfe:	6a 54                	push   $0x54
  jmp __alltraps
  101e00:	e9 83 07 00 00       	jmp    102588 <__alltraps>

00101e05 <vector85>:
.globl vector85
vector85:
  pushl $0
  101e05:	6a 00                	push   $0x0
  pushl $85
  101e07:	6a 55                	push   $0x55
  jmp __alltraps
  101e09:	e9 7a 07 00 00       	jmp    102588 <__alltraps>

00101e0e <vector86>:
.globl vector86
vector86:
  pushl $0
  101e0e:	6a 00                	push   $0x0
  pushl $86
  101e10:	6a 56                	push   $0x56
  jmp __alltraps
  101e12:	e9 71 07 00 00       	jmp    102588 <__alltraps>

00101e17 <vector87>:
.globl vector87
vector87:
  pushl $0
  101e17:	6a 00                	push   $0x0
  pushl $87
  101e19:	6a 57                	push   $0x57
  jmp __alltraps
  101e1b:	e9 68 07 00 00       	jmp    102588 <__alltraps>

00101e20 <vector88>:
.globl vector88
vector88:
  pushl $0
  101e20:	6a 00                	push   $0x0
  pushl $88
  101e22:	6a 58                	push   $0x58
  jmp __alltraps
  101e24:	e9 5f 07 00 00       	jmp    102588 <__alltraps>

00101e29 <vector89>:
.globl vector89
vector89:
  pushl $0
  101e29:	6a 00                	push   $0x0
  pushl $89
  101e2b:	6a 59                	push   $0x59
  jmp __alltraps
  101e2d:	e9 56 07 00 00       	jmp    102588 <__alltraps>

00101e32 <vector90>:
.globl vector90
vector90:
  pushl $0
  101e32:	6a 00                	push   $0x0
  pushl $90
  101e34:	6a 5a                	push   $0x5a
  jmp __alltraps
  101e36:	e9 4d 07 00 00       	jmp    102588 <__alltraps>

00101e3b <vector91>:
.globl vector91
vector91:
  pushl $0
  101e3b:	6a 00                	push   $0x0
  pushl $91
  101e3d:	6a 5b                	push   $0x5b
  jmp __alltraps
  101e3f:	e9 44 07 00 00       	jmp    102588 <__alltraps>

00101e44 <vector92>:
.globl vector92
vector92:
  pushl $0
  101e44:	6a 00                	push   $0x0
  pushl $92
  101e46:	6a 5c                	push   $0x5c
  jmp __alltraps
  101e48:	e9 3b 07 00 00       	jmp    102588 <__alltraps>

00101e4d <vector93>:
.globl vector93
vector93:
  pushl $0
  101e4d:	6a 00                	push   $0x0
  pushl $93
  101e4f:	6a 5d                	push   $0x5d
  jmp __alltraps
  101e51:	e9 32 07 00 00       	jmp    102588 <__alltraps>

00101e56 <vector94>:
.globl vector94
vector94:
  pushl $0
  101e56:	6a 00                	push   $0x0
  pushl $94
  101e58:	6a 5e                	push   $0x5e
  jmp __alltraps
  101e5a:	e9 29 07 00 00       	jmp    102588 <__alltraps>

00101e5f <vector95>:
.globl vector95
vector95:
  pushl $0
  101e5f:	6a 00                	push   $0x0
  pushl $95
  101e61:	6a 5f                	push   $0x5f
  jmp __alltraps
  101e63:	e9 20 07 00 00       	jmp    102588 <__alltraps>

00101e68 <vector96>:
.globl vector96
vector96:
  pushl $0
  101e68:	6a 00                	push   $0x0
  pushl $96
  101e6a:	6a 60                	push   $0x60
  jmp __alltraps
  101e6c:	e9 17 07 00 00       	jmp    102588 <__alltraps>

00101e71 <vector97>:
.globl vector97
vector97:
  pushl $0
  101e71:	6a 00                	push   $0x0
  pushl $97
  101e73:	6a 61                	push   $0x61
  jmp __alltraps
  101e75:	e9 0e 07 00 00       	jmp    102588 <__alltraps>

00101e7a <vector98>:
.globl vector98
vector98:
  pushl $0
  101e7a:	6a 00                	push   $0x0
  pushl $98
  101e7c:	6a 62                	push   $0x62
  jmp __alltraps
  101e7e:	e9 05 07 00 00       	jmp    102588 <__alltraps>

00101e83 <vector99>:
.globl vector99
vector99:
  pushl $0
  101e83:	6a 00                	push   $0x0
  pushl $99
  101e85:	6a 63                	push   $0x63
  jmp __alltraps
  101e87:	e9 fc 06 00 00       	jmp    102588 <__alltraps>

00101e8c <vector100>:
.globl vector100
vector100:
  pushl $0
  101e8c:	6a 00                	push   $0x0
  pushl $100
  101e8e:	6a 64                	push   $0x64
  jmp __alltraps
  101e90:	e9 f3 06 00 00       	jmp    102588 <__alltraps>

00101e95 <vector101>:
.globl vector101
vector101:
  pushl $0
  101e95:	6a 00                	push   $0x0
  pushl $101
  101e97:	6a 65                	push   $0x65
  jmp __alltraps
  101e99:	e9 ea 06 00 00       	jmp    102588 <__alltraps>

00101e9e <vector102>:
.globl vector102
vector102:
  pushl $0
  101e9e:	6a 00                	push   $0x0
  pushl $102
  101ea0:	6a 66                	push   $0x66
  jmp __alltraps
  101ea2:	e9 e1 06 00 00       	jmp    102588 <__alltraps>

00101ea7 <vector103>:
.globl vector103
vector103:
  pushl $0
  101ea7:	6a 00                	push   $0x0
  pushl $103
  101ea9:	6a 67                	push   $0x67
  jmp __alltraps
  101eab:	e9 d8 06 00 00       	jmp    102588 <__alltraps>

00101eb0 <vector104>:
.globl vector104
vector104:
  pushl $0
  101eb0:	6a 00                	push   $0x0
  pushl $104
  101eb2:	6a 68                	push   $0x68
  jmp __alltraps
  101eb4:	e9 cf 06 00 00       	jmp    102588 <__alltraps>

00101eb9 <vector105>:
.globl vector105
vector105:
  pushl $0
  101eb9:	6a 00                	push   $0x0
  pushl $105
  101ebb:	6a 69                	push   $0x69
  jmp __alltraps
  101ebd:	e9 c6 06 00 00       	jmp    102588 <__alltraps>

00101ec2 <vector106>:
.globl vector106
vector106:
  pushl $0
  101ec2:	6a 00                	push   $0x0
  pushl $106
  101ec4:	6a 6a                	push   $0x6a
  jmp __alltraps
  101ec6:	e9 bd 06 00 00       	jmp    102588 <__alltraps>

00101ecb <vector107>:
.globl vector107
vector107:
  pushl $0
  101ecb:	6a 00                	push   $0x0
  pushl $107
  101ecd:	6a 6b                	push   $0x6b
  jmp __alltraps
  101ecf:	e9 b4 06 00 00       	jmp    102588 <__alltraps>

00101ed4 <vector108>:
.globl vector108
vector108:
  pushl $0
  101ed4:	6a 00                	push   $0x0
  pushl $108
  101ed6:	6a 6c                	push   $0x6c
  jmp __alltraps
  101ed8:	e9 ab 06 00 00       	jmp    102588 <__alltraps>

00101edd <vector109>:
.globl vector109
vector109:
  pushl $0
  101edd:	6a 00                	push   $0x0
  pushl $109
  101edf:	6a 6d                	push   $0x6d
  jmp __alltraps
  101ee1:	e9 a2 06 00 00       	jmp    102588 <__alltraps>

00101ee6 <vector110>:
.globl vector110
vector110:
  pushl $0
  101ee6:	6a 00                	push   $0x0
  pushl $110
  101ee8:	6a 6e                	push   $0x6e
  jmp __alltraps
  101eea:	e9 99 06 00 00       	jmp    102588 <__alltraps>

00101eef <vector111>:
.globl vector111
vector111:
  pushl $0
  101eef:	6a 00                	push   $0x0
  pushl $111
  101ef1:	6a 6f                	push   $0x6f
  jmp __alltraps
  101ef3:	e9 90 06 00 00       	jmp    102588 <__alltraps>

00101ef8 <vector112>:
.globl vector112
vector112:
  pushl $0
  101ef8:	6a 00                	push   $0x0
  pushl $112
  101efa:	6a 70                	push   $0x70
  jmp __alltraps
  101efc:	e9 87 06 00 00       	jmp    102588 <__alltraps>

00101f01 <vector113>:
.globl vector113
vector113:
  pushl $0
  101f01:	6a 00                	push   $0x0
  pushl $113
  101f03:	6a 71                	push   $0x71
  jmp __alltraps
  101f05:	e9 7e 06 00 00       	jmp    102588 <__alltraps>

00101f0a <vector114>:
.globl vector114
vector114:
  pushl $0
  101f0a:	6a 00                	push   $0x0
  pushl $114
  101f0c:	6a 72                	push   $0x72
  jmp __alltraps
  101f0e:	e9 75 06 00 00       	jmp    102588 <__alltraps>

00101f13 <vector115>:
.globl vector115
vector115:
  pushl $0
  101f13:	6a 00                	push   $0x0
  pushl $115
  101f15:	6a 73                	push   $0x73
  jmp __alltraps
  101f17:	e9 6c 06 00 00       	jmp    102588 <__alltraps>

00101f1c <vector116>:
.globl vector116
vector116:
  pushl $0
  101f1c:	6a 00                	push   $0x0
  pushl $116
  101f1e:	6a 74                	push   $0x74
  jmp __alltraps
  101f20:	e9 63 06 00 00       	jmp    102588 <__alltraps>

00101f25 <vector117>:
.globl vector117
vector117:
  pushl $0
  101f25:	6a 00                	push   $0x0
  pushl $117
  101f27:	6a 75                	push   $0x75
  jmp __alltraps
  101f29:	e9 5a 06 00 00       	jmp    102588 <__alltraps>

00101f2e <vector118>:
.globl vector118
vector118:
  pushl $0
  101f2e:	6a 00                	push   $0x0
  pushl $118
  101f30:	6a 76                	push   $0x76
  jmp __alltraps
  101f32:	e9 51 06 00 00       	jmp    102588 <__alltraps>

00101f37 <vector119>:
.globl vector119
vector119:
  pushl $0
  101f37:	6a 00                	push   $0x0
  pushl $119
  101f39:	6a 77                	push   $0x77
  jmp __alltraps
  101f3b:	e9 48 06 00 00       	jmp    102588 <__alltraps>

00101f40 <vector120>:
.globl vector120
vector120:
  pushl $0
  101f40:	6a 00                	push   $0x0
  pushl $120
  101f42:	6a 78                	push   $0x78
  jmp __alltraps
  101f44:	e9 3f 06 00 00       	jmp    102588 <__alltraps>

00101f49 <vector121>:
.globl vector121
vector121:
  pushl $0
  101f49:	6a 00                	push   $0x0
  pushl $121
  101f4b:	6a 79                	push   $0x79
  jmp __alltraps
  101f4d:	e9 36 06 00 00       	jmp    102588 <__alltraps>

00101f52 <vector122>:
.globl vector122
vector122:
  pushl $0
  101f52:	6a 00                	push   $0x0
  pushl $122
  101f54:	6a 7a                	push   $0x7a
  jmp __alltraps
  101f56:	e9 2d 06 00 00       	jmp    102588 <__alltraps>

00101f5b <vector123>:
.globl vector123
vector123:
  pushl $0
  101f5b:	6a 00                	push   $0x0
  pushl $123
  101f5d:	6a 7b                	push   $0x7b
  jmp __alltraps
  101f5f:	e9 24 06 00 00       	jmp    102588 <__alltraps>

00101f64 <vector124>:
.globl vector124
vector124:
  pushl $0
  101f64:	6a 00                	push   $0x0
  pushl $124
  101f66:	6a 7c                	push   $0x7c
  jmp __alltraps
  101f68:	e9 1b 06 00 00       	jmp    102588 <__alltraps>

00101f6d <vector125>:
.globl vector125
vector125:
  pushl $0
  101f6d:	6a 00                	push   $0x0
  pushl $125
  101f6f:	6a 7d                	push   $0x7d
  jmp __alltraps
  101f71:	e9 12 06 00 00       	jmp    102588 <__alltraps>

00101f76 <vector126>:
.globl vector126
vector126:
  pushl $0
  101f76:	6a 00                	push   $0x0
  pushl $126
  101f78:	6a 7e                	push   $0x7e
  jmp __alltraps
  101f7a:	e9 09 06 00 00       	jmp    102588 <__alltraps>

00101f7f <vector127>:
.globl vector127
vector127:
  pushl $0
  101f7f:	6a 00                	push   $0x0
  pushl $127
  101f81:	6a 7f                	push   $0x7f
  jmp __alltraps
  101f83:	e9 00 06 00 00       	jmp    102588 <__alltraps>

00101f88 <vector128>:
.globl vector128
vector128:
  pushl $0
  101f88:	6a 00                	push   $0x0
  pushl $128
  101f8a:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  101f8f:	e9 f4 05 00 00       	jmp    102588 <__alltraps>

00101f94 <vector129>:
.globl vector129
vector129:
  pushl $0
  101f94:	6a 00                	push   $0x0
  pushl $129
  101f96:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  101f9b:	e9 e8 05 00 00       	jmp    102588 <__alltraps>

00101fa0 <vector130>:
.globl vector130
vector130:
  pushl $0
  101fa0:	6a 00                	push   $0x0
  pushl $130
  101fa2:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  101fa7:	e9 dc 05 00 00       	jmp    102588 <__alltraps>

00101fac <vector131>:
.globl vector131
vector131:
  pushl $0
  101fac:	6a 00                	push   $0x0
  pushl $131
  101fae:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  101fb3:	e9 d0 05 00 00       	jmp    102588 <__alltraps>

00101fb8 <vector132>:
.globl vector132
vector132:
  pushl $0
  101fb8:	6a 00                	push   $0x0
  pushl $132
  101fba:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  101fbf:	e9 c4 05 00 00       	jmp    102588 <__alltraps>

00101fc4 <vector133>:
.globl vector133
vector133:
  pushl $0
  101fc4:	6a 00                	push   $0x0
  pushl $133
  101fc6:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  101fcb:	e9 b8 05 00 00       	jmp    102588 <__alltraps>

00101fd0 <vector134>:
.globl vector134
vector134:
  pushl $0
  101fd0:	6a 00                	push   $0x0
  pushl $134
  101fd2:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  101fd7:	e9 ac 05 00 00       	jmp    102588 <__alltraps>

00101fdc <vector135>:
.globl vector135
vector135:
  pushl $0
  101fdc:	6a 00                	push   $0x0
  pushl $135
  101fde:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  101fe3:	e9 a0 05 00 00       	jmp    102588 <__alltraps>

00101fe8 <vector136>:
.globl vector136
vector136:
  pushl $0
  101fe8:	6a 00                	push   $0x0
  pushl $136
  101fea:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  101fef:	e9 94 05 00 00       	jmp    102588 <__alltraps>

00101ff4 <vector137>:
.globl vector137
vector137:
  pushl $0
  101ff4:	6a 00                	push   $0x0
  pushl $137
  101ff6:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  101ffb:	e9 88 05 00 00       	jmp    102588 <__alltraps>

00102000 <vector138>:
.globl vector138
vector138:
  pushl $0
  102000:	6a 00                	push   $0x0
  pushl $138
  102002:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102007:	e9 7c 05 00 00       	jmp    102588 <__alltraps>

0010200c <vector139>:
.globl vector139
vector139:
  pushl $0
  10200c:	6a 00                	push   $0x0
  pushl $139
  10200e:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102013:	e9 70 05 00 00       	jmp    102588 <__alltraps>

00102018 <vector140>:
.globl vector140
vector140:
  pushl $0
  102018:	6a 00                	push   $0x0
  pushl $140
  10201a:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  10201f:	e9 64 05 00 00       	jmp    102588 <__alltraps>

00102024 <vector141>:
.globl vector141
vector141:
  pushl $0
  102024:	6a 00                	push   $0x0
  pushl $141
  102026:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10202b:	e9 58 05 00 00       	jmp    102588 <__alltraps>

00102030 <vector142>:
.globl vector142
vector142:
  pushl $0
  102030:	6a 00                	push   $0x0
  pushl $142
  102032:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102037:	e9 4c 05 00 00       	jmp    102588 <__alltraps>

0010203c <vector143>:
.globl vector143
vector143:
  pushl $0
  10203c:	6a 00                	push   $0x0
  pushl $143
  10203e:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102043:	e9 40 05 00 00       	jmp    102588 <__alltraps>

00102048 <vector144>:
.globl vector144
vector144:
  pushl $0
  102048:	6a 00                	push   $0x0
  pushl $144
  10204a:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10204f:	e9 34 05 00 00       	jmp    102588 <__alltraps>

00102054 <vector145>:
.globl vector145
vector145:
  pushl $0
  102054:	6a 00                	push   $0x0
  pushl $145
  102056:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10205b:	e9 28 05 00 00       	jmp    102588 <__alltraps>

00102060 <vector146>:
.globl vector146
vector146:
  pushl $0
  102060:	6a 00                	push   $0x0
  pushl $146
  102062:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102067:	e9 1c 05 00 00       	jmp    102588 <__alltraps>

0010206c <vector147>:
.globl vector147
vector147:
  pushl $0
  10206c:	6a 00                	push   $0x0
  pushl $147
  10206e:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102073:	e9 10 05 00 00       	jmp    102588 <__alltraps>

00102078 <vector148>:
.globl vector148
vector148:
  pushl $0
  102078:	6a 00                	push   $0x0
  pushl $148
  10207a:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10207f:	e9 04 05 00 00       	jmp    102588 <__alltraps>

00102084 <vector149>:
.globl vector149
vector149:
  pushl $0
  102084:	6a 00                	push   $0x0
  pushl $149
  102086:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10208b:	e9 f8 04 00 00       	jmp    102588 <__alltraps>

00102090 <vector150>:
.globl vector150
vector150:
  pushl $0
  102090:	6a 00                	push   $0x0
  pushl $150
  102092:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102097:	e9 ec 04 00 00       	jmp    102588 <__alltraps>

0010209c <vector151>:
.globl vector151
vector151:
  pushl $0
  10209c:	6a 00                	push   $0x0
  pushl $151
  10209e:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1020a3:	e9 e0 04 00 00       	jmp    102588 <__alltraps>

001020a8 <vector152>:
.globl vector152
vector152:
  pushl $0
  1020a8:	6a 00                	push   $0x0
  pushl $152
  1020aa:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1020af:	e9 d4 04 00 00       	jmp    102588 <__alltraps>

001020b4 <vector153>:
.globl vector153
vector153:
  pushl $0
  1020b4:	6a 00                	push   $0x0
  pushl $153
  1020b6:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1020bb:	e9 c8 04 00 00       	jmp    102588 <__alltraps>

001020c0 <vector154>:
.globl vector154
vector154:
  pushl $0
  1020c0:	6a 00                	push   $0x0
  pushl $154
  1020c2:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1020c7:	e9 bc 04 00 00       	jmp    102588 <__alltraps>

001020cc <vector155>:
.globl vector155
vector155:
  pushl $0
  1020cc:	6a 00                	push   $0x0
  pushl $155
  1020ce:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1020d3:	e9 b0 04 00 00       	jmp    102588 <__alltraps>

001020d8 <vector156>:
.globl vector156
vector156:
  pushl $0
  1020d8:	6a 00                	push   $0x0
  pushl $156
  1020da:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1020df:	e9 a4 04 00 00       	jmp    102588 <__alltraps>

001020e4 <vector157>:
.globl vector157
vector157:
  pushl $0
  1020e4:	6a 00                	push   $0x0
  pushl $157
  1020e6:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1020eb:	e9 98 04 00 00       	jmp    102588 <__alltraps>

001020f0 <vector158>:
.globl vector158
vector158:
  pushl $0
  1020f0:	6a 00                	push   $0x0
  pushl $158
  1020f2:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1020f7:	e9 8c 04 00 00       	jmp    102588 <__alltraps>

001020fc <vector159>:
.globl vector159
vector159:
  pushl $0
  1020fc:	6a 00                	push   $0x0
  pushl $159
  1020fe:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102103:	e9 80 04 00 00       	jmp    102588 <__alltraps>

00102108 <vector160>:
.globl vector160
vector160:
  pushl $0
  102108:	6a 00                	push   $0x0
  pushl $160
  10210a:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  10210f:	e9 74 04 00 00       	jmp    102588 <__alltraps>

00102114 <vector161>:
.globl vector161
vector161:
  pushl $0
  102114:	6a 00                	push   $0x0
  pushl $161
  102116:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10211b:	e9 68 04 00 00       	jmp    102588 <__alltraps>

00102120 <vector162>:
.globl vector162
vector162:
  pushl $0
  102120:	6a 00                	push   $0x0
  pushl $162
  102122:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102127:	e9 5c 04 00 00       	jmp    102588 <__alltraps>

0010212c <vector163>:
.globl vector163
vector163:
  pushl $0
  10212c:	6a 00                	push   $0x0
  pushl $163
  10212e:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102133:	e9 50 04 00 00       	jmp    102588 <__alltraps>

00102138 <vector164>:
.globl vector164
vector164:
  pushl $0
  102138:	6a 00                	push   $0x0
  pushl $164
  10213a:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10213f:	e9 44 04 00 00       	jmp    102588 <__alltraps>

00102144 <vector165>:
.globl vector165
vector165:
  pushl $0
  102144:	6a 00                	push   $0x0
  pushl $165
  102146:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10214b:	e9 38 04 00 00       	jmp    102588 <__alltraps>

00102150 <vector166>:
.globl vector166
vector166:
  pushl $0
  102150:	6a 00                	push   $0x0
  pushl $166
  102152:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102157:	e9 2c 04 00 00       	jmp    102588 <__alltraps>

0010215c <vector167>:
.globl vector167
vector167:
  pushl $0
  10215c:	6a 00                	push   $0x0
  pushl $167
  10215e:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102163:	e9 20 04 00 00       	jmp    102588 <__alltraps>

00102168 <vector168>:
.globl vector168
vector168:
  pushl $0
  102168:	6a 00                	push   $0x0
  pushl $168
  10216a:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10216f:	e9 14 04 00 00       	jmp    102588 <__alltraps>

00102174 <vector169>:
.globl vector169
vector169:
  pushl $0
  102174:	6a 00                	push   $0x0
  pushl $169
  102176:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10217b:	e9 08 04 00 00       	jmp    102588 <__alltraps>

00102180 <vector170>:
.globl vector170
vector170:
  pushl $0
  102180:	6a 00                	push   $0x0
  pushl $170
  102182:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102187:	e9 fc 03 00 00       	jmp    102588 <__alltraps>

0010218c <vector171>:
.globl vector171
vector171:
  pushl $0
  10218c:	6a 00                	push   $0x0
  pushl $171
  10218e:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102193:	e9 f0 03 00 00       	jmp    102588 <__alltraps>

00102198 <vector172>:
.globl vector172
vector172:
  pushl $0
  102198:	6a 00                	push   $0x0
  pushl $172
  10219a:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10219f:	e9 e4 03 00 00       	jmp    102588 <__alltraps>

001021a4 <vector173>:
.globl vector173
vector173:
  pushl $0
  1021a4:	6a 00                	push   $0x0
  pushl $173
  1021a6:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1021ab:	e9 d8 03 00 00       	jmp    102588 <__alltraps>

001021b0 <vector174>:
.globl vector174
vector174:
  pushl $0
  1021b0:	6a 00                	push   $0x0
  pushl $174
  1021b2:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1021b7:	e9 cc 03 00 00       	jmp    102588 <__alltraps>

001021bc <vector175>:
.globl vector175
vector175:
  pushl $0
  1021bc:	6a 00                	push   $0x0
  pushl $175
  1021be:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1021c3:	e9 c0 03 00 00       	jmp    102588 <__alltraps>

001021c8 <vector176>:
.globl vector176
vector176:
  pushl $0
  1021c8:	6a 00                	push   $0x0
  pushl $176
  1021ca:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1021cf:	e9 b4 03 00 00       	jmp    102588 <__alltraps>

001021d4 <vector177>:
.globl vector177
vector177:
  pushl $0
  1021d4:	6a 00                	push   $0x0
  pushl $177
  1021d6:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1021db:	e9 a8 03 00 00       	jmp    102588 <__alltraps>

001021e0 <vector178>:
.globl vector178
vector178:
  pushl $0
  1021e0:	6a 00                	push   $0x0
  pushl $178
  1021e2:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1021e7:	e9 9c 03 00 00       	jmp    102588 <__alltraps>

001021ec <vector179>:
.globl vector179
vector179:
  pushl $0
  1021ec:	6a 00                	push   $0x0
  pushl $179
  1021ee:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1021f3:	e9 90 03 00 00       	jmp    102588 <__alltraps>

001021f8 <vector180>:
.globl vector180
vector180:
  pushl $0
  1021f8:	6a 00                	push   $0x0
  pushl $180
  1021fa:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1021ff:	e9 84 03 00 00       	jmp    102588 <__alltraps>

00102204 <vector181>:
.globl vector181
vector181:
  pushl $0
  102204:	6a 00                	push   $0x0
  pushl $181
  102206:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10220b:	e9 78 03 00 00       	jmp    102588 <__alltraps>

00102210 <vector182>:
.globl vector182
vector182:
  pushl $0
  102210:	6a 00                	push   $0x0
  pushl $182
  102212:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102217:	e9 6c 03 00 00       	jmp    102588 <__alltraps>

0010221c <vector183>:
.globl vector183
vector183:
  pushl $0
  10221c:	6a 00                	push   $0x0
  pushl $183
  10221e:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102223:	e9 60 03 00 00       	jmp    102588 <__alltraps>

00102228 <vector184>:
.globl vector184
vector184:
  pushl $0
  102228:	6a 00                	push   $0x0
  pushl $184
  10222a:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10222f:	e9 54 03 00 00       	jmp    102588 <__alltraps>

00102234 <vector185>:
.globl vector185
vector185:
  pushl $0
  102234:	6a 00                	push   $0x0
  pushl $185
  102236:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10223b:	e9 48 03 00 00       	jmp    102588 <__alltraps>

00102240 <vector186>:
.globl vector186
vector186:
  pushl $0
  102240:	6a 00                	push   $0x0
  pushl $186
  102242:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102247:	e9 3c 03 00 00       	jmp    102588 <__alltraps>

0010224c <vector187>:
.globl vector187
vector187:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $187
  10224e:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102253:	e9 30 03 00 00       	jmp    102588 <__alltraps>

00102258 <vector188>:
.globl vector188
vector188:
  pushl $0
  102258:	6a 00                	push   $0x0
  pushl $188
  10225a:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10225f:	e9 24 03 00 00       	jmp    102588 <__alltraps>

00102264 <vector189>:
.globl vector189
vector189:
  pushl $0
  102264:	6a 00                	push   $0x0
  pushl $189
  102266:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10226b:	e9 18 03 00 00       	jmp    102588 <__alltraps>

00102270 <vector190>:
.globl vector190
vector190:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $190
  102272:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102277:	e9 0c 03 00 00       	jmp    102588 <__alltraps>

0010227c <vector191>:
.globl vector191
vector191:
  pushl $0
  10227c:	6a 00                	push   $0x0
  pushl $191
  10227e:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102283:	e9 00 03 00 00       	jmp    102588 <__alltraps>

00102288 <vector192>:
.globl vector192
vector192:
  pushl $0
  102288:	6a 00                	push   $0x0
  pushl $192
  10228a:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10228f:	e9 f4 02 00 00       	jmp    102588 <__alltraps>

00102294 <vector193>:
.globl vector193
vector193:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $193
  102296:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10229b:	e9 e8 02 00 00       	jmp    102588 <__alltraps>

001022a0 <vector194>:
.globl vector194
vector194:
  pushl $0
  1022a0:	6a 00                	push   $0x0
  pushl $194
  1022a2:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1022a7:	e9 dc 02 00 00       	jmp    102588 <__alltraps>

001022ac <vector195>:
.globl vector195
vector195:
  pushl $0
  1022ac:	6a 00                	push   $0x0
  pushl $195
  1022ae:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1022b3:	e9 d0 02 00 00       	jmp    102588 <__alltraps>

001022b8 <vector196>:
.globl vector196
vector196:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $196
  1022ba:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1022bf:	e9 c4 02 00 00       	jmp    102588 <__alltraps>

001022c4 <vector197>:
.globl vector197
vector197:
  pushl $0
  1022c4:	6a 00                	push   $0x0
  pushl $197
  1022c6:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1022cb:	e9 b8 02 00 00       	jmp    102588 <__alltraps>

001022d0 <vector198>:
.globl vector198
vector198:
  pushl $0
  1022d0:	6a 00                	push   $0x0
  pushl $198
  1022d2:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1022d7:	e9 ac 02 00 00       	jmp    102588 <__alltraps>

001022dc <vector199>:
.globl vector199
vector199:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $199
  1022de:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1022e3:	e9 a0 02 00 00       	jmp    102588 <__alltraps>

001022e8 <vector200>:
.globl vector200
vector200:
  pushl $0
  1022e8:	6a 00                	push   $0x0
  pushl $200
  1022ea:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1022ef:	e9 94 02 00 00       	jmp    102588 <__alltraps>

001022f4 <vector201>:
.globl vector201
vector201:
  pushl $0
  1022f4:	6a 00                	push   $0x0
  pushl $201
  1022f6:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1022fb:	e9 88 02 00 00       	jmp    102588 <__alltraps>

00102300 <vector202>:
.globl vector202
vector202:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $202
  102302:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102307:	e9 7c 02 00 00       	jmp    102588 <__alltraps>

0010230c <vector203>:
.globl vector203
vector203:
  pushl $0
  10230c:	6a 00                	push   $0x0
  pushl $203
  10230e:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102313:	e9 70 02 00 00       	jmp    102588 <__alltraps>

00102318 <vector204>:
.globl vector204
vector204:
  pushl $0
  102318:	6a 00                	push   $0x0
  pushl $204
  10231a:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  10231f:	e9 64 02 00 00       	jmp    102588 <__alltraps>

00102324 <vector205>:
.globl vector205
vector205:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $205
  102326:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10232b:	e9 58 02 00 00       	jmp    102588 <__alltraps>

00102330 <vector206>:
.globl vector206
vector206:
  pushl $0
  102330:	6a 00                	push   $0x0
  pushl $206
  102332:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102337:	e9 4c 02 00 00       	jmp    102588 <__alltraps>

0010233c <vector207>:
.globl vector207
vector207:
  pushl $0
  10233c:	6a 00                	push   $0x0
  pushl $207
  10233e:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102343:	e9 40 02 00 00       	jmp    102588 <__alltraps>

00102348 <vector208>:
.globl vector208
vector208:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $208
  10234a:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10234f:	e9 34 02 00 00       	jmp    102588 <__alltraps>

00102354 <vector209>:
.globl vector209
vector209:
  pushl $0
  102354:	6a 00                	push   $0x0
  pushl $209
  102356:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10235b:	e9 28 02 00 00       	jmp    102588 <__alltraps>

00102360 <vector210>:
.globl vector210
vector210:
  pushl $0
  102360:	6a 00                	push   $0x0
  pushl $210
  102362:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102367:	e9 1c 02 00 00       	jmp    102588 <__alltraps>

0010236c <vector211>:
.globl vector211
vector211:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $211
  10236e:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102373:	e9 10 02 00 00       	jmp    102588 <__alltraps>

00102378 <vector212>:
.globl vector212
vector212:
  pushl $0
  102378:	6a 00                	push   $0x0
  pushl $212
  10237a:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10237f:	e9 04 02 00 00       	jmp    102588 <__alltraps>

00102384 <vector213>:
.globl vector213
vector213:
  pushl $0
  102384:	6a 00                	push   $0x0
  pushl $213
  102386:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10238b:	e9 f8 01 00 00       	jmp    102588 <__alltraps>

00102390 <vector214>:
.globl vector214
vector214:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $214
  102392:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102397:	e9 ec 01 00 00       	jmp    102588 <__alltraps>

0010239c <vector215>:
.globl vector215
vector215:
  pushl $0
  10239c:	6a 00                	push   $0x0
  pushl $215
  10239e:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1023a3:	e9 e0 01 00 00       	jmp    102588 <__alltraps>

001023a8 <vector216>:
.globl vector216
vector216:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $216
  1023aa:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1023af:	e9 d4 01 00 00       	jmp    102588 <__alltraps>

001023b4 <vector217>:
.globl vector217
vector217:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $217
  1023b6:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1023bb:	e9 c8 01 00 00       	jmp    102588 <__alltraps>

001023c0 <vector218>:
.globl vector218
vector218:
  pushl $0
  1023c0:	6a 00                	push   $0x0
  pushl $218
  1023c2:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1023c7:	e9 bc 01 00 00       	jmp    102588 <__alltraps>

001023cc <vector219>:
.globl vector219
vector219:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $219
  1023ce:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1023d3:	e9 b0 01 00 00       	jmp    102588 <__alltraps>

001023d8 <vector220>:
.globl vector220
vector220:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $220
  1023da:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1023df:	e9 a4 01 00 00       	jmp    102588 <__alltraps>

001023e4 <vector221>:
.globl vector221
vector221:
  pushl $0
  1023e4:	6a 00                	push   $0x0
  pushl $221
  1023e6:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1023eb:	e9 98 01 00 00       	jmp    102588 <__alltraps>

001023f0 <vector222>:
.globl vector222
vector222:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $222
  1023f2:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1023f7:	e9 8c 01 00 00       	jmp    102588 <__alltraps>

001023fc <vector223>:
.globl vector223
vector223:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $223
  1023fe:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102403:	e9 80 01 00 00       	jmp    102588 <__alltraps>

00102408 <vector224>:
.globl vector224
vector224:
  pushl $0
  102408:	6a 00                	push   $0x0
  pushl $224
  10240a:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  10240f:	e9 74 01 00 00       	jmp    102588 <__alltraps>

00102414 <vector225>:
.globl vector225
vector225:
  pushl $0
  102414:	6a 00                	push   $0x0
  pushl $225
  102416:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10241b:	e9 68 01 00 00       	jmp    102588 <__alltraps>

00102420 <vector226>:
.globl vector226
vector226:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $226
  102422:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102427:	e9 5c 01 00 00       	jmp    102588 <__alltraps>

0010242c <vector227>:
.globl vector227
vector227:
  pushl $0
  10242c:	6a 00                	push   $0x0
  pushl $227
  10242e:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102433:	e9 50 01 00 00       	jmp    102588 <__alltraps>

00102438 <vector228>:
.globl vector228
vector228:
  pushl $0
  102438:	6a 00                	push   $0x0
  pushl $228
  10243a:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  10243f:	e9 44 01 00 00       	jmp    102588 <__alltraps>

00102444 <vector229>:
.globl vector229
vector229:
  pushl $0
  102444:	6a 00                	push   $0x0
  pushl $229
  102446:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10244b:	e9 38 01 00 00       	jmp    102588 <__alltraps>

00102450 <vector230>:
.globl vector230
vector230:
  pushl $0
  102450:	6a 00                	push   $0x0
  pushl $230
  102452:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102457:	e9 2c 01 00 00       	jmp    102588 <__alltraps>

0010245c <vector231>:
.globl vector231
vector231:
  pushl $0
  10245c:	6a 00                	push   $0x0
  pushl $231
  10245e:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102463:	e9 20 01 00 00       	jmp    102588 <__alltraps>

00102468 <vector232>:
.globl vector232
vector232:
  pushl $0
  102468:	6a 00                	push   $0x0
  pushl $232
  10246a:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10246f:	e9 14 01 00 00       	jmp    102588 <__alltraps>

00102474 <vector233>:
.globl vector233
vector233:
  pushl $0
  102474:	6a 00                	push   $0x0
  pushl $233
  102476:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  10247b:	e9 08 01 00 00       	jmp    102588 <__alltraps>

00102480 <vector234>:
.globl vector234
vector234:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $234
  102482:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102487:	e9 fc 00 00 00       	jmp    102588 <__alltraps>

0010248c <vector235>:
.globl vector235
vector235:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $235
  10248e:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102493:	e9 f0 00 00 00       	jmp    102588 <__alltraps>

00102498 <vector236>:
.globl vector236
vector236:
  pushl $0
  102498:	6a 00                	push   $0x0
  pushl $236
  10249a:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10249f:	e9 e4 00 00 00       	jmp    102588 <__alltraps>

001024a4 <vector237>:
.globl vector237
vector237:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $237
  1024a6:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1024ab:	e9 d8 00 00 00       	jmp    102588 <__alltraps>

001024b0 <vector238>:
.globl vector238
vector238:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $238
  1024b2:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1024b7:	e9 cc 00 00 00       	jmp    102588 <__alltraps>

001024bc <vector239>:
.globl vector239
vector239:
  pushl $0
  1024bc:	6a 00                	push   $0x0
  pushl $239
  1024be:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1024c3:	e9 c0 00 00 00       	jmp    102588 <__alltraps>

001024c8 <vector240>:
.globl vector240
vector240:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $240
  1024ca:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1024cf:	e9 b4 00 00 00       	jmp    102588 <__alltraps>

001024d4 <vector241>:
.globl vector241
vector241:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $241
  1024d6:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1024db:	e9 a8 00 00 00       	jmp    102588 <__alltraps>

001024e0 <vector242>:
.globl vector242
vector242:
  pushl $0
  1024e0:	6a 00                	push   $0x0
  pushl $242
  1024e2:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1024e7:	e9 9c 00 00 00       	jmp    102588 <__alltraps>

001024ec <vector243>:
.globl vector243
vector243:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $243
  1024ee:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1024f3:	e9 90 00 00 00       	jmp    102588 <__alltraps>

001024f8 <vector244>:
.globl vector244
vector244:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $244
  1024fa:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1024ff:	e9 84 00 00 00       	jmp    102588 <__alltraps>

00102504 <vector245>:
.globl vector245
vector245:
  pushl $0
  102504:	6a 00                	push   $0x0
  pushl $245
  102506:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10250b:	e9 78 00 00 00       	jmp    102588 <__alltraps>

00102510 <vector246>:
.globl vector246
vector246:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $246
  102512:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102517:	e9 6c 00 00 00       	jmp    102588 <__alltraps>

0010251c <vector247>:
.globl vector247
vector247:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $247
  10251e:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102523:	e9 60 00 00 00       	jmp    102588 <__alltraps>

00102528 <vector248>:
.globl vector248
vector248:
  pushl $0
  102528:	6a 00                	push   $0x0
  pushl $248
  10252a:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  10252f:	e9 54 00 00 00       	jmp    102588 <__alltraps>

00102534 <vector249>:
.globl vector249
vector249:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $249
  102536:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10253b:	e9 48 00 00 00       	jmp    102588 <__alltraps>

00102540 <vector250>:
.globl vector250
vector250:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $250
  102542:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102547:	e9 3c 00 00 00       	jmp    102588 <__alltraps>

0010254c <vector251>:
.globl vector251
vector251:
  pushl $0
  10254c:	6a 00                	push   $0x0
  pushl $251
  10254e:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102553:	e9 30 00 00 00       	jmp    102588 <__alltraps>

00102558 <vector252>:
.globl vector252
vector252:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $252
  10255a:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  10255f:	e9 24 00 00 00       	jmp    102588 <__alltraps>

00102564 <vector253>:
.globl vector253
vector253:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $253
  102566:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  10256b:	e9 18 00 00 00       	jmp    102588 <__alltraps>

00102570 <vector254>:
.globl vector254
vector254:
  pushl $0
  102570:	6a 00                	push   $0x0
  pushl $254
  102572:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102577:	e9 0c 00 00 00       	jmp    102588 <__alltraps>

0010257c <vector255>:
.globl vector255
vector255:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $255
  10257e:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102583:	e9 00 00 00 00       	jmp    102588 <__alltraps>

00102588 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102588:	1e                   	push   %ds
    pushl %es
  102589:	06                   	push   %es
    pushl %fs
  10258a:	0f a0                	push   %fs
    pushl %gs
  10258c:	0f a8                	push   %gs
    pushal
  10258e:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  10258f:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102594:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102596:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102598:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap       #调用 trap.c文件中这个函数
  102599:	e8 64 f5 ff ff       	call   101b02 <trap>

    # pop the pushed stack pointer
    popl %esp
  10259e:	5c                   	pop    %esp

0010259f <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  10259f:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1025a0:	0f a9                	pop    %gs
    popl %fs
  1025a2:	0f a1                	pop    %fs
    popl %es
  1025a4:	07                   	pop    %es
    popl %ds
  1025a5:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1025a6:	83 c4 08             	add    $0x8,%esp
    iret
  1025a9:	cf                   	iret   

001025aa <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1025aa:	55                   	push   %ebp
  1025ab:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1025ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1025b0:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  1025b3:	b8 23 00 00 00       	mov    $0x23,%eax
  1025b8:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  1025ba:	b8 23 00 00 00       	mov    $0x23,%eax
  1025bf:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  1025c1:	b8 10 00 00 00       	mov    $0x10,%eax
  1025c6:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  1025c8:	b8 10 00 00 00       	mov    $0x10,%eax
  1025cd:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  1025cf:	b8 10 00 00 00       	mov    $0x10,%eax
  1025d4:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  1025d6:	ea dd 25 10 00 08 00 	ljmp   $0x8,$0x1025dd
}
  1025dd:	5d                   	pop    %ebp
  1025de:	c3                   	ret    

001025df <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  1025df:	55                   	push   %ebp
  1025e0:	89 e5                	mov    %esp,%ebp
  1025e2:	83 ec 10             	sub    $0x10,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  1025e5:	b8 00 fa 10 00       	mov    $0x10fa00,%eax
  1025ea:	05 00 04 00 00       	add    $0x400,%eax
  1025ef:	a3 84 f9 10 00       	mov    %eax,0x10f984
    ts.ts_ss0 = KERNEL_DS;
  1025f4:	66 c7 05 88 f9 10 00 	movw   $0x10,0x10f988
  1025fb:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1025fd:	66 c7 05 48 ea 10 00 	movw   $0x68,0x10ea48
  102604:	68 00 
  102606:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  10260b:	66 a3 4a ea 10 00    	mov    %ax,0x10ea4a
  102611:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  102616:	c1 e8 10             	shr    $0x10,%eax
  102619:	a2 4c ea 10 00       	mov    %al,0x10ea4c
  10261e:	0f b6 05 4d ea 10 00 	movzbl 0x10ea4d,%eax
  102625:	83 e0 f0             	and    $0xfffffff0,%eax
  102628:	83 c8 09             	or     $0x9,%eax
  10262b:	a2 4d ea 10 00       	mov    %al,0x10ea4d
  102630:	0f b6 05 4d ea 10 00 	movzbl 0x10ea4d,%eax
  102637:	83 c8 10             	or     $0x10,%eax
  10263a:	a2 4d ea 10 00       	mov    %al,0x10ea4d
  10263f:	0f b6 05 4d ea 10 00 	movzbl 0x10ea4d,%eax
  102646:	83 e0 9f             	and    $0xffffff9f,%eax
  102649:	a2 4d ea 10 00       	mov    %al,0x10ea4d
  10264e:	0f b6 05 4d ea 10 00 	movzbl 0x10ea4d,%eax
  102655:	83 c8 80             	or     $0xffffff80,%eax
  102658:	a2 4d ea 10 00       	mov    %al,0x10ea4d
  10265d:	0f b6 05 4e ea 10 00 	movzbl 0x10ea4e,%eax
  102664:	83 e0 f0             	and    $0xfffffff0,%eax
  102667:	a2 4e ea 10 00       	mov    %al,0x10ea4e
  10266c:	0f b6 05 4e ea 10 00 	movzbl 0x10ea4e,%eax
  102673:	83 e0 ef             	and    $0xffffffef,%eax
  102676:	a2 4e ea 10 00       	mov    %al,0x10ea4e
  10267b:	0f b6 05 4e ea 10 00 	movzbl 0x10ea4e,%eax
  102682:	83 e0 df             	and    $0xffffffdf,%eax
  102685:	a2 4e ea 10 00       	mov    %al,0x10ea4e
  10268a:	0f b6 05 4e ea 10 00 	movzbl 0x10ea4e,%eax
  102691:	83 c8 40             	or     $0x40,%eax
  102694:	a2 4e ea 10 00       	mov    %al,0x10ea4e
  102699:	0f b6 05 4e ea 10 00 	movzbl 0x10ea4e,%eax
  1026a0:	83 e0 7f             	and    $0x7f,%eax
  1026a3:	a2 4e ea 10 00       	mov    %al,0x10ea4e
  1026a8:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  1026ad:	c1 e8 18             	shr    $0x18,%eax
  1026b0:	a2 4f ea 10 00       	mov    %al,0x10ea4f
    gdt[SEG_TSS].sd_s = 0;
  1026b5:	0f b6 05 4d ea 10 00 	movzbl 0x10ea4d,%eax
  1026bc:	83 e0 ef             	and    $0xffffffef,%eax
  1026bf:	a2 4d ea 10 00       	mov    %al,0x10ea4d

    // reload all segment registers
    lgdt(&gdt_pd);
  1026c4:	68 50 ea 10 00       	push   $0x10ea50
  1026c9:	e8 dc fe ff ff       	call   1025aa <lgdt>
  1026ce:	83 c4 04             	add    $0x4,%esp
  1026d1:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  1026d7:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  1026db:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  1026de:	c9                   	leave  
  1026df:	c3                   	ret    

001026e0 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  1026e0:	55                   	push   %ebp
  1026e1:	89 e5                	mov    %esp,%ebp
    gdt_init();
  1026e3:	e8 f7 fe ff ff       	call   1025df <gdt_init>
}
  1026e8:	5d                   	pop    %ebp
  1026e9:	c3                   	ret    

001026ea <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1026ea:	55                   	push   %ebp
  1026eb:	89 e5                	mov    %esp,%ebp
  1026ed:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1026f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1026f7:	eb 04                	jmp    1026fd <strlen+0x13>
        cnt ++;
  1026f9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  1026fd:	8b 45 08             	mov    0x8(%ebp),%eax
  102700:	8d 50 01             	lea    0x1(%eax),%edx
  102703:	89 55 08             	mov    %edx,0x8(%ebp)
  102706:	0f b6 00             	movzbl (%eax),%eax
  102709:	84 c0                	test   %al,%al
  10270b:	75 ec                	jne    1026f9 <strlen+0xf>
        cnt ++;
    }
    return cnt;
  10270d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102710:	c9                   	leave  
  102711:	c3                   	ret    

00102712 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102712:	55                   	push   %ebp
  102713:	89 e5                	mov    %esp,%ebp
  102715:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102718:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  10271f:	eb 04                	jmp    102725 <strnlen+0x13>
        cnt ++;
  102721:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  102725:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102728:	3b 45 0c             	cmp    0xc(%ebp),%eax
  10272b:	73 10                	jae    10273d <strnlen+0x2b>
  10272d:	8b 45 08             	mov    0x8(%ebp),%eax
  102730:	8d 50 01             	lea    0x1(%eax),%edx
  102733:	89 55 08             	mov    %edx,0x8(%ebp)
  102736:	0f b6 00             	movzbl (%eax),%eax
  102739:	84 c0                	test   %al,%al
  10273b:	75 e4                	jne    102721 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  10273d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102740:	c9                   	leave  
  102741:	c3                   	ret    

00102742 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102742:	55                   	push   %ebp
  102743:	89 e5                	mov    %esp,%ebp
  102745:	57                   	push   %edi
  102746:	56                   	push   %esi
  102747:	83 ec 20             	sub    $0x20,%esp
  10274a:	8b 45 08             	mov    0x8(%ebp),%eax
  10274d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102750:	8b 45 0c             	mov    0xc(%ebp),%eax
  102753:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102756:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102759:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10275c:	89 d1                	mov    %edx,%ecx
  10275e:	89 c2                	mov    %eax,%edx
  102760:	89 ce                	mov    %ecx,%esi
  102762:	89 d7                	mov    %edx,%edi
  102764:	ac                   	lods   %ds:(%esi),%al
  102765:	aa                   	stos   %al,%es:(%edi)
  102766:	84 c0                	test   %al,%al
  102768:	75 fa                	jne    102764 <strcpy+0x22>
  10276a:	89 fa                	mov    %edi,%edx
  10276c:	89 f1                	mov    %esi,%ecx
  10276e:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102771:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102774:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102777:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  10277a:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  10277b:	83 c4 20             	add    $0x20,%esp
  10277e:	5e                   	pop    %esi
  10277f:	5f                   	pop    %edi
  102780:	5d                   	pop    %ebp
  102781:	c3                   	ret    

00102782 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102782:	55                   	push   %ebp
  102783:	89 e5                	mov    %esp,%ebp
  102785:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102788:	8b 45 08             	mov    0x8(%ebp),%eax
  10278b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  10278e:	eb 21                	jmp    1027b1 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102790:	8b 45 0c             	mov    0xc(%ebp),%eax
  102793:	0f b6 10             	movzbl (%eax),%edx
  102796:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102799:	88 10                	mov    %dl,(%eax)
  10279b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10279e:	0f b6 00             	movzbl (%eax),%eax
  1027a1:	84 c0                	test   %al,%al
  1027a3:	74 04                	je     1027a9 <strncpy+0x27>
            src ++;
  1027a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1027a9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1027ad:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  1027b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1027b5:	75 d9                	jne    102790 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  1027b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1027ba:	c9                   	leave  
  1027bb:	c3                   	ret    

001027bc <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1027bc:	55                   	push   %ebp
  1027bd:	89 e5                	mov    %esp,%ebp
  1027bf:	57                   	push   %edi
  1027c0:	56                   	push   %esi
  1027c1:	83 ec 20             	sub    $0x20,%esp
  1027c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1027c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1027ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1027cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  1027d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1027d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1027d6:	89 d1                	mov    %edx,%ecx
  1027d8:	89 c2                	mov    %eax,%edx
  1027da:	89 ce                	mov    %ecx,%esi
  1027dc:	89 d7                	mov    %edx,%edi
  1027de:	ac                   	lods   %ds:(%esi),%al
  1027df:	ae                   	scas   %es:(%edi),%al
  1027e0:	75 08                	jne    1027ea <strcmp+0x2e>
  1027e2:	84 c0                	test   %al,%al
  1027e4:	75 f8                	jne    1027de <strcmp+0x22>
  1027e6:	31 c0                	xor    %eax,%eax
  1027e8:	eb 04                	jmp    1027ee <strcmp+0x32>
  1027ea:	19 c0                	sbb    %eax,%eax
  1027ec:	0c 01                	or     $0x1,%al
  1027ee:	89 fa                	mov    %edi,%edx
  1027f0:	89 f1                	mov    %esi,%ecx
  1027f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1027f5:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1027f8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  1027fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  1027fe:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  1027ff:	83 c4 20             	add    $0x20,%esp
  102802:	5e                   	pop    %esi
  102803:	5f                   	pop    %edi
  102804:	5d                   	pop    %ebp
  102805:	c3                   	ret    

00102806 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102806:	55                   	push   %ebp
  102807:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102809:	eb 0c                	jmp    102817 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  10280b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10280f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102813:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102817:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10281b:	74 1a                	je     102837 <strncmp+0x31>
  10281d:	8b 45 08             	mov    0x8(%ebp),%eax
  102820:	0f b6 00             	movzbl (%eax),%eax
  102823:	84 c0                	test   %al,%al
  102825:	74 10                	je     102837 <strncmp+0x31>
  102827:	8b 45 08             	mov    0x8(%ebp),%eax
  10282a:	0f b6 10             	movzbl (%eax),%edx
  10282d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102830:	0f b6 00             	movzbl (%eax),%eax
  102833:	38 c2                	cmp    %al,%dl
  102835:	74 d4                	je     10280b <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102837:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10283b:	74 18                	je     102855 <strncmp+0x4f>
  10283d:	8b 45 08             	mov    0x8(%ebp),%eax
  102840:	0f b6 00             	movzbl (%eax),%eax
  102843:	0f b6 d0             	movzbl %al,%edx
  102846:	8b 45 0c             	mov    0xc(%ebp),%eax
  102849:	0f b6 00             	movzbl (%eax),%eax
  10284c:	0f b6 c0             	movzbl %al,%eax
  10284f:	29 c2                	sub    %eax,%edx
  102851:	89 d0                	mov    %edx,%eax
  102853:	eb 05                	jmp    10285a <strncmp+0x54>
  102855:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10285a:	5d                   	pop    %ebp
  10285b:	c3                   	ret    

0010285c <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10285c:	55                   	push   %ebp
  10285d:	89 e5                	mov    %esp,%ebp
  10285f:	83 ec 04             	sub    $0x4,%esp
  102862:	8b 45 0c             	mov    0xc(%ebp),%eax
  102865:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102868:	eb 14                	jmp    10287e <strchr+0x22>
        if (*s == c) {
  10286a:	8b 45 08             	mov    0x8(%ebp),%eax
  10286d:	0f b6 00             	movzbl (%eax),%eax
  102870:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102873:	75 05                	jne    10287a <strchr+0x1e>
            return (char *)s;
  102875:	8b 45 08             	mov    0x8(%ebp),%eax
  102878:	eb 13                	jmp    10288d <strchr+0x31>
        }
        s ++;
  10287a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  10287e:	8b 45 08             	mov    0x8(%ebp),%eax
  102881:	0f b6 00             	movzbl (%eax),%eax
  102884:	84 c0                	test   %al,%al
  102886:	75 e2                	jne    10286a <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  102888:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10288d:	c9                   	leave  
  10288e:	c3                   	ret    

0010288f <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  10288f:	55                   	push   %ebp
  102890:	89 e5                	mov    %esp,%ebp
  102892:	83 ec 04             	sub    $0x4,%esp
  102895:	8b 45 0c             	mov    0xc(%ebp),%eax
  102898:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10289b:	eb 11                	jmp    1028ae <strfind+0x1f>
        if (*s == c) {
  10289d:	8b 45 08             	mov    0x8(%ebp),%eax
  1028a0:	0f b6 00             	movzbl (%eax),%eax
  1028a3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  1028a6:	75 02                	jne    1028aa <strfind+0x1b>
            break;
  1028a8:	eb 0e                	jmp    1028b8 <strfind+0x29>
        }
        s ++;
  1028aa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  1028ae:	8b 45 08             	mov    0x8(%ebp),%eax
  1028b1:	0f b6 00             	movzbl (%eax),%eax
  1028b4:	84 c0                	test   %al,%al
  1028b6:	75 e5                	jne    10289d <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  1028b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1028bb:	c9                   	leave  
  1028bc:	c3                   	ret    

001028bd <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1028bd:	55                   	push   %ebp
  1028be:	89 e5                	mov    %esp,%ebp
  1028c0:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1028c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1028ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1028d1:	eb 04                	jmp    1028d7 <strtol+0x1a>
        s ++;
  1028d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1028d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1028da:	0f b6 00             	movzbl (%eax),%eax
  1028dd:	3c 20                	cmp    $0x20,%al
  1028df:	74 f2                	je     1028d3 <strtol+0x16>
  1028e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1028e4:	0f b6 00             	movzbl (%eax),%eax
  1028e7:	3c 09                	cmp    $0x9,%al
  1028e9:	74 e8                	je     1028d3 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  1028eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1028ee:	0f b6 00             	movzbl (%eax),%eax
  1028f1:	3c 2b                	cmp    $0x2b,%al
  1028f3:	75 06                	jne    1028fb <strtol+0x3e>
        s ++;
  1028f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1028f9:	eb 15                	jmp    102910 <strtol+0x53>
    }
    else if (*s == '-') {
  1028fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1028fe:	0f b6 00             	movzbl (%eax),%eax
  102901:	3c 2d                	cmp    $0x2d,%al
  102903:	75 0b                	jne    102910 <strtol+0x53>
        s ++, neg = 1;
  102905:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102909:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102910:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102914:	74 06                	je     10291c <strtol+0x5f>
  102916:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10291a:	75 24                	jne    102940 <strtol+0x83>
  10291c:	8b 45 08             	mov    0x8(%ebp),%eax
  10291f:	0f b6 00             	movzbl (%eax),%eax
  102922:	3c 30                	cmp    $0x30,%al
  102924:	75 1a                	jne    102940 <strtol+0x83>
  102926:	8b 45 08             	mov    0x8(%ebp),%eax
  102929:	83 c0 01             	add    $0x1,%eax
  10292c:	0f b6 00             	movzbl (%eax),%eax
  10292f:	3c 78                	cmp    $0x78,%al
  102931:	75 0d                	jne    102940 <strtol+0x83>
        s += 2, base = 16;
  102933:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102937:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10293e:	eb 2a                	jmp    10296a <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  102940:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102944:	75 17                	jne    10295d <strtol+0xa0>
  102946:	8b 45 08             	mov    0x8(%ebp),%eax
  102949:	0f b6 00             	movzbl (%eax),%eax
  10294c:	3c 30                	cmp    $0x30,%al
  10294e:	75 0d                	jne    10295d <strtol+0xa0>
        s ++, base = 8;
  102950:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102954:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  10295b:	eb 0d                	jmp    10296a <strtol+0xad>
    }
    else if (base == 0) {
  10295d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102961:	75 07                	jne    10296a <strtol+0xad>
        base = 10;
  102963:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  10296a:	8b 45 08             	mov    0x8(%ebp),%eax
  10296d:	0f b6 00             	movzbl (%eax),%eax
  102970:	3c 2f                	cmp    $0x2f,%al
  102972:	7e 1b                	jle    10298f <strtol+0xd2>
  102974:	8b 45 08             	mov    0x8(%ebp),%eax
  102977:	0f b6 00             	movzbl (%eax),%eax
  10297a:	3c 39                	cmp    $0x39,%al
  10297c:	7f 11                	jg     10298f <strtol+0xd2>
            dig = *s - '0';
  10297e:	8b 45 08             	mov    0x8(%ebp),%eax
  102981:	0f b6 00             	movzbl (%eax),%eax
  102984:	0f be c0             	movsbl %al,%eax
  102987:	83 e8 30             	sub    $0x30,%eax
  10298a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10298d:	eb 48                	jmp    1029d7 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  10298f:	8b 45 08             	mov    0x8(%ebp),%eax
  102992:	0f b6 00             	movzbl (%eax),%eax
  102995:	3c 60                	cmp    $0x60,%al
  102997:	7e 1b                	jle    1029b4 <strtol+0xf7>
  102999:	8b 45 08             	mov    0x8(%ebp),%eax
  10299c:	0f b6 00             	movzbl (%eax),%eax
  10299f:	3c 7a                	cmp    $0x7a,%al
  1029a1:	7f 11                	jg     1029b4 <strtol+0xf7>
            dig = *s - 'a' + 10;
  1029a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a6:	0f b6 00             	movzbl (%eax),%eax
  1029a9:	0f be c0             	movsbl %al,%eax
  1029ac:	83 e8 57             	sub    $0x57,%eax
  1029af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1029b2:	eb 23                	jmp    1029d7 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1029b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1029b7:	0f b6 00             	movzbl (%eax),%eax
  1029ba:	3c 40                	cmp    $0x40,%al
  1029bc:	7e 3d                	jle    1029fb <strtol+0x13e>
  1029be:	8b 45 08             	mov    0x8(%ebp),%eax
  1029c1:	0f b6 00             	movzbl (%eax),%eax
  1029c4:	3c 5a                	cmp    $0x5a,%al
  1029c6:	7f 33                	jg     1029fb <strtol+0x13e>
            dig = *s - 'A' + 10;
  1029c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1029cb:	0f b6 00             	movzbl (%eax),%eax
  1029ce:	0f be c0             	movsbl %al,%eax
  1029d1:	83 e8 37             	sub    $0x37,%eax
  1029d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1029d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029da:	3b 45 10             	cmp    0x10(%ebp),%eax
  1029dd:	7c 02                	jl     1029e1 <strtol+0x124>
            break;
  1029df:	eb 1a                	jmp    1029fb <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  1029e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1029e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1029e8:	0f af 45 10          	imul   0x10(%ebp),%eax
  1029ec:	89 c2                	mov    %eax,%edx
  1029ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029f1:	01 d0                	add    %edx,%eax
  1029f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  1029f6:	e9 6f ff ff ff       	jmp    10296a <strtol+0xad>

    if (endptr) {
  1029fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1029ff:	74 08                	je     102a09 <strtol+0x14c>
        *endptr = (char *) s;
  102a01:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a04:	8b 55 08             	mov    0x8(%ebp),%edx
  102a07:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102a09:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102a0d:	74 07                	je     102a16 <strtol+0x159>
  102a0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102a12:	f7 d8                	neg    %eax
  102a14:	eb 03                	jmp    102a19 <strtol+0x15c>
  102a16:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102a19:	c9                   	leave  
  102a1a:	c3                   	ret    

00102a1b <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102a1b:	55                   	push   %ebp
  102a1c:	89 e5                	mov    %esp,%ebp
  102a1e:	57                   	push   %edi
  102a1f:	83 ec 24             	sub    $0x24,%esp
  102a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a25:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102a28:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102a2c:	8b 55 08             	mov    0x8(%ebp),%edx
  102a2f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102a32:	88 45 f7             	mov    %al,-0x9(%ebp)
  102a35:	8b 45 10             	mov    0x10(%ebp),%eax
  102a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102a3b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102a3e:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102a42:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102a45:	89 d7                	mov    %edx,%edi
  102a47:	f3 aa                	rep stos %al,%es:(%edi)
  102a49:	89 fa                	mov    %edi,%edx
  102a4b:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102a4e:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102a51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102a54:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102a55:	83 c4 24             	add    $0x24,%esp
  102a58:	5f                   	pop    %edi
  102a59:	5d                   	pop    %ebp
  102a5a:	c3                   	ret    

00102a5b <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102a5b:	55                   	push   %ebp
  102a5c:	89 e5                	mov    %esp,%ebp
  102a5e:	57                   	push   %edi
  102a5f:	56                   	push   %esi
  102a60:	53                   	push   %ebx
  102a61:	83 ec 30             	sub    $0x30,%esp
  102a64:	8b 45 08             	mov    0x8(%ebp),%eax
  102a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102a70:	8b 45 10             	mov    0x10(%ebp),%eax
  102a73:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a79:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102a7c:	73 42                	jae    102ac0 <memmove+0x65>
  102a7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102a84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102a87:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102a8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102a8d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102a90:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102a93:	c1 e8 02             	shr    $0x2,%eax
  102a96:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  102a98:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102a9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102a9e:	89 d7                	mov    %edx,%edi
  102aa0:	89 c6                	mov    %eax,%esi
  102aa2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102aa4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102aa7:	83 e1 03             	and    $0x3,%ecx
  102aaa:	74 02                	je     102aae <memmove+0x53>
  102aac:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102aae:	89 f0                	mov    %esi,%eax
  102ab0:	89 fa                	mov    %edi,%edx
  102ab2:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102ab5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102ab8:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  102abb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  102abe:	eb 36                	jmp    102af6 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102ac0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ac3:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ac6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ac9:	01 c2                	add    %eax,%edx
  102acb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ace:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ad4:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  102ad7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ada:	89 c1                	mov    %eax,%ecx
  102adc:	89 d8                	mov    %ebx,%eax
  102ade:	89 d6                	mov    %edx,%esi
  102ae0:	89 c7                	mov    %eax,%edi
  102ae2:	fd                   	std    
  102ae3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ae5:	fc                   	cld    
  102ae6:	89 f8                	mov    %edi,%eax
  102ae8:	89 f2                	mov    %esi,%edx
  102aea:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102aed:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102af0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  102af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102af6:	83 c4 30             	add    $0x30,%esp
  102af9:	5b                   	pop    %ebx
  102afa:	5e                   	pop    %esi
  102afb:	5f                   	pop    %edi
  102afc:	5d                   	pop    %ebp
  102afd:	c3                   	ret    

00102afe <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102afe:	55                   	push   %ebp
  102aff:	89 e5                	mov    %esp,%ebp
  102b01:	57                   	push   %edi
  102b02:	56                   	push   %esi
  102b03:	83 ec 20             	sub    $0x20,%esp
  102b06:	8b 45 08             	mov    0x8(%ebp),%eax
  102b09:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102b12:	8b 45 10             	mov    0x10(%ebp),%eax
  102b15:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102b18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102b1b:	c1 e8 02             	shr    $0x2,%eax
  102b1e:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  102b20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102b23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b26:	89 d7                	mov    %edx,%edi
  102b28:	89 c6                	mov    %eax,%esi
  102b2a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102b2c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102b2f:	83 e1 03             	and    $0x3,%ecx
  102b32:	74 02                	je     102b36 <memcpy+0x38>
  102b34:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102b36:	89 f0                	mov    %esi,%eax
  102b38:	89 fa                	mov    %edi,%edx
  102b3a:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102b3d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102b40:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  102b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  102b46:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102b47:	83 c4 20             	add    $0x20,%esp
  102b4a:	5e                   	pop    %esi
  102b4b:	5f                   	pop    %edi
  102b4c:	5d                   	pop    %ebp
  102b4d:	c3                   	ret    

00102b4e <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102b4e:	55                   	push   %ebp
  102b4f:	89 e5                	mov    %esp,%ebp
  102b51:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102b54:	8b 45 08             	mov    0x8(%ebp),%eax
  102b57:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102b60:	eb 30                	jmp    102b92 <memcmp+0x44>
        if (*s1 != *s2) {
  102b62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b65:	0f b6 10             	movzbl (%eax),%edx
  102b68:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b6b:	0f b6 00             	movzbl (%eax),%eax
  102b6e:	38 c2                	cmp    %al,%dl
  102b70:	74 18                	je     102b8a <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102b72:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b75:	0f b6 00             	movzbl (%eax),%eax
  102b78:	0f b6 d0             	movzbl %al,%edx
  102b7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b7e:	0f b6 00             	movzbl (%eax),%eax
  102b81:	0f b6 c0             	movzbl %al,%eax
  102b84:	29 c2                	sub    %eax,%edx
  102b86:	89 d0                	mov    %edx,%eax
  102b88:	eb 1a                	jmp    102ba4 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  102b8a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102b8e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  102b92:	8b 45 10             	mov    0x10(%ebp),%eax
  102b95:	8d 50 ff             	lea    -0x1(%eax),%edx
  102b98:	89 55 10             	mov    %edx,0x10(%ebp)
  102b9b:	85 c0                	test   %eax,%eax
  102b9d:	75 c3                	jne    102b62 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  102b9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102ba4:	c9                   	leave  
  102ba5:	c3                   	ret    

00102ba6 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102ba6:	55                   	push   %ebp
  102ba7:	89 e5                	mov    %esp,%ebp
  102ba9:	83 ec 38             	sub    $0x38,%esp
  102bac:	8b 45 10             	mov    0x10(%ebp),%eax
  102baf:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102bb2:	8b 45 14             	mov    0x14(%ebp),%eax
  102bb5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102bb8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102bbb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102bbe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102bc1:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102bc4:	8b 45 18             	mov    0x18(%ebp),%eax
  102bc7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102bca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102bcd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102bd0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102bd3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102bdc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102be0:	74 1c                	je     102bfe <printnum+0x58>
  102be2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102be5:	ba 00 00 00 00       	mov    $0x0,%edx
  102bea:	f7 75 e4             	divl   -0x1c(%ebp)
  102bed:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bf3:	ba 00 00 00 00       	mov    $0x0,%edx
  102bf8:	f7 75 e4             	divl   -0x1c(%ebp)
  102bfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102bfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c04:	f7 75 e4             	divl   -0x1c(%ebp)
  102c07:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102c0a:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102c0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c10:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102c13:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102c16:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102c19:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c1c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102c1f:	8b 45 18             	mov    0x18(%ebp),%eax
  102c22:	ba 00 00 00 00       	mov    $0x0,%edx
  102c27:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102c2a:	77 41                	ja     102c6d <printnum+0xc7>
  102c2c:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102c2f:	72 05                	jb     102c36 <printnum+0x90>
  102c31:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102c34:	77 37                	ja     102c6d <printnum+0xc7>
        printnum(putch, putdat, result, base, width - 1, padc);
  102c36:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102c39:	83 e8 01             	sub    $0x1,%eax
  102c3c:	83 ec 04             	sub    $0x4,%esp
  102c3f:	ff 75 20             	pushl  0x20(%ebp)
  102c42:	50                   	push   %eax
  102c43:	ff 75 18             	pushl  0x18(%ebp)
  102c46:	ff 75 ec             	pushl  -0x14(%ebp)
  102c49:	ff 75 e8             	pushl  -0x18(%ebp)
  102c4c:	ff 75 0c             	pushl  0xc(%ebp)
  102c4f:	ff 75 08             	pushl  0x8(%ebp)
  102c52:	e8 4f ff ff ff       	call   102ba6 <printnum>
  102c57:	83 c4 20             	add    $0x20,%esp
  102c5a:	eb 1b                	jmp    102c77 <printnum+0xd1>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102c5c:	83 ec 08             	sub    $0x8,%esp
  102c5f:	ff 75 0c             	pushl  0xc(%ebp)
  102c62:	ff 75 20             	pushl  0x20(%ebp)
  102c65:	8b 45 08             	mov    0x8(%ebp),%eax
  102c68:	ff d0                	call   *%eax
  102c6a:	83 c4 10             	add    $0x10,%esp
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102c6d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102c71:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102c75:	7f e5                	jg     102c5c <printnum+0xb6>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102c77:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102c7a:	05 50 39 10 00       	add    $0x103950,%eax
  102c7f:	0f b6 00             	movzbl (%eax),%eax
  102c82:	0f be c0             	movsbl %al,%eax
  102c85:	83 ec 08             	sub    $0x8,%esp
  102c88:	ff 75 0c             	pushl  0xc(%ebp)
  102c8b:	50                   	push   %eax
  102c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8f:	ff d0                	call   *%eax
  102c91:	83 c4 10             	add    $0x10,%esp
}
  102c94:	c9                   	leave  
  102c95:	c3                   	ret    

00102c96 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102c96:	55                   	push   %ebp
  102c97:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102c99:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102c9d:	7e 14                	jle    102cb3 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca2:	8b 00                	mov    (%eax),%eax
  102ca4:	8d 48 08             	lea    0x8(%eax),%ecx
  102ca7:	8b 55 08             	mov    0x8(%ebp),%edx
  102caa:	89 0a                	mov    %ecx,(%edx)
  102cac:	8b 50 04             	mov    0x4(%eax),%edx
  102caf:	8b 00                	mov    (%eax),%eax
  102cb1:	eb 30                	jmp    102ce3 <getuint+0x4d>
    }
    else if (lflag) {
  102cb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102cb7:	74 16                	je     102ccf <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102cbc:	8b 00                	mov    (%eax),%eax
  102cbe:	8d 48 04             	lea    0x4(%eax),%ecx
  102cc1:	8b 55 08             	mov    0x8(%ebp),%edx
  102cc4:	89 0a                	mov    %ecx,(%edx)
  102cc6:	8b 00                	mov    (%eax),%eax
  102cc8:	ba 00 00 00 00       	mov    $0x0,%edx
  102ccd:	eb 14                	jmp    102ce3 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd2:	8b 00                	mov    (%eax),%eax
  102cd4:	8d 48 04             	lea    0x4(%eax),%ecx
  102cd7:	8b 55 08             	mov    0x8(%ebp),%edx
  102cda:	89 0a                	mov    %ecx,(%edx)
  102cdc:	8b 00                	mov    (%eax),%eax
  102cde:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102ce3:	5d                   	pop    %ebp
  102ce4:	c3                   	ret    

00102ce5 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102ce5:	55                   	push   %ebp
  102ce6:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102ce8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102cec:	7e 14                	jle    102d02 <getint+0x1d>
        return va_arg(*ap, long long);
  102cee:	8b 45 08             	mov    0x8(%ebp),%eax
  102cf1:	8b 00                	mov    (%eax),%eax
  102cf3:	8d 48 08             	lea    0x8(%eax),%ecx
  102cf6:	8b 55 08             	mov    0x8(%ebp),%edx
  102cf9:	89 0a                	mov    %ecx,(%edx)
  102cfb:	8b 50 04             	mov    0x4(%eax),%edx
  102cfe:	8b 00                	mov    (%eax),%eax
  102d00:	eb 28                	jmp    102d2a <getint+0x45>
    }
    else if (lflag) {
  102d02:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102d06:	74 12                	je     102d1a <getint+0x35>
        return va_arg(*ap, long);
  102d08:	8b 45 08             	mov    0x8(%ebp),%eax
  102d0b:	8b 00                	mov    (%eax),%eax
  102d0d:	8d 48 04             	lea    0x4(%eax),%ecx
  102d10:	8b 55 08             	mov    0x8(%ebp),%edx
  102d13:	89 0a                	mov    %ecx,(%edx)
  102d15:	8b 00                	mov    (%eax),%eax
  102d17:	99                   	cltd   
  102d18:	eb 10                	jmp    102d2a <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d1d:	8b 00                	mov    (%eax),%eax
  102d1f:	8d 48 04             	lea    0x4(%eax),%ecx
  102d22:	8b 55 08             	mov    0x8(%ebp),%edx
  102d25:	89 0a                	mov    %ecx,(%edx)
  102d27:	8b 00                	mov    (%eax),%eax
  102d29:	99                   	cltd   
    }
}
  102d2a:	5d                   	pop    %ebp
  102d2b:	c3                   	ret    

00102d2c <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102d2c:	55                   	push   %ebp
  102d2d:	89 e5                	mov    %esp,%ebp
  102d2f:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  102d32:	8d 45 14             	lea    0x14(%ebp),%eax
  102d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d3b:	50                   	push   %eax
  102d3c:	ff 75 10             	pushl  0x10(%ebp)
  102d3f:	ff 75 0c             	pushl  0xc(%ebp)
  102d42:	ff 75 08             	pushl  0x8(%ebp)
  102d45:	e8 05 00 00 00       	call   102d4f <vprintfmt>
  102d4a:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  102d4d:	c9                   	leave  
  102d4e:	c3                   	ret    

00102d4f <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102d4f:	55                   	push   %ebp
  102d50:	89 e5                	mov    %esp,%ebp
  102d52:	56                   	push   %esi
  102d53:	53                   	push   %ebx
  102d54:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d57:	eb 18                	jmp    102d71 <vprintfmt+0x22>
            if (ch == '\0') {
  102d59:	85 db                	test   %ebx,%ebx
  102d5b:	75 05                	jne    102d62 <vprintfmt+0x13>
                return;
  102d5d:	e9 8b 03 00 00       	jmp    1030ed <vprintfmt+0x39e>
            }
            putch(ch, putdat);
  102d62:	83 ec 08             	sub    $0x8,%esp
  102d65:	ff 75 0c             	pushl  0xc(%ebp)
  102d68:	53                   	push   %ebx
  102d69:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6c:	ff d0                	call   *%eax
  102d6e:	83 c4 10             	add    $0x10,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d71:	8b 45 10             	mov    0x10(%ebp),%eax
  102d74:	8d 50 01             	lea    0x1(%eax),%edx
  102d77:	89 55 10             	mov    %edx,0x10(%ebp)
  102d7a:	0f b6 00             	movzbl (%eax),%eax
  102d7d:	0f b6 d8             	movzbl %al,%ebx
  102d80:	83 fb 25             	cmp    $0x25,%ebx
  102d83:	75 d4                	jne    102d59 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102d85:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102d89:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102d90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d93:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102d96:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102d9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102da0:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102da3:	8b 45 10             	mov    0x10(%ebp),%eax
  102da6:	8d 50 01             	lea    0x1(%eax),%edx
  102da9:	89 55 10             	mov    %edx,0x10(%ebp)
  102dac:	0f b6 00             	movzbl (%eax),%eax
  102daf:	0f b6 d8             	movzbl %al,%ebx
  102db2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102db5:	83 f8 55             	cmp    $0x55,%eax
  102db8:	0f 87 02 03 00 00    	ja     1030c0 <vprintfmt+0x371>
  102dbe:	8b 04 85 74 39 10 00 	mov    0x103974(,%eax,4),%eax
  102dc5:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102dc7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102dcb:	eb d6                	jmp    102da3 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102dcd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102dd1:	eb d0                	jmp    102da3 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102dd3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102dda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102ddd:	89 d0                	mov    %edx,%eax
  102ddf:	c1 e0 02             	shl    $0x2,%eax
  102de2:	01 d0                	add    %edx,%eax
  102de4:	01 c0                	add    %eax,%eax
  102de6:	01 d8                	add    %ebx,%eax
  102de8:	83 e8 30             	sub    $0x30,%eax
  102deb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102dee:	8b 45 10             	mov    0x10(%ebp),%eax
  102df1:	0f b6 00             	movzbl (%eax),%eax
  102df4:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102df7:	83 fb 2f             	cmp    $0x2f,%ebx
  102dfa:	7e 0b                	jle    102e07 <vprintfmt+0xb8>
  102dfc:	83 fb 39             	cmp    $0x39,%ebx
  102dff:	7f 06                	jg     102e07 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102e01:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102e05:	eb d3                	jmp    102dda <vprintfmt+0x8b>
            goto process_precision;
  102e07:	eb 2e                	jmp    102e37 <vprintfmt+0xe8>

        case '*':
            precision = va_arg(ap, int);
  102e09:	8b 45 14             	mov    0x14(%ebp),%eax
  102e0c:	8d 50 04             	lea    0x4(%eax),%edx
  102e0f:	89 55 14             	mov    %edx,0x14(%ebp)
  102e12:	8b 00                	mov    (%eax),%eax
  102e14:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102e17:	eb 1e                	jmp    102e37 <vprintfmt+0xe8>

        case '.':
            if (width < 0)
  102e19:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e1d:	79 07                	jns    102e26 <vprintfmt+0xd7>
                width = 0;
  102e1f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102e26:	e9 78 ff ff ff       	jmp    102da3 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102e2b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102e32:	e9 6c ff ff ff       	jmp    102da3 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102e37:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e3b:	79 0d                	jns    102e4a <vprintfmt+0xfb>
                width = precision, precision = -1;
  102e3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e40:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102e43:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102e4a:	e9 54 ff ff ff       	jmp    102da3 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102e4f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102e53:	e9 4b ff ff ff       	jmp    102da3 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102e58:	8b 45 14             	mov    0x14(%ebp),%eax
  102e5b:	8d 50 04             	lea    0x4(%eax),%edx
  102e5e:	89 55 14             	mov    %edx,0x14(%ebp)
  102e61:	8b 00                	mov    (%eax),%eax
  102e63:	83 ec 08             	sub    $0x8,%esp
  102e66:	ff 75 0c             	pushl  0xc(%ebp)
  102e69:	50                   	push   %eax
  102e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e6d:	ff d0                	call   *%eax
  102e6f:	83 c4 10             	add    $0x10,%esp
            break;
  102e72:	e9 71 02 00 00       	jmp    1030e8 <vprintfmt+0x399>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102e77:	8b 45 14             	mov    0x14(%ebp),%eax
  102e7a:	8d 50 04             	lea    0x4(%eax),%edx
  102e7d:	89 55 14             	mov    %edx,0x14(%ebp)
  102e80:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102e82:	85 db                	test   %ebx,%ebx
  102e84:	79 02                	jns    102e88 <vprintfmt+0x139>
                err = -err;
  102e86:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102e88:	83 fb 06             	cmp    $0x6,%ebx
  102e8b:	7f 0b                	jg     102e98 <vprintfmt+0x149>
  102e8d:	8b 34 9d 34 39 10 00 	mov    0x103934(,%ebx,4),%esi
  102e94:	85 f6                	test   %esi,%esi
  102e96:	75 19                	jne    102eb1 <vprintfmt+0x162>
                printfmt(putch, putdat, "error %d", err);
  102e98:	53                   	push   %ebx
  102e99:	68 61 39 10 00       	push   $0x103961
  102e9e:	ff 75 0c             	pushl  0xc(%ebp)
  102ea1:	ff 75 08             	pushl  0x8(%ebp)
  102ea4:	e8 83 fe ff ff       	call   102d2c <printfmt>
  102ea9:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102eac:	e9 37 02 00 00       	jmp    1030e8 <vprintfmt+0x399>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102eb1:	56                   	push   %esi
  102eb2:	68 6a 39 10 00       	push   $0x10396a
  102eb7:	ff 75 0c             	pushl  0xc(%ebp)
  102eba:	ff 75 08             	pushl  0x8(%ebp)
  102ebd:	e8 6a fe ff ff       	call   102d2c <printfmt>
  102ec2:	83 c4 10             	add    $0x10,%esp
            }
            break;
  102ec5:	e9 1e 02 00 00       	jmp    1030e8 <vprintfmt+0x399>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102eca:	8b 45 14             	mov    0x14(%ebp),%eax
  102ecd:	8d 50 04             	lea    0x4(%eax),%edx
  102ed0:	89 55 14             	mov    %edx,0x14(%ebp)
  102ed3:	8b 30                	mov    (%eax),%esi
  102ed5:	85 f6                	test   %esi,%esi
  102ed7:	75 05                	jne    102ede <vprintfmt+0x18f>
                p = "(null)";
  102ed9:	be 6d 39 10 00       	mov    $0x10396d,%esi
            }
            if (width > 0 && padc != '-') {
  102ede:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102ee2:	7e 3f                	jle    102f23 <vprintfmt+0x1d4>
  102ee4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102ee8:	74 39                	je     102f23 <vprintfmt+0x1d4>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102eea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102eed:	83 ec 08             	sub    $0x8,%esp
  102ef0:	50                   	push   %eax
  102ef1:	56                   	push   %esi
  102ef2:	e8 1b f8 ff ff       	call   102712 <strnlen>
  102ef7:	83 c4 10             	add    $0x10,%esp
  102efa:	89 c2                	mov    %eax,%edx
  102efc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eff:	29 d0                	sub    %edx,%eax
  102f01:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f04:	eb 17                	jmp    102f1d <vprintfmt+0x1ce>
                    putch(padc, putdat);
  102f06:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102f0a:	83 ec 08             	sub    $0x8,%esp
  102f0d:	ff 75 0c             	pushl  0xc(%ebp)
  102f10:	50                   	push   %eax
  102f11:	8b 45 08             	mov    0x8(%ebp),%eax
  102f14:	ff d0                	call   *%eax
  102f16:	83 c4 10             	add    $0x10,%esp
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102f19:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f1d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102f21:	7f e3                	jg     102f06 <vprintfmt+0x1b7>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f23:	eb 35                	jmp    102f5a <vprintfmt+0x20b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102f25:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102f29:	74 1c                	je     102f47 <vprintfmt+0x1f8>
  102f2b:	83 fb 1f             	cmp    $0x1f,%ebx
  102f2e:	7e 05                	jle    102f35 <vprintfmt+0x1e6>
  102f30:	83 fb 7e             	cmp    $0x7e,%ebx
  102f33:	7e 12                	jle    102f47 <vprintfmt+0x1f8>
                    putch('?', putdat);
  102f35:	83 ec 08             	sub    $0x8,%esp
  102f38:	ff 75 0c             	pushl  0xc(%ebp)
  102f3b:	6a 3f                	push   $0x3f
  102f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f40:	ff d0                	call   *%eax
  102f42:	83 c4 10             	add    $0x10,%esp
  102f45:	eb 0f                	jmp    102f56 <vprintfmt+0x207>
                }
                else {
                    putch(ch, putdat);
  102f47:	83 ec 08             	sub    $0x8,%esp
  102f4a:	ff 75 0c             	pushl  0xc(%ebp)
  102f4d:	53                   	push   %ebx
  102f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102f51:	ff d0                	call   *%eax
  102f53:	83 c4 10             	add    $0x10,%esp
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f56:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f5a:	89 f0                	mov    %esi,%eax
  102f5c:	8d 70 01             	lea    0x1(%eax),%esi
  102f5f:	0f b6 00             	movzbl (%eax),%eax
  102f62:	0f be d8             	movsbl %al,%ebx
  102f65:	85 db                	test   %ebx,%ebx
  102f67:	74 10                	je     102f79 <vprintfmt+0x22a>
  102f69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f6d:	78 b6                	js     102f25 <vprintfmt+0x1d6>
  102f6f:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102f73:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f77:	79 ac                	jns    102f25 <vprintfmt+0x1d6>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102f79:	eb 14                	jmp    102f8f <vprintfmt+0x240>
                putch(' ', putdat);
  102f7b:	83 ec 08             	sub    $0x8,%esp
  102f7e:	ff 75 0c             	pushl  0xc(%ebp)
  102f81:	6a 20                	push   $0x20
  102f83:	8b 45 08             	mov    0x8(%ebp),%eax
  102f86:	ff d0                	call   *%eax
  102f88:	83 c4 10             	add    $0x10,%esp
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102f8b:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102f8f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102f93:	7f e6                	jg     102f7b <vprintfmt+0x22c>
                putch(' ', putdat);
            }
            break;
  102f95:	e9 4e 01 00 00       	jmp    1030e8 <vprintfmt+0x399>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102f9a:	83 ec 08             	sub    $0x8,%esp
  102f9d:	ff 75 e0             	pushl  -0x20(%ebp)
  102fa0:	8d 45 14             	lea    0x14(%ebp),%eax
  102fa3:	50                   	push   %eax
  102fa4:	e8 3c fd ff ff       	call   102ce5 <getint>
  102fa9:	83 c4 10             	add    $0x10,%esp
  102fac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102faf:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102fb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fb8:	85 d2                	test   %edx,%edx
  102fba:	79 23                	jns    102fdf <vprintfmt+0x290>
                putch('-', putdat);
  102fbc:	83 ec 08             	sub    $0x8,%esp
  102fbf:	ff 75 0c             	pushl  0xc(%ebp)
  102fc2:	6a 2d                	push   $0x2d
  102fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc7:	ff d0                	call   *%eax
  102fc9:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  102fcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fcf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fd2:	f7 d8                	neg    %eax
  102fd4:	83 d2 00             	adc    $0x0,%edx
  102fd7:	f7 da                	neg    %edx
  102fd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fdc:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102fdf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102fe6:	e9 9f 00 00 00       	jmp    10308a <vprintfmt+0x33b>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102feb:	83 ec 08             	sub    $0x8,%esp
  102fee:	ff 75 e0             	pushl  -0x20(%ebp)
  102ff1:	8d 45 14             	lea    0x14(%ebp),%eax
  102ff4:	50                   	push   %eax
  102ff5:	e8 9c fc ff ff       	call   102c96 <getuint>
  102ffa:	83 c4 10             	add    $0x10,%esp
  102ffd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103000:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  103003:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10300a:	eb 7e                	jmp    10308a <vprintfmt+0x33b>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  10300c:	83 ec 08             	sub    $0x8,%esp
  10300f:	ff 75 e0             	pushl  -0x20(%ebp)
  103012:	8d 45 14             	lea    0x14(%ebp),%eax
  103015:	50                   	push   %eax
  103016:	e8 7b fc ff ff       	call   102c96 <getuint>
  10301b:	83 c4 10             	add    $0x10,%esp
  10301e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103021:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103024:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10302b:	eb 5d                	jmp    10308a <vprintfmt+0x33b>

        // pointer
        case 'p':
            putch('0', putdat);
  10302d:	83 ec 08             	sub    $0x8,%esp
  103030:	ff 75 0c             	pushl  0xc(%ebp)
  103033:	6a 30                	push   $0x30
  103035:	8b 45 08             	mov    0x8(%ebp),%eax
  103038:	ff d0                	call   *%eax
  10303a:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  10303d:	83 ec 08             	sub    $0x8,%esp
  103040:	ff 75 0c             	pushl  0xc(%ebp)
  103043:	6a 78                	push   $0x78
  103045:	8b 45 08             	mov    0x8(%ebp),%eax
  103048:	ff d0                	call   *%eax
  10304a:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  10304d:	8b 45 14             	mov    0x14(%ebp),%eax
  103050:	8d 50 04             	lea    0x4(%eax),%edx
  103053:	89 55 14             	mov    %edx,0x14(%ebp)
  103056:	8b 00                	mov    (%eax),%eax
  103058:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10305b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103062:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103069:	eb 1f                	jmp    10308a <vprintfmt+0x33b>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10306b:	83 ec 08             	sub    $0x8,%esp
  10306e:	ff 75 e0             	pushl  -0x20(%ebp)
  103071:	8d 45 14             	lea    0x14(%ebp),%eax
  103074:	50                   	push   %eax
  103075:	e8 1c fc ff ff       	call   102c96 <getuint>
  10307a:	83 c4 10             	add    $0x10,%esp
  10307d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103080:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103083:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10308a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  10308e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103091:	83 ec 04             	sub    $0x4,%esp
  103094:	52                   	push   %edx
  103095:	ff 75 e8             	pushl  -0x18(%ebp)
  103098:	50                   	push   %eax
  103099:	ff 75 f4             	pushl  -0xc(%ebp)
  10309c:	ff 75 f0             	pushl  -0x10(%ebp)
  10309f:	ff 75 0c             	pushl  0xc(%ebp)
  1030a2:	ff 75 08             	pushl  0x8(%ebp)
  1030a5:	e8 fc fa ff ff       	call   102ba6 <printnum>
  1030aa:	83 c4 20             	add    $0x20,%esp
            break;
  1030ad:	eb 39                	jmp    1030e8 <vprintfmt+0x399>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1030af:	83 ec 08             	sub    $0x8,%esp
  1030b2:	ff 75 0c             	pushl  0xc(%ebp)
  1030b5:	53                   	push   %ebx
  1030b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b9:	ff d0                	call   *%eax
  1030bb:	83 c4 10             	add    $0x10,%esp
            break;
  1030be:	eb 28                	jmp    1030e8 <vprintfmt+0x399>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1030c0:	83 ec 08             	sub    $0x8,%esp
  1030c3:	ff 75 0c             	pushl  0xc(%ebp)
  1030c6:	6a 25                	push   $0x25
  1030c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030cb:	ff d0                	call   *%eax
  1030cd:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  1030d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1030d4:	eb 04                	jmp    1030da <vprintfmt+0x38b>
  1030d6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1030da:	8b 45 10             	mov    0x10(%ebp),%eax
  1030dd:	83 e8 01             	sub    $0x1,%eax
  1030e0:	0f b6 00             	movzbl (%eax),%eax
  1030e3:	3c 25                	cmp    $0x25,%al
  1030e5:	75 ef                	jne    1030d6 <vprintfmt+0x387>
                /* do nothing */;
            break;
  1030e7:	90                   	nop
        }
    }
  1030e8:	e9 6a fc ff ff       	jmp    102d57 <vprintfmt+0x8>
}
  1030ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1030f0:	5b                   	pop    %ebx
  1030f1:	5e                   	pop    %esi
  1030f2:	5d                   	pop    %ebp
  1030f3:	c3                   	ret    

001030f4 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1030f4:	55                   	push   %ebp
  1030f5:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1030f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030fa:	8b 40 08             	mov    0x8(%eax),%eax
  1030fd:	8d 50 01             	lea    0x1(%eax),%edx
  103100:	8b 45 0c             	mov    0xc(%ebp),%eax
  103103:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103106:	8b 45 0c             	mov    0xc(%ebp),%eax
  103109:	8b 10                	mov    (%eax),%edx
  10310b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10310e:	8b 40 04             	mov    0x4(%eax),%eax
  103111:	39 c2                	cmp    %eax,%edx
  103113:	73 12                	jae    103127 <sprintputch+0x33>
        *b->buf ++ = ch;
  103115:	8b 45 0c             	mov    0xc(%ebp),%eax
  103118:	8b 00                	mov    (%eax),%eax
  10311a:	8d 48 01             	lea    0x1(%eax),%ecx
  10311d:	8b 55 0c             	mov    0xc(%ebp),%edx
  103120:	89 0a                	mov    %ecx,(%edx)
  103122:	8b 55 08             	mov    0x8(%ebp),%edx
  103125:	88 10                	mov    %dl,(%eax)
    }
}
  103127:	5d                   	pop    %ebp
  103128:	c3                   	ret    

00103129 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103129:	55                   	push   %ebp
  10312a:	89 e5                	mov    %esp,%ebp
  10312c:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10312f:	8d 45 14             	lea    0x14(%ebp),%eax
  103132:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103135:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103138:	50                   	push   %eax
  103139:	ff 75 10             	pushl  0x10(%ebp)
  10313c:	ff 75 0c             	pushl  0xc(%ebp)
  10313f:	ff 75 08             	pushl  0x8(%ebp)
  103142:	e8 0b 00 00 00       	call   103152 <vsnprintf>
  103147:	83 c4 10             	add    $0x10,%esp
  10314a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10314d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103150:	c9                   	leave  
  103151:	c3                   	ret    

00103152 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103152:	55                   	push   %ebp
  103153:	89 e5                	mov    %esp,%ebp
  103155:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103158:	8b 45 08             	mov    0x8(%ebp),%eax
  10315b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10315e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103161:	8d 50 ff             	lea    -0x1(%eax),%edx
  103164:	8b 45 08             	mov    0x8(%ebp),%eax
  103167:	01 d0                	add    %edx,%eax
  103169:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10316c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103173:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103177:	74 0a                	je     103183 <vsnprintf+0x31>
  103179:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10317c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10317f:	39 c2                	cmp    %eax,%edx
  103181:	76 07                	jbe    10318a <vsnprintf+0x38>
        return -E_INVAL;
  103183:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103188:	eb 20                	jmp    1031aa <vsnprintf+0x58>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10318a:	ff 75 14             	pushl  0x14(%ebp)
  10318d:	ff 75 10             	pushl  0x10(%ebp)
  103190:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103193:	50                   	push   %eax
  103194:	68 f4 30 10 00       	push   $0x1030f4
  103199:	e8 b1 fb ff ff       	call   102d4f <vprintfmt>
  10319e:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  1031a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031a4:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1031a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1031aa:	c9                   	leave  
  1031ab:	c3                   	ret    
