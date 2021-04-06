From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Date: Tue, 06 Apr 2021 14:30:30 +0200
Message-ID: 
 <CAHUa44HDrHP6-z=FRkNJtkSe8cVJY-acPDK_r7QrO5QgPwo+iA@mail.gmail.com>
In-Reply-To: <
 <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6307044503186084839=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6307044503186084839==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

[+Arnd]

On Tue, Apr 6, 2021 at 12:38 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> Hi Jens,
>
> Am Di., 30. M=C3=A4rz 2021 um 10:26 Uhr schrieb Jens Wiklander
> <jens.wiklander@linaro.org>:
> >
> > On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> > > If build kernel without "O=3Ddir", below error will be seen:
> > >
> > > In file included from drivers/tee/optee/optee_trace.h:67,
> > >                  from drivers/tee/optee/call.c:18:
> > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No =
such file or directory
> > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > > compilation terminated.
> > >
> > > Fix it by adding below line to Makefile:
> > > CFLAGS_call.o :=3D -I$(src)
> > >
> > > Tested with and without "O=3Ddir", both can build successfully.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >
> > I've picked up this.
>
> For what tree did you pick this? I still see this build failure on the
> latest next tree (next-20210401).

The next tree hasn't been updated since 1th of April so it's not
unexpected. The fix is supposed to be on its way to
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Darm/driv=
ers
, I can't see it there yet though.

Cheers,
Jens

--===============6307044503186084839==--

