From: Sjoerd Meijer <Sjoerd.Meijer@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [llvm-dev] Aarch64: unaligned access despite -mstrict-align
Date: Mon, 01 Jun 2020 15:32:11 +0000
Message-ID: <DB6PR0801MB1990F9182ED63C8D565C0B76FC8A0@DB6PR0801MB1990.eurprd08.prod.outlook.com>
In-Reply-To: <66c0aca5-8614-a438-3090-28af787b8713@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6647870525952231017=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6647870525952231017==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

> Note the 'ldr x9, [x0]'. At this point there is no guarantee that x0 is a m=
ultiple of 8, so why is Clang generating this code?

I think the point is that it can assume it is 8 byte aligned, so the question=
 is why it isn't.  I guess that requires looking into how memory is allocated=
 to what C is pointing to, or if some type punning caused passing an address =
that is not properly aligned.

Cheers,
Sjoerd.
________________________________
From: llvm-dev <llvm-dev-bounces@lists.llvm.org> on behalf of Jerome Foriss=
ier via llvm-dev <llvm-dev@lists.llvm.org>
Sent: 01 June 2020 15:26
To: llvm-dev(a)lists.llvm.org <llvm-dev@lists.llvm.org>
Cc: op-tee(a)lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>
Subject: [llvm-dev] Aarch64: unaligned access despite -mstrict-align

Hi,

I experienced a crash in code compiled with Clang 10.0.0 due to a
misaligned 64-bit data access. The (ARMv8) CPU is configured with SCTL.A
=3D=3D 1 (alignment check enable). With SCTLR.A =3D=3D 0 the code runs as exp=
ected.

After some investigation I came up with the following reproducer:

---8<-------8<-------8<-------8<-------8<-------8<-------8<-------
$ cat test.c
extern char *g;
int memcmp(const void *s1, const void *s2, unsigned long n);

int f(void *c)
{
        return memcmp(g, c, 16);
}
$ clang --target=3Daarch64-linux-gnu -Os -mstrict-align -S test.c
$ cat test.s
        .text
        .file   "test.c"
        .globl  f                       // -- Begin function f
        .p2align        2
        .type   f,@function
f:                                      // @f
// %bb.0:
        adrp    x8, g
        ldr     x10, [x8, :lo12:g]
        ldr     x9, [x0]
        ldr     x8, [x10]
        rev     x9, x9
        rev     x8, x8
        cmp     x8, x9
        b.ne    .LBB0_3
// %bb.1:
        ldr     x8, [x10, #8]
        ldr     x9, [x0, #8]
        rev     x8, x8
        rev     x9, x9
        cmp     x8, x9
        b.ne    .LBB0_3
// %bb.2:
        mov     w0, wzr
        ret
.LBB0_3:
        cmp     x8, x9
        mov     w8, #-1
        cneg    w0, w8, hs
        ret
.Lfunc_end0:
        .size   f, .Lfunc_end0-f
                                        // -- End function
        .ident  "clang version 10.0.0-4ubuntu1 "
        .section        ".note.GNU-stack","",@progbits
        .addrsig
---8<-------8<-------8<-------8<-------8<-------8<-------8<-------

Note the 'ldr x9, [x0]'. At this point there is no guarantee that x0 is
a multiple of 8, so why is Clang generating this code?

Thanks,
--
Jerome
_______________________________________________
LLVM Developers mailing list
llvm-dev@lists.llvm.org
https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev

--===============6647870525952231017==--

