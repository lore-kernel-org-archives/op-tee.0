From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] tee: add tee_device_set_dev_groups()
Date: Tue, 13 Aug 2024 14:55:21 +0200
Message-ID: 
 <CAHUa44G6JHLyUCd=ZAaDY=jjsKJWFiQJ=r7u9kEKK4L8crHqrA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNwsgLD4bYRbPPG4MqshP8cmvZ5YdvgnX6Zsoeez8b-bw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2883009917145627795=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2883009917145627795==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Tue, Aug 13, 2024 at 1:40=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Jens,
>
> On Mon, 12 Aug 2024 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
> > attribute groups. The class specific attributes are from now on added
> > via the tee_class, which currently only consist of implementation_id.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------
>
> These changes don't seem to belong to this patch but rather patch #1.
>
> >  drivers/tee/tee_core.c   |  19 +++--
>
> >  include/linux/rpmb.h     |  53 +++++--------
>
> Ditto here.

Ouch, thanks for noticing this. I'll fix it in the next version.

Cheers,
Jens

--===============2883009917145627795==--

