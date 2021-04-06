From: Heiko Thiery <heiko.thiery@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Date: Tue, 06 Apr 2021 12:38:03 +0200
Message-ID: 
 <CAEyMn7a1Ec6WZ24i5kCP-4AmM0=s2qEoOTXFpS72a7n+0P7uaw@mail.gmail.com>
In-Reply-To: <20210330082617.GA971075@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6874539062977133227=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6874539062977133227==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Am Di., 30. M=C3=A4rz 2021 um 10:26 Uhr schrieb Jens Wiklander
<jens.wiklander@linaro.org>:
>
> On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> > If build kernel without "O=3Ddir", below error will be seen:
> >
> > In file included from drivers/tee/optee/optee_trace.h:67,
> >                  from drivers/tee/optee/call.c:18:
> > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No su=
ch file or directory
> >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >       |                                          ^
> > compilation terminated.
> >
> > Fix it by adding below line to Makefile:
> > CFLAGS_call.o :=3D -I$(src)
> >
> > Tested with and without "O=3Ddir", both can build successfully.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
> I've picked up this.

For what tree did you pick this? I still see this build failure on the
latest next tree (next-20210401).

>
> Thanks,
> Jens

Thank you,
Heiko

--===============6874539062977133227==--

