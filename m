From: Mehdi AMINI <joker.eph@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [llvm-dev] Issue with __attribute__((constructor)) and
 -Os -fno-common
Date: Sun, 14 Jun 2020 16:42:16 -0700
Message-ID: 
 <CANF-O=ZDs1oTqdWou-u0GmFsic8SSMDquKZwWBsh3waRHg+WpQ@mail.gmail.com>
In-Reply-To: <20200614191848.pxae5nisquyeqtrq@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858197869735458846=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0858197869735458846==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2020 at 12:18 PM Fangrui Song <maskray@google.com> wrote:

> On 2020-06-12, Mehdi AMINI via llvm-dev wrote:
> >On Fri, Jun 12, 2020 at 1:05 AM Jerome Forissier via llvm-dev <
> >llvm-dev(a)lists.llvm.org> wrote:
> >
> >>
> >>
> >> On 6/11/20 11:25 PM, James Y Knight wrote:
> >> > The global constructor was removed by setting the initial value of
> "val"
> >> to
> >> > 1 instead of 0. So, the behavior of this program is preserved. Doesn't
> >> look
> >> > like erroneous behavior.
> >>
> >> OK, my example is too simplified indeed. Please consider the following
> >> instead:
> >>
> >> int val;
> >>
> >> static void __attribute__((constructor)) init_fn(void)
> >> {
> >>         val++;
> >> }
> >>
> >> int main(int argc, char *argv[])
> >> {
> >>         return val;
> >> }
> >>
> >> With this, clang -Os -fno-common generates a global variable initialized
> >> to 1 and discards init_fn().
> >>
> >> Now, what happens if the executable is later linked against a shared
> >> library which has its own constructor and sets "val" to some non-zero
> >> value? I mean this for instance:
> >>
> >> extern int val;
> >>
> >> static void __attribute__((constructor)) so_init_fn(void)
> >> {
> >>         val =3D 1;
> >> }
> >>
> >> I would expect the main program to return 2, not 1.
> >>
> >
> >It seems to me that there is no ordering guarantee that your so_init_fn()
> >would run before init_fn(), isn't this a case of "static initialization
> >order fiasco"?
> ><
> https://www.google.com/search?client=3Dsafari&rls=3Den&q=3Dstatic+initializ=
ation+order+fiasco&ie=3DUTF-8&oe=3DUTF-8
> >
>
> I tend to agree that clang has a bug.
>
> __attribute__((constructor)) is an extension to the C++ standard.
> Even if C++ defined this and said this were an undefined behavior,
> an implementation can augment the C++ standard by providing a definition
> of an undefined behavior.
>

> On ELF, the implementation uses Initialization and Termination
> Functions, which are subject to
> http://www.sco.com/developers/gabi/latest/ch5.dynamic.html#init_fini
>
> "Before the initialization functions for any object A is called, the
> initialization functions for any other objects that object A depends on
> are called."


In this case though the "object" does not depend on any other object here I
believe. Even if it did, the behavior of the loader does not put constraint
on the source/language semantics that the compiler operates with: it only
puts guarantee on the output of the compiler.



> The ld.so implementations use a post-order traversal of DT_NEEDED
> dependencies.
> I tend to think the intention of the function attribute
> (
> https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Common-Function-Attributes.ht=
ml#Common-Function-Attributes
> )
> is to conform to the ELF specification. This is a property users can
> reliably depend on.
>

I don't read it the same way: this doc to me indicates that it is an
extension to C that provides the same behavior as a C++ global constructor.
I don't see here anything that put a restriction on the cross-object
initialization order.
The fact that the platform (ELF or another) provides a restriction does not
automatically translate to the higher-level.



>
> In Jerome's example, it is guaranteed that the initialization function
> in the shared object runs before the one in the main executable.
> clang should not optimize out the initialization function to alter the
> observed program behavior.
>

I see it similarly to the different choice clang and gcc are making on the
"interposible" property and assumptions, isn't it? See:
http://lists.llvm.org/pipermail/llvm-dev/2016-November/107625.html

Actually taking the example above, adding -fsemantic-interposition shows
the difference: with the flag it behaves as you'd expect:
https://godbolt.org/z/fC5yzY  ; however not for the reason you're arguing
for.


--=20
Mehdi



> >>
> >> Last thing, if I define "val" as volatile, the programs behaves as
> >> expected.
> >>
> >> Are we in "unspecified, just don't do this" territory here?
> >>
> >> Thanks,
> >> --
> >> Jerome
> >>
> >> >
> >> > On Thu, Jun 11, 2020 at 10:12 AM Jerome Forissier via llvm-dev <
> >> > llvm-dev(a)lists.llvm.org> wrote:
> >> >
> >> >> Hi,
> >> >>
> >> >> I think that Clang erroneously discards a function annotated with
> >> >> __attribute__((constructor)) when flags -Os -fno-common are given.
> Test
> >> >> case below.
> >> >>
> >> >> What do you think?
> >> >>
> >> >> Thanks.
> >> >>
> >> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> >> $ cat ctor.c
> >> >> int val;
> >> >>
> >> >> static void __attribute__((constructor)) init_fn(void)
> >> >> {
> >> >>         val =3D 1;
> >> >> }
> >> >>
> >> >> int main(int argc, char *argv[])
> >> >> {
> >> >>         return val;
> >> >> }
> >> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> >>
> >> >> Here is what I observed:
> >> >>
> >> >> - Clang (10.0.0-4ubuntu1) with -Os -fno-common: function init_fn() is
> >> >> NOT emitted,
> >> >> - Clang (10.0.0-4ubuntu1) with no flag, or only -Os or -fno-common:
> >> >> init_fn() is present as expected,
> >> >> - GCC (Ubuntu 9.3.0-10ubuntu1) with the same flags: init_fn() is
> present
> >> >> too,
> >> >> - Since https://reviews.llvm.org/D75056, -fno-common is the default
> and
> >> >> therefore -Os is enough to cause the issue.
> >> >>
> >> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> >> $ clang --target=3Darm-linux-gnueabihf -Os -fno-common -S ctor.c \
> >> >>   -o /dev/stdout | grep init_fn
> >> >> $ clang --target=3Darm-linux-gnueabihf -Os -S ctor.c \
> >> >>   -o /dev/stdout | grep init_fn
> >> >>         .p2align        2               @ -- Begin function init_fn
> >> >>         .type   init_fn,%function
> >> >>         .code   32                      @ @init_fn
> >> >> init_fn:
> >> >>         .size   init_fn, .Lfunc_end0-init_fn
> >> >>         .long   init_fn(target1)
> >> >>         .addrsig_sym init_fn
> >> >> $ clang --target=3Darm-linux-gnueabihf -fno-common -S ctor.c \
> >> >>   -o /dev/stdout | grep init_fn
> >> >>         .p2align        2               @ -- Begin function init_fn
> >> >>         .type   init_fn,%function
> >> >>         .code   32                      @ @init_fn
> >> >> init_fn:
> >> >>         .size   init_fn, .Lfunc_end0-init_fn
> >> >>         .long   init_fn(target1)
> >> >>         .addrsig_sym init_fn
> >> >> $ arm-linux-gnueabihf-gcc -Os -fno-common -S ctor.c \
> >> >>   -o /dev/stdout | grep init_fn
> >> >>         .type   init_fn, %function
> >> >> init_fn:
> >> >>         .size   init_fn, .-init_fn
> >> >>         .word   init_fn(target1)
> >> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> >>
> >> >> --
> >> >> Jerome
> >> >> _______________________________________________
> >> >> LLVM Developers mailing list
> >> >> llvm-dev(a)lists.llvm.org
> >> >> https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
> >> >>
> >> >
> >> _______________________________________________
> >> LLVM Developers mailing list
> >> llvm-dev(a)lists.llvm.org
> >> https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
> >>
>
> >_______________________________________________
> >LLVM Developers mailing list
> >llvm-dev(a)lists.llvm.org
> >https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
>
>

--===============0858197869735458846==--

