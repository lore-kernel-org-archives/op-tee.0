From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Post-boot loading of OP-TEE
Date: Mon, 09 Jan 2023 08:39:20 +0100
Message-ID: 
 <CAHUa44Eq7u2jQD-AinskV6RRbiRhb1gO-KmR562VzCC0fYqoag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0226266044215165524=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0226266044215165524==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/18635
[2] https://lists.trustedfirmware.org/archives/list/tf-a(a)lists.trustedfirmw=
are.org/thread/D2HEKDEGRBLMMLAQ6OKC3AQDM4ELSJPL/#D2HEKDEGRBLMMLAQ6OKC3AQDM4EL=
SJPL
[3] https://github.com/OP-TEE/optee_os/issues/5699

Thanks,
Jens

--===============0226266044215165524==--

