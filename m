From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee_benchmark found optee_os function vm_set_ctx() spent much time
Date: Mon, 26 Jun 2023 11:15:11 +0200
Message-ID: 
 <CAHUa44F6iqE19fVwD=kgi3B=gktHg3oGk5NR2wnaA-k0EA_A7g@mail.gmail.com>
In-Reply-To: <168776873876.1165.5832647553655830437@lists.trustedfirmware.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5386073867656405306=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5386073867656405306==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 26, 2023 at 10:39=E2=80=AFAM haiyuan.ghy--- via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi, Jens,
> I tried CFG_CORE_PREALLOC_EL0_TBLS=3Dy to compile optee_os.
> I used the same optee_example_hello_world CA and TA, tested 10K times Invok=
eCommand.
> I got average of time was 17 us, somewhat less than previous 20 us.

A small improvement, at least it didn't make things worse. :-)

>
> Any suggestion? Thanks for help.

With CFG_CORE_PREALLOC_EL0_TBLS=3Dy each TA has preallocated translation
tables that don't need to be completely reinitialized each time. I
guess some of the saved time above is from
core_mmu_populate_user_map() taking a bit less time. It would be
interesting to know how the time is spent by vm_set_ctx(), assuming
that's still the main problem.

There are also the calls to tlbi_all() and icache_inv_all() in
core_mmu_set_user_map() that might be a bit brutal. If you're only
calling the same TA repeatedly it could be interesting to so how how
much time can be saved by skipping those two calls. So we know if it's
worth trying to optimize that part.

Cheers,
Jens

--===============5386073867656405306==--

