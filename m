From: Jeffrey Kardatzke <jkardatzke@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Post-boot loading of OP-TEE
Date: Mon, 13 Mar 2023 09:25:52 -0700
Message-ID: 
 <CA+ddPcM5QeY6-oW4hti+8R2H_Amt86vKE_KHUFb4X2qiUej06w@mail.gmail.com>
In-Reply-To: <
 <7f633631-de65-463c-91a9-a3a43bf18506.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240446315842603652=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0240446315842603652==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 1:14=E2=80=AFAM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
>
>
>
>
> Hi, experts,
>
> I have another two other questions about this issue.
> (1) What should I do if the current optee to load already exists or I want =
to update optee?
> The most straightforward way I could think of is to reclaim the memory curr=
ently used by optee, then reload the optee image and initialize it.
I just reboot to handle this.
> (2) optee may use multiple cores. When and how to process the initializatio=
n of multiple cores?
This is already handled in the TF-A code patch, when an SMC from the
non-secure world comes in or a relevant power management event occurs,
it checks to see if that CPU has been initialized yet, and if it
hasn't it initializes it then.
> Do you have any solutions or ideas?
>
> Regards,
> Yuye.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B43=E6=9C=8811=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E5=85=AD) 21:44
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>; tf-a <tf-a@lists.trustedfirmware.org>; OP-TEE TrustedFirmware <op-te=
e@lists.trustedfirmware.org>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9ADan Handley <Dan.Handley@arm.com>; Je=
ffrey Kardatzke <jkardatzke@google.com>; jwerner <jwerner@chromium.org>; =
raghu.ncstate <raghu.ncstate@icloud.com>; Ilias Apalodimas <ilias.apalodima=
s@linaro.org>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: Post-boot loading of OP-TEE
>
>
>
>
> Hi, experts,
>
> If I want to apply the code to the S-EL2 framework (Hafnium as SPMC),
> What special processing should be added to spmd_handle_smc_load function or=
 other function, such as context restore and save?
> I'm not clear about the details of the process, can you give me some help?
>
> Regards,
> Yuye.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B41=E6=9C=889=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=80) 15:39
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Atf-a <tf-a@lists.trustedfirmware.org>=
; OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9ADan Handley <Dan.Handley@arm.com>; Je=
ffrey Kardatzke <jkardatzke@google.com>; jwerner <jwerner@chromium.org>; =
raghu.ncstate <raghu.ncstate@icloud.com>; Ilias Apalodimas <ilias.apalodima=
s@linaro.org>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9APost-boot loading of OP-TEE
>
> Hi,
>
> The recent patch [1] for the OP-TEE Dispatcher in TF-A proposes a way
> of post-boot loading OP-TEE by the Linux kernel with signature
> verification in the normal world only. This has previously been
> discussed in this mail thread [2] about half a year ago. Ultimately,
> it was concluded that this should in principle be accepted upstream as
> a platform choice to allow this or not. There are concerns that what
> we have in upstream TF-A should serve as good examples, and trusting
> the normal world to verify secure world software might not meet that
> criterion. There are also concerns about adding signature verification
> to BL31
>
> Leaving the secure world wide open until the Linux kernel has been
> able to successfully load and verify an OP-TEE binary seems very
> risky. Even if it's claimed that the normal world can be trusted at
> this point, we're still giving up a critical level of defense without
> a good reason.
>
> I've started to review [1], but it should not be accepted for merging
> without support and approval from other maintainers.
>
> I would like to explore other options in this mail thread. In [2] it
> was suggested that a remnant of bl2 could be kept to verify OP-TEE
> before starting to execute it. This could be taken one step further
> and load a limited OP-TEE at boot which later is updated live, almost
> like what's discussed in [3]. This should minimize the impact on TF-A
> and also leave OP-TEE in charge of accepting an update instead of a
> divided responsibility between the normal world and TF-A.
>
> [1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/18635
> [2] https://lists.trustedfirmware.org/archives/list/tf-a(a)lists.trustedfir=
mware.org/thread/D2HEKDEGRBLMMLAQ6OKC3AQDM4ELSJPL/#D2HEKDEGRBLMMLAQ6OKC3AQDM4=
ELSJPL
> [3] https://github.com/OP-TEE/optee_os/issues/5699
>
> Thanks,
> Jens

--===============0240446315842603652==--

