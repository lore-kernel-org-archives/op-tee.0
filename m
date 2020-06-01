From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] Aarch64: unaligned access despite -mstrict-align
Date: Mon, 01 Jun 2020 16:26:48 +0200
Message-ID: <66c0aca5-8614-a438-3090-28af787b8713@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3506922748000631688=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3506922748000631688==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

I experienced a crash in code compiled with Clang 10.0.0 due to a
misaligned 64-bit data access. The (ARMv8) CPU is configured with SCTL.A
== 1 (alignment check enable). With SCTLR.A == 0 the code runs as expected.

After some investigation I came up with the following reproducer:

---8<-------8<-------8<-------8<-------8<-------8<-------8<-------
$ cat test.c
extern char *g;
int memcmp(const void *s1, const void *s2, unsigned long n);

int f(void *c)
{
	return memcmp(g, c, 16);
}
$ clang --target=aarch64-linux-gnu -Os -mstrict-align -S test.c
$ cat test.s
	.text
	.file	"test.c"
	.globl	f                       // -- Begin function f
	.p2align	2
	.type	f,@function
f:                                      // @f
// %bb.0:
	adrp	x8, g
	ldr	x10, [x8, :lo12:g]
	ldr	x9, [x0]
	ldr	x8, [x10]
	rev	x9, x9
	rev	x8, x8
	cmp	x8, x9
	b.ne	.LBB0_3
// %bb.1:
	ldr	x8, [x10, #8]
	ldr	x9, [x0, #8]
	rev	x8, x8
	rev	x9, x9
	cmp	x8, x9
	b.ne	.LBB0_3
// %bb.2:
	mov	w0, wzr
	ret
.LBB0_3:
	cmp	x8, x9
	mov	w8, #-1
	cneg	w0, w8, hs
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
                                        // -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
---8<-------8<-------8<-------8<-------8<-------8<-------8<-------

Note the 'ldr x9, [x0]'. At this point there is no guarantee that x0 is
a multiple of 8, so why is Clang generating this code?

Thanks,
-- 
Jerome

--===============3506922748000631688==--

