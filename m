From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Post-boot loading of OP-TEE
Date: Sat, 11 Mar 2023 21:44:13 +0800
Message-ID: 
 <750fa1f7-56d9-4ff2-9004-112fdbbdb940.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2908058814409267699=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2908058814409267699==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, experts,
If I want to apply the code to the S-EL2 framework (Hafnium as SPMC),=20
What special processing should be added to spmd_handle_smc_load function or o=
ther function, such as context restore and save?=20
I'm not clear about the details of the process, can you give me some help?
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B41=E6=9C=889=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=80) 15:39
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Atf-a <tf-a@lists.trustedfirmware.org>; =
OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9ADan Handley <Dan.Handley@arm.com>; Jeff=
rey Kardatzke <jkardatzke@google.com>; jwerner <jwerner@chromium.org>; ra=
ghu.ncstate <raghu.ncstate@icloud.com>; Ilias Apalodimas <ilias.apalodimas(=
a)linaro.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9APost-boot loading of OP-TEE
Hi,
The recent patch [1] for the OP-TEE Dispatcher in TF-A proposes a way
of post-boot loading OP-TEE by the Linux kernel with signature
verification in the normal world only. This has previously been
discussed in this mail thread [2] about half a year ago. Ultimately,
it was concluded that this should in principle be accepted upstream as
a platform choice to allow this or not. There are concerns that what
we have in upstream TF-A should serve as good examples, and trusting
the normal world to verify secure world software might not meet that
criterion. There are also concerns about adding signature verification
to BL31
Leaving the secure world wide open until the Linux kernel has been
able to successfully load and verify an OP-TEE binary seems very
risky. Even if it's claimed that the normal world can be trusted at
this point, we're still giving up a critical level of defense without
a good reason.
I've started to review [1], but it should not be accepted for merging
without support and approval from other maintainers.
I would like to explore other options in this mail thread. In [2] it
was suggested that a remnant of bl2 could be kept to verify OP-TEE
before starting to execute it. This could be taken one step further
and load a limited OP-TEE at boot which later is updated live, almost
like what's discussed in [3]. This should minimize the impact on TF-A
and also leave OP-TEE in charge of accepting an update instead of a
divided responsibility between the normal world and TF-A.
[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/18635 <htt=
ps://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/18635 >
[2] https://lists.trustedfirmware.org/archives/list/tf-a(a)lists.trustedfirmw=
are.org/thread/D2HEKDEGRBLMMLAQ6OKC3AQDM4ELSJPL/#D2HEKDEGRBLMMLAQ6OKC3AQDM4EL=
SJPL <https://lists.trustedfirmware.org/archives/list/tf-a@lists.trustedfir=
mware.org/thread/D2HEKDEGRBLMMLAQ6OKC3AQDM4ELSJPL/#D2HEKDEGRBLMMLAQ6OKC3AQDM4=
ELSJPL >
[3] https://github.com/OP-TEE/optee_os/issues/5699 <https://github.com/OP-TEE=
/optee_os/issues/5699 >
Thanks,
Jens

--===============2908058814409267699==--

