From: Mehdi AMINI <joker.eph@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [llvm-dev] Issue with __attribute__((constructor)) and
 -Os -fno-common
Date: Fri, 12 Jun 2020 14:26:30 -0700
Message-ID: 
 <CANF-O=YD_RBE5fcm3V8UsPg2Qgj3V7j0rabriFUVbgXENO268g@mail.gmail.com>
In-Reply-To: <726bd030-b37c-157d-a865-6d3962709a83@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3784745511173859242=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3784745511173859242==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 1:05 AM Jerome Forissier via llvm-dev <
llvm-dev@lists.llvm.org> wrote:

>
>
> On 6/11/20 11:25 PM, James Y Knight wrote:
> > The global constructor was removed by setting the initial value of "val"
> to
> > 1 instead of 0. So, the behavior of this program is preserved. Doesn't
> look
> > like erroneous behavior.
>
> OK, my example is too simplified indeed. Please consider the following
> instead:
>
> int val;
>
> static void __attribute__((constructor)) init_fn(void)
> {
>         val++;
> }
>
> int main(int argc, char *argv[])
> {
>         return val;
> }
>
> With this, clang -Os -fno-common generates a global variable initialized
> to 1 and discards init_fn().
>
> Now, what happens if the executable is later linked against a shared
> library which has its own constructor and sets "val" to some non-zero
> value? I mean this for instance:
>
> extern int val;
>
> static void __attribute__((constructor)) so_init_fn(void)
> {
>         val =3D 1;
> }
>
> I would expect the main program to return 2, not 1.
>

It seems to me that there is no ordering guarantee that your so_init_fn()
would run before init_fn(), isn't this a case of "static initialization
order fiasco"?
<https://www.google.com/search?client=3Dsafari&rls=3Den&q=3Dstatic+initializa=
tion+order+fiasco&ie=3DUTF-8&oe=3DUTF-8>


>
> Last thing, if I define "val" as volatile, the programs behaves as
> expected.
>
> Are we in "unspecified, just don't do this" territory here?
>
> Thanks,
> --
> Jerome
>
> >
> > On Thu, Jun 11, 2020 at 10:12 AM Jerome Forissier via llvm-dev <
> > llvm-dev(a)lists.llvm.org> wrote:
> >
> >> Hi,
> >>
> >> I think that Clang erroneously discards a function annotated with
> >> __attribute__((constructor)) when flags -Os -fno-common are given. Test
> >> case below.
> >>
> >> What do you think?
> >>
> >> Thanks.
> >>
> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> $ cat ctor.c
> >> int val;
> >>
> >> static void __attribute__((constructor)) init_fn(void)
> >> {
> >>         val =3D 1;
> >> }
> >>
> >> int main(int argc, char *argv[])
> >> {
> >>         return val;
> >> }
> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >>
> >> Here is what I observed:
> >>
> >> - Clang (10.0.0-4ubuntu1) with -Os -fno-common: function init_fn() is
> >> NOT emitted,
> >> - Clang (10.0.0-4ubuntu1) with no flag, or only -Os or -fno-common:
> >> init_fn() is present as expected,
> >> - GCC (Ubuntu 9.3.0-10ubuntu1) with the same flags: init_fn() is present
> >> too,
> >> - Since https://reviews.llvm.org/D75056, -fno-common is the default and
> >> therefore -Os is enough to cause the issue.
> >>
> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >> $ clang --target=3Darm-linux-gnueabihf -Os -fno-common -S ctor.c \
> >>   -o /dev/stdout | grep init_fn
> >> $ clang --target=3Darm-linux-gnueabihf -Os -S ctor.c \
> >>   -o /dev/stdout | grep init_fn
> >>         .p2align        2               @ -- Begin function init_fn
> >>         .type   init_fn,%function
> >>         .code   32                      @ @init_fn
> >> init_fn:
> >>         .size   init_fn, .Lfunc_end0-init_fn
> >>         .long   init_fn(target1)
> >>         .addrsig_sym init_fn
> >> $ clang --target=3Darm-linux-gnueabihf -fno-common -S ctor.c \
> >>   -o /dev/stdout | grep init_fn
> >>         .p2align        2               @ -- Begin function init_fn
> >>         .type   init_fn,%function
> >>         .code   32                      @ @init_fn
> >> init_fn:
> >>         .size   init_fn, .Lfunc_end0-init_fn
> >>         .long   init_fn(target1)
> >>         .addrsig_sym init_fn
> >> $ arm-linux-gnueabihf-gcc -Os -fno-common -S ctor.c \
> >>   -o /dev/stdout | grep init_fn
> >>         .type   init_fn, %function
> >> init_fn:
> >>         .size   init_fn, .-init_fn
> >>         .word   init_fn(target1)
> >> ----8<--------8<--------8<--------8<--------8<--------8<--------
> >>
> >> --
> >> Jerome
> >> _______________________________________________
> >> LLVM Developers mailing list
> >> llvm-dev(a)lists.llvm.org
> >> https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
> >>
> >
> _______________________________________________
> LLVM Developers mailing list
> llvm-dev(a)lists.llvm.org
> https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
>

--===============3784745511173859242==--

