From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Thu, 25 Mar 2021 07:49:19 +0000
Message-ID: 
 <CAHUa44GC9Co3v6RqqwpnAVRnGzWZyPnr=7Ww8C5_deoBpruPTg@mail.gmail.com>
In-Reply-To: <20210325115043.6c00a33e@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6666236526727747058=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6666236526727747058==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 3:50 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> On Wed, 24 Mar 2021 10:53:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> >
> > On Wed, 24 Mar 2021 07:48:53 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:
> > > > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:
> > > > > Add tracepoints to retrieve information about the invoke_fn. This w=
ould
> > > > > help to measure how many invoke_fn are triggered and how long it ta=
kes
> > > > > to complete one invoke_fn call.
> > > > >
> > > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > >
> > > > arm64:defconfig:
> > > >
> > > > make-arm64 -j drivers/tee/optee/call.o
> > > >   CALL    scripts/atomic/check-atomics.sh
> > > >   CALL    scripts/checksyscalls.sh
> > > >   CC      drivers/tee/optee/call.o
> > > > In file included from drivers/tee/optee/optee_trace.h:67,
> > > >                  from drivers/tee/optee/call.c:18:
> > > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: N=
o such file or directory
> > > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >       |                                          ^
> > > > compilation terminated.
>
> Interesting, I always build linux kernel with "O=3D", didn't see such build=
 error
> and IIRC, we didn't receive any lkp robot build error report.
>
> My steps are:
>
> mkdir /tmp/test
>
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- O=3D/tmp/test defconfig
>
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- O=3D/tmp/test drivers/=
tee/optee/
>
> Today, I tried to build the linux kernel w/o "O=3D...", I reproduced this e=
rror!
> This is the first time I saw "O=3D" make a different behavior.

I'm also compiling with O=3D... and couldn't understand what was going
on. Thanks for saving me from digging any deeper.

>
> I'll send out a patch to fix it.

Thanks,
Jens

--===============6666236526727747058==--

